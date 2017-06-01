
module nios_sys (
	clk_clk,
	leds_external_connection_export,
	reset_reset_n,
	switches_external_connection_export,
	load_external_connection_export,
	parallel_output_external_connection_export,
	parallel_input_external_connection_export,
	data_received_external_connection_export,
	transmit_enable_external_connection_export);	

	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input		reset_reset_n;
	input	[7:0]	switches_external_connection_export;
	output		load_external_connection_export;
	output	[7:0]	parallel_output_external_connection_export;
	input	[7:0]	parallel_input_external_connection_export;
	input		data_received_external_connection_export;
	output		transmit_enable_external_connection_export;
endmodule
