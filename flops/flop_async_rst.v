// Model a simple flip flop with asynchronous reset
//
module flop_async_rst(
   input clk,
   input arst,
   input din,
   output reg q
);

always@(posedge clk or posedge arst)
   if(rst)
      q <= 0;
   else
      q <= din;

endmodule
