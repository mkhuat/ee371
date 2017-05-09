`include "TopLevelScannerSystem.v"
`include "Scanner.v"

module TestBench();
	
	// Ports list
	wire clk, reset, startScan, startTransfer, startSystem; // KEY [2:0]
	wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	wire [6:0] stateHex1, stateHex2, countHex1, countHex2; // HEX 5, 4, 1, 0
	wire clk_led;
	
	TopLevelScannerSystem dut(
		/* Inputs */ clk, reset, startScan, startTransfer, startSystem,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
	Tester t(
		/* Inputs */ clk, reset, startScan, startTransfer, startSystem,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
endmodule

module Tester(/* Inputs */ clk, reset, startScan, startTransfer, startSystem,
		/* Outputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		/* Outputs: HEX */ stateHex1, stateHex2, countHex1, countHex2);
	
	output reg clk, reset, startScan, startTransfer, startSystem;
	input scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	input wire [6:0] stateHex1, stateHex2, countHex1, countHex2;
	input wire clk_led;
	
	integer i;
	initial begin
		$monitor("%b", clk);
	
		clk = 1'b0;
		
		for (i = 0; i < 10; i = i + 1) begin
			clk = ~clk;
		end
		
		$finish;
	end
endmodule
