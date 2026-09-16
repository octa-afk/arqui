// Testbench ProcessorPatterson (top de placa Boolean)
// Top-level Entity: processor_arm

module processor_arm_tb();
	logic [15:0] i_sw;
	logic        i_mclk;
	logic        i_reset;
	logic [15:0] o_led;
	logic [7:0]  D0_seg, D1_seg;
	logic [3:0]  D0_a, D1_a;
	logic        dump;

  // instantiate device under test
  // SIM=1: clkDiv usa el bit rapido para simulacion (si no, el reloj interno
  // tarda 2^20 ciclos de i_mclk en alternar una vez)
  processor_arm #(.PIPELINE(0), .SIM(1)) dut (
      .i_sw(i_sw),
      .i_mclk(i_mclk),
      .i_reset(i_reset),
      .o_led(o_led),
      .D0_seg(D0_seg),
      .D1_seg(D1_seg),
      .D0_a(D0_a),
      .D1_a(D1_a),
      .dump(dump));

  // generate clock
  always     // no sensitivity list, so it always executes
    begin
      #10 i_mclk = ~i_mclk;
    end


  initial
    begin
      i_mclk = 0; i_reset = 1; i_sw = 1; dump = 0;
      #20 i_reset = 0;
      #400 dump = 1;
	   #20 $stop;
	end
endmodule
