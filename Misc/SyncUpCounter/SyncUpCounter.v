// Dataflow: connected modules
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

module SyncUpCounter(clk, rst, q);
	input clk, rst;
	output [3:0] q;
	wire [3:0] q, d, qBar;
	
	d0 d0_inst (q, d[0]);
	d1 d1_inst (q, d[1]);
	d2 d2_inst (q, d[2]);
	d3 d3_inst (q, d[3]);
	
	DFlipFlop zero (q[0], qBar[0], d[0], clk, rst);
	DFlipFlop one (q[1], qBar[1], d[1], clk, rst);
	DFlipFlop two (q[2], qBar[2], d[2], clk, rst);
	DFlipFlop three (q[3], qBar[3], d[3], clk, rst);
endmodule
