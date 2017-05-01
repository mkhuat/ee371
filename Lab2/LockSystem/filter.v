module filter(clk, reset, in, out);
	input wire clk, reset, in;
	output reg out;
	
	reg active;
	
	// Based on the given clock...
	// 1. If we're resetting, we set our active value to true
	//    and have our output (the "enable") set to false
	// 2. If our input is True and we're active, then we flip
	//    the output (enable) to True
	// 3. If our input is False and we're not active, then we
	//	  flip the output (enable) to False
	// 4. Default
	
	always @ (posedge clk) begin
		if (reset) begin
			// $display("Filter reset");
			active <= 1;
			out <= 0;
		end
		else if (active && in) begin
			// $display("Filter output 1");
			active <= 0;
			out <= 1;
		end
		else if (~( active || in)) begin 
			// $display("Filter output case 2");
			active <= 1;
			out <= 0;
		end
		else begin
			// $display("Filter default");
			active <= ~in;
			out <= 0;
		end
	end
	
endmodule
