module TopLevelCommSystem (clk, reset, SW, LEDR, parallel_in, parallel_out, data_received, load, transmit_enable);
	parameter 
		
		// Clock index	
		CLOCK_INDEX = 24,
		
		// Sample index: subtract 4 because 16x faster
		SAMPLE_INDEX = CLOCK_INDEX - 4;

	
	// Inputs
	input clk;
	input [0:0] reset; // can assign this to KEY 0
	input [7:0] SW;
	input [7:0] parallel_in;
	
	// Outputs
	output [7:0] LEDR;
	output [7:0] parallel_out;
	output load, transmit_enable, data_received; 

	// Divide and display the 50MHz clock
	reg [30:0] clock_buff;
	always@(posedge clk) clock_buff <= clock_buff + 1'b1;		
	
	// Tap at our CLOCK_INDEX for our desired speed
	wire clock, scan_clk;
	assign clock = clock_buff[CLOCK_INDEX];
	assign scan_clk = clock_buff[SAMPLE_INDEX];
	assign led_clk = clock_buff[CLOCK_INDEX];
	
	// Instantiate the Nios II system module generated by the Qsys tool:
	nios_sys u0 (
		.clk_clk                                    (clk),
		.leds_external_connection_export            (LEDR),
		.reset_reset_n                              (reset),
		.switches_external_connection_export        (SW),
		.load_external_connection_export            (load),
		.parallel_output_external_connection_export (parallel_out),
		.parallel_input_external_connection_export  (parallel_in),
		.data_received_external_connection_export   (data_received),
		.transmit_enable_external_connection_export (transmit_enable)  // transmit_enable_external_connection.export
	);

		
endmodule
