`include "DFlipFlop.v"
// TODO: This file is a mess. We need to figure out dataflow stuff.
// We aren't using regs correctly, or something.
module d0(input [3:0] q, output d);
	assign d = ~q[0];
endmodule

module d1(input [3:0] q, output d);
	assign d = q[1] ^ q[0];
endmodule

module d2(input [3:0] q, output d);
	assign d = (~q[2] & q[1] & q[0]) | (q[2] & (~q[0] | ~q[1]));
endmodule

module d3(input [3:0] q, output d);
	assign d = (~q[3] & q[2] & q[1] & q[0]) | (q[3] & (~q[0] | ~q[1] | ~q[2]));
endmodule

// Used: http://www.electronics-tutorials.ws/sequential/seq_6.html
module JohnsonUpCounter(clk, rst, q, qBar);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	wire [3:0] d;
	
	d0 d0_inst (qBar, d[0]);
	d1 d1_inst (qBar, d[1]);
	d2 d2_inst (qBar, d[2]);
	d3 d3_inst (qBar, d[3]);

	DFlipFlop zero (q[0], qBar[0], d0, clk, rst);
	DFlipFlop one (q[1], qBar[1], d1, clk, rst);
	DFlipFlop two (q[2], qBar[2], d2, clk, rst);
	DFlipFlop three (q[3], qBar[3], d3, clk, rst);
endmodule
	
