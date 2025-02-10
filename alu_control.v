module alu_control (
    input  [2:0] aluop,  // ALU operation code
    input  [3:0] func,   // Function code for R-type instructions
    output reg [3:0] out // Output ALU control signal
);

always @(*) begin
    if (aluop == 3'b000) begin // R-type instructions
        case (func)
            4'b0001: out = 4'b0001; // ADD
            4'b0010: out = 4'b0010; // SUB
            4'b0011: out = 4'b0011; // AND
            4'b0100: out = 4'b0100; // OR
            4'b0101: out = 4'b0101; // SLT
            default: out = 4'b1111; // Default case
        endcase
    end
    else begin // Non-R-type instructions
        case (aluop)
            3'b001: out = 4'b0110; // ADDI
            3'b010: out = 4'b0111; // ANDI
            3'b011: out = 4'b1000; // STW
            3'b101: out = 4'b1001; // STORE
            3'b100: out = 4'b1010; // LOAD
            3'b110: out = 4'b1011; // BEQ
            3'b111: out = 4'b1100; // JMEM
            default: out = 4'b1111; // Default case
        endcase
    end
end

endmodule
