`include "LockSystem.v"
module testBench();
	
	// Input
	wire inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
	// Output
	wire clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
			inc_water_level, dec_water_level;
		
	// Declare instance of device under test
	TopLevelLockSystem dut (clk, reset, inner_door_sw, outer_door_sw,
		outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,inner_gondola_led,
		outer_gondola_led, outer_door_openable_led, inner_door_openable_led);


	// Declare an instance of the Tester module
	Tester aTester (clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
		 inc_water_level,dec_water_level, inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led);

	// dumpfile for gtkwave
	initial
	begin
		$dumpfile("LockSystem.vcd");
		$dumpvars(1, dut);
	end
endmodule

module Tester(clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
	 inc_water_level,dec_water_level,inner_gondola_led, outer_gondola_led, outer_door_openable_led,
	 inner_door_openable_led);
	 
		// Output
		
		// Input of Lock System
		output clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
			inc_water_level, dec_water_level;
		// Output of Lock System
		reg clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
			inc_water_level, dec_water_level;
		
		// Output 
		output inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
		wire inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
		
		// Declare instance of device under test
		TopLevelLockSystem dut (clk, reset, inner_door_sw, outer_door_sw,
			outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,inner_gondola_led,
			outer_gondola_led, outer_door_openable_led, inner_door_openable_led);	
			
		// Test vars
		parameter stimDelay = 20;
		parameter nSteps = 64;
		// Decrease these delays to verify specific amounts...
		integer i = 0, j = 0, boat_delay = 10, rise_delay = 8, fall_delay = 7;

		initial begin
			$display(" inner_door_sw  |  outer_door_sw |  outer_gondola_arrival_sw  |  inner_gondola_arrival_sw  |  inc_water_level  |  dec_water_level  |  inner_gondola_led  |  outer_gondola_led  |  outer_door_openable_led  |  inner_door_openable_led  |  Clock  |  Reset  |  Time ");
			$monitor(" %b  |  %b  |  %b |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %t",
			inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level, inner_gondola_led,
			outer_gondola_led, outer_door_openable_led, inner_door_openable_led, clk, reset, $time);
		end

		initial
		begin
			// Prime the system
			clk = 1'b0;
			reset = 1'b1;
			inner_door_sw = 1'b0;
			outer_door_sw = 1'b0;
			outer_gondola_arrival_sw = 1'b0;
			inner_gondola_arrival_sw = 1'b0;
			inc_water_level = 1'b0;
			dec_water_level = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = ~clk;
			reset = 1'b0;
			#stimDelay clk = ~clk;
			#stimDelay clk = ~clk;
			#stimDelay clk = ~clk;
			
			// Signal a Gondola.
			outer_gondola_arrival_sw = 1'b1;
			#stimDelay clk = ~clk;
			outer_gondola_arrival_sw = 1'b0;
			#stimDelay clk = ~clk;

			// Wait for gondola to arrive
			// Multiply by 2 since ticks are only on posedge
			for (j = 0; j < boat_delay*2; j++) begin
				#stimDelay clk = ~clk;
			end
			#stimDelay clk = ~clk;

			// Open the outer gate.
			outer_door_sw = 1'b1;
			#stimDelay clk = ~clk;
			outer_door_sw = 1'b0;
			#stimDelay clk = ~clk;


			for (i = 0; i < rise_delay*2; i=i+1) begin
				// Increase water level for awhile
				inc_water_level = 1'b1;
				inc_water_level = 1'b0;
			    #stimDelay clk = ~clk;
			end
			
			// Open the inner gate.
			inner_door_sw = 1'b1;
			#stimDelay clk = ~clk;
			inner_door_sw = 1'b0;
			#stimDelay clk = ~clk;
			
			// Wait for boat to depart
			for (j = 0; j < boat_delay*2; j++) begin
				#stimDelay clk = ~clk;
			end

			// TODO: Start next test...
			for (j = 0; j < boat_delay*2; j++) begin
				#stimDelay clk = ~clk;
			end
			$finish; // finish simulation
		end
endmodule
