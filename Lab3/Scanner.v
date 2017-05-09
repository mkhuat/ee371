module Scanner(
	/* Inputs */ clk, reset, userInput, count, receiveComm, // goToStandby, startScan, startTranfser, startFlush,
	/* Outputs  signalReadyToTransfer, signalGoToStandby, signalStartScan, signalFlush,*/transmitComm, ps);

	// Inputs: used to determine this scanner's next state
	input clk, reset;
	input [2:0] userInput;
	output [3:0] count;
	input [1:0] receiveComm;
	
	// Outputs: used to communicate to another scanner
	//output signalReadyToTransfer, signalGoToStandby, signalStartScan, signalFlush;
	output reg [1:0] transmitComm;
	output reg [2:0] ps; 	// Present State
	reg [2:0] ns;			// Next state
	

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

	// Next state logic
	always @(*) begin
		ns = ps;
		resetCounter = 1'b0;
		transmitComm = INACTIVE;
		case (ps)
			LOWPOWER: 	begin
							if (receiveComm == GO_TO_STANDBY || userInput[0]) begin
								ns = STANDBY;
								resetCounter = 1'b1;
							end
						end

			STANDBY:  	begin
							if (receiveComm == START_SCAN || userInput[2]) begin
								ns = COLLECTING;
								resetCounter = 1'b1;
							end
						end

			COLLECTING:	begin
							if (count == 4'b1001) ns = IDLE;
							if (count == 4'b0111) transmitComm = GO_TO_STANDBY;
							if (count == 4'b1000) transmitComm = START_SCAN;
							if (count == 4'b0101) transmitComm = START_FLUSH;
						end

			IDLE:  		begin
							if (userInput[1]) begin
								ns = TRANSFERRING;
								resetCounter = 1'b1;
							end else if (receiveComm == START_FLUSH) begin
								ns = FLUSHING;
								resetCounter = 1'b1;
							end
						end

			TRANSFERRING:	begin
								if (count == 4'b0100) ns = LOWPOWER; // After 5 cycles, go to low
							end

			FLUSHING: 	begin
							if (count == 4'b0100) ns = LOWPOWER; // After 5 cycles, go to low
						end

			default: ns = ps;

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
			count <= 4'b0001;
		end else begin
			count <= count + 1;			
		end
	end

endmodule
