

module TopLevelLockSystem
		#( parameter INNER = 6,  parameter OUTER = 4)
		(/* Inputs */ clk, reset, arr_sw, dept_sw, toggle_outer_sw, toggle_inner_sw, inc_water_level, dec_water_level,
		/* Outputs */ arr_led, dept_led, toggle_outer_led, toggle_inner_led);
		
        input clk, reset, arr_sw, dept_sw, toggle_outer_sw, toggle_inner_sw, inc_water_level, dec_water_level;
		output arr_led, dept_led, toggle_outer_led, toggle_inner_led;
		
		// State
		reg clk, rst, empty;
		reg [6:0] waterLevel;
		

endmodule

/*
Door system action depends on toggle_inner versus toggle_outer
Listens to the water level so then you can open when the delta is 0.3.
Disallows if you don't.
*/ 
module DoorSystem(
		/* Inputs */ toggle_outer_sw, toggle_inner_sw, 
		/* Outputs */ toggle_outer_led, toggle_inner_led);

endmodule


/*
Updates water level at the correct rate.
Stops updating water volume after Open/Close Inner/Outer is triggered.
*/
module WaterSystem();

endmodule


/*
Gondola signals 5 minutes before arrival.

State:
empty: 1/0
waterLevel: 0.1 level increments. Use 2^6=64 to represent 0-6.4.


Basically:
1. Water Level starts somewhere.
2. You only care that you are thresholded above/below the bounds,
so you want for Inner=6, Outer=4, to bounce <=4.3 and >=5.7
3. Because these rates aren't symmetric, you need to keep track of the
actual water level. 5/7 rate (5/7 feet per minute) for lowering, 5/8 for raising.
4. We will have it conveniently such that, at these rates, you will be able
to make the 5 minute deadline
5. 

*/

