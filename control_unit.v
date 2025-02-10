module control_unit(
    input      [0:3] opcode,
    output reg       regdest, regwrite, extd, alusrc, memread, memwrite, memtoreg, j, branch, stw,
    output reg       jmem, // new control signal used for the new operation
    output reg [0:2] aluop
);

always @(*) begin
    case (opcode)
        // R-type instructions (add, sub, and, or, slt)
        4'b0000: begin
            regdest  = 1;
            regwrite = 1;
            extd     = 0;
            alusrc   = 0;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 0;
            aluop    = 3'b000;
        end

        // ADDi case
        4'b0001: begin
            regdest  = 0;
            regwrite = 1;
            extd     = 1;
            alusrc   = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 0;
            aluop    = 3'b001;
        end

        // ANDi case
        4'b0010: begin
            regdest  = 0;
            regwrite = 1;
            extd     = 0;
            alusrc   = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 0;
            aluop    = 3'b010;
        end

        // stw case
        4'b0011: begin
            regdest  = 0;
            regwrite = 1;
            extd     = 1;
            alusrc   = 1;
            memread  = 0;
            memwrite = 1;
            memtoreg = 1;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 1;
            aluop    = 3'b011;
        end

        // lw case
        4'b0100: begin
            regdest  = 0;
            regwrite = 1;
            extd     = 1;
            alusrc   = 1;
            memread  = 1;
            memwrite = 0;
            memtoreg = 1;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 1;
            aluop    = 3'b100;
        end

        // sw case
        4'b0101: begin
            regdest  = 0;
            regwrite = 0;
            extd     = 1;
            alusrc   = 1;
            memread  = 0;
            memwrite = 1;
            memtoreg = 0;
            j        = 0;
            branch   = 0;
            jmem     = 0;
            stw      = 0;
            aluop    = 3'b101;
        end

        // beq case
        4'b0110: begin
            regdest  = 0;
            regwrite = 0;
            extd     = 1;
            alusrc   = 0;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            j        = 0;
            branch   = 1;
            jmem     = 0;
            stw      = 0;
            aluop    = 3'b110;
        end

        // j case
        4'b0111: begin
            regdest  = 0;
            regwrite = 0;
            extd     = 0;
            alusrc   = 0;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            j        = 1;
            branch   = 0;
            jmem     = 0;
            stw      = 0;
            // ALU is not used in the jump case
        end

        // jmem case
        4'b1000: begin
            regdest  = 0;
            regwrite = 0;
            extd     = 1;
            alusrc   = 1;
            memread  = 1;
            memwrite = 1;
            memtoreg = 0;
            j        = 0;
            branch   = 0;
            jmem     = 1;
            stw      = 0;
            aluop    = 3'b111;
        end
    endcase
end

endmodule
