`include "TopLevelScannerSystem.v"
`include "Scanner.v"

module testbench();
	
	// PORTS
	wire clk, reset, startSystem, startScan, startTransfer; // KEY [2:0]
	wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	wire [6:0] stateHex1, stateHex2, countHex1, countHex2; // HEX 5, 4, 1, 0
	wire clk_led;
	
	/* Can't manipulate inner clock from this level
		TopLevelScannerSystem dut (clk, reset, startSystem, startScan, startTransfer,
		  scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		  stateHex1, stateHex2, countHex1, countHex2);
	*/
	
	// SIMULATE TOP LEVEL
		
	// State and counters
	wire [3:0]	scan_1_count, scan_2_count;
	wire [1:0] scan_1_comm, scan_2_comm;
	
	wire [2:0] userInput1 = {~startScan, ~startTransfer, ~startSystem};
	wire [2:0] userInput2 = {1'b0, ~startTransfer, 1'b0};
	
	Scanner scan_1 (clk, reset, userInput1,
					/* Clocked buffer  */	scan_1_count, 
					/* Info FRM scan 2 */	scan_2_comm,	// output wire[1:0] ===> scan_2_go_to_standby = 1, scan_2_start_scan = 2, scan_2_transfer = 3, scan_2_flush = 4,
					/* Info TO scan 2  */	scan_1_comm,	// output wire[1:0] ===> scan_1_ready_to_transfer = 1, scan_1_go_to_standby = 2, scan_1_start_scan = 3, scan_1_flush = 4, 
					/* Display HEX	   */		stateHex1, countHex1);

		
	Scanner scan_2 (clk, reset, userInput2,
					/* Clocked buffer  */	scan_2_count, 
					/* Info FRM scan 1 */	scan_1_comm,	// output wire[1:0] ===> scan_1_go_to_standby, scan_1_start_scan, scan_1_transfer, scan_1_flush,
					/* Info TO scan 1  */	scan_2_comm,	// output wire[1:0] ===> scan_2_ready_to_transfer, scan_2_go_to_standby, scan_2_start_scan, scan_2_flush, 
					/* Display HEX	   */		stateHex2, countHex2);
	
	Tester tester (clk, reset, startSystem, startScan, startTransfer,
	  scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
	  stateHex1, stateHex2, countHex1, countHex2);
	  
endmodule

module Tester(clk, reset, startSystem, startScan, startTransfer,
	  scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
	  stateHex1, stateHex2, countHex1, countHex2);
	
	// PORTS
	output reg clk, reset, startSystem, startScan, startTransfer; // KEY [2:0]
	input wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	input wire [6:0] stateHex1, stateHex2, countHex1, countHex2; // HEX 5, 4, 1, 0
	input wire clk_led;
	
	// Iterative var
	integer i;
	
	// Knowledge of hex values to interpret visible states
	parameter
	
		// Hex display of numbers
		HEX_1 = 7'b1111001, 
		HEX_2 = 7'b0100100,
		HEX_3 = 7'b0110000,
		HEX_4 = 7'b0011001,
		HEX_5 = 7'b0010010,
		HEX_6 = 7'b0000010,
		HEX_7 = 7'b1111000,
		HEX_8 = 7'b0000000,
		HEX_9 = 7'b0010000,
		HEX_10 = 7'b0001001,
		
		// Hex display of misc.
		HEX_DASH = 7'b0111111,
		HEX_CLEAR = 7'b1111111,

		// Hex display of states
		HEX_L = 7'b1000111, // L = Low Power
		HEX_S = 7'b0010010, // S = Standby
		HEX_C = 7'b1000110, // C = Collecting (Scanning)
		HEX_I = 7'b0100001, // d = Idle
		HEX_T = 7'b0000111, // t = Transferring
		HEX_F = 7'b0001110; // F = Flushing
	
	// HUMAN READABLE HEX DECODER
	wire [7:0] stateChar1, countChar1, stateChar2, countChar2;
	HexToString #(0) toString1 (stateHex1, stateChar1);
	HexToString #(0) toString2 (stateHex2, stateChar2);
	HexToString toString3 (countHex1, countChar1);
	HexToString toString4 (countHex2, countChar2);
	
	// COMPILE CSV DATA
	initial begin
		$display("clk,reset,startTransfer,startScan,startSystem,stateHex1,countHex1,stateHex2,countHex2");
		$monitor("%b,%b,%b,%b,%b,%s,%s,%s,%s", clk, reset, startTransfer, startScan, startSystem, stateChar1, countChar1, stateChar2, countChar2);
	end
	
	// FACSIMILATE CLOCK
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// STIMULATE SYSTEM
	initial begin
		reset <= 1;		startSystem <= 1;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk); // SW0 on
		reset <= 0;		startSystem <= 1;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk); // SW0 off
		reset <= 0;		startSystem <= 0;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk); // KEY1 press
		reset <= 0;		startSystem <= 1;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk);
		reset <= 0;		startSystem <= 1;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk);
		reset <= 0;		startSystem <= 1;		startScan <= 0;		startTransfer <= 1; 	@(posedge clk); // KEY2 press
		reset <= 0;		startSystem <= 1;		startScan <= 1;		startTransfer <= 1; 	@(posedge clk);
		
		// COLLECTION MODE
		while (stateHex1 == HEX_C) @(posedge clk);
		
		// GOTO FLUSH 1
		while (stateHex1 != HEX_F) @(posedge clk);
		
		// Whatch a few steps as 1 and 2 change
		for (i = 0; i < 8; i = i + 1)  @(posedge clk);
		
		$finish;
	end

endmodule

module HexToString #(parameter NUM = 1) (led,char);
	input wire [6:0] led;
	output reg [7:0] char;
	
	always @(*) begin
		case (led)
			7'b1111001: char = "1"; 
			7'b0100100: char = "2";
			7'b0110000: char = "3";
			7'b0011001: char = "4";
			7'b0010010: if (NUM == 1) char = "5"; else char = "S";
			7'b0000010: char = "6";
			7'b1111000: char = "7";
			7'b0000000: char = "8";
			7'b0010000: char = "9";
			7'b0001001: char = "H";
			7'b0111111: char = "-";
			7'b1111111: char = " ";
			7'b1000111: char = "L";
		//	7'b0010010: char = "S";
			7'b1000110: char = "C";
			7'b0100001: char = "d";
			7'b0000111: char = "t";
			7'b0001110: char = "F";
			default: char = "x";
		endcase
	end
	
endmodule
