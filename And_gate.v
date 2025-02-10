module And_gate (
    input  a,   // Input a
    input  b,   // Input b
    output reg out // Output of the AND gate
);

always @(*) begin
    out = a & b; // Perform AND operation
end

endmodule
