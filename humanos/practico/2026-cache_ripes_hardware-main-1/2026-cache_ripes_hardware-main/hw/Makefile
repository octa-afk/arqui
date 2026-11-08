# =============================================================================
# Makefile — Hardware simulation del comparador de caché
#
# Flujo principal:
#   1. iverilog  → simulación funcional del Verilog (verifica corrección)
#   2. yosys     → síntesis multi-W → synth_results/synth_results.csv
#
# Uso:
#   make sim          → simulación funcional con iverilog
#   make synth        → síntesis con Yosys (requiere: sudo apt install yosys)
#   make all          → sim + synth
#   make install      → instala yosys
#   make clean        → limpia todos los archivos generados
#
# =============================================================================

VERILOG_SRC  := cache_comparator.v plru_state.v
TB_SRC       := tb_cache.v
PLOTS_DIR    := plots
RESULTS_DIR  := synth_results
SYNTH_CSV    := $(RESULTS_DIR)/synth_results.csv

# Miss rates medidos en RIPES (Ejercicio 3), en %:  W=1, 2, 4, 8, 16
# Actualizar con los valores medidos por el estudiante
MISS_RATES  ?= 100,100,50,50,50

# Detectar yosys en el PATH de forma robusta
YOSYS := $(shell which yosys 2>/dev/null || type -P yosys 2>/dev/null)

.PHONY: all sim synth plots install clean help

all: sim synth

# ── Simulación funcional ──────────────────────────────────────────────────────
sim: tb_cache
	@echo "=== Simulación funcional ==="
	./tb_cache

tb_cache: $(TB_SRC) $(VERILOG_SRC)
	iverilog -o $@ $^
	@echo "Compilado: $@"

# ── Síntesis con Yosys ───────────────────────────────────────────────────────
synth: $(SYNTH_CSV)

$(SYNTH_CSV): $(VERILOG_SRC) run_sweep.sh
	@test -n "$(YOSYS)" || { \
		echo "ERROR: yosys no encontrado. Instalar con: make install"; \
		exit 1; \
	}
	@echo "Usando yosys: $(YOSYS)"
	chmod +x run_sweep.sh
	./run_sweep.sh

# ── Instalación de Yosys ─────────────────────────────────────────────────────
install:
	@echo "Instalando yosys..."
	sudo apt-get install -y yosys
	yosys --version

# ── Limpieza ──────────────────────────────────────────────────────────────────
clean:
	rm -f tb_cache tb_cache.vcd
	rm -rf $(RESULTS_DIR) $(PLOTS_DIR)

help:
	@echo "============================================================"
	@echo " Workshop Caché — Simulación de hardware RTL"
	@echo "============================================================"
	@echo " make sim       Simula el Verilog con iverilog (verifica)"
	@echo " make synth     Sintetiza con Yosys → $(SYNTH_CSV)"
	@echo " make all       sim + synth"
	@echo " make install   Instala yosys vía apt"
	@echo " make clean     Elimina archivos generados"
	@echo ""
	@echo "============================================================"
