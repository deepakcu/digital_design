// Model a reset synchronizer circuit (active low reset)
//
// Notes:
// - Reset synchronizer creates a "predictable reset
//   from an asynchronous reset input. Async resets are 
//   notorious for their unpredictability - reset assertion
//   /removal can happen anytime near the clock edge.
//   Reset assertion/removal can be glitchy especially
//   when driven from a pin or bounce switch. async
//   reset fanouts to multiple flops can take different
//   paths. Since reset removal can happen anytime before
//   the clock edge of these flops, timing analysis
//   is difficult and often unpredictable. 
//
//   Reset sync circuit allows immediate reset assertion
//   and "predictable" reset removal. Clean reset removal
//   helps predictable timing analysis.
//
//   There won't be any metastability problem on the second
//   FF because both input and output are held at active
//   low during reset removal and therefore the output
//   doesn't oscillate during reset removal. The first
//   flop can still have metastability.
//
//   Also note that the metastability issue occures only
//   at during reset removal, not during reset assertion.
//   reset assertion happens immediately (as in the reset
//   bypasses the flop)
//
module reset_synchronizer (
   input arst_in_n,
   input clk
   output arst_out_n
);

reg[1:0] ff;
assign arst_out_n = ff[1];

always@(posedge clk or negedge arst_in_n)
begin
   if(arst_in_n)
     ff <= '0;
  else
     ff <= {ff[0],1'b1};
end

end
endmodule
