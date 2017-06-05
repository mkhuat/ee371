
module nios_sys (
	char_received_external_connection_export,
	char_sent_external_connection_export,
	clk_clk,
	leds_external_connection_export,
	load_external_connection_export,
	parallel_input_external_connection_export,
	parallel_output_external_connection_export,
	reset_reset_n,
	switches_external_connection_export,
	transmit_enable_external_connection_export,
	hex5_external_connection_export,
	hex4_external_connection_export,
	hex3_external_connection_export,
	hex2_external_connection_export,
	hex1_external_connection_export,
	hex0_external_connection_export);	

	input		char_received_external_connection_export;
	input		char_sent_external_connection_export;
	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	output		load_external_connection_export;
	output	[7:0]	parallel_input_external_connection_export;
	input	[7:0]	parallel_output_external_connection_export;
	input		reset_reset_n;
	input	[7:0]	switches_external_connection_export;
	output		transmit_enable_external_connection_export;
	output	[7:0]	hex5_external_connection_export;
	output	[7:0]	hex4_external_connection_export;
	output	[7:0]	hex3_external_connection_export;
	output	[7:0]	hex2_external_connection_export;
	output	[7:0]	hex1_external_connection_export;
	output	[7:0]	hex0_external_connection_export;
endmodule
