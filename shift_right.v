module shift_right (
    input [19:0] imm, // Input: Immediate value
    output reg [19:0] out // Output: Shifted value
);

always @(*) begin
    // Perform a right shift by 2 bits
    out <= imm >> 2;
end

endmodule
