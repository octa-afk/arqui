/*
 * cache_comparator.v
 *
 * Lógica de hit-detection para una caché W-way set-associative.
 *
 * Instancia:
 *   - W comparadores de tag en paralelo  (crecen ~linealmente con W)
 *   - OR-tree para señal de hit global   (crece logarítmicamente)
 *   - MUX W:1 sobre D bits de datos      (crecen ~linealmente con W)
 *
 * Síntesis con Yosys:
 *   yosys synth.ys W=<1|2|4|8|16>
 *
 * Configuración de referencia: caché 256B, bloque 16B, addr 32-bit
 *   W=1  (DM):  T=24, S=16
 *   W=2:        T=25, S=8
 *   W=4:        T=26, S=4
 *   W=8:        T=27, S=2
 *   W=16 (FA):  T=28, S=1
 */

`default_nettype none

/* ── Comparador de un tag (1 vía) ──────────────────────────────────────────
 * XOR bit a bit + NOR de T bits → señal de igualdad
 * Hardware: T puertas XOR + árbol NOR/AND
 */
module tag_compare #(
    parameter T = 26
)(
    input  [T-1:0] tag_addr,
    input  [T-1:0] tag_stored,
    input          valid,
    output         hit
);
    assign hit = valid & (tag_addr == tag_stored);
endmodule


/* ── MUX 2:1 genérico ────────────────────────────────────────────────────── */
module mux2 #(
    parameter D = 32
)(
    input  [D-1:0] in0,
    input  [D-1:0] in1,
    input          sel,
    output [D-1:0] out
);
    assign out = sel ? in1 : in0;
endmodule


/* ── Módulo principal: W-way hit detection + data MUX ──────────────────────
 *
 * Parámetros:
 *   W : asociatividad (número de vías)  — el parámetro clave a variar
 *   T : bits de tag
 *   D : bits de datos por línea (bloque_bytes × 8; aquí 16B × 8 = 128 bits)
 */
module cache_comparator #(
    parameter W = 4,
    parameter T = 26,
    parameter D = 128   /* 16 bytes = 128 bits por línea de caché */
)(
    /* Entradas */
    input  [T-1:0]   addr_tag,        /* tag extraído de la dirección */
    input  [W*T-1:0] stored_tags,     /* W tags almacenados (concatenados) */
    input  [W-1:0]   valid,           /* W valid bits */
    input  [W*D-1:0] data_lines,      /* W líneas de datos (concatenadas) */

    /* Salidas */
    output           hit,             /* 1 si alguna vía tiene el tag correcto */
    output [D-1:0]   data_out         /* dato de la vía ganadora */
);

    /* ── W comparadores en paralelo ─────────────────────────────────── */
    wire [W-1:0] way_hit;

    genvar g;
    generate
        for (g = 0; g < W; g = g + 1) begin : COMP
            tag_compare #(.T(T)) u_cmp (
                .tag_addr   (addr_tag),
                .tag_stored (stored_tags[g*T +: T]),
                .valid      (valid[g]),
                .hit        (way_hit[g])
            );
        end
    endgenerate

    /* ── OR-tree: hit global ────────────────────────────────────────── */
    assign hit = |way_hit;

    /* ── MUX W:1 sobre los datos ────────────────────────────────────── */
    /* Prioridad: vía de menor índice con hit gana (DM: W=1, selección trivial) */
    reg [D-1:0] mux_result;
    integer k;
    always @(*) begin
        mux_result = data_lines[0 +: D];        /* default: vía 0 */
        for (k = W-1; k >= 1; k = k - 1)
            if (way_hit[k])
                mux_result = data_lines[k*D +: D];
    end

    assign data_out = mux_result;

endmodule
