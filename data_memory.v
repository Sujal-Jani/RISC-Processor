module Data_Memory (clk,rst,WE,WD,A,RD);

    input clk,rst,WE;
    input [31:0] A,WD;

    output [31:0] RD;

    reg [31:0] Data_Mem [1023:0];

    //write
    always @(posedge clk) begin

        if (WE)
            begin
                Data_Mem[A] <= WD;
            end
        
    end

    //read
    //assign RD = (WE == 1'b0) ? Data_Mem[A] : 32'h00000000;
    assign RD = (~rst) ? 32'd0 : Data_Mem[A];

    initial begin
        Data_Mem[28] = 32'h00000020;
        Data_Mem[40] = 32'h00000002;
    end

endmodule