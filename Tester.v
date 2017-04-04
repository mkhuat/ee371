`include "Main.v"

module testBench;

	// connect the two modules
	wire clk, rst;
	wire [3:0] q;

	// declare an instance of the AND module
	Main main (clk, rst, q);

	// declare an instance of the testIt module
	Tester aTester (clk, rst, q);

	// file for gtkwave
	initial
	begin
		// these two files support gtkwave and are required
		$dumpfile("main.vcd");
		$dumpvars(1, main);
	end
endmodule

module Tester(clk, rst, q);
        input clk, rst;
		output [3:0] q;
		wire [3:0] q;
        Main dut (clk, rst, q);
			
		parameter stimDelay = 20;

		initial // Response

		begin
			$display("\t\t q[3] q[2] q[1] q[0] \t Time ");
			$monitor("\t\t %b %b %b %b \t %b", q[3], q[2], q[1], q[0], $time);
		end	

		initial // Stimulus
		begin
			clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = 1'b0;
			#(2*stimDelay); // needed to see END of simulation
			$finish; // finish simulation
		end
		
        // Set up the clock.
		
		/*
        parameter CLOCK_PERIOD=100;
        initial clk=1;
        always begin
                #(CLOCK_PERIOD/2);
                clk = ~clk;
        end
        initial begin
			rst=0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			rst=0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			
			// dump file is for dumping all the variables in a simulation
			$dumpfile("gfxFile.vcd");

			// dumps all the variables in module myDesign and below
			// but not modules instantiated in myDesign into the dump file.
			$dumpvars(1, dut);
        end
		*/
		

		
endmodule
