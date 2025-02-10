module pipeline (
    input clk, // Clock signal
    input rst  // Reset signal
);

// Internal wires and registers
wire [19:0] pc_in; // Wires into the PC from jump and branch
wire [19:0] pc_out; // Wires out of the PC
wire [19:0] new_pc; // Used to shift PC value twice to get PC+4
wire [19:0] adder1_output; // Increment PC with 4
wire [19:0] instruction_wire; // Wires out of the instruction memory
wire [19:0] adder1_output_out1; // Output of IF/ID register for adder1
wire [19:0] instruction_wire_out1; // Output of IF/ID register for instruction memory
wire [19:0] read_data1; // Read data 1 from register file
wire [19:0] read_data2; // Read data 2 from register file
wire [19:0] sign_extension; // Sign extension output value
wire [19:0] alusrc_mux_output;
wire [2:0] stw_mux_output;
wire [19:0] alu_result;
wire zeros;
wire [2:0] regdst_mux_output;
wire [19:0] shift2_output;
wire [19:0] branch_result;
wire [17:0] output_shift1; // Shift for address (jump)
wire [17:0] output_shift1_out2; // Shift for address (jump) after being stored in register
wire [19:0] adder1_output_out2; // Output of ID/EX register for adder1
wire [19:0] read_data1_out2; // Read data 1 from register file
wire [19:0] read_data2_out2; // Read data 2 from register file
wire [19:0] sign_extension_out2; // Sign extension output value
wire [19:0] instruction_wire_out2; // Output of ID/EX register for instruction memory
wire [3:0] alu_operation; // Output of the ALU control
wire [2:0] stw_mux_output_out3;
wire zeros_out3;
wire [19:0] alu_result_out3;
wire [17:0] output_shift1_out3;
wire [19:0] branch_result_out3;
wire [19:0] read_data1_out3;
wire [19:0] read_data2_out3;
wire [19:0] adder1_output_out3;
wire memwrite1_out3;
wire memread1_out3;
wire branch1_out3;
wire j1_out3;
wire jmem1_out3;
wire stw1_out3;
wire regwrite1_out3;
wire out_and;
wire [19:0] output_read_address_mem;
wire [19:0] output_write_address_mem;
wire [19:0] output_write_data_mem;
wire [19:0] output_read_data_memory;
wire [17:0] output_shift1_out4;
wire [19:0] branch_result_out4;
wire branch1_out4;
wire j1_out4;
wire jmem1_out4;
wire stw1_out4;
wire regwrite1_out4;
wire [2:0] stw_mux_output_out4;
wire [19:0] output_read_data_memory_out4;
wire [19:0] alu_result_out4;
wire out_and_out4;
wire [19:0] out_write_register;
wire [19:0] pc_in2;
wire [19:0] adder1_output_out4;

// Control signals
wire regdest1, regwrite1, extd1, alusrc1, memread1, memwrite1, memtoreg1, j1, branch1, jmem1, stw1;
wire regdest1_out2, regwrite1_out2, alusrc1_out2, memread1_out2, memwrite1_out2, memtoreg1_out2, j1_out2, branch1_out2, jmem1_out2, stw1_out2;
wire [2:0] aluop1;
wire [2:0] aluop1_out2;

// Initialization
reg [19:0] a;
initial begin
    a = 20'b0000_0000_0000_0000_0100; // Initialize 'a' to 4
end

// Instantiate modules
counter_pip PC (clk, rst, pc_in, pc_out); // Program Counter
shift_left shift3 (pc_out, new_pc); // Shift PC value
adder ADD1 (new_pc, a, adder1_output); // Adder for PC+4
instruction_memory_pipeline imem (pc_out, instruction_wire); // Instruction Memory
IF IFID (clk, adder1_output, instruction_wire, adder1_output_out1, instruction_wire_out1); // IF/ID Register

register reg_file (
    clk, regwrite1_out4, instruction_wire_out1[15:13], instruction_wire_out1[12:10],
    stw_mux_output_out4, read_data1, read_data2, out_write_register
); // Register File

control_unit CTRL (
    instruction_wire_out1[19:16], regdest1, regwrite1, extd1, alusrc1, memread1,
    memwrite1, memtoreg1, j1, branch1, jmem1, aluop1, stw1
); // Control Unit

sinexten signext (extd1, instruction_wire_out1[9:0], sign_extension); // Sign Extension
shift_left shift1 (instruction_wire_out1[15:0], output_shift1); // Shift for Jump Address

ID IDEX (
    clk, regdest1, regwrite1, alusrc1, memread1, memwrite1, memtoreg1, j1, branch1, jmem1, aluop1, stw1,
    output_shift1, adder1_output_out1, read_data1, read_data2, sign_extension, instruction_wire_out1,
    regdest1_out2, regwrite1_out2, alusrc1_out2, memread1_out2, memwrite1_out2, memtoreg1_out2, j1_out2,
    branch1_out2, jmem1_out2, aluop1_out2, stw1_out2, output_shift1_out2, adder1_output_out2, read_data1_out2,
    read_data2_out2, sign_extension_out2, instruction_wire_out2
); // ID/EX Register

alu_control alu_CTRL (aluop1_out2, instruction_wire_out2[3:0], alu_operation); // ALU Control
MUX alusrc_mux (read_data2_out2, sign_extension_out2, alusrc1_out2, alusrc_mux_output); // ALU Source MUX
alu ALU (read_data1_out2, alusrc_mux_output, alu_operation, alu_result, zeros); // ALU
MUX regdst_mux (instruction_wire_out2[12:10], instruction_wire_out2[9:7], regdest1_out2, regdst_mux_output); // Register Destination MUX
MUX stw_mux (regdst_mux_output, instruction_wire_out1[15:13], stw1_out2, stw_mux_output); // STW MUX
shift_left shift2 (sign_extension_out2, shift2_output); // Shift for Branch Address
adder adder2 (shift2_output, adder1_output_out2, branch_result); // Adder for Branch

EX EXWB (
    clk, stw_mux_output, zeros, alu_result, output_shift1_out2, branch_result, read_data1_out2, read_data2_out2,
    adder1_output_out2, memwrite1_out2, memread1_out2, branch1_out2, j1_out2, jmem1_out2, stw1_out2, regwrite1_out2,
    stw_mux_output_out3, zeros_out3, alu_result_out3, output_shift1_out3, branch_result_out3, read_data1_out3,
    read_data2_out3, adder1_output_out3, memwrite1_out3, memread1_out3, branch1_out3, j1_out3, jmem1_out3, stw1_out3,
    regwrite1_out3
); // EX/WB Register

And_gate branch_select (zeros_out3, branch_result_out3, out_and); // AND Gate for Branch
MUX read_address_mem (alu_result_out3, read_data2_out3, jmem1_out3, output_read_address_mem); // Read Address MUX
MUX write_address_mem (alu_result_out3, read_data1_out3, stw1_out3, output_write_address_mem); // Write Address MUX
MUX write_data_mem (read_data2_out3, adder1_output_out3, jmem1_out3, output_write_data_mem); // Write Data MUX

data_memmory data_mem (
    clk, output_read_address_mem, output_write_address_mem, output_write_data_mem, memwrite1_out3, memread1_out3,
    output_read_data_memory
); // Data Memory

WB wb (
    clk, output_shift1_out3, branch_result_out3, branch1_out3, j1_out3, jmem1_out3, stw1_out3, regwrite1_out3,
    stw_mux_output_out3, output_read_data_memory, alu_result_out3, out_and, output_shift1_out4, branch_result_out4,
    branch1_out4, j1_out4, jmem1_out4, stw1_out4, regwrite1_out4, stw_mux_output_out4, output_read_data_memory_out4,
    alu_result_out4, out_and_out4, adder1_output_out3, adder1_output_out4
); // WB Stage

MUX read_memory (alu_result_out4, output_read_data_memory_out4, stw1_out4, out_write_register); // Read Memory MUX
if_condition pc_if (
    clk, j1_out4, branch1_out4, jmem1_out4, output_shift1_out4, branch_result_out4, out_write_register, new_pc, pc_in2
); // PC Condition MUX
shift_right pc (pc_in2, pc_in); // Shift Right for PC

endmodule
