// Model a simple flip flop
//
module flop(
   input clk,
   input din,
   output reg q
);

always@(posedge clk)
   q <= din;

endmodule
