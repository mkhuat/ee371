
module TopLevelScannerSystem(
	/* Inputs */ clk, reset, startScan, startTransfer,
	/* Outputs: LED */ scan_1_transfer_me, scan_2_transfer_me, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_flush, scan_2_flush,
	/* Outputs: HEX */ HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input clk, reset, startScan, startTransfer;
	output scan_1_transfer_me, scan_2_transfer_me, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_flush, scan_2_flush;
	output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	parameter 
		
		// Hex display of numbers
		HEX_0 = 7'b1000000,
		HEX_1 = 7'b1111001,
		HEX_2 = 7'b0100100,
		HEX_3 = 7'b0110000,
		HEX_4 = 7'b0011001,
		HEX_5 = 7'b0010010,
		HEX_6 = 7'b0000010,
		HEX_7 = 7'b1111000,
		HEX_8 = 7'b0000000,
		HEX_9 = 7'b0010000,
		
		// Hex display of misc.
		HEX_DASH = 7'b1111110,
		HEX_CLEAR = 7'b1111111,

		// Hex display of states
		HEX_L = 7'b1110001, // L = Low Power
		HEX_S = 7'b0100100, // S = Standby
		HEX_C = 7'b0110001, // C = Collecting (Scanning)
		HEX_I = 7'b1000010, // d = Idle
		HEX_T = 7'b1110000, // t = Transferring
		HEX_F = 7'b0111000, // F = Flushing

		// Encoding of states
		lowPower = 4'b0000,
		standby = 4'b0001,
		collecting = 4'b0010,
		idle = 4'b0011,
		transferring = 4'b0100,
		flushing = 4'b0101;
		// TODO: init state?

endmodule

