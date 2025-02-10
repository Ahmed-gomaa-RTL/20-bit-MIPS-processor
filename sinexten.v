module sinexten (
    input [9:0] imm,       // 10-bit immediate input
    input extd,            // Extension control signal
    output reg [19:0] extenstion // 19-bit extension value
);

always @(*) begin
    if (extd == 1) begin
        extenstion <= { {10{imm[9]}}, imm }; // Sign extension
    end else begin
        extenstion <= {10'b0000000000, imm}; // Zero extension
    end
end

endmodule

