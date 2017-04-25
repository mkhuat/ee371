`include "DFlipFlop.v"

module SyncUpCounterGateModel(clk, rst, q);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	
	DFlipFlop zero (q[0], qBar[0], qBar[0], clk, rst);
	DFlipFlop one (q[1], qBar[1], q[1] ^ q[0], clk, rst);
	DFlipFlop two (q[2], qBar[2], (~q[2] & q[1] & q[0]) | (q[2] & (~q[0] | ~q[1])), clk, rst);
	DFlipFlop three (q[3], qBar[3], (~q[3] & q[2] & q[1] & q[0]) | (q[3] & (~q[0] | ~q[1] | ~q[2])), clk, rst);
endmodule
	
