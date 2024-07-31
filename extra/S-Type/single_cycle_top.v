`include "program_counter.v"
`include "instruction_memory.v"
`include "register_files.v"
`include "sign_extend.v"
`include "ALU.v"
`include "control_unit_top.v"
`include "data_memory.v"
`include "PC_adder.v"

module Single_Cycle_Top (clk,rst);

    input clk,rst;

    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top;
    wire RegWrite,MemWrite;
    wire [1:0] ImmSrc;
    wire [2:0]ALU_Control_Top;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder (
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    Instruction_Memory Instruction_Memory(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    Register_File Register_File(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(ReadData),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .Imm_Ext(Imm_Ext_Top),
        .ImmSrc(ImmSrc[0])
    );

    ALU ALU(
        .A(RD1_Top),
        .B(Imm_Ext_Top),
        .Result(ALUResult),
        .ALUControl(ALU_Control_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(),
        .MemWrite(),
        .ResultSrc(),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(),
        .ALUControl(ALU_Control_Top)
    );

    Data_Memory Data_Memory (
        .clk(clk),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALUResult),
        .RD(ReadData)
    );

endmodule