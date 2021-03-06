/*
Implements a simple Nios II system for the DE-series board.

Inputs: SW7−0 are parallel port inputs to the Nios II system
CLOCK_50 is the system clock
KEY0 is the active-low system reset
Outputs: LEDR7−0 are parallel port outputs from the Nios II system

*/
module TopLevelCommSystem (CLOCK_50, SW, KEY, LEDR, serial_in, serial_out);
	
		
	parameter 
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = 20;
	
	
	input CLOCK_50, serial_in;
	input [7:0] SW;
	input [0:0] KEY;
	output [7:0] LEDR;
	output serial_out;
	
	
	
	// Divide the 50MHz clock
	reg [30:0] clock_buff;
	always@(posedge CLOCK_50) clock_buff <= clock_buff + 1'b1;		
	
	
	// Tap at our CLOCK_INDEX for our desired speed
	wire scan_clk;
	assign scan_clk = clock_buff[SAMPLE_INDEX];
	
	
	// TODO: Why does it not complain when parallel_in and others are not declared?
	wire [7:0] parallel_in, parallel_out; 		// 8-bit parallel bus
	wire char_received, char_sent, transmit_en, load;	// For nios communication
	
	
	TransmitComm transmit(scan_clk, reset, transmit_en, load, parallel_in, serial_out, char_sent);
	ReceiveComm receive(scan_clk, reset, serial_in, parallel_out, char_received);


	
	// Instantiate the Nios II system module generated by the Qsys tool:
	nios_sys NiosII (
		.clk_clk(CLOCK_50),
		.reset_reset_n(KEY),
		.switches_external_connection_export(SW),
		.leds_external_connection_export(LEDR),
		.parallel_input_external_connection_export(parallel_in),
		.parallel_output_external_connection_export(parallel_out),
		.char_received_external_connection_export(char_received),
		.char_sent_external_connection_export(char_sent),
		.transmit_enable_external_connection_export(transmit_en),
		.load_external_connection_export(load)
		);

		
endmodule
