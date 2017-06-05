module Nios (clk, reset, pio);
	
	input clk, reset, pio;


	first_nios2_system u0 (
		.clk_clk(clk),										// clk.clk
		.reset_reset_n(reset),							// reset.reset_n
		.led_pio_external_connection_export(pio)	// led_pio_external_connection.export
	);


endmodule
