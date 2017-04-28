`include "LockSystem.v"
module testBench();
	wire clk, reset;
	wire [3:0] q;

	// Declare instance of device under test
	TopLevelLockSystem dut (clk, reset, arr_sw, dept_sw,
		toggle_outer_sw, toggle_inner_sw, inc_water_level, dec_water_level,arr_led,
		dept_led, toggle_outer_led, toggle_inner_led);


	// Declare an instance of the Tester module
	Tester aTester (clk, reset, arr_sw, dept_sw, toggle_outer_sw, toggle_inner_sw,
		 inc_water_level,dec_water_level,arr_led, dept_led, toggle_outer_led,
		 toggle_inner_led);

	// dumpfile for gtkwave
	initial
	begin
		$dumpfile("LockSystem.vcd");
		$dumpvars(1, dut);
	end
endmodule

module Tester(clk, reset, arr_sw, dept_sw, toggle_outer_sw, toggle_inner_sw,
	 inc_water_level,dec_water_level,arr_led, dept_led, toggle_outer_led,
	 toggle_inner_led);

		input wire arr_led, dept_led, toggle_outer_led, toggle_inner_led;
		output reg clk, reset, arr_sw, dept_sw, toggle_outer_sw, toggle_inner_sw,
			inc_water_level, dec_water_level;

		// Declare instance of device under test
		TopLevelLockSystem dut (clk, reset, arr_sw, dept_sw,
			toggle_outer_sw, toggle_inner_sw, inc_water_level, dec_water_level,arr_led,
			dept_led, toggle_outer_led, toggle_inner_led);
				
			
		// Test vars
		parameter stimDelay = 20;
		parameter nSteps = 64;
		integer i = 0;

		initial begin
			// TODO: truncate literals
			$display(" ArriveLED  |  DepartLED  |  OutGateLED  |  InGateLED  |  ArriveSW  |  DepartSW  |  OutGateSW  |  InGateSW  |  IncrWater  |  DecrWater  |  Clock  |  Reset  |  Time ");
			$monitor(" %b  |  %b  |  %b |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %t",
			arr_led, dept_led, toggle_outer_led, toggle_inner_led, arr_sw, dept_sw, toggle_outer_sw,
			toggle_inner_sw, inc_water_level, dec_water_level, clk, reset, $time);
		end

		initial
		begin
			// Prime the system
			clk = 1'b0;
			reset = 1'b1;
			arr_sw = 1'b0;
			dept_sw = 1'b0;
			toggle_outer_sw = 1'b0;
			toggle_inner_sw = 1'b0;
			inc_water_level = 1'b0;
			dec_water_level = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = ~clk;
			reset = 1'b0;
			#stimDelay clk = ~clk;

			// Signal a Gondola.
			arr_sw = 1'b1;
			#stimDelay clk = ~clk;
			arr_sw = 1'b0;
			#stimDelay clk = ~clk;

			// Wait for gate
			while (toggle_outer_led == 0) begin
				#stimDelay clk = ~clk;
			end
			#stimDelay clk = ~clk;

			// Open the gate.
			toggle_outer_sw = 1'b1;
			#stimDelay clk = ~clk;
			toggle_outer_sw = 1'b0;
			#stimDelay clk = ~clk;


			for (i = 0; i < nSteps; i=i+1) begin
			    #stimDelay clk = ~clk;
			end

			#(2*stimDelay); // needed to see END of simulation
			$finish; // finish simulation
		end
endmodule
