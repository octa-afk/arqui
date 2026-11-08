#!/usr/bin/env bash
# =============================================================================
# run_sweep.sh — Barrido de asociatividad W con síntesis Yosys
#
# Para cada W en {1, 2, 4, 8, 16}:
#   1. Sintetiza cache_comparator.v + plru_state.v con Yosys
#   2. Extrae: celdas combinacionales, flip-flops, bits de datos
#   3. Guarda resultados (CSV + logs) ordenados por W en RESULTS_DIR
#
# Uso:
#   chmod +x run_sweep.sh && ./run_sweep.sh
#
# Prerequisito: yosys instalado (sudo apt install yosys)
# =============================================================================

set -e

YOSYS_BIN=$(which yosys 2>/dev/null || type -P yosys 2>/dev/null)
if [ -z "$YOSYS_BIN" ]; then
    echo "ERROR: yosys no encontrado."
    echo "  Instalar con: sudo apt install yosys"
    exit 1
fi
echo "Usando: $YOSYS_BIN ($($YOSYS_BIN --version 2>&1 | head -1))"

RESULTS_DIR="synth_results"
LOGS_DIR="${RESULTS_DIR}/logs"
CSV="${RESULTS_DIR}/synth_results.csv"
mkdir -p "$LOGS_DIR"

CSV_TMP=$(mktemp)
echo "W,T,S,cells_comb,cells_ff,cells_total,wire_bits" > "$CSV_TMP"

# Parametros: cache 256B, bloque 16B (b=4), addr 32-bit, D=128 bits/linea
declare -A TAG=(  [1]=24 [2]=25 [4]=26 [8]=27 [16]=28 )
declare -A SETS=( [1]=16 [2]=8  [4]=4  [8]=2  [16]=1  )

for W in 1 2 4 8 16; do
    T=${TAG[$W]}
    S=${SETS[$W]}
    LOG="${LOGS_DIR}/synth_W${W}.log"

    echo "────────────────────────────────────────────"
    echo " Sintetizando W=${W}  (T=${T} bits tag, S=${S} sets)"
    echo "────────────────────────────────────────────"

    # Sintetizar cache_top (wrapper que incluye comparador + PLRU)
    "$YOSYS_BIN" -p "
        read_verilog cache_comparator.v plru_state.v cache_top.v
        chparam -set W ${W} -set T ${T} -set D 128 -set S ${S} cache_top
        hierarchy -check -top cache_top
        proc
        flatten
        synth -flatten -top cache_top -noabc
        stat
    " 2>&1 | tee "$LOG"

    # Extraer totales del bloque "=== cache_top ===" final
    # Yosys imprime stat dos veces; tomar la ultima ocurrencia
    CELLS_TOTAL=$(grep "Number of cells:" "$LOG" | tail -1 | grep -oE "[0-9]+" || echo 0)
    WIRE_BITS=$(grep "Number of wire bits:" "$LOG" | tail -1 | grep -oE "[0-9]+" || echo 0)

    # FFs: lineas que contienen $_DFF (grep -F: busqueda de cadena literal)
    # awk extrae el ultimo campo (el conteo) y los suma
    CELLS_FF=$(grep -F '$_DFF' "$LOG" | awk '{print $NF}' | awk '{s+=$1} END {print s+0}')

    CELLS_COMB=$((CELLS_TOTAL - CELLS_FF))

    echo ""
    echo "  W=${W}: total=${CELLS_TOTAL} | comb=${CELLS_COMB} | FFs=${CELLS_FF} | wire_bits=${WIRE_BITS}"
    echo "${W},${T},${S},${CELLS_COMB},${CELLS_FF},${CELLS_TOTAL},${WIRE_BITS}" >> "$CSV_TMP"
done

# Ordenar filas por W (numerico), conservando el encabezado
{
    head -1 "$CSV_TMP"
    tail -n +2 "$CSV_TMP" | sort -t, -k1,1n
} > "$CSV"
rm -f "$CSV_TMP"

echo ""
echo "════════════════════════════════════════════════════════════"
echo " Resumen"
echo "════════════════════════════════════════════════════════════"
if command -v column >/dev/null 2>&1; then
    column -t -s, "$CSV"
else
    cat "$CSV"
fi

echo ""
echo "Leyenda:"
echo "  W            asociatividad (vias por set)"
echo "  T            ancho del tag (bits)"
echo "  S            cantidad de sets"
echo "  cells_comb   celdas combinacionales sintetizadas"
echo "  cells_ff     flip-flops (\$_DFF*)"
echo "  cells_total  celdas totales (comb + ff)"
echo "  wire_bits    bits de cableado (ancho total de senales internas)"

echo ""
echo "Archivos generados en ${RESULTS_DIR}/:"
find "$RESULTS_DIR" -type f -not -name '.*' | sort | while read -r f; do
    printf "  %-45s %8s\n" "$f" "$(du -h "$f" | cut -f1)"
done
