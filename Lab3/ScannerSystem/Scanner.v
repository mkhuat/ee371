module Scanner (
	/* Inputs  */ clk, reset, userInput, count, receiveComm,
	/* Outputs */ transmitComm, stateHex, countHex);

	// Inputs: used to determine this scanner's next state
	input clk, reset;
	input [2:0] userInput;
	output reg [3:0] count;
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
	reg hold; // stop counting
	DisplayState displayState (ps, count, stateHex, countHex);
	
	// Next state logic
	always @(*) begin
		
		// System defaults (steady state)
		hold = 1'b1;
		ns = ps;
		transmitComm = INACTIVE;
		
		case (ps)
			LOWPOWER:
				if (receiveComm == GO_TO_STANDBY || userInput[0])
					ns = STANDBY;
							
			STANDBY: 
				if (receiveComm == START_SCAN || userInput[2])
					ns = COLLECTING;
					
			COLLECTING:	
				begin
					hold = 1'b0;
					
					// Signal adjacent scanner
					case (count)
						4'b1001: ns = IDLE;
						4'b0111: transmitComm = GO_TO_STANDBY; // 80%
						4'b1000: transmitComm = START_SCAN;    // 90%
						4'b0101: transmitComm = START_FLUSH;   // 50%
						default: transmitComm = INACTIVE;   // 50%
					endcase
				end

			IDLE: 
				begin
					if (userInput[1])
						ns = TRANSFERRING;		
				
					else if (receiveComm == START_FLUSH)
						ns = FLUSHING;				
				end
				
			FLUSHING, TRANSFERRING:
				begin
					hold = 1'b0;
					if (count == 4'b0010) ns = LOWPOWER; // After 2 cycles, go to low
				end
				
			default: 
				begin
					hold = 1'b1;
					ns = ps;
					transmitComm = INACTIVE;
				end
		endcase
	end

	
	// state loading
	always @(posedge clk) begin
		if (reset)
			ps <= LOWPOWER;
		else
			ps <= ns;
	end
	
	// counter counting
	always @(posedge clk) begin
		if (hold)
			count <= 4'b1111;
		else
			count = (count != 4'b1111) ? count + 4'b0001 : 4'b0000;
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
		HEX_10 = 7'b0001001,
		
		// Hex display of misc.
		HEX_DASH = 7'b0111111,
		HEX_CLEAR = 7'b1111111,

		// Hex display of states
		HEX_L = 7'b1000111, // L = Low Power
		HEX_S = 7'b0010010, // S = Standby
		HEX_C = 7'b1000110, // C = Collecting (Scanning)
		HEX_I = 7'b0100001, // d = Idle
		HEX_T = 7'b0000111, // t = Transferring
		HEX_F = 7'b0001110, // F = Flushing
		
		// Encoding of states
		LOWPOWER = 3'b000,
		STANDBY = 3'b001,
		COLLECTING = 3'b010,
		IDLE = 3'b011,
		TRANSFERRING = 3'b100,
		FLUSHING = 3'b101;
		
	
	always @(*) begin
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

	always @(*) begin
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
			4'b1111: countHex = HEX_DASH;
			default: countHex = HEX_CLEAR;
		endcase
	end

endmodule