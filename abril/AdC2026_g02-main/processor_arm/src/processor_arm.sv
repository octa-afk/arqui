// TOP-LEVEL PROCESSOR (placa Boolean)
// Instancia el processor_core (CPU + memorias) y le agrega los perifericos
// de la placa: switches/LEDs mapeados en memoria, displays de 7 segmentos
// y el divisor de clock.

module processor_arm #(parameter N = 64, parameter bit PIPELINE = 0, parameter bit SIM = 0)
							(input logic [15:0] i_sw,
                             input logic i_mclk,
                             input logic i_reset,
                             output logic [15:0] o_led,
                             output [7:0] D0_seg, D1_seg,
                             output [3:0] D0_a, D1_a,
						  	 input	logic dump);

	logic mclk;
	logic [N-1:0] DM_writeData, DM_addr;
	logic DM_writeEnable;
	logic [28:0] cnt29 = 29'd0;

	clkDiv #(.SIM(SIM)) cD 	(.clk (i_mclk),
					.reset (i_reset),
					.clkDiv (mclk));

	processor_core #(.N(N), .PIPELINE(PIPELINE)) core
									(.CLOCK_50(mclk),
									.reset(i_reset),
									.DM_writeData(DM_writeData),
									.DM_addr(DM_addr),
									.DM_writeEnable(DM_writeEnable),
									.dump(dump),
									.mmio_sel(DM_addr == 64'h8000),
									.mmio_readData({48'b0, i_sw}));

	always_ff @(posedge mclk)
		if (DM_addr == 64'h8008)
		  o_led <= DM_writeData[15:0];

	disp7seg_controller dispA(  .clk(cnt29[13]),
	                            .bcd_dig({4'h0, 4'hC, 4'hD, 4'hA}),
	                            .blank_dig(4'b0001),
	                            .seg(D0_seg),
	                            .dig_en(D0_a));

	disp7seg_controller dispB(  .clk(cnt29[13]),
	                            .bcd_dig({4'h5, 4'h2, 4'h0, 4'h2}),
	                            .blank_dig(4'b0000),
	                            .seg(D1_seg),
	                            .dig_en(D1_a));

	always_ff @(posedge i_mclk) cnt29 <= cnt29 + 1;

endmodule
