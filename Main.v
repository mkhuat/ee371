module DFlipFlop(q, qBar, D, clk, rst);
	input D, clk, rst;
	output q, qBar;
	reg q;
	not n1 (qBar, q);
		always@ (negedge rst or posedge clk)
		begin
			if(!rst)
				q = 0;
			else
				q = D;
		end
endmodule



module Main(clk, rst, q);
	input clk, rst;
	output [3:0] q, qBar;
	wire [3:0] q;
	DFlipFlop zero (q[0], qBar[0], 1'b1, clk, rst);
	DFlipFlop one (q[1], qBar[1], 1'b1, q[0], rst);
	DFlipFlop two (q[2], qBar[2], 1'b1, q[1], rst);
	DFlipFlop three (q[3], qBar[3], 1'b1, q[2], rst);
	
endmodule
	

	