

module TopLevelLockSystem
		#( parameter INNER = 5,  parameter OUTER = 0, parameter TOLERANCE = 0.3)
		(/* Inputs */ clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,
		/* Outputs */ inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led);
		
	input clk, reset, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level;
	output inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
	
	// State
	reg clk, rst, empty;
	
	// We need water_level such that we can show the 0.3 boundary
	reg real water_level;
		

endmodule

/*
The terminology "Arrival SW" or "Arrival LED" and "Departure SW" or "Departure LED"
are direction dependant. If the SW corresponding to outer is pressed, then "Arrival"
side refers to outer, and "Departure" refers to inner.

Lights should change:
1. The "Arrival SW" informs the side the gondola is arriving from,
which turns on the corresponding side's LED
2. The "Arrival LED" can return to LOW iff:
		1. water_level is within the 0.3 margin such that the proper "Arrival" door LED is illuminated
		2. 5 minutes have passed such that the boat is waiting for the door to open
		3. Operator pressed the "Arrival SW" door open switch
3. The "Departure LED" will go HIGH iff:
		1. The boat is in the pound (the procedure in 1 and 2 occurred)
		2. water_level is within the 0.3 margin such that the "Departure" door LED is illuminated
		3. Operator pressed the "Departure SW" door open switch
4. The "Departure LED" will go low after 5 minutes.

LEDs can only cycle from "Arrival" to "Departure" except if the operator pressed the wrong direction key.
*/
module GondolaDoorLight();
		#( parameter INNER = 5,  parameter OUTER = 0, parameter TOLERANCE = 0.3, parameter GONDOLA_ARR_DELAY = 300, parameter GONDOLA_DEPT_DELAY = 300)
		(/* Inputs */ inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, water_level, reset, clk,
		/* Outputs */ inner_gondola_led, outer_gondola_led);
		
		// Clock and reset input
		input clk, reset;
		// Door controls
		input inner_door_sw, outer_door_sw;
		// Gondola arrival controls
		input outer_gondola_arrival_sw, inner_gondola_arrival_sw;
		
		// Needed to respond to inner_door_sw and outer_door_sw
		input water_level;
		real water_level;
		
		// Can change arrival switch only after 5 minutes, or 300
		reg counter;
		
		// Once the gondola enters the lock, we need to know what direction it needs to go
		// Clear these once the gondolas leave the locks
		reg to_outer, to_inner;
		// 0: arriving, 1: in pound, 2: departing
		reg position;
		
		// TODO: Perhaps reduce duplication with the LED
		assign outer_door_openable = water_level < OUTER + TOLERANCE;
		assign inner_door_openable = water_level > INNER - TOLERANCE;
		
		always @ (posedge clk)
			begin
				if (reset)
					begin
						// Reset to default values
						// counter = 0
						counter = 0;
						to_outer = 0;
						to_inner = 0;
					end
				else
					// Only respond to inc/dec_water_level if not resetting
					begin
						counter = counter < GONDOLA_ARR_DELAY ? counter + 1 : GONDOLA_ARR_DELAY; 
						
					end
			end
		
		
		always @ (posedge inner_door_sw)
			begin
				// The gondola only wants to enter the inner door iff:
				// 1. The gondola is entering from outer and 5 minutes have elapsed.
				// 2. The gondola is already in the pound and is heading from inner to outer
				if (inner_door_openable && counter >= GONDOLA_ARR_DELAY && position == 0 && to_outer)
					begin
					
					end
			end
			
		always @ (posedge outer_door_sw)
			begin
				// The gondola only wants to enter the outer door iff:
				// 1. The gondola is entering from outer and 5 minutes have elapsed.
				// 2. The gondola is already in the pound and is heading from inner to outer
				if (outer_door_openable && counter >= GONDOLA_ARR_DELAY && position == 0 && to_inner)
					begin
					
					end
			end
		
		// No gondolas may arrive during the lock traversal procedure
		// Start 5 minute timer, such that the pound becomes enter-able only after 5 minutes

		always @ (posedge outer_gondola_arrival_sw)
			begin
				if (!to_outer && !to_inner)
					begin
						counter = 0;
						to_outer = 0;
						to_inner = 1;
					end

			end
				
		always @ (posedge inner_gondola_arrival_sw)
			begin
				if (!to_outer && !to_inner)
					begin
						counter = 0;
						to_outer = 1;
						to_inner = 0;
					end
			end
		
endmodule


/*
Updates water level at the correct rate.
Stops updating water volume after Open/Close Inner/Outer is triggered.
*/
module WaterSystem();
		#( parameter INNER = 5,  parameter OUTER = 0, parameter TOLERANCE = 0.3)
		(/* Inputs */ inc_water_level, dec_water_level, clk, reset,
		/* Outputs */ water_level, outer_door_openable_led, inner_door_openable_led);
		
		// Water level controls
		input inc_water_level, dec_water_level;
		// Clock and reset input
		input clk, reset;
		
		// water_level changes responding to the WaterSystem
		output water_level;
		reg water_level;
		
		// Wires for continuous increment (not truly continuous as water increments only at clk boundary)
		output outer_door_openable_led, inner_door_openable_led;
		wire outer_door_openable_led, inner_door_openable_led;
		
		assign outer_door_openable_led = water_level < OUTER + TOLERANCE;
		assign inner_door_openable_led = water_level > INNER - TOLERANCE;
		
		// To hold state of inc_pressed 
		reg inc_pressed, dec_pressed;
		
		always @ (posedge clk)
			begin
			// Increment water level if key was pressed or reset if reset is high
				if (reset)
					begin
						// Reset to default values
						// water_level = OUTER;
						// outer_led = HIGH;
						water_level = OUTER;
						inc_pressed = 1'b0;
						dec_pressed = 1'b0;
					end
				else
					// Only respond to inc/dec_water_level if not resetting
					begin
						if (inc_pressed)
							begin
								// Bound the max water level to be INNER
								water_level = water_level + (5/8) < INNER ? water_level + (5/8) : INNER;
								inc_pressed = 1'b0;
							end
						if (dec_pressed)
							begin
								// Bound the min water level to be OUTER
								water_level = water_level - (5/7) > OUTER ? water_level - (5/7) : OUTER;
								dec_pressed = 1'b0;
							end
					end
			end
		
		always @ (posedge inc_water_level)
			inc_pressed = 1'b1;
		always @ (posedge dec_water_level)
			dec_pressed = 1'b1;
		
endmodule


/*
Gondola signals 5 minutes before arrival.


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

/*
Door system action depends on toggle_inner versus toggle_outer
Listens to the water level so then you can open when the delta is 0.3.
Disallows if you don't.
*/ 
module DoorSystem
		#( parameter INNER = 5,  parameter OUTER = 0, parameter TOLERANCE = 0.3)
		(/* Inputs */ outer_gondola_arrival_sw, inner_gondola_arrival_sw, water_level, reset,
		/* Outputs */ outer_door_openable_led, inner_door_openable_led);
		
	input outer_gondola_arrival_sw, inner_gondola_arrival_sw, water_level, reset;
	output outer_door_openable_led, inner_door_openable_led;
	
	// Door control based on past LED status:
	// If outer on, the water level is low. Pressing the switch will:
	
	// *1. Turn off the led in 1 second (actually 0.3/(5/7) = 0.48 seconds if the
	// water levels are 0.0 and 5.0, and the LEDs should illuminate/de-illuminate at 0.3 and 4.7
	// 2. Turn off immediately if we just are alternating 
	// between 0.3 and 5.3 with true water levels of 0.0 and 5.6)
	
	
	// Switch behavior
	// *1. NOP if LED not illuminated
	// 2. Error state 
	always @ (posedge inner_gondola_arrival_sw)
		if (water_level > INNER - TOLERANCE )
			// Open inner door
		// else err?
	
	always @ (posedge outer_gondola_arrival_sw)
		if (water_level < OUTER + TOLERANCE )
			// Open outer door
		// else err?
endmodule

