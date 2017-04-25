module testBench;
	wire clk, rst;
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


		// Test vars
		parameter delay = 20;
		parameter nSteps;
		integer i;

		initial begin
			// TODO: truncate literals
			$display("\t\t ArriveLED | DepartLED | OutGateLED | InGateLED | ArriveSW | DepartSW | OutGateSW | InGateSW | IncrWater | DecrWater | Clock | Reset | Time ");
			$monitor("\t\t     %b 	 |     %b    |     %b     |     %b    |     %b   |    %b    |     %b    |   %b     |    %b     |    %b     |  %b   |   %b  |  %t",
			arr_led, dept_led, toggle_outer_led, toggle_inner_led, arr_sw, dept_sw, toggle_outer_sw,
			toggle_inner_sw, inc_water_level, dec_water_level, clk, reset, $time);
		end

		initial begin
			// Prime the system
			clk = 1'b0;
			rst = 1'b0;
			arr_sw = 1'b0;
			dept_sw = 1'b0;
			toggle_outer_sw = 1'b0;
			toggle_inner_sw = 1'b0;
			inc_water_level = 1'b0;
			dec_water_level = 1'b0;
			#delay clk = 1'b1;
			#delay clk = 1'b0;
			rst = 1'b1; // Activation
			#delay clk = ~clk;

			// Signal a Gondola.
			arr_sw = 1'b1;
			#delay clk = ~clk;
			arr_sw = 1'b0;
			#delay clk = ~clk;

			// Wait for gate
			while (toggle_outer_led == 0) begin
				#delay clk = ~clk;
			end
			#delay clk = ~clk;

			// Open the gate.
			toggle_outer_sw = 1'b1;
			#delay clk = ~clk;
			toggle_outer_sw = 1'b0;
			#delay clk = ~clk;


			for (i = 0; i < nSteps; i=i+1) begin
			    #delay clk = ~clk;
			end



			#(2*delay); // needed to see END of simulation
			$finish; // finish simulation
		end
endmodule
