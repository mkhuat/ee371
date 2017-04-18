`include "DFlipFlop.v"
// Gate design: connected wires
module RippleUpCounter(clk, rst, q);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	
	DFlipFlop zero (q[0], qBar[0], qBar[0], clk, rst);
	DFlipFlop one (q[1], qBar[1], qBar[1], qBar[0], rst);
	DFlipFlop two (q[2], qBar[2], qBar[2], qBar[1], rst);
	DFlipFlop three (q[3], qBar[3], qBar[3], qBar[2], rst);
endmodule
	

	