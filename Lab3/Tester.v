`include "TopLevelScannerSystem.v"
`include "Scanner.v"

module TestBench();
	
	// Ports list
	wire clk, reset, startScan, startTransfer;
	wire scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire clk_led;
	
	TopLevelScannerSystem dut(clk, reset, startScan, startTransfer, scan_1_ready_to_transfer,
		scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby,
		scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	Tester t(clk, reset, startScan, startTransfer, scan_1_ready_to_transfer,
		scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby,
		scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
endmodule

module Tester(/* Outputs */ clk, reset, startScan, startTransfer,
	/* Inputs: LED */ scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush, clk_led,
	/* Inputs: HEX */ HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	output clk, reset, startScan, startTransfer;
	input scan_1_ready_to_transfer, scan_2_ready_to_transfer, scan_1_go_to_standby, scan_2_go_to_standby, scan_1_start_scan, scan_2_start_scan, scan_1_flush, scan_2_flush;
	input wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input wire clk_led;
	
	initial begin
		monitor("%b", clk)
	
		clk = 1'b0;
		
		integer i;
		for (i = 0; i < 10; i = i + 1) begin
			clk = ~clk;
		end
		
		$finish
	end
endmodule
