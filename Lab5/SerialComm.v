module SerialComm(
	/* Inputs */ clk, serial_in, parallel_in, load, transmit_enable,
	/* Outputs: */ led_clk, serial_out, parallel_out, char_received, char_sent);
	
	/*
	Inputs
		
	*/
	input clk, serial_in, load, transmit_enable;
	input [7:0] paralell_in; // From Nios II Proc to Transmission
	output wire led_clk, serial_out, char_received, char_sent;
	output [7:0] paralell_out; // To Nios II Proc from Serial Receive

	parameter 
		
		// Clock index
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4,

		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000, // When pointing to the 9th bit, we have read everything

		
		// BSC States
		START_BSC = 4'b0000,
		MIDDLE_BSC = 4'b0111, // When to sample
		END_BSC = 4'b1111;


	// Divide and display the 50MHz clock
	reg [30:0] scan_clk;
	always@(posedge clk) scan_clk <= scan_clk + 1'b1
	assign clk_led = scan_clk[CLOCK_INDEX];

	// State and counters
	reg[3:0] bic_transmit, bic_receive;
	reg[7:0] buffer_transmit, buffer_receive; // "Shift Registers"
	
	// Modules
	
endmodule

module Loader(clk, load, parallel_in, buffer_transmit, bic_transmit) begin
	
	// TODO: Add as parameter
	parameter 
		
		// Clock index
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4,

		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000, // When pointing to the 9th bit, we have read everything

		
		// BSC States
		START_BSC = 4'b0000,
		MIDDLE_BSC = 4'b0111, // When to sample
		END_BSC = 4'b1111;

	always@(posedge load) begin
		// Load message if the last message can be discarded, due to already being sent
		if bic_transmit == END_WRITE_BIC
			buffer_transmit = paralell_in
	end
end

module Transmitter(clk, buffer_transmit, bic_transmit, transmit_enable, serial_out);
	
	// TODO: Add as parameter
	parameter 
		
		// Clock index
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4,

		// Encoding of states
		
		// BIC states
		// 0-based Indexing makes along with "Pointing to next write"
		START_BIC = 4'b0000,
		END_READ_BIC = 4'b1010, // When pointing to 11th bit, we have read everything
		END_WRITE_BIC = 4'b1000, // When pointing to the 9th bit, we have read everything

		
		// BSC States
		START_BSC = 4'b0000,
		MIDDLE_BSC = 4'b0111, // When to sample
		END_BSC = 4'b1111;


	always@(posedge clk) begin
		// Clock out the parallel signal while transmit_enable is high and the
		// message has not been read out fully.
		if (transmit_enable && bic_transmit < END_WRITE_BIC) begin
			serial_out = buffer_transmit[bic_transmit]
			bic_transmit = bic_transmit + 1
		end
	end
endmodule

module Receiver(clk, bic_receive, buffer_receive, start_bit_received);
	
	output[7:0] buffer_receive;

	// When to sample
	reg[3:0] bsc;

	// TODO: When can we start reading? When do we track when "Start Bit Detect" 
	always@(posedge clk) begin
		// Clock in the serial signal while the signal has not been read in fully
		if (transmit_enable && bic_transmit < END_WRITE_BIC) begin
			serial_out = buffer_transmit[bic_transmit]
			bic_transmit = bic_transmit + 1
		end

	end

endmodule

// module BSC();
// 	always@(posedge clk) begin
	
	
// 	end
// endmodule


// module BIC();
// 	always@(posedge clk) begin
	
	
// 	end
// endmodule



// module StartBitDetect();
// 	// Look for start sequence if not currently reading for transmitting
	
// 	always@(posedge clk) begin
	
// 	end
// endmodule

// module TransmitEnable();
// 	//
// endmodule

// // TODO: Add Shift Registers and Clock Control