// Model a simple flip flop with asynchronous reset
//
// Notes:
// - Including the reset signal in the sensitivity list is 
//   what makes the reset asynchronous
//
// - Most flip-flops have an asynchronous reset pin.
//   This pin is inferred from the behavioral statement below.
//
// Advantages:
// - Asynchronous resets do not add combinational path delay
//   resulting in higher frequency circuits. Most vendor libraries
//   include flops with async resets that can be directly inferred
//   from the logic below.
//
// - The circuit can be reset without a clock being present
//
// Disadvantages:
// - Async reset can be asserted/deasserted at anytime (e.g.
//   from a board pin). The assertion/de-assertion may not 
//   be clean (i.e. can glitch/bounce). If the reset removal
//   happens during during the setup/hold time of the flop,
//   flop output can go metastable (this is true for sync
//   reset as well - but the problem is more common in async flops).
//   It is recommended to use a reset removal circuit to 
//   remove any glitching for async reset.
// - Suppose the async reset is applied to two flops.
//   Each flop could recieve the reset signal at different times
//   and cause reset at different times. This will cause
//   different registers to exit the reset state at different time.
//   This behavior can cascade through the design.
// 
// - As a general guideline, always synchronize asynchronous
//   reset inputs using a reset synchronizer circuit
//   (see reset_synchronizer.v)
// 
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
