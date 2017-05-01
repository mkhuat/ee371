module filter(clk, reset, in, out);
	input wire clk, reset, in;
	output reg out;
	
	reg active;
	
	always @ (posedge clk) begin
		if (reset) begin
			active <= 1;
			out <= 0;
		end
		else if (active && in) begin
			active <= 0;
			out <= in;
		end
		else if (~( active || in)) begin 
			active <= 1;
			out <= 0;
		end
		else begin
			active <= ~in;
			out <= 0;
		end
	end
	
endmodule
