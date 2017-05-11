module TopLevelScannerSystem(
	/* Inputs */ clk, reset, startSystem, startScan, startTransfer,
	/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
	/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
	/*
	Inputs
		reset: sets all scanners to a low power state
		startSystem: transitions first scanner from low power to standby
		startScan: transitions first scanner from standby to scanning
		startTransfer: transitions an idle scanner to transferring
	*/
	input clk, reset, startSystem, startScan, startTransfer; // KEY [2:0]
	output wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	output wire [6:0] stateHex1, stateHex2, countHex1, countHex2; // HEX 5, 4, 1, 0
	output wire clk_led;

	parameter 
		
		// Clock index
		CLOCK_INDEX = 24,

		// Encoding of states
		LOWPOWER = 3'b000,
		STANDBY = 3'b001,
		COLLECTING = 3'b010,
		IDLE = 3'b011,
		TRANSFERRING = 3'b100,
		FLUSHING = 3'b101,
		
		// Encoding of communication signals
		INACTIVE = 2'b00,
		GO_TO_STANDBY = 2'b01, // Equivalent to: READY_TO_TRANSFER
		START_SCAN = 2'b10,
		START_FLUSH = 2'b11;


	// Divide and display the 50MHz clock
	reg [30:0] scan_clk;
	always@(posedge clk) scan_clk <= scan_clk + 1'b1;
	assign clk_led = scan_clk[CLOCK_INDEX];

	// State and counters
	wire [3:0]	scan_1_count, scan_2_count;
	wire [1:0] scan_1_comm, scan_2_comm;
	
	wire [2:0] userInput = {!startScan, !startTransfer, !startSystem};
	
	Scanner #(1) scan_1 (clk, reset, userInput,
					/* Clocked buffer  */	scan_1_count, 
					/* Info FRM scan 2 */	scan_2_comm,	// output wire[1:0] ===> scan_2_go_to_standby = 1, scan_2_start_scan = 2, scan_2_transfer = 3, scan_2_flush = 4,
					/* Info TO scan 2  */	scan_1_comm,	// output wire[1:0] ===> scan_1_ready_to_transfer = 1, scan_1_go_to_standby = 2, scan_1_start_scan = 3, scan_1_flush = 4, 
					/* Display HEX	   */	stateHex1, countHex1);

		
	Scanner #(2) scan_2 (clk, reset, 3'b000,
					/* Clocked buffer  */	scan_2_count, 
					/* Info FRM scan 1 */	scan_1_comm,	// output wire[1:0] ===> scan_1_go_to_standby, scan_1_start_scan, scan_1_transfer, scan_1_flush,
					/* Info TO scan 1  */	scan_2_comm,	// output wire[1:0] ===> scan_2_ready_to_transfer, scan_2_go_to_standby, scan_2_start_scan, scan_2_flush, 
					/* Display HEX	   */	stateHex2, countHex2);

	
	// TODO: Invest more time into thinking about test bench's clocked output with always @ (*) non-synchronous output
	
	// Go to Standby
	assign scan_1_go_to_standby = (scan_2_comm == GO_TO_STANDBY);
	assign scan_2_go_to_standby = (scan_1_comm == GO_TO_STANDBY);
	
	// Ready to Transfer
	assign scan_1_ready_to_transfer = (scan_2_comm == GO_TO_STANDBY);
	assign scan_2_ready_to_transfer = (scan_1_comm == GO_TO_STANDBY);
	
	// Start Scan
	assign scan_1_start_scan = (scan_2_comm == START_SCAN);
	assign scan_2_start_scan = (scan_1_comm == START_SCAN);
	
	// Flush
	assign scan_1_flush = (scan_2_comm == START_FLUSH);
	assign scan_2_flush = (scan_1_comm == START_FLUSH);
	
endmodule
