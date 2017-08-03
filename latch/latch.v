// Model a simple latch
//
module latch(
   input en,
   input din,
   output reg q
);

always@(*)
   if(en)
      q <= din;

endmodule
