module TopLevelLockSystem
		#( parameter INNER = 5*560,  parameter OUTER = 0, parameter TOLERANCE = 0.3*560, parameter CLOCK_INDEX = 24)
		(/* Inputs */ clk, rst, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level,
		/* Outputs */ inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led, clk_led,
		/* Display */ HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		
	input clk, rst, inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, inc_water_level, dec_water_level;
	output inner_gondola_led, outer_gondola_led, outer_door_openable_led, inner_door_openable_led;
	output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire inner_door_en, outer_door_en, outer_gondola_arrival_en, inner_gondola_arrival_en, inc_water_level_en, dec_water_level_en, reset;
	
	reg [30:0] tBase;
	always@(posedge clk) tBase <= tBase + 1'b1;
	
	assign reset = !rst;
	
	filter inner_door_f (tBase[CLOCK_INDEX], reset, inner_door_sw, inner_door_en);
	filter outer_door_f (tBase[CLOCK_INDEX], reset, outer_door_sw, outer_door_en);
	filter outer_gondola_arrival_f (tBase[CLOCK_INDEX], reset, outer_gondola_arrival_sw, outer_gondola_arrival_en);
	filter inner_gondola_arrival_f (tBase[CLOCK_INDEX], reset, inner_gondola_arrival_sw, inner_gondola_arrival_en);
	//filter inc_water_level_f (tBase[CLOCK_INDEX], reset, !inc_water_level, inc_water_level_en);
	//filter dec_water_level_f (tBase[CLOCK_INDEX], reset, !dec_water_level, dec_water_level_en);
	
	wire [3:0] state;
	
	
	// We need water_level such that we can show the 0.3 boundary
	wire [31:0] water_level;
	
	WaterSystem waterSystem (!inc_water_level, !dec_water_level, tBase[CLOCK_INDEX], reset, water_level, outer_door_openable_led, inner_door_openable_led);
	
	GondolaDoorLight gondolaDoorLight (inner_door_en, outer_door_en, outer_gondola_arrival_en, inner_gondola_arrival_en, water_level, reset, tBase[CLOCK_INDEX],
	  outer_door_openable_led, inner_door_openable_led, inner_gondola_led, outer_gondola_led, state);
	
	DisplayState displayState (state, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

	output wire clk_led;
	assign clk_led = tBase[CLOCK_INDEX];
	
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
module GondolaDoorLight
		#( parameter INNER = 10*560, parameter OUTER = 5*560, parameter TOLERANCE = 3*56, parameter GONDOLA_ARR_DELAY = 5, parameter GONDOLA_DEPT_DELAY = 5, parameter ARRIVING = 0, parameter IN_POUND = 1, parameter DEPARTING = 2, parameter VACANT = 3)
		(/* Inputs */ inner_door_sw, outer_door_sw, outer_gondola_arrival_sw, inner_gondola_arrival_sw, water_level, reset, clk, outer_door_openable, inner_door_openable,
		/* Outputs */ inner_gondola_led, outer_gondola_led, state);
		
		// Clock and reset input
		input clk, reset;
		// Door controls
		input inner_door_sw, outer_door_sw;
		// Gondola arrival controls
		input outer_gondola_arrival_sw, inner_gondola_arrival_sw;
		// Gondola LED output
		output inner_gondola_led, outer_gondola_led;
		reg inner_gondola_led, outer_gondola_led;
		// Needed to respond to inner_door_sw and outer_door_sw
		input [31:0] water_level;
		
		input outer_door_openable, inner_door_openable;
		
		// Display state
		output reg [3:0] state;
		
		// Can change arrival switch only after 5
		reg [31:0] counter;
		
		// Once the gondola enters the lock, we need to know what direction it needs to go
		// Clear these once the gondolas leave the locks
		// TODO: Should we have position track clear state instead?
		reg to_outer, to_inner;
		
		// 0: arriving, 1: in pound, 2: departing
		// TODO: Should we have position track clear state instead?
		reg [8:0] position;
		
		// We should only keep the counter incrementing until the highest value of the counter we care about
		reg [31:0] counter_max = GONDOLA_ARR_DELAY > GONDOLA_DEPT_DELAY ? GONDOLA_ARR_DELAY : GONDOLA_DEPT_DELAY;
		
		// TODO: Perhaps reduce duplication with the LED in the other module
		// assign outer_door_openable = water_level <= OUTER + TOLERANCE;
		// assign inner_door_openable = water_level >= INNER - TOLERANCE;
		
		always @ (posedge clk)
			begin
				// We need to mark the canal as clear and reset its state if:
				// 1. The boat is in position 2 (leaving) and the counter is at least GONDOLA_DEPT_DELAY
				// 2. We reset
				if (reset || (position == DEPARTING && counter >= GONDOLA_DEPT_DELAY))
					begin
						// Reset to default values
						// Do not reset water. It is handled by the WaterSystem module.
						counter = 0;
						to_outer = 0;
						to_inner = 0;
						position = VACANT;
						inner_gondola_led = 0;
						outer_gondola_led = 0;
						state = 'd0;
					end
				else
					begin
					
						
						// OUTER ARRIVAL
						// No gondolas may arrive during the lock traversal procedure
						// Start timer, such that the pound becomes enter-able only after GONDOLA_DEPT_DELAY units after the boat leaves the lock
						if (outer_gondola_arrival_sw)
							begin
								// reset must be low, and there needs to be no boats currently traversing (!to_outer && !to_inner)
								if (!reset && !to_outer && !to_inner)
									begin
										counter = 0;
										position = ARRIVING;
										to_outer = 0;
										to_inner = 1;
										outer_gondola_led = 1;
										state = 'd8;
									end
							end
						
						// INNER ARRIVAL
						if (inner_gondola_arrival_sw)
							begin
								// reset must be low, and there needs to be no boats currently traversing (!to_outer && !to_inner)
								if (!reset && !to_outer && !to_inner)
									begin
										counter = 0;
										position = ARRIVING;
										to_outer = 1;
										to_inner = 0;
										inner_gondola_led = 1;
										state = 'd1;
									end
							end

					
						counter = counter < counter_max ? counter + 1 : counter_max;
						
						
						// Animate state of gondola
						if (counter >= GONDOLA_ARR_DELAY && to_inner && !outer_door_sw && position == ARRIVING) begin
							state = 'd7;
						end

						if (counter >= GONDOLA_ARR_DELAY && to_outer && !inner_door_sw && position == ARRIVING) begin
							state = 'd2;
						end
						
						
						if (position == IN_POUND) begin
							if ((to_inner && inner_door_openable) || (to_outer && !outer_door_openable)) state = 'd4;
							else if ((to_outer && outer_door_openable) || (to_inner && inner_door_openable)) state = 'd5;
						end
						
						if (to_inner && position == IN_POUND && inner_door_openable) begin
							state = 'd4;
						end

						if (to_outer && position == IN_POUND && outer_door_openable) begin
							state = 'd5;
						end
						
						// Trigger departure
						if (position == DEPARTING && counter <= GONDOLA_DEPT_DELAY)
							begin
							if (to_inner)
								begin
									state = 'd1;
								end
							else
								begin
								if (to_outer)
									begin
										state = 'd8;
									end								
								end
							
							
							end
						
						
						// INNER SWITCH
						if (inner_door_sw) begin
							case(position)
								ARRIVING:
								// Boat is before the pound, only move forward if:
								// 1. It's been long enough (>=GONDOLA_ARR_DELAY)
								// 2. it's going to_outer
								// 3. inner_door_openable is true
									if (inner_door_openable && counter >= GONDOLA_ARR_DELAY && to_outer)
									begin
										position = IN_POUND;
										// Both lights on when boat is in the pound
										outer_gondola_led = 1;
										inner_gondola_led = 1;
										state = 'd4;
									end
								IN_POUND:
								// Boat is in the pound, only move forward if:
								// 2. it's going to_inner
								// 3. inner_door_openable is true
									if (inner_door_openable && to_inner)
									begin
										position = DEPARTING;
										outer_gondola_led = 0;
										inner_gondola_led = 1;
										// Restart counter as we need to wait for the boat to leave
										counter = 0;
										state = 'd2;
									end
							endcase
						end
						
						// OUTER SWITCH
						if (outer_door_sw)
							begin
								case(position)
									ARRIVING:
									// Boat is before the pound, only move forward if:
									// 1. It's been long enough (>=GONDOLA_ARR_DELAY)
									// 2. it's going to_inner
									// 3.  is true
										if (outer_door_openable && counter >= GONDOLA_ARR_DELAY && to_inner)
										begin
											position = IN_POUND;
											// Both lights on when boat is in the pound
											outer_gondola_led = 1;
											inner_gondola_led = 1;
											state = 'd5;
										end
									IN_POUND:
									// Boat is in the pound, only move forward if:
									// 2. it's going to_outer
									// 3. outer_door_openable is true
										if (outer_door_openable && to_outer)
										begin
											position = DEPARTING;
											// Restart counter as we need to wait for the boat to leave
											counter = 0;
											inner_gondola_led = 0;
											outer_gondola_led = 1;
											state = 'd7;
										end
								endcase
							end
					end
				end
endmodule


/*
Updates water level at the correct rate.
Stops updating water volume after Open/Close Inner/Outer is triggered.
*/
module WaterSystem
		#( parameter INNER = 10*560,  parameter OUTER = 5*560, parameter TOLERANCE = 56*3, parameter INC_AMT = 5 * 560 / 8, parameter DEC_AMT = 5 * 560 / 7)
		(/* Inputs */ inc_water_level, dec_water_level, clk, reset,
		/* Outputs */ water_level, outer_door_openable_led, inner_door_openable_led);
		
		// Water level controls
		input inc_water_level, dec_water_level;
		// Clock and reset input
		input clk, reset;
		
		// water_level changes responding to the WaterSystem
		output [31:0] water_level;
		reg [31:0] water_level;
		
		// Wires for continuous increment (not truly continuous as water increments only at clk boundary)
		output outer_door_openable_led, inner_door_openable_led;
		wire outer_door_openable_led, inner_door_openable_led;
		
		assign outer_door_openable_led = water_level < OUTER + TOLERANCE;
		assign inner_door_openable_led = water_level > INNER - TOLERANCE;
		
		always @ (posedge clk)
			begin
			// Increment water level if key was pressed or reset if reset is high
			// Limits rate at which water can increase
				if (reset)
					begin
						// Reset to default values
						// water_level = OUTER;
						// outer_led = HIGH;
						water_level = OUTER;
					end
				else
					// Only respond to inc/dec_water_level if not resetting
					begin
						if (inc_water_level)
							begin
								// Bound the max water level to be INNER
								water_level = water_level + INC_AMT < INNER ? water_level + INC_AMT : INNER;
							end
						if (dec_water_level)
							begin
								// Bound the min water level to be OUTER
								water_level = water_level - DEC_AMT > OUTER ? water_level - DEC_AMT : OUTER;
							end
					end
			end
endmodule
