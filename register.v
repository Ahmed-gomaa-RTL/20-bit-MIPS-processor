module register (
    input clk, // Clock signal
    input reg_write, // Register write enable signal
    input [2:0] read_register1, // Read register 1 address
    input [2:0] read_register2, // Read register 2 address
    input [2:0] write_register, // Write register address
    output reg [19:0] read_data1, // Read data 1
    output reg [19:0] read_data2, // Read data 2
    input [19:0] write_data // Write data
);

// Define the register file with 8 registers, each 20 bits wide
reg [19:0] register [0:7];

// Initialize the register file with predefined values
initial begin
    register[0] = 20'b0000_0000_0000_0000_0100; // 4
    register[1] = 20'b0000_0000_0000_0000_1100; // 12
    register[2] = 20'b0000_0000_0000_0000_0110; // 6
    register[3] = 20'b0000_0000_0000_0000_0011; // 3
    register[4] = 20'b0000_0000_0000_0000_1000; // 8
    register[5] = 20'b0000_0000_0000_0000_1111; // 15
    register[6] = 20'b0000_0000_0000_0000_0101; // 5
    register[7] = 20'b0000_0000_0000_0000_1001; // 9
end

// Write operation (sequential logic, triggered on clock edge)
always @(posedge clk) begin
    if (reg_write == 1'b1) begin
        register[write_register] <= write_data; // Write data to the specified register
    end
end

// Read operation (combinational logic)
always @(*) begin
    read_data1 <= register[read_register1]; // Read data from register 1
    read_data2 <= register[read_register2]; // Read data from register 2
end

endmodule
