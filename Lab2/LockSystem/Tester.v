`include "TopLevelLockSystem.v"
`include "DisplayState.v"
`include "filter.v"

module testBench();
	
	// Input
	wire inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
	// Output
	wire clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
			inc_water_level, dec_water_level;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		
	// Declare instance of device under test
	TopLevelLockSystem dut (clk, reset, inner_door_sw, outer_door_sw,
		outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,inner_gondola_led,
		outer_gondola_led, outer_door_openable_led, inner_door_openable_led,
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);


	// Declare an instance of the Tester module
	Tester aTester (clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
		 inc_water_level,dec_water_level, inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led,
		 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	// dumpfile for gtkwave
	initial
	begin
		$dumpfile("LockSystem.vcd");
		$dumpvars(1, dut);
	end
endmodule

module Tester(clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
	 inc_water_level,dec_water_level,inner_gondola_led, outer_gondola_led, outer_door_openable_led,
	 inner_door_openable_led, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	 
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
		
		output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		
		/*
		// Declare instance of device under test
		TopLevelLockSystem dut (clk, reset, inner_door_sw, outer_door_sw,
			outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,inner_gondola_led,
			outer_gondola_led, outer_door_openable_led, inner_door_openable_led);	
		*/
		
		// Instantiate a logging module
		output reg log = 1;
		output reg [7*8:0] level = "INITIAL";
		Logger logger(log, level, {inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw,
		  inc_water_level, dec_water_level,inner_gondola_led, outer_gondola_led, outer_door_openable_led,
		  inner_door_openable_led, clk, reset}, {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} );
		
		// Test vars
		parameter stimDelay = 20;
		parameter nSteps = 64;
		// Decrease these delays to verify specific amounts...
		integer i = 0, j = 0, boat_delay = 10, rise_delay = 8, fall_delay = 7;

		
		initial
		begin
			// Prime the system
			clk = 1'b0;
			reset = 1'b0;
			inner_door_sw = 1'b0;
			outer_door_sw = 1'b0;
			outer_gondola_arrival_sw = 1'b0;
			inner_gondola_arrival_sw = 1'b0;
			inc_water_level = 1'b0;
			dec_water_level = 1'b0;
			#stimDelay clk = 1'b1;
			#stimDelay clk = ~clk;
			reset = 1'b1;

			// Logging pattern
            level = "RESET--"; log = ~log;

			#stimDelay clk = ~clk;
			#stimDelay clk = ~clk;
			#stimDelay clk = ~clk;

			// Signal a Gondola.
			outer_gondola_arrival_sw = 1'b1;
			level = "SIGNAL-"; log = ~log;
			#stimDelay clk = ~clk;
			outer_gondola_arrival_sw = 1'b1;
			#stimDelay clk = ~clk;


			// Wait for gondola to arrive
			// Multiply by 2 since ticks are only on posedge
			for (j = 0; j < boat_delay*2; j=j+1) begin
				#stimDelay clk = ~clk;
			end
			#stimDelay clk = ~clk;
            level = "ARRIVE-"; log = ~log;

			// Open the outer gate.
			outer_door_sw = 1'b1;
			#stimDelay clk = ~clk;
            level = "GATEOPN"; log = ~log;
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
			for (j = 0; j < boat_delay*2; j=j+1) begin
				#stimDelay clk = ~clk;
			end

			// TODO: Start next test...
			for (j = 0; j < boat_delay*2; j=j+1) begin
				#stimDelay clk = ~clk;
			end
			
			// TEST 2: While water is HIGH, Gondola arrives from outer as before, moves through pound, leaves.

			// TEST 3: Gondola arrives from inner. Fiddle around with the water level to look at the LEDs.

			// TEST 4: Gondola signals from outer. Open outer door before it arrives. Open the wrong door to make sure it doesn't go through.

			$finish; // finish simulation
		end
endmodule

module Logger
  #( parameter DUT="TopLevelLockSystem" )
  (
    log, level, dutPort, HEX
  );

  // Toggling log sends a message
  input log;

  // 7 char string to say where the system is at
  input [7*8:0] level;

  // DUT info
  input [11:0] dutPort;
  input [41:0] HEX;
  /*
  always @ (posedge log or negedge log) begin
      $display({"%s:@%s  State:", 
        "{inner_door_sw:%b, ", 
        "outer_door_sw:%b, ", 
        "outer_gondola_arrival_sw:%b, ",
        "inner_gondola_arrival_sw:%b, ",
        "inc_water_level:%b, ",
        "dec_water_level:%b, ",
        "inner_gondola_led:%b, ",
        "outer_gondola_led:%b, ",
        "outer_door_openable_led:%b, ",
        "inner_door_openable_led:%b, ",
        "clk:%b, reset:%b, ",
		"HEX5:%b, HEX4:%b, HEX3:%b, HEX2:%b, HEX1:%b, HEX0:%b}", 
		"%t|timestamp"},
        DUT,level,dutPort[11],dutPort[10],dutPort[9],
        dutPort[8],dutPort[7],dutPort[6],dutPort[5],dutPort[4],
		dutPort[3],dutPort[2],dutPort[1],dutPort[0],
		HEX[41:35],HEX[34:28],HEX[27:21],HEX[20:14],HEX[13:7],HEX[6:0],
        $time);
  end
*/
endmodule
