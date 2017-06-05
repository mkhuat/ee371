`include "TransmitComm.v"
`include "ReceiveComm.v"

module testbench();
  wire clk, reset, serial_io, char_sent, char_received;
  wire transmit_en, load;
  wire [7:0] parallel_in, parallel_out;
  wire [9:0] data_r, data_t;
  wire [3:0] bic;
  
  ReceiveComm receiver(clk, reset, serial_io, parallel_out, char_received, data_r, bic);
  TransmitComm sender(clk, reset, transmit_en, load, parallel_in, serial_io, char_sent, data_t);

	Tester tester (clk, reset, serial_io, parallel_in, parallel_out,
    char_received, char_sent, transmit_en, load, data_r, data_t, bic);

endmodule

module Tester(clk, reset, serial_io, parallel_in, parallel_out,
  char_received, char_sent, transmit_en, load, data_r, data_t, bic);

	// PORTS
  input wire serial_io, char_received, char_sent;
  input [7:0] parallel_out;
	output reg clk, reset, load, transmit_en;
  output reg [7:0] parallel_in;

  input [9:0] data_r, data_t;
  
  input [3:0] bic;

	// Iterative var
	integer i;

  parameter START_BIC = 4'b0000, END_READ_BIC = 4'b1010, END_WRITE_BIC = 4'b1000;

	// COMPILE CSV DATA
	initial begin
		$display("ser_io\tparallel_in\tparallel_out\tdata_rec\tdata_transm\tbic\tch_sent\tch_rec\tt_en\tload");
		$monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", serial_io, parallel_in, parallel_out, data_r, data_t, bic, char_sent, char_received, transmit_en, load);
	end

	// FACSIMILATE CLOCK
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// STIMULATE SYSTEM
	initial begin
    parallel_in = "k";
	reset <= 1;		load <= 0;	transmit_en <= 0; 	@(posedge clk);
    reset <= 1;		load <= 0;	transmit_en <= 0; 	@(posedge clk);
	reset <= 0;		load <= 1;	transmit_en <= 0; 	@(posedge clk);
    reset <= 0;		load <= 1;	transmit_en <= 1; 	@(posedge clk);
    reset <= 0;		load <= 0;	transmit_en <= 0; 	@(posedge clk);

	// Step 24 times
	for (i = 0; i < 640; i = i + 1)  @(posedge clk);

    parallel_in = 0;
	reset <= 0;		load <= 1;	transmit_en <= 0; 	@(posedge clk);
    reset <= 0;		load <= 1;	transmit_en <= 1; 	@(posedge clk);
    reset <= 0;		load <= 0;	transmit_en <= 0; 	@(posedge clk);

	// Step 24 times
	for (i = 0; i < 640; i = i + 1)  @(posedge clk);
	
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
