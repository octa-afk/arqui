`timescale 1ns / 1ps

module regfile_tb ();
    
    logic clk;
    logic we3;
    logic [4:0] ra1;
    logic [4:0] ra2;
    logic [4:0] wa3;
    logic [63:0] wd3;
    logic [63:0] rd1;
    logic [63:0] rd2;

    regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);

    //clock cada 10 ns
    always begin
        clk = 0; #5; clk = 1; #5; //periodos de 10 ns
    end

    initial begin
        //caso 1, verifico los valores de la inicializacion
        #5
        for(int i = 0; i < 32; i++) begin
            ra1 = i;
            ra2 = i;
            
            @(negedge clk); //espero el flanco descendente y verifico
            
            #1;

            if(i < 31) begin
                if((rd1 == i) & (rd2 == i))
                    $display("correcto");
                else
                    $display("error: x%0d, rd1 = %0d, rd2 = %0d",i, rd1, rd2);
            end
            else begin
                if((rd1 == 64'b0) & (rd2 == 64'b0))
                    $display("correcto");
                else
                    $display("error: x%0d, rd1 = %0d, rd2 = %0d",i, rd1, rd2);
            end

        end

        //caso 2: escritura y lectura en el mismo flanco de clock
        //preparo las entradas 
        wa3 = 5'd15; 
        wd3 = 64'd1100;   //quiero escribir 1100 en el registro 15
        we3 = 1;         //habilito el enable(permiso de escribir)

        @(posedge clk); //espero al flanco positivo
        
        #1;    
        we3 = 0;         //desactivo el enable

        ra1 = 5'd15;     //leo el registro
        
        #1;

        if(rd1 == 64'd1100)
            $display("correcto");
        else
            $display("error caso 2: x15 = %0d",rd1);

        //caso 3: enable de write es 0
        //preparo las entradas

        wa3 = 5'd5;   
        wd3 = 64'd1000;  //intento escribir 1000 en en el registro 5
        we3 = 0;        //permiso desactivado

        @(posedge clk); //espero al flanco positivo
    
        ra1 = 5'd5;     //leo el registro
        
        #1;

        if(rd1 == 64'd5)
            $display("correcto");
        else
            $display("error caso 3: x5 = %0d",rd1);

        //caso 4: intentar escribir XZR
        //preparo las entradas
        wa3 = 5'd31;
        wd3 = 64'd1200;             //intento escribir 1200 en el registro xzr
        we3 = 1;         //escritura habilitada
        
        @(posedge clk);

        ra1 = 5'd31;     //leo
        ra2 = 5'd31;     //leo
        
        #1;

        if((rd1 == 64'b0) & (rd2 == 64'b0))
            $display("correcto");
        else
            $display("error caso 4: rd1 = %h, rd2 = %h", rd1, rd2);       

        $stop;
    
    end

endmodule