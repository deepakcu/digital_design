// Single-bit clock-domain crossing synchronizer
//
// Notes:
// A synchronizer is a device that takes an asynchronous
// input and produces an output signal that transitions
// synchronous to a sample clock
// 
// The single-bit clock domain synchronizer safely
// transfers the output from clock domain A to 
// clock domain B. Without the synchronizer, the 
// input of the receiving clock domain can go 
// metastable at the first register stage of the
// sampling domain. A good synchronizer
// removes the probability of input going metastable 
// by moving the input through register stages in 
// the target clock domain
//
// Mean Time Between Failures defines the probability
// of the o/p of the sampling domain going metastable.
// MTBF = 1/(freq of sampling * freq of data change *X)
// Higher MTBF, the better
// As freq of sampling increases, probability of metastability
// is higher (lower MTBF)
//
// It is generally recommended that the output of the
// launching clock domain is registered before synchronizing.
// Consider the case where a signal is derived through some
// combinational logic before getting transfered from clock
// domain A to B. The probability of glitching after the 
// combinational logic is very high, which in turn increases
// probability of metastability at the latching clock domain.
//
// The synchronizer may be used in different scenarios
// - Case 1: Transfer from slow clock domain to fast
// - Case 2: Transfer from fast clock domain to slow
// - Case 3: Transfer b/w unrelated clocks with same frequency, 
//
// Case 1 is the most straightforward. A CDC with >=2 stages is
// sufficient. Case 2 is tricky because the launch data can
// change multiple times before capturing in the latching domain.
// In this situation, it is recommended that either the launch clock
// hold the data for at-least 3 clock cycles of the latch
// clock domain (open-loop solution) or hold the data until
// the latch domain sends back an acknowledgment (closed-loop
// solution).
//
module single_bit_cdc_synchronizer #(
   parameter NUM_STAGES = 3 // minimum 2 stages, recommended 3 stages
                            // probability of metastability decreases
                            // exponentially with #stages
) (
   input clk, //latch clock
   input d_in,
   output q_out;
);

reg[NUM_STAGES-1:0] r;
assign q_out=r[NUM_STAGES-1];

integer i;
always@(posedge latch_clk)
begin
   for(i=1; i<NUM_STAGES; i=i+1) begin
      r[i] <= r[i-1];
   end
end

endmodule
