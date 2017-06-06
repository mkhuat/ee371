/*
Implements a simple Nios II system for the DE-series board.

Inputs: SW7−0 are parallel port inputs to the Nios II system
CLOCK_50 is the system clock
KEY0 is the active-low system reset
Outputs: LEDR7−0 are parallel port outputs from the Nios II system

*/
module TopLevelCommSystem (CLOCK_50, SW, KEY, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, serial_in, serial_out, ps);
	
		
	parameter 
		
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = 20;
	
	
	input CLOCK_50, serial_in;
	input [7:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output serial_out;
	output [3:0] ps;
	
	
	assign LEDR[8] = serial_in;
	assign LEDR[9] = serial_out;
	
	// Divide the 50MHz clock
	reg [30:0] clock_buff;
	always@(posedge CLOCK_50) clock_buff <= clock_buff + 1'b1;		
	
	
	// Tap at our CLOCK_INDEX for our desired speed
	wire clk, scan_clk;
	assign clk = clock_buff[CLOCK_INDEX];
	assign scan_clk = clock_buff[SAMPLE_INDEX];
	
	
	// TODO: Why does it not complain when parallel_in and others are not declared?
	wire [7:0] parallel_in, parallel_out; 		// 8-bit parallel bus
	wire[10:0] data_trans, data_receive;
	wire[3:0] bic_trans, bic_receive;
	wire char_received, char_sent, transmit_en, load;	// For nios communication
	wire[7:0] hex_value_5, hex_value_4, hex_value_3, hex_value_2, hex_value_1, hex_value_0;
	
	TransmitComm transmit(.clk(clk), .sample_clk(scan_clk), .reset(~KEY), .transmit_en(transmit_en), .load(load), .parallel_in(parallel_in), 
										.serial_out(serial_out), .char_sent(char_sent), .data(data_trans), .ps(ps), .bic(bic_trans));
	
	ReceiveComm receive(.clk(clk), .sample_clk(scan_clk), .reset(~KEY), .serial_in(serial_in), .parallel_out(parallel_out), 
										.char_received(char_received), .data(data_receive), .bic(bic_receive));
	
	
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
		.load_external_connection_export(load),
		.hex5_external_connection_export(hex_value_5),
		.hex4_external_connection_export(hex_value_4),
		.hex3_external_connection_export(hex_value_3),
		.hex2_external_connection_export(hex_value_2),
		.hex1_external_connection_export(hex_value_1),
		.hex0_external_connection_export(hex_value_0)
		);

		
	// Display hex
	HexEncoder hexencoder5 (hex_value_5, HEX5);
	HexEncoder hexencoder4 (hex_value_4, HEX4);
	HexEncoder hexencoder3 (hex_value_3, HEX3);
	HexEncoder hexencoder2 (hex_value_2, HEX2);
	HexEncoder hexencoder1 (hex_value_1, HEX1);
	HexEncoder hexencoder0 (hex_value_0, HEX0);
		
endmodule
