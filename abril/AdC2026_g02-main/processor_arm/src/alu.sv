module alu (input logic [63:0] a, b,
            input logic [3:0] ALUControl,
            output logic zero, 
            output logic [63:0] result);
            always_comb 
              begin
                case (ALUControl)
                     4'b0000: result = a & b; //AND
                     4'b0001: result = a | b; //OR
                     4'b0010: result = a + b; //add
                     4'b0110: result = a - b; //sub
                     4'b0111: result = b; //pass input b
                     default: result = '0;
                endcase
                if (!result) zero=1;
                else zero=0;
              end    
endmodule

