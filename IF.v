module IF (
    input                 clk, // Clock signal
    input          [19:0] result_increment_pc_input, // Input: Incremented PC value
    input          [19:0] instruction_input,        // Input: Instruction to be fetched
    output   reg   [19:0] result_increment_pc_output, // Output: Incremented PC value
    output   reg   [19:0] instruction_output          // Output: Fetched instruction
);

always @(posedge clk) begin
    // On the rising edge of the clock, update the outputs
    result_increment_pc_output <= result_increment_pc_input;
    instruction_output <= instruction_input;
end

endmodule
