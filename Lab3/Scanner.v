module Scanner #(parameter ID = 0) (
	/* Inputs  */ clk, reset, userInput, count, receiveComm,
	/* Outputs */ transmitComm, stateHex, countHex);

	// Inputs: used to determine this scanner's next state
	input clk, reset;
	input [2:0] userInput;
	output [3:0] count;
	input [1:0] receiveComm;
	
	// Outputs: used to communicate to another scanner
	//output signalReadyToTransfer, signalGoToStandby, signalStartScan, signalFlush;
	output reg [1:0] transmitComm;
	output wire [6:0] stateHex, countHex;
	
	reg [2:0] ps, ns;	// Present, Next state
	
	parameter
	
		// Encoding of states
		LOWPOWER = 3'b000,
		STANDBY = 3'b001,
		COLLECTING = 3'b010,
		IDLE = 3'b011,
		TRANSFERRING = 3'b100,
		FLUSHING = 3'b101,
		
		// Encoding of communication signals
		INACTIVE = 2'b00,
		GO_TO_STANDBY = 2'b01, // Equivalent to: READY_TO_TRANSFER
		START_SCAN = 2'b10,
		START_FLUSH = 2'b11;
		
		
	//reg scanner_active;

	// Counts for this scanner
	reg resetCounter; // Maybe wire idk
	Counter ctr (clk, resetCounter, count);
	DisplayState displayState (ps, count, stateHex, countHex);
	
	// Next state logic
	always @(*) begin
		// $display("Start next state logic");

		// ns = ps;
		resetCounter = 1'b0;
		transmitComm = INACTIVE;
		case (ps)
			LOWPOWER: 	begin
							$display("LOWPOWER %d", ID);
							if (receiveComm == GO_TO_STANDBY || userInput[0]) begin
								ns = STANDBY;
								resetCounter = 1'b1;
							end
						end

			STANDBY:  	begin
							$display("STANDBY %d", ID);
							if (receiveComm == START_SCAN || userInput[2]) begin
								ns = COLLECTING;
								resetCounter = 1'b1;
							end
						end

			COLLECTING:	begin
							$display("COLLECTING %d", ID);
							if (count == 4'b1001) ns = IDLE;
							if (count == 4'b0111) transmitComm = GO_TO_STANDBY;
							if (count == 4'b1000) transmitComm = START_SCAN;
							if (count == 4'b0101) transmitComm = START_FLUSH;
						end

			IDLE:  		begin
							$display("IDLE %d", ID);
							if (userInput[1]) begin
								ns = TRANSFERRING;
								resetCounter = 1'b1;
							end else if (receiveComm == START_FLUSH) begin
								ns = FLUSHING;
								resetCounter = 1'b1;
							end
						end

			TRANSFERRING:	begin
								$display("TRANSFERRING %d", ID);
								if (count == 4'b0010) ns = LOWPOWER; // After 2 cycles, go to low
							end

			FLUSHING: 	begin
							$display("FLUSHING %d", ID);
							if (count == 4'b0010) ns = LOWPOWER; // After 2 cycles, go to low
						end

			default: 	begin
							$display("DEFAULT %d", ID);
							ns = LOWPOWER;
						end
		endcase
	end

	// Reset and state transition logic
	always @(posedge clk) begin
		if (reset) begin
			ps <= LOWPOWER;
		end else begin	
			ps <= ns;
		end
	end

endmodule


/*

A mod-10 counter.

Counts up to a value of ten (0, 1, ..., 9) and then wraps
around to zero. Resets to 0.

*/
module Counter(clk, reset, count);
	input clk, reset;
	output reg [3:0] count;

	always @ (posedge clk) begin
		if (reset || count == 4'b1001) begin
			count <= 4'b0000;
		end else begin
			count <= count + 1;			
		end
	end

endmodule


module DisplayState (state, count, stateHex, countHex);

	input [2:0] state;
	input [3:0] count;
	output reg [6:0] stateHex, countHex;

	parameter
	
		// Hex display of numbers
		HEX_1 = 7'b1111001,
		HEX_2 = 7'b0100100,
		HEX_3 = 7'b0110000,
		HEX_4 = 7'b0011001,
		HEX_5 = 7'b0010010,
		HEX_6 = 7'b0000010,
		HEX_7 = 7'b1111000,
		HEX_8 = 7'b0000000,
		HEX_9 = 7'b0010000,
		HEX_10 = 7'b1001000,
		
		// Hex display of misc.
		HEX_DASH = 7'b1111110,
		HEX_CLEAR = 7'b1111111,

		// Hex display of states
		HEX_L = 7'b1110001, // L = Low Power
		HEX_S = 7'b0100100, // S = Standby
		HEX_C = 7'b0110001, // C = Collecting (Scanning)
		HEX_I = 7'b1000010, // d = Idle
		HEX_T = 7'b1110000, // t = Transferring
		HEX_F = 7'b0111000, // F = Flushing
		
		// Encoding of states
		LOWPOWER = 3'b000,
		STANDBY = 3'b001,
		COLLECTING = 3'b010,
		IDLE = 3'b011,
		TRANSFERRING = 3'b100,
		FLUSHING = 3'b101;
	
	always @(state) begin
		case (state)
			LOWPOWER: stateHex = HEX_L;
			STANDBY: stateHex = HEX_S;
			COLLECTING:	stateHex = HEX_C;
			IDLE: stateHex = HEX_I;
			TRANSFERRING: stateHex = HEX_T;
			FLUSHING: stateHex = HEX_F;
			default: stateHex = HEX_CLEAR;
		endcase
	end

	always @(count) begin
		case (count)
			4'b0000: countHex = HEX_1;
			4'b0001: countHex = HEX_2;
			4'b0010: countHex = HEX_3;
			4'b0011: countHex = HEX_4;
			4'b0100: countHex = HEX_5;
			4'b0101: countHex = HEX_6;
			4'b0110: countHex = HEX_7;
			4'b0111: countHex = HEX_8;
			4'b1000: countHex = HEX_9;
			4'b1001: countHex = HEX_10;
			default: countHex = HEX_CLEAR;
		endcase
	end

endmodule

