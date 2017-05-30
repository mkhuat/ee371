module TopLevelSerialCommSystem(
	/* Inputs */ clk, serial_in, parallel_in,
	/* Outputs: */ led_clk, serial_out, parallel_out);
	
	/*
	Inputs
		reset: sets all scanners to a low power state
		startSystem: transitions first scanner from low power to standby
		startScan: transitions first scanner from standby to scanning
		startTransfer: transitions an idle scanner to transferring
	*/
	input clk, serial_in;
	input [7:0] paralell_in; // From Nios II Proc to Transmission
	output wire serial_out, led_clk;
	output [7:0] paralell_out; // To Nios II Proc from Serial Receive

	parameter 
		
		// Clock index
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4,

		// Encoding of states
		
		
		// BIC states
		START_BIC = 4'b0000, // Incremented as 

		
		// BSC States
		START_BSC = 4'b0000,
		MIDDLE_BSC = 4'b0111, // When to sample
		END_BSC = 4'b1111;


	// Divide and display the 50MHz clock
	reg [30:0] scan_clk;
	always@(posedge clk) scan_clk <= scan_clk + 1'b1
	assign clk_led = scan_clk[CLOCK_INDEX];

	// State and counters
	reg[3:0] bic, bsc;
	reg[7:0] buffer_transmit, buffer_receive; // "Shift Registers"
	
	// Modules
	assign 
	
endmodule


module BSC();
	always@(posedge clk) begin
	
	
	end
endmodule


module BIC();
	always@(posedge clk) begin
	
	
	end
endmodule



module StartBitDetect();
	// Look for start sequence if not currently reading for transmitting
	
	always@(posedge clk) begin
	
	end
endmodule

module TransmitEnable();
	//
endmodule

// TODO: Add Shift Registers and Clock Control