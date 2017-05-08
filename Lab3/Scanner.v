module Scanner(
	/* Inputs */ clk, reset, count, goToStandby, startScan, startTranfser, startFlush,
	/* Outputs */ signalReadyToTransfer, signalGoToStandby, signalStartScan, signalFlush, state);

	// Inputs: used to determine this scanner's next state
	input clk, reset, goToStandby, startScan, startTranfser, startFlush;
	input [3:0] count;

	// Outputs: used to communicate to another scanner
	output signalReadyToTransfer, signalGoToStandby, signalStartScan, signalFlush;
	output [2:0] state;

	// Encoding of states
	LOWPOWER = 3'b000,
	STANDBY = 3'b001,
	COLLECTING = 3'b010,
	IDLE = 3'b011,
	TRANSFERRING = 3'b100,
	FLUSHING = 3'b101;

	// Present state and next state
	reg [2:0] ps, ns;

	reg scanner_active;

	// Counts for this scanner
	Counter ctr (clk, reset, count);

	// Next state logic
	always @(*) begin

		if (scanner_active) begin

			case (ps)
				LOWPOWER: 	begin
								if (goToStandby) ns = STANDBY;
								else ns = ps;	
							end

				STANDBY:  	begin
								if (startScan) ns = COLLECTING;
								else ns = ps;
							end

				COLLECTING:	begin
								if (count == 4'b1001) ns = IDLE;
								else ns = ps;
							end

				IDLE:  		begin
								if (startTransfer && count < 4'b0100) ns = TRANSFERRING;
								else if (startFlush) ns = FLUSHING;
								else ns = ps;
							end

				TRANSFERRING:	begin
									if (count = 4'b0100) ns = LOWPOWER
									else ns = ps
								end

				FLUSHING: 	begin
								if (count = 4'b0100) ns = LOWPOWER
								else ns = ps
							end

				default: ns = ps;

			endcase

		end
	end

	// Reset and state transition logic
	always@(posedge clk) begin
		if (reset) begin
			scaner_active <= 0;
			ps <= LOWPOWER;
		end else begin
			scaner_active <= scaner_active		
			ps <= ns;
		end
	end

	// Assign our outputs
	assign signalReadyToTransfer = (count == 4'b0111); 	// At 80%
	assign signalGoToStandby = (count == 4'b0111); 		// At 80%
	assign signalStartScan = (count == 4'b1000);		// At 90%
	assign signalFlush = (count == 4'b1001);			// At 100%
	assign state = ps;

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
			counter <= 4'b1001
		end else begin
			counter <= counter + 1;			
		end
	end

endmodule