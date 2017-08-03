// Model a simple flip flop with synchronous reset
//
// Notes:
// - Omitting the rst from the sensitivity list makes the flop synchronous
//
// - rst must be prioritized in the condition check for the synthesis tool
//   to infer the rst signal.
//
//  Advantages:
// - Synchronous reset ensures that the reset occurs only "after" the active
//   edge of a clock cycle. This requires that the "reset & din" arrive 
//   before the setup time of the flop. If "reset & din" violates setup
//   requirements, the flop will go into metastability upon reset.
//
// - Synchronous reset can help eliminate glitches if the glitching
//   happens before the setup time of the flop. The clock basically 
//   acts as a fliter for the flop.
//
// - If the reset is internally generated using some internal logic,
//   synchronous reset is recommended
//
//  Disadvantages:
// - Not all ASIC/FPGA standard cells support synchronous resets
// - Synchronous resets can be synthesized in the combinational path, they
//   add to combinational path delay
// - Sometimes, when transfering the synch reset from one clock
//   domain to another, the reset signal must stay high during the active
//   edge of the target clock domain. This can be achieved by stretching
//   the signal using a counter.
// - By definition, requires a clock to reset. This may be a problem
//   in low-power designs where the clock is turned off to save power
module flop_sync_rst(
   input clk,
   input rst,
   input din,
   output reg q
);

always@(posedge clk)
   if(rst)
      q <= 0;
   else
      q <= din;

endmodule
