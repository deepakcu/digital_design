// Design a circuit that generates a 1-clock
// cycle wide pulse from "pulse_out"
// when the input signal "en" is toggled high.
// 
// Analysis
// --------
// Desired truth table
// en(cur state)  q(next state)  pulse_out
// 0              0              0
// 0              1              0
// 1              0              1
// 1              1              0
//
// pulse_out = ~q&en
//
module pulse_generator(
   input clk,
   input en,
   output pulse_out
);

reg q;

assign pulse_out = !q & en;

always@(posedge clk)
   q <= en;

endmodule
