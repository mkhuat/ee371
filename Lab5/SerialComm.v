module SerialComm(
	/* Inputs */ clock, rst, serial_in, parallel_in, load, transmit_enable,
	/* Outputs: */ led_clk, serial_out, parallel_out, char_received, char_sent);
	
	/*
	Inputs
		
	*/
	input clock, rst, serial_in, load, transmit_enable;
	input [7:0] parallel_in; // From Nios II Proc to Transmission
	output wire led_clk, serial_out, char_received, char_sent;
	output [7:0] parallel_out; // To Nios II Proc from Serial Receive

	parameter 
		
		// Clock index	
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4;


	// Divide and display the 50MHz clock
	
	reg [30:0] clock_buff;
	always@(posedge clock) clock_buff <= clock_buff + 1'b1;	
	
	
	// Tap at our CLOCK_INDEX for our desired speed
	wire clk, scan_clk;
	
	assign clk = clock_buff[CLOCK_INDEX];
	assign scan_clk = clock_buff[SAMPLE_INDEX];
	assign led_clk = clock_buff[CLOCK_INDEX];
	

	// State and counters
	reg[3:0] bic_transmit, bic_receive;
	reg[7:0] buffer_transmit, buffer_receive; // "Shift Registers"
	
	// Modules
	Loader loader(clk, rst, load, parallel_in, buffer_transmit, bic_transmit);
	Transmitter transmitter(clk, rst, buffer_transmit, bic_transmit, transmit_enable, serial_out);
	Receiver receiver(clk, rst, serial_in, bic_receive, buffer_receive, scan_clk);
	
	
endmodule

module Loader(clk, rst, load, parallel_in, buffer_transmit, bic_transmit);
	input clk, rst, load;
	input[7:0] parallel_in;
	output reg [7:0] buffer_transmit;
	output reg [3:0] bic_transmit;
	
	// TODO: Add as parameter
	parameter 

		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000; // When pointing to the 9th bit, we have read everything

	always@(posedge load) begin
		// Load message if the last message can be discarded, due to already being sent
		if (bic_transmit == END_WRITE_BIC) begin
			buffer_transmit = parallel_in;
			bic_transmit = START_BIC;
		end
	end
endmodule

module Transmitter(clk, rst, buffer_transmit, bic_transmit, transmit_enable, serial_out);
	input clk, rst, transmit_enable;
	input[7:0] buffer_transmit;
	output reg [3:0] bic_transmit;
	output reg serial_out;
	
	
	// TODO: Add as parameter
	parameter 

		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000; // When pointing to the 9th bit, we have read everything


	always@(posedge clk) begin
		// Clock out the parallel signal while transmit_enable is high and the
		// message has not been read out fully.
		if (transmit_enable && bic_transmit < END_WRITE_BIC) begin
			serial_out = buffer_transmit[bic_transmit];
			bic_transmit = bic_transmit + 1;
		end
	end
endmodule

module Receiver(clk, rst, serial_in, bic_receive, buffer_receive, clk_scan);
	input clk, rst, serial_in, clk_scan;
	output reg [3:0] bic_receive;	
	output reg [7:0] buffer_receive;
	
		// TODO: Add as parameter
	parameter 
		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		// TODO: Check for Off by One errors!
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000, // When pointing to the 9th bit, we have read everything

		
		// BSC States
		START_BSC = 4'b0000,
		MIDDLE_BSC = 4'b0111, // When to sample
		END_BSC = 4'b1111;
	
	

	// When to sample
	reg[3:0] bsc;
	
	reg startBitReceived;
	
	always@(posedge clk_scan) begin
	
		// TODO: Check for bsc off by one here as well!
		if (bsc == MIDDLE_BSC) begin
				if (startBitReceived) begin
					// We can now sample the trasmitted bit from the wire
					buffer_receive[bic_receive] = serial_in;
					bic_receive = bic_receive + 1;
					
					if (bic_receive == END_READ_BIC) begin
						// TODO: Evaluate Off by one because this should toggle after the END BIT, NOT AFTER JUST THE MESSAGE!
						startBitReceived = 0;
						bic_receive = 0; // This is sketchy, because we don't know yet if the Processor has read this. There is no feedback!
					end
				end
				else begin
					if (!serial_in) begin
						// Start bit received!!!
						startBitReceived = 1;
					end
				end
		end
		
		bsc <= bsc + 1'b1;
	end
endmodule
