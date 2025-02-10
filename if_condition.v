module if_condition (
    input clk, // Clock signal
    input j,   // Jump control signal
    input beq, // Branch if equal control signal
    input jmem, // Jump memory control signal
    input [19:0] pc_before, // Current PC value
    input [19:0] jump_value, // Jump target address
    input [19:0] beq_value,  // Branch target address
    input [19:0] jmem_value, // Jump memory target address
    output reg [19:0] next_pc // Next PC value
);

always @(posedge clk) begin
    if (j == 1'b1) begin
        // Jump: Set next_pc to jump_value
        next_pc <= jump_value;
    end
    else if (beq == 1'b1) begin
        // Branch if equal: Set next_pc to beq_value
        next_pc <= beq_value;
    end
    else if (jmem == 1'b1) begin
        // Jump memory: Set next_pc to jmem_value
        next_pc <= jmem_value;
    end
    else begin
        // Default: Increment PC by 4 (next instruction)
        next_pc <= pc_before + 20'b0000_0000_0000_0000_0100;
    end
end

endmodule
