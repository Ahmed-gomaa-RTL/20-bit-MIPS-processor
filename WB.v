module WB (
    input clk, // Clock signal
    input [19:0] result_shift_jump, // Result of shift/jump
    input [19:0] result_adder_branch, // Result of adder for branch
    input branch, j, jmem, stw, regwrite, // Control signals
    input [19:0] write_destination, // Write destination
    input [19:0] read_data_memory, // Data read from memory
    input [19:0] alu_output, // ALU output
    input output_and_gate, // Output of AND gate (branch condition)
    input [19:0] adder1_output, // Output of adder for PC increment

    output reg [19:0] out_result_shift_jump, // Output: Result of shift/jump
    output reg [19:0] out_result_adder_branch, // Output: Result of adder for branch
    output reg out_branch, out_j, out_jmem, out_stw, out_regwrite, // Output control signals
    output reg [19:0] out_write_destination, // Output: Write destination
    output reg [19:0] out_read_data_memory, // Output: Data read from memory
    output reg [19:0] out_alu_output, // Output: ALU output
    output reg [19:0] out_adder1_output, // Output: Adder output for PC increment
    output reg out_output_and_gate // Output: AND gate result (branch condition)
);

always @(posedge clk) begin
    // On the rising edge of the clock, update the outputs with the inputs
    out_result_shift_jump <= result_shift_jump;
    out_result_adder_branch <= result_adder_branch;
    out_branch <= branch;
    out_j <= j;
    out_jmem <= jmem;
    out_stw <= stw;
    out_regwrite <= regwrite;
    out_write_destination <= write_destination;
    out_read_data_memory <= read_data_memory;
    out_alu_output <= alu_output;
    out_output_and_gate <= output_and_gate;
    out_adder1_output <= adder1_output;
end

endmodule
