// Top-level entity
module SyncUpCounterImpl(outBus, iClk, externalRst);

	input iClk, externalRst; // connect to system 50 MHz clock
	output [3:0] outBus;
	wire [3:0] outBus;
	
	reg [30:0] tBase; // system time base
	
	buf b0(outBus[0], qA);
	buf b1(outBus[1], qB);
	buf b2(outBus[2], qC);
	buf b3(outBus[3], qD);

	wire aBar, bBar, cBar, dBar;
	
	always@(posedge iClk) tBase <= tBase + 1'b1;
	
	SyncUpCounter syncUpCounter(tBase[24], externalRst, {qD, qC, qB, qA});

endmodule
