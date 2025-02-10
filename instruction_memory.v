module instruction_memory_pipeline (
    input [19:0] counter_in, // Input: Program counter (PC) value
    output reg [19:0] instruction // Output: Instruction fetched from memory
);

// Define the instruction memory as an array of 13 instructions, each 20 bits wide
reg [19:0] input_code [0:12];

// Initialize the instruction memory with predefined instructions
initial begin
    input_code[0]  = 20'b0001_0000_0100_0000_1010; // addi imm value 10
    input_code[1]  = 20'b0000_0100_1100_0000_0010; // sub
    input_code[2]  = 20'b0000_0101_0010_1000_0011; // and
    input_code[3]  = 20'b0000_0000_0101_0000_0001; // add
    input_code[4]  = 20'b0000_0101_0001_0000_0100; // or
    input_code[5]  = 20'b0010_1011_0000_0000_0111; // andi imm value 7
    input_code[6]  = 20'b0011_0000_1100_0000_1010; // stw imm value 10
    input_code[7]  = 20'b0100_1100_1000_0000_0011; // lw imm value 3
    input_code[8]  = 20'b0000_1001_1100_1000_0101; // slt
    input_code[9]  = 20'b0110_1001_0100_0000_0001; // beq imm value 13
    input_code[10] = 20'b0101_0100_1100_0000_0101; // sw imm value 5
    input_code[11] = 20'b1000_0110_0100_0000_0110; // jmem imm value 6
    input_code[12] = 20'b0111_0000_0000_0000_0010; // jump
end

// Fetch instruction based on the program counter (PC) value
always @(*) begin
    instruction <= input_code[counter_in];
end

endmodule
