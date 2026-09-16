// PROCESSOR CORE (CPU + memorias)
// Jerarquia baja: interfaz pensada para el testbench (processor_tb.sv).
// El top de placa (processor_arm.sv) instancia este modulo y le agrega
// los perifericos de la Boolean (switches, LEDs, displays, clkDiv).

module processor_core #(parameter N = 64, parameter bit PIPELINE = 0)
							(input logic CLOCK_50, reset,
							output logic [N-1:0] DM_writeData, DM_addr,
							output logic DM_writeEnable,
							input	logic dump,
							input logic mmio_sel = 1'b0,
							input logic [N-1:0] mmio_readData = '0);

	logic [31:0] q;
	logic [10:0] instr;
	logic [3:0] AluControl;
	logic reg2loc, regWrite, AluSrc, Branch, memtoReg, memRead, memWrite;
	logic [N-1:0] DM_readData_mem, DM_readData, IM_address;
	logic DM_readEnable;

	generate
		if (PIPELINE) begin : gen_pipeline_ctrl
			flopr #(11)	IF_ID_TOP(.clk(CLOCK_50),
										.reset(reset),
										.d(q[31:21]),
										.q(instr));
		end else begin : gen_single_ctrl
			assign instr = q[31:21];
		end
	endgenerate

	controller 		c 			(.instr(instr),
									.AluControl(AluControl),
									.reg2loc(reg2loc),
									.regWrite(regWrite),
									.AluSrc(AluSrc),
									.Branch(Branch),
									.memtoReg(memtoReg),
									.memRead(memRead),
									.memWrite(memWrite));


	datapath #(.N(64), .PIPELINE(PIPELINE)) dp 		(.reset(reset),
									.clk(CLOCK_50),
									.reg2loc(reg2loc),
									.AluSrc(AluSrc),
									.AluControl(AluControl),
									.Branch(Branch),
									.memRead(memRead),
									.memWrite(memWrite),
									.regWrite(regWrite),
									.memtoReg(memtoReg),
									.IM_readData(q),
									.DM_readData(DM_readData),
									.IM_addr(IM_address),
									.DM_addr(DM_addr),
									.DM_writeData(DM_writeData),
									.DM_writeEnable(DM_writeEnable),
									.DM_readEnable(DM_readEnable));


	imem 				instrMem (.addr(IM_address[8:2]),
									.q(q));


	dmem 				dataMem 	(.clk(CLOCK_50),
									.memWrite(DM_writeEnable),
									.memRead(DM_readEnable),
									.address(DM_addr[8:3]),
									.writeData(DM_writeData),
									.readData(DM_readData_mem),
									.dump(dump));


	assign DM_readData = mmio_sel ? mmio_readData : DM_readData_mem;

endmodule
