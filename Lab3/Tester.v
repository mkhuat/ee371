`include "TopLevelScannerSystem.v"
`include "Scanner.v"

module TestBench();
	
	// Ports list
	wire clk, reset, startScan, startTransfer, startSystem; // KEY [2:0]
	wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	wire [6:0] stateHex1, stateHex2, countHex1, countHex2; // HEX 5, 4, 1, 0
	wire clk_led;
	
	TopLevelScannerSystem dut(
		/* Inputs */ clk, reset, startSystem, startScan, startTransfer,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
	Tester t(
		/* Inputs */ clk, reset, startSystem, startScan, startTransfer,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
endmodule

module Tester(/* Inputs */ clk, reset, startSystem, startScan, startTransfer,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
	output reg clk, reset, startSystem, startTransfer, startScan;
	input scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	input wire [6:0] stateHex1, stateHex2, countHex1, countHex2;
	input wire clk_led;
	
	initial begin 
			$display("clk, reset, startSystem, startTransfer, startScan, scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush");
			$monitor(" %b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%t",
			clk, reset, startSystem, startScan, startTransfer,
			scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, $time);
	end
	
	integer i;
	parameter stimDelay = 20;
	initial begin
		// $monitor("%b", clk);
		
		clk = 1'b0; reset = 1;
		clk = 1'b1; reset = 0;
		
		startScan = 0;
		startTransfer = 0;
		startSystem = 1;
	
		for (i = 0; i < 2*2; i = i + 1) begin
			#stimDelay clk = ~clk;
		end
		
	
		#stimDelay clk = ~clk;
		#stimDelay clk = ~clk;
		startSystem = 0;
		
		/*
		Test 0: Start scanning, hit transfer after 80% but before second hits 50%.
		*/
		startScan = 1;
		for (i = 0; i < 2*8; i = i + 1) begin
			#stimDelay clk = ~clk;
		end
		
		// We should now be at 80%
		startTransfer = 1;
		
		for (i = 0; i < 2*10; i = i + 1) begin
			#stimDelay clk = ~clk;
		end
		
		/*
		Test 1: Start scanning, begin transfer after hitting 90%, but before second scanner hits 50%.
		Transfer the second state at 80%. This will end the oscillation between scanners.
		*/
		
		/*
		Test 2: Start scanning. Wait until second scanner hits 50%, then first will flush, as transfer was not hit.
		Transfer the second state at 80%. This will end the oscillation between scanners.
		*/
		
		for (i = 0; i < 2*10; i = i + 1) begin
			#stimDelay clk = ~clk;
		end
		
		
		
		$finish;
	end
endmodule
