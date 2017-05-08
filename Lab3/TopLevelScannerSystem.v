module TopLevelScannerSystem(
	/* Inputs */ clk, reset, startScan, startTransfer,
	/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
	/* Outputs: HEX */ HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input clk, reset, startScan, startTransfer;
	output scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output wire clk_led;

	parameter 
		
		// Clock index
		CLOCK_INDEX = 24

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
		LOWPOWER = 3'b000,
		STANDBY = 3'b001,
		COLLECTING = 3'b010,
		IDLE = 3'b011,
		TRANSFERRING = 3'b100,
		FLUSHING = 3'b101;
		// TODO: init state?

		// Divide and display the 50MHz clock
		reg [30:0] scan_clk;
		always@(posedge clk) scan_clk <= scan_clk + 1'b1;
		assign clk_led = scan_clk[CLOCK_INDEX];

		// Communication wires?
		wire [3:0] scan_1_state, scan_2_state,
					scan_1_count, scan_2_count;

		Scanner scan_1 (clk, reset, 
						/* Clocked buffer  */	scan_1_count, 
						/* Info FRM scan 2 */	scan_2_go_to_standby, scan_2_start_scan, scan_2_transfer, scan_2_flush,
						/* Info TO scan 2  */	scan_1_ready_to_transfer, scan_1_go_to_standby, scan_1_start_scan, scan_1_flush, 
						/* Current state   */	scan_1_state);
		
		Scanner scan_2 (clk, reset, 
						/* Clocked buffer  */	scan_2_count, 
						/* Info FRM scan 1 */	scan_1_go_to_standby, scan_1_start_scan, scan_1_transfer, scan_1_flush,
						/* Info TO scan 1  */	scan_2_ready_to_transfer, scan_2_go_to_standby, scan_2_start_scan, scan_2_flush, 
						/* Current state   */	scan_2_state);


		// DisplayState displayState (state, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);


endmodule

