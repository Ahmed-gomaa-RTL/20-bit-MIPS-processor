module data_memory (
    input clk,                   // Clock signal
    input [19:0] read_address,   // Address to read from
    input [19:0] write_address,  // Address to write to
    input [19:0] write_data,     // Data to write
    input memwrite,              // Write enable signal
    input memread,               // Read enable signal
    output reg [19:0] read_data  // Data read from memory
);

// Define memory as an array with 1001 elements (1 MB)
reg [19:0] memory [0:1000];

// Initialize memory with predefined values
initial begin
    memory[14] = 20'b0000_0000_0000_0000_0001;
    memory[3]  = 20'b0000_0000_0000_0000_0010;
    memory[0]  = 20'b0000_0000_0000_0000_0011;
    memory[16] = 20'b0000_0000_0000_0000_0100;
    memory[7]  = 20'b0000_0000_0000_0000_0101;
    memory[4]  = 20'b0000_0000_0000_0000_0110;
    memory[12] = 20'b0000_0000_0000_0000_0111;
    memory[6]  = 20'b0000_0000_0000_0000_1000;
    memory[8]  = 20'b0000_0000_0000_0000_1001;
    memory[15] = 20'b0000_0000_0000_0000_1010;
    memory[5]  = 20'b0000_0000_0000_0000_1011;
    memory[9]  = 20'b0000_0000_0000_0000_1100;
    memory[13] = 20'b0000_0000_0000_0000_1101;
    memory[1]  = 20'b0000_0000_0000_0000_1110;
    memory[19] = 20'b0000_0000_0000_0000_0011;
    memory[1]  = 20'b0000_0000_0000_0000_0011;
    memory[2]  = 20'b0000_0000_0000_0000_0001;
    memory[10] = 20'b0000_0000_0000_0000_0010;
    memory[11] = 20'b0000_0000_0000_0000_0100;
    memory[17] = 20'b0000_0000_0000_0000_1000;
    memory[18] = 20'b0000_0000_0000_0000_1001;
    memory[20] = 20'b0000_0000_0000_0000_0101;
    memory[21] = 20'b0000_0000_0000_0000_0111;
    memory[22] = 20'b0000_0000_0000_0000_0110;
    memory[23] = 20'b0000_0000_0000_0000_0000;
    memory[24] = 20'b0000_0000_0000_0000_1010;
    memory[25] = 20'b0000_0000_0000_0000_1001;
    memory[26] = 20'b0000_0000_0000_0000_0101;
    memory[27] = 20'b0000_0000_0000_0000_0011;
    memory[28] = 20'b0000_0000_0000_0000_0010;
    memory[29] = 20'b0000_0000_0000_0000_0001;
    memory[30] = 20'b0000_0000_0000_0000_0001;
end

// Read operation (combinational logic)
always @(*) begin
    if (memread) begin
        read_data <= memory[read_address];
    end
end

// Write operation (sequential logic, triggered on clock edge)
always @(posedge clk) begin
    if (memwrite) begin
        memory[write_address] <= write_data;
    end
end

endmodule
