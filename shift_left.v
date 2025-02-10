module shift_left (
    input [19:0] imm,   // 20-bit input
    output reg [19:0] out // 20-bit output after left shift
);

always @(*) begin
    out <= imm << 2; // Shift left by 2 bits
end

endmodule

