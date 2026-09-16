module dmem (input  logic        clk, memWrite, memRead,
             input  logic [5:0]  address,
             input  logic [63:0] writeData,
             output logic [63:0] readData,
             input  logic        dump);

	localparam MAX_BOUND = 64;
	localparam MEMORY_DUMP_FILE = "mem.dump";

	logic [63:0] mem [MAX_BOUND-1:0];

	always_ff @(posedge clk)
		if (memWrite)
			mem[address] <= writeData;

	always_comb
		if (memRead) readData = mem[address];
		else         readData = '0;

	always_ff @(posedge dump) begin
		integer dumpfile;
		integer i;
		dumpfile = $fopen(MEMORY_DUMP_FILE, "w");
		$fdisplay(dumpfile, "Memoria RAM de Arm:");
		$fdisplay(dumpfile, "Address Data");
		for (i = 0; i <= MAX_BOUND-1; i = i+1) begin
			$fdisplay(dumpfile, "%0d %016h", i, mem[i]);
		end
		$fclose(dumpfile);
		$display("fin del testdump");
	end

endmodule
