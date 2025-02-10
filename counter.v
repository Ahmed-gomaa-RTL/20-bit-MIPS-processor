module counter (
    input clk,         // Clock signal
    input rst,         // Reset signal
    input [19:0] next, // Next value for the program counter (PC)
    output reg [19:0] pc // Output: Program counter (PC)
);

// Initialize the program counter to 0
initial begin
    pc = 20'b0000_0000_0000_0000_0000;
end

always @(posedge clk) begin
    if (rst == 1'b1) begin
        // Reset the program counter to 0
        pc <= 20'b0000_0000_0000_0000_0000;
    end
    else begin
        // Update the program counter with the next value
        pc <= next;
    end
end

endmodule
