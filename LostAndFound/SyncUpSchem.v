// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition"
// CREATED		"Sun Apr 09 16:30:30 2017"

module SyncUpSchem(
	clock,
	rst,
	q0,
	q1,
	q2,
	q3
);


input wire	clock;
input wire	rst;
output wire	q0;
output wire	q1;
output wire	q2;
output wire	q3;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
reg	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
reg	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
reg	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_7;
reg	DFF_inst13;

assign	q0 = SYNTHESIZED_WIRE_11;
assign	q1 = SYNTHESIZED_WIRE_16;
assign	q2 = SYNTHESIZED_WIRE_14;
assign	q3 = DFF_inst13;
assign	SYNTHESIZED_WIRE_12 = 1;




always@(posedge clock or negedge rst)
begin
if (!rst)
	begin
	SYNTHESIZED_WIRE_11 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_11 <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge clock or negedge rst)
begin
if (!rst)
	begin
	SYNTHESIZED_WIRE_16 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_16 <= SYNTHESIZED_WIRE_1;
	end
end


always@(posedge clock or negedge rst)
begin
if (!rst)
	begin
	SYNTHESIZED_WIRE_14 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_14 <= SYNTHESIZED_WIRE_2;
	end
end


always@(posedge clock or negedge rst)
begin
if (!rst)
	begin
	DFF_inst13 <= 0;
	end
else
	begin
	DFF_inst13 <= SYNTHESIZED_WIRE_3;
	end
end

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_11 ^ SYNTHESIZED_WIRE_12;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_13 ^ SYNTHESIZED_WIRE_14;

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_15 ^ SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_3 = SYNTHESIZED_WIRE_7 ^ DFF_inst13;

assign	SYNTHESIZED_WIRE_15 = SYNTHESIZED_WIRE_11 & SYNTHESIZED_WIRE_12;

assign	SYNTHESIZED_WIRE_13 = SYNTHESIZED_WIRE_16 & SYNTHESIZED_WIRE_15;

assign	SYNTHESIZED_WIRE_7 = SYNTHESIZED_WIRE_14 & SYNTHESIZED_WIRE_13;



endmodule
