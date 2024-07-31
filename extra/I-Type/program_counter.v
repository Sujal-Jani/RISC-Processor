module PC_Module (clk,rst,PC,PC_Next);

    input [31:0] PC_Next;
    input clk,rst;

    output reg [31:0] PC;   // reg considered PC a register

    always @(posedge clk) 
    begin

    if (rst == 1'b0)
        begin
            PC <= 32'h00000000;
        end
    else
        begin
            PC <= PC_Next;  
        end

    end
    
endmodule