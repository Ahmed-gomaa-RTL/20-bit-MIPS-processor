module alu (
    input  [19:0] a,       // input 1
    input  [19:0] b,       // input 2
    input  [3:0]  aluop,   // choose the operation done by the ALU (from the ALU control block)
    output        zeros,   // flags 1 when the result of the operation is zero
    output reg [19:0] result // output of the ALU operation chosen by aluop
);

always @(*) begin
    case (aluop)
        // ADD
        4'b0001: result = a + b;

        // SUB
        4'b0010: result = a - b;

        // AND
        4'b0011: result = a & b;

        // OR
        4'b0100: result = a | b;

        // SLT (Set Less Than)
        4'b0101: result = (a < b) ? 1 : 0;

        // ADDI (Add Immediate)
        4'b0110: result = a + b;

        // ANDI (AND Immediate)
        4'b0111: result = a & b;

        // STW (Store Word)
        4'b1000: result = a + b;

        // STORE
        4'b1001: result = a + b;

        // STORE
        4'b1010: result = a + b;

        // BEQ (Branch if Equal)
        4'b1011: result = a - b;

        // JMEM
        4'b1100: result = a + b;

        // Default case
        default: result = 0; // if aluop is not one of the above, set result to 0
    endcase
end

// Zero flag: flags 1 when result is zero
assign zeros = (result == 0);

endmodule
