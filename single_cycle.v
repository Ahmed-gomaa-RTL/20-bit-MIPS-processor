module single_cycle (
    input clk, // Clock signal
    input rst  // Reset signal
);

// Internal wires
wire [19:0] pc_in; // Wires into the PC from jump and branch
wire [19:0] pc_out; // Wires out of the PC
wire [19:0] instruction_wire; // Wires out of the instruction memory
wire [2:0] mux_writereg; // Mux for the data to be written in the register file
wire [19:0] read_data1; // Read data 1 from register file
wire [19:0] read_data2; // Read data 2 from register file
wire [19:0] sign_extension; // Sign extension output value
wire [3:0] alu_operation; // Output of the ALU control
wire [19:0] mux_alusrc; // Output of the mux entering the ALU
wire [19:0] alu_output; // Result of the operation done in the ALU
wire zero_flag; // Output of 1 if the result of the ALU is zero
wire [19:0] write_data; // Write data in data memory
wire [19:0] read_data; // Read data from memory
wire [19:0] data_write_reg; // Output of mux to write register (memtoreg)
wire [19:0] adder1_output; // Increment PC with 4
wire [19:0] output_shift1; // Shift for address (jump)
wire [19:0] output_shift2; // Shift for sign extension value
wire [19:0] adder2_output; // Output (PC + 4) + (4 * sign extension)
wire and_output; // Selection of branch
wire [19:0] output_mux_branch; // Selection between PC + 4 and branch
wire [19:0] read_memory_address; // Selection between rt and ALU output
wire [19:0] instruction_fetch; // Selection between j and branch
wire [19:0] wire_write_address; // Selection between rs and ALU output
wire [19:0] jmem_mux_output; // Selection between read_data2 and adder1_output
wire [2:0] out_last; // Selection between rs, rd, and rt
wire [19:0] pc_in2;
wire [19:0] new_pc; // Used to shift PC value twice to get PC+4

// Control wires
wire regdest1, regwrite1, extd1, alusrc1, memread1, memwrite1, memtoreg1, j1, branch1, jmem1, stw1;
wire [2:0] aluop1;

// Initialization
reg [19:0] a;
initial begin
    a = 20'b0000_0000_0000_0000_0100; // Initialize 'a' to 4
end

// Instantiate modules
counter PC (clk, rst, pc_in, pc_out); // Program Counter
instruction_memory imem (pc_out, instruction_wire); // Instruction Memory

MUX mux1 (
    instruction_wire[12:10], instruction_wire[9:7], regdest1, mux_writereg
); // Mux for write register

register register_file (
    clk, regwrite1, instruction_wire[15:13], instruction_wire[12:10], out_last,
    read_data1, read_data2, data_write_reg
); // Register File

control_unit CTRL (
    instruction_wire[19:16], regdest1, regwrite1, extd1, alusrc1, memread1,
    memwrite1, memtoreg1, j1, branch1, jmem1, aluop1, stw1
); // Control Unit

sinexten signext (extd1, instruction_wire[9:0], sign_extension); // Sign Extension
alu_control ALU_CTRL (aluop1, instruction_wire[3:0], alu_operation); // ALU Control

MUX mux2 (
    read_data2, sign_extension, alusrc1, mux_alusrc
); // ALU Source Mux

alu ALU_UNIT (
    read_data1, mux_alusrc, alu_operation, alu_output, zero_flag
); // ALU Unit

MUX read_adddress_memory (
    alu_output, read_data2, jmem1, read_memory_address
); // Read Address Mux

MUX write_data_memory (
    read_data2, adder1_output, jmem1, write_data
); // Write Data Mux

MUX write_address_memory (
    alu_output, read_data1, stw1, wire_write_address
); // Write Address Mux

MUX last (
    mux_writereg, instruction_wire[15:13], stw1, out_last
); // Last Mux

data_memmory Dmem (
    clk, read_memory_address, wire_write_address, write_data, memwrite1, memread1, read_data
); // Data Memory

MUX memtoreg_mux (
    alu_output, read_data, memtoreg1, data_write_reg
); // MemtoReg Mux

shift_left shift3 (pc_out, new_pc); // Shift PC value
adder Pc_increment4 (new_pc, a, adder1_output); // Adder for PC+4

shift_left shift1 (
    instruction_wire[15:0], output_shift1
); // Shift for Jump Address

shift_left shift2 (
    sign_extension, output_shift2
); // Shift for Sign Extension

adder beq_adder (
    adder1_output, output_shift2, adder2_output
); // Adder for Branch

And_gate branch_select (
    zero_flag, branch1, and_output
); // AND Gate for Branch

MUX branch_mux (
    adder1_output, adder2_output, and_output, output_mux_branch
); // Branch Mux

MUX j_mux (
    output_mux_branch, output_shift1, j1, instruction_fetch
); // Jump Mux

MUX pc_mux (
    instruction_fetch, data_write_reg, jmem1, pc_in2
); // PC Mux

shift_right pc_next (
    pc_in2, pc_in
); // Shift Right for PC

endmodule
