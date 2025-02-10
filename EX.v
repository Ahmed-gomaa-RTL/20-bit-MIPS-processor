module EX (
    input clk, // Clock signal
    input [19:0] write_destination, // Input: Write destination
    input zero_flaf,                // Input: Zero flag
    input [19:0] alu_output,        // Input: ALU output
    input [19:0] result_shift_jump, // Input: Result of shift/jump
    input [19:0] result_adder_branch, // Input: Result of adder for branch
    input [19:0] Read_data1,        // Input: Read data 1
    input [19:0] read_data2,        // Input: Read data 2
    input [19:0] output_adder_increment_pc, // Input: Output of adder for PC increment
    input memwrite, memread, branch, j, jmem, stw, regwrite, // Control signals

    output reg [19:0] out_write_destination, // Output: Write destination
    output reg out_zero_flaf,                // Output: Zero flag
    output reg [19:0] out_alu_output,        // Output: ALU output
    output reg [19:0] out_result_shift_jump, // Output: Result of shift/jump
    output reg [19:0] out_result_adder_branch, // Output: Result of adder for branch
    output reg [19:0] out_Read_data1,        // Output: Read data 1
    output reg [19:0] out_read_data2,        // Output: Read data 2
    output reg [19:0] out_output_adder_increment_pc, // Output: Output of adder for PC increment
    output reg out_memwrite, out_memread, out_branch, out_j, out_jmem, out_stw, out_regwrite // Output control signals
);

always @(posedge clk) begin
    // On the rising edge of the clock, update the outputs with the inputs
    out_write_destination <= write_destination;
    out_zero_flaf <= zero_flaf;
    out_alu_output <= alu_output;
    out_result_shift_jump <= result_shift_jump;
    out_result_adder_branch <= result_adder_branch;
    out_Read_data1 <= Read_data1;
    out_read_data2 <= read_data2;
    out_output_adder_increment_pc <= output_adder_increment_pc;
    out_memwrite <= memwrite;
    out_memread <= memread;
    out_branch <= branch;
    out_j <= j;
    out_jmem <= jmem;
    out_stw <= stw;
    out_regwrite <= regwrite;
end

endmodule
