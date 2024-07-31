module Instruction_Memory (rst,A,RD);

   input [31:0] A;
   input rst;

   output [31:0] RD;

   reg [31:0] Mem [1023:0];   // creating memory // reg is the mem of 32 bit have 1024 resisters in it of 32 bit

   // Mem[A];   // giving instruction at the location A

   assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];

   initial begin
      Mem[0] = 32'hFFC4A303;
      Mem[1] = 32'h00832383;
   end

endmodule