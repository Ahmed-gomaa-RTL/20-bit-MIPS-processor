module MUX (
    input [19:0] input_1, // Input 1
    input [19:0] input_2, // Input 2
    input select,         // Select signal
    output reg [19:0] out // Output
);

always @(*) begin
    if (select == 1'b0) begin
        out = input_1; // Select input_1 when select is 0
    end
    else if (select == 1'b1) begin
        out = input_2; // Select input_2 when select is 1
    end
end

endmodule
