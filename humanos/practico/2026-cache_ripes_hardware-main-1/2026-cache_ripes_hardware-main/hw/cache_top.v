/*
 * cache_top.v — Wrapper de síntesis que combina cache_comparator + plru_state
 *
 * Este módulo existe solo para síntesis con Yosys.
 * Al instanciar ambos submódulos, el stat final incluye:
 *   - Celdas combinacionales: comparadores de tag + MUX de datos
 *   - Flip-flops: estado PLRU (S × (W-1) FFs)
 *
 * Los parámetros se pasan a cache_top y éste los delega a los submódulos.
 */

`default_nettype none

module cache_top #(
    parameter W = 4,    /* asociatividad */
    parameter T = 26,   /* bits de tag */
    parameter D = 128,  /* bits de datos por línea */
    parameter S = 4     /* número de sets */
)(
    input                      clk,
    input                      rst,

    /* Puerto de comparación (cache_comparator) */
    input  [T-1:0]             addr_tag,
    input  [W*T-1:0]           stored_tags,
    input  [W-1:0]             valid,
    input  [W*D-1:0]           data_lines,
    output                     hit,
    output [D-1:0]             data_out,

    /* Puerto de reemplazo (plru_state) */
    input  [W-1:0]             access_way,
    output [W-1:0]             replace_way
);

    /* ── Lógica de hit-detection ────────────────────────────── */
    cache_comparator #(
        .W(W), .T(T), .D(D)
    ) u_cmp (
        .addr_tag    (addr_tag),
        .stored_tags (stored_tags),
        .valid       (valid),
        .data_lines  (data_lines),
        .hit         (hit),
        .data_out    (data_out)
    );

    /* ── Estado de reemplazo PLRU ───────────────────────────── */
    /* set_idx: usa los bits de índice del addr para seleccionar el set.
     * Aquí simplificado a log2(S) bits; en la práctica viene del decodificador. */
    localparam S_BITS = (S > 1) ? $clog2(S) : 1;
    wire [S_BITS-1:0] set_idx = addr_tag[S_BITS-1:0]; /* simplificado */

    plru_state #(
        .W(W), .S(S)
    ) u_plru (
        .clk         (clk),
        .rst         (rst),
        .set_idx     (set_idx),
        .access_way  (access_way),
        .replace_way (replace_way)
    );

endmodule
