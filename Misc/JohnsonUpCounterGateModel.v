`include "DFlipFlop.v"
module JohnsonUpCounterGateModel(clk, rst, q);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	reg [3:0] d;	
	// Nothing is a 1 or everything is 
	DFlipFlop zero (q[0], qBar[0], qBar[3], clk, rst);
	DFlipFlop one (q[1], qBar[1], q[0], clk, rst);
	DFlipFlop two (q[2], qBar[2], q[1], clk, rst);
	DFlipFlop three (q[3], qBar[3], q[2], clk, rst);
endmodule
	
