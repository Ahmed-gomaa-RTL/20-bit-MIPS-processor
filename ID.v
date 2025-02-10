module ID (
    input clk, // Clock signal
    input regdest, regwrite, alusrc, memread, memwrite, memtoreg, j, branch, jmem, stw, // Control signals
    input [2:0] aluop, // ALU operation code
    input [19:0] result_shift_jump, // Result of shift/jump
    input [19:0] output_adder_increment_pc, // Output of adder for PC increment
    input [19:0] read_data1, // Read data 1
    input [19:0] read_data2, // Read data 2
    input [19:0] output_sign_extention, // Output of sign extension
    input [19:0] instruction, // Instruction

    output reg out_regdest, out_regwrite, out_alusrc, out_memread, out_memwrite, out_memtoreg, out_j, out_branch, out_jmem, out_stw, // Output control signals
    output reg [2:0] out_aluop, // Output ALU operation code
    output reg [19:0] out_result_shift_jump, // Output result of shift/jump
    output reg [19:0] out_output_adder_increment_pc, // Output of adder for PC increment
    output reg [19:0] out_read_data1, // Output read data 1
    output reg [19:0] out_read_data2, // Output read data 2
    output reg [19:0] out_output_sign_extention, // Output of sign extension
    output reg [19:0] out_instruction // Output instruction
);

always @(posedge clk) begin
    // On the rising edge of the clock, update the outputs with the inputs
    out_regdest <= regdest;
    out_regwrite <= regwrite;
    out_alusrc <= alusrc;
    out_memread <= memread;
    out_memwrite <= memwrite;
    out_memtoreg <= memtoreg;
    out_j <= j;
    out_branch <= branch;
    out_jmem <= jmem;
    out_stw <= stw;
    out_aluop <= aluop;
    out_result_shift_jump <= result_shift_jump;
    out_output_adder_increment_pc <= output_adder_increment_pc;
    out_read_data1 <= read_data1;
    out_read_data2 <= read_data2;
    out_output_sign_extention <= output_sign_extention;
    out_instruction <= instruction;
end

endmodule
