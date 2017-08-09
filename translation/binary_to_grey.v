// Model a simple flip flop
// Output follows input on clock edge
module flop(
   input clk,
   input din,
   output reg q
);

always@(posedge clk)
   q <= din;

endmodule
