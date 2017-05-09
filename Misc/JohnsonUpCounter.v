`include "DFlipFlop.v"
// Behavioral: case statements
// Used: http://www.electronics-tutorials.ws/sequential/seq_6.html
module JohnsonUpCounter(clk, rst, q);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	reg [3:0] d;
	
	// Could also do this with integer arithmetic, then wrapping with mod
	always@ (posedge clk or negedge rst)
	case (q)
		4'b0000: d = 4'b1000;
		4'b1000: d = 4'b1100;
		4'b1100: d = 4'b1110;
		4'b1110: d = 4'b1111;
		4'b1111: d = 4'b0111;
		4'b0111: d = 4'b0011;
		4'b0011: d = 4'b0001;
		4'b0001: d = 4'b0000;
	endcase
	
	
	DFlipFlop zero (q[0], qBar[0], d[0], clk, rst);
	DFlipFlop one (q[1], qBar[1], d[1], clk, rst);
	DFlipFlop two (q[2], qBar[2], d[2], clk, rst);
	DFlipFlop three (q[3], qBar[3], d[3], clk, rst);
endmodule
	
