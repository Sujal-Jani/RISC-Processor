module alu(A,B,ALUControl,Result);
    // declaring inputs
    input [31:0] A,B;  // 32 bits variable
    input [2:0] ALUControl;

    // declaring outputs
    output [31:0] Result;

    // declaring interim wires
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;

    wire [31:0] mux_1;

    wire [31:0] sum;

    wire [31:0] mux_2;

    // logic design
    // AND Operation
    assign a_and_b = A & B;

    // OR Operation
    assign a_or_b = A | B;

    // NOT Operation
    assign not_b = ~B;

    // Ternary Operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;

    // Addition / Subtraction Operation
    assign sum = A + mux_1 + ALUControl[0];

    // Designing 4by1 Mux
    assign mux_2 = (ALUControl[1:0] == 2'b00) ? sum :              //if
                   (ALUControl[1:0] == 2'b01) ? sum :              //else if
                   (ALUControl[1:0] == 2'b10) ? a_and_b : a_or_b;  //else if //else 

    // Result
    assign Result = mux_2;

endmodule;  


module ALU(A,B,ALUControl,Result,Z,N,V,C);
    // declaring inputs
    input [31:0] A,B;  // 32 bits variable
    input [2:0] ALUControl;

    // declaring outputs
    output [31:0] Result;
    output [31:0] Z,N,V,C;

    // declaring interim wires
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;

    wire [31:0] mux_1;

    wire [31:0] sum;

    wire [31:0] mux_2;

    wire [31:0] slt;

    wire cout;

    // logic design
    // AND Operation
    assign a_and_b = A & B;

    // OR Operation
    assign a_or_b = A | B;

    // NOT Operation
    assign not_b = ~B;

    // Ternary Operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;

    // Addition / Subtraction Operation
    assign {cout,sum} = A + mux_1 + ALUControl[0];

    // Zero Extension
    assign slt = {31'b0000000000000000000000000000000,sum[31]};

    // Designing 4by1 Mux
    assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum :              //if
                   (ALUControl[2:0] == 3'b001) ? sum :              //else if
                   (ALUControl[2:0] == 3'b010) ? a_and_b :          //else if
                   (ALUControl[2:0] == 3'b011) ? a_or_b :           //else if 
                   (ALUControl[2:0] == 3'b101) ? slt : 31'h00000000;  //else if //else 

    // Result
    assign Result = mux_2;

    // flags Assignment
    assign Z = &(~Result);  // zero flag

    assign N = Result[31];  // first digit is zero or one tell the number is -ve or +ve

    assign C = cout & (~ALUControl[1]);  // carru flag

    assign V = ((~ALUControl[1]) & (A[31] ^ Sum[31]) & (~(ALUControl[0] ^ A[31] ^ B[31])));

endmodule;  


