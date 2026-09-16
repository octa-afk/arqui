// CLOCK DIVIDER

module clkDiv #(parameter bit SIM = 0)
					(input logic clk,
					input logic reset,
					output logic clkDiv);

	logic [20:0] clk_divider;

	always_ff @(posedge clk, posedge reset)
		if(reset) clk_divider  <= '0;
		else clk_divider <= clk_divider + 1;

	// SIM=1: bit rapido, para analizar en simulador
	// SIM=0: bit lento, para grabar en FPGA
	generate
		if (SIM) begin : gen_sim
			assign clkDiv = clk_divider[0];
		end else begin : gen_hw
			assign clkDiv = clk_divider[20];
		end
	endgenerate

endmodule
