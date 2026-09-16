`timescale 1ns/10ps

module flopr_tb_64 ();
   logic clk, reset; 
   logic [63:0] q, d; 
   flopr #(64) dut(clk, reset, d, q);
   //reloj
   always 
      begin
         clk=0; #5; clk=1; #5; 
      end
  
   initial 
      begin
         reset= 1;
         d= 64'd99; #10;
         if (q !== 64'd0) $display("Error: q debería ser 0");
         d= 64'd1000; #10;
         if (q !== 64'd0) $display ("Error: q debería ser 0");
         d= 64'd46; #10;
         if (q !== 64'd0) $display("Error: q debería ser 0");
         d= 64'd62; #10;
         if (q !== 64'd0) $display("Error: q debería ser 0");
         d= 64'd72; #10;
         if (q !== 64'd0) $display("Error: q debería ser 0");
         reset= 0;
         d= 64'd1; #10;
         if (q !== 64'd1) $display("Error: q debería ser 1");
         d= 64'd0; #10;
         if (q !== 64'd0) $display("Error: q debería ser 0");
         d= 64'd12; #10;
         if (q !== 64'd12) $display ("Error: q debería ser 12");
         d= 64'd55; #10;
         if (q !== 64'd55) $display("Error: q debería ser 55");
         d= 64'd503; #10;
         if (q !== 64'd503) $display("Error: q debería ser 503");
         $stop; // Detiene la simulación 
      end
endmodule
