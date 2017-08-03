//Illustrates how to release reset from a testbench
//
// Notes:
//
// Reset must never be removed near the active edge of the clock
// This will cause metastability problems irrespective
// of whether circuit is synchronously/asynchronously reset.
//
//
module tb();
   initial begin
      clk <= 0; //time 0 (non-blocking)
      forever #(`CYCLE/2) clk <= ~clk; //generate clock
   end
 
   initial begin
      rst_n <= 0;             // time 0 nonblocking assignment
      @(posedge clk);         // Wait to get past time 0
      @(negedge clk) rst_n = 1; // rst_n low for one clock cycle
   end

endmodule





