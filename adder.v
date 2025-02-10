module adder (
    input      [19:0] a ,
    input      [19:0] b ,
    output reg [19:0] y
);

always @(*) begin
    y <= a + b;
end

endmodule
