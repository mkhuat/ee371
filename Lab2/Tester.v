/*
To test a module, uncomment:
	1. test module declaration (ex: RippleUpCounter rippleUpCounter (clk, rst, q);)
	2. dump files (ex: $dumpfile("RippleUpCounter.vcd"); $dumpvars(1, rippleUpCounter);)
	3. dut in the test proper (ex: SyncUpCounter dut (clk, rst, q);)
*/

module testBench;
	wire clk, rst;
	wire [3:0] q;

	// Declare instance of test module
	RippleUpCounter rippleUpCounter (clk, rst, q);

	
	// declare an instance of the Tester module
	Tester aTester (clk, rst, q);
	
	// file for gtkwave
	initial
	begin
		$dumpfile("RippleUpCounter.vcd");
		$dumpvars(1, rippleUpCounter);
	end
endmodule

module Tester(clk, rst, q);
        output clk, rst;
		reg clk, rst;
		output [3:0] q;
		wire [3:0] q;
        
		// Uncomment to test:
		RippleUpCounter dut (clk, rst, q);

		
		parameter stimDelay = 20;
		parameter nSteps = 36;
		integer i;
		initial // Response

		begin
			$display("\t\t q[3] \t q[2] \t q[1] \t q[0] \t Clock \t Time ");
			$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %d", q[3], q[2], q[1], q[0], clk, $time);
		end	

		initial // Stimulus
		begin
			clk = 1'b0;
			rst = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			// Will now have set q to be 0000
			rst = 1'b1;
			for (i = 0; i < nSteps; i=i+1) begin
			    #stimDelay clk = ~clk;
			end
			#(2*stimDelay); // needed to see END of simulation
			$finish; // finish simulation
		end		
endmodule
