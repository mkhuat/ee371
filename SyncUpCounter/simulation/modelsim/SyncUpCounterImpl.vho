-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

-- DATE "04/09/2017 22:19:12"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	SyncUpCounterImpl IS
    PORT (
	outBus : BUFFER std_logic_vector(3 DOWNTO 0);
	iClk : IN std_logic;
	externalRst : IN std_logic
	);
END SyncUpCounterImpl;

-- Design Ports Information
-- outBus[0]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outBus[1]	=>  Location: PIN_W20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outBus[2]	=>  Location: PIN_W21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outBus[3]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- externalRst	=>  Location: PIN_AE12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iClk	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF SyncUpCounterImpl IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_outBus : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_iClk : std_logic;
SIGNAL ww_externalRst : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \iClk~input_o\ : std_logic;
SIGNAL \iClk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \tBase[0]~0_combout\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \tBase[2]~feeder_combout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \tBase[4]~feeder_combout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \tBase[5]~feeder_combout\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \tBase[6]~feeder_combout\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \tBase[8]~feeder_combout\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \syncUpCounter|zero|q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|zero|q~feeder_combout\ : std_logic;
SIGNAL \externalRst~input_o\ : std_logic;
SIGNAL \syncUpCounter|zero|q~q\ : std_logic;
SIGNAL \syncUpCounter|zero|q~DUPLICATE_q\ : std_logic;
SIGNAL \syncUpCounter|one|q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|one|q~feeder_combout\ : std_logic;
SIGNAL \syncUpCounter|one|q~q\ : std_logic;
SIGNAL \syncUpCounter|two|q~q\ : std_logic;
SIGNAL \syncUpCounter|two|q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|two|q~feeder_combout\ : std_logic;
SIGNAL \syncUpCounter|two|q~DUPLICATE_q\ : std_logic;
SIGNAL \syncUpCounter|three|q~q\ : std_logic;
SIGNAL \syncUpCounter|three|q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|three|q~feeder_combout\ : std_logic;
SIGNAL \syncUpCounter|three|q~DUPLICATE_q\ : std_logic;
SIGNAL tBase : std_logic_vector(30 DOWNTO 0);
SIGNAL \syncUpCounter|zero|ALT_INV_q~DUPLICATE_q\ : std_logic;
SIGNAL \syncUpCounter|zero|ALT_INV_q~0_combout\ : std_logic;
SIGNAL ALT_INV_tBase : std_logic_vector(24 DOWNTO 0);
SIGNAL \syncUpCounter|three|ALT_INV_q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|two|ALT_INV_q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|one|ALT_INV_q~0_combout\ : std_logic;
SIGNAL \syncUpCounter|three|ALT_INV_q~q\ : std_logic;
SIGNAL \syncUpCounter|two|ALT_INV_q~q\ : std_logic;
SIGNAL \syncUpCounter|one|ALT_INV_q~q\ : std_logic;
SIGNAL \syncUpCounter|zero|ALT_INV_q~q\ : std_logic;
SIGNAL \ALT_INV_Add0~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~65_sumout\ : std_logic;

BEGIN

outBus <= ww_outBus;
ww_iClk <= iClk;
ww_externalRst <= externalRst;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\syncUpCounter|zero|ALT_INV_q~DUPLICATE_q\ <= NOT \syncUpCounter|zero|q~DUPLICATE_q\;
\syncUpCounter|zero|ALT_INV_q~0_combout\ <= NOT \syncUpCounter|zero|q~0_combout\;
ALT_INV_tBase(0) <= NOT tBase(0);
ALT_INV_tBase(1) <= NOT tBase(1);
ALT_INV_tBase(2) <= NOT tBase(2);
ALT_INV_tBase(3) <= NOT tBase(3);
ALT_INV_tBase(4) <= NOT tBase(4);
ALT_INV_tBase(5) <= NOT tBase(5);
ALT_INV_tBase(6) <= NOT tBase(6);
ALT_INV_tBase(7) <= NOT tBase(7);
ALT_INV_tBase(8) <= NOT tBase(8);
ALT_INV_tBase(9) <= NOT tBase(9);
ALT_INV_tBase(10) <= NOT tBase(10);
ALT_INV_tBase(11) <= NOT tBase(11);
ALT_INV_tBase(12) <= NOT tBase(12);
ALT_INV_tBase(13) <= NOT tBase(13);
ALT_INV_tBase(14) <= NOT tBase(14);
ALT_INV_tBase(15) <= NOT tBase(15);
ALT_INV_tBase(16) <= NOT tBase(16);
ALT_INV_tBase(17) <= NOT tBase(17);
ALT_INV_tBase(18) <= NOT tBase(18);
ALT_INV_tBase(19) <= NOT tBase(19);
ALT_INV_tBase(20) <= NOT tBase(20);
ALT_INV_tBase(21) <= NOT tBase(21);
ALT_INV_tBase(22) <= NOT tBase(22);
ALT_INV_tBase(23) <= NOT tBase(23);
\syncUpCounter|three|ALT_INV_q~0_combout\ <= NOT \syncUpCounter|three|q~0_combout\;
\syncUpCounter|two|ALT_INV_q~0_combout\ <= NOT \syncUpCounter|two|q~0_combout\;
\syncUpCounter|one|ALT_INV_q~0_combout\ <= NOT \syncUpCounter|one|q~0_combout\;
ALT_INV_tBase(24) <= NOT tBase(24);
\syncUpCounter|three|ALT_INV_q~q\ <= NOT \syncUpCounter|three|q~q\;
\syncUpCounter|two|ALT_INV_q~q\ <= NOT \syncUpCounter|two|q~q\;
\syncUpCounter|one|ALT_INV_q~q\ <= NOT \syncUpCounter|one|q~q\;
\syncUpCounter|zero|ALT_INV_q~q\ <= NOT \syncUpCounter|zero|q~q\;
\ALT_INV_Add0~89_sumout\ <= NOT \Add0~89_sumout\;
\ALT_INV_Add0~81_sumout\ <= NOT \Add0~81_sumout\;
\ALT_INV_Add0~77_sumout\ <= NOT \Add0~77_sumout\;
\ALT_INV_Add0~73_sumout\ <= NOT \Add0~73_sumout\;
\ALT_INV_Add0~65_sumout\ <= NOT \Add0~65_sumout\;

-- Location: IOOBUF_X84_Y0_N2
\outBus[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \syncUpCounter|zero|q~q\,
	devoe => ww_devoe,
	o => ww_outBus(0));

-- Location: IOOBUF_X89_Y6_N5
\outBus[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \syncUpCounter|one|q~q\,
	devoe => ww_devoe,
	o => ww_outBus(1));

-- Location: IOOBUF_X89_Y8_N5
\outBus[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \syncUpCounter|two|q~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_outBus(2));

-- Location: IOOBUF_X89_Y6_N22
\outBus[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \syncUpCounter|three|q~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_outBus(3));

-- Location: IOIBUF_X32_Y0_N1
\iClk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iClk,
	o => \iClk~input_o\);

-- Location: CLKCTRL_G6
\iClk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \iClk~input_o\,
	outclk => \iClk~inputCLKENA0_outclk\);

-- Location: LABCELL_X31_Y3_N18
\tBase[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[0]~0_combout\ = ( !tBase(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => ALT_INV_tBase(0),
	combout => \tBase[0]~0_combout\);

-- Location: FF_X31_Y3_N20
\tBase[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(0));

-- Location: LABCELL_X31_Y3_N30
\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( tBase(1) ) + ( tBase(0) ) + ( !VCC ))
-- \Add0~94\ = CARRY(( tBase(1) ) + ( tBase(0) ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_tBase(0),
	datad => ALT_INV_tBase(1),
	cin => GND,
	sumout => \Add0~93_sumout\,
	cout => \Add0~94\);

-- Location: FF_X31_Y3_N29
\tBase[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	asdata => \Add0~93_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(1));

-- Location: LABCELL_X31_Y3_N33
\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( tBase(2) ) + ( GND ) + ( \Add0~94\ ))
-- \Add0~90\ = CARRY(( tBase(2) ) + ( GND ) + ( \Add0~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(2),
	cin => \Add0~94\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\);

-- Location: LABCELL_X31_Y3_N0
\tBase[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[2]~feeder_combout\ = ( \Add0~89_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~89_sumout\,
	combout => \tBase[2]~feeder_combout\);

-- Location: FF_X31_Y3_N2
\tBase[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(2));

-- Location: LABCELL_X31_Y3_N36
\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( tBase(3) ) + ( GND ) + ( \Add0~90\ ))
-- \Add0~86\ = CARRY(( tBase(3) ) + ( GND ) + ( \Add0~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(3),
	cin => \Add0~90\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\);

-- Location: FF_X31_Y3_N7
\tBase[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	asdata => \Add0~85_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(3));

-- Location: LABCELL_X31_Y3_N39
\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( tBase(4) ) + ( GND ) + ( \Add0~86\ ))
-- \Add0~82\ = CARRY(( tBase(4) ) + ( GND ) + ( \Add0~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_tBase(4),
	cin => \Add0~86\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\);

-- Location: LABCELL_X31_Y3_N12
\tBase[4]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[4]~feeder_combout\ = ( \Add0~81_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~81_sumout\,
	combout => \tBase[4]~feeder_combout\);

-- Location: FF_X31_Y3_N14
\tBase[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(4));

-- Location: LABCELL_X31_Y3_N42
\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( tBase(5) ) + ( GND ) + ( \Add0~82\ ))
-- \Add0~78\ = CARRY(( tBase(5) ) + ( GND ) + ( \Add0~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_tBase(5),
	cin => \Add0~82\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\);

-- Location: LABCELL_X31_Y3_N9
\tBase[5]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[5]~feeder_combout\ = ( \Add0~77_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~77_sumout\,
	combout => \tBase[5]~feeder_combout\);

-- Location: FF_X31_Y3_N11
\tBase[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[5]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(5));

-- Location: LABCELL_X31_Y3_N45
\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( tBase(6) ) + ( GND ) + ( \Add0~78\ ))
-- \Add0~74\ = CARRY(( tBase(6) ) + ( GND ) + ( \Add0~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_tBase(6),
	cin => \Add0~78\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\);

-- Location: LABCELL_X31_Y3_N15
\tBase[6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[6]~feeder_combout\ = ( \Add0~73_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~73_sumout\,
	combout => \tBase[6]~feeder_combout\);

-- Location: FF_X31_Y3_N17
\tBase[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(6));

-- Location: LABCELL_X31_Y3_N48
\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( tBase(7) ) + ( GND ) + ( \Add0~74\ ))
-- \Add0~70\ = CARRY(( tBase(7) ) + ( GND ) + ( \Add0~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_tBase(7),
	cin => \Add0~74\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\);

-- Location: FF_X31_Y3_N26
\tBase[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	asdata => \Add0~69_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(7));

-- Location: LABCELL_X31_Y3_N51
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( tBase(8) ) + ( GND ) + ( \Add0~70\ ))
-- \Add0~66\ = CARRY(( tBase(8) ) + ( GND ) + ( \Add0~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(8),
	cin => \Add0~70\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\);

-- Location: LABCELL_X31_Y3_N3
\tBase[8]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \tBase[8]~feeder_combout\ = ( \Add0~65_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~65_sumout\,
	combout => \tBase[8]~feeder_combout\);

-- Location: FF_X31_Y3_N5
\tBase[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \tBase[8]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(8));

-- Location: LABCELL_X31_Y3_N54
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( tBase(9) ) + ( GND ) + ( \Add0~66\ ))
-- \Add0~62\ = CARRY(( tBase(9) ) + ( GND ) + ( \Add0~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(9),
	cin => \Add0~66\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X31_Y3_N23
\tBase[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	asdata => \Add0~61_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(9));

-- Location: LABCELL_X31_Y3_N57
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( tBase(10) ) + ( GND ) + ( \Add0~62\ ))
-- \Add0~58\ = CARRY(( tBase(10) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(10),
	cin => \Add0~62\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X31_Y3_N46
\tBase[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	asdata => \Add0~57_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(10));

-- Location: LABCELL_X31_Y2_N0
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( tBase(11) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~54\ = CARRY(( tBase(11) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(11),
	cin => \Add0~58\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X31_Y2_N2
\tBase[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(11));

-- Location: LABCELL_X31_Y2_N3
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( tBase(12) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~50\ = CARRY(( tBase(12) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(12),
	cin => \Add0~54\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: FF_X31_Y2_N5
\tBase[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(12));

-- Location: LABCELL_X31_Y2_N6
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( tBase(13) ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~46\ = CARRY(( tBase(13) ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(13),
	cin => \Add0~50\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X31_Y2_N8
\tBase[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(13));

-- Location: LABCELL_X31_Y2_N9
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( tBase(14) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~42\ = CARRY(( tBase(14) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(14),
	cin => \Add0~46\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X31_Y2_N11
\tBase[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(14));

-- Location: LABCELL_X31_Y2_N12
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( tBase(15) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~38\ = CARRY(( tBase(15) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(15),
	cin => \Add0~42\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X31_Y2_N14
\tBase[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(15));

-- Location: LABCELL_X31_Y2_N15
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( tBase(16) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~34\ = CARRY(( tBase(16) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(16),
	cin => \Add0~38\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X31_Y2_N17
\tBase[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(16));

-- Location: LABCELL_X31_Y2_N18
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( tBase(17) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~30\ = CARRY(( tBase(17) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(17),
	cin => \Add0~34\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X31_Y2_N20
\tBase[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(17));

-- Location: LABCELL_X31_Y2_N21
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( tBase(18) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~26\ = CARRY(( tBase(18) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(18),
	cin => \Add0~30\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X31_Y2_N23
\tBase[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(18));

-- Location: LABCELL_X31_Y2_N24
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( tBase(19) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~22\ = CARRY(( tBase(19) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(19),
	cin => \Add0~26\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X31_Y2_N26
\tBase[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(19));

-- Location: LABCELL_X31_Y2_N27
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( tBase(20) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~18\ = CARRY(( tBase(20) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(20),
	cin => \Add0~22\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X31_Y2_N29
\tBase[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(20));

-- Location: LABCELL_X31_Y2_N30
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( tBase(21) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~14\ = CARRY(( tBase(21) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(21),
	cin => \Add0~18\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X31_Y2_N32
\tBase[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(21));

-- Location: LABCELL_X31_Y2_N33
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( tBase(22) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~10\ = CARRY(( tBase(22) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(22),
	cin => \Add0~14\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X31_Y2_N35
\tBase[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(22));

-- Location: LABCELL_X31_Y2_N36
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( tBase(23) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~6\ = CARRY(( tBase(23) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(23),
	cin => \Add0~10\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X31_Y2_N38
\tBase[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(23));

-- Location: LABCELL_X31_Y2_N39
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( tBase(24) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_tBase(24),
	cin => \Add0~6\,
	sumout => \Add0~1_sumout\);

-- Location: FF_X31_Y2_N59
\tBase[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iClk~input_o\,
	asdata => \Add0~1_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => tBase(24));

-- Location: LABCELL_X30_Y2_N51
\syncUpCounter|zero|q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|zero|q~0_combout\ = ( !\syncUpCounter|zero|q~q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \syncUpCounter|zero|ALT_INV_q~q\,
	combout => \syncUpCounter|zero|q~0_combout\);

-- Location: LABCELL_X30_Y2_N30
\syncUpCounter|zero|q~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|zero|q~feeder_combout\ = ( \syncUpCounter|zero|q~0_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \syncUpCounter|zero|ALT_INV_q~0_combout\,
	combout => \syncUpCounter|zero|q~feeder_combout\);

-- Location: IOIBUF_X2_Y0_N58
\externalRst~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_externalRst,
	o => \externalRst~input_o\);

-- Location: FF_X30_Y2_N32
\syncUpCounter|zero|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|zero|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|zero|q~q\);

-- Location: FF_X30_Y2_N31
\syncUpCounter|zero|q~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|zero|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|zero|q~DUPLICATE_q\);

-- Location: LABCELL_X30_Y2_N27
\syncUpCounter|one|q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|one|q~0_combout\ = ( !\syncUpCounter|one|q~q\ & ( \syncUpCounter|zero|q~DUPLICATE_q\ ) ) # ( \syncUpCounter|one|q~q\ & ( !\syncUpCounter|zero|q~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \syncUpCounter|one|ALT_INV_q~q\,
	dataf => \syncUpCounter|zero|ALT_INV_q~DUPLICATE_q\,
	combout => \syncUpCounter|one|q~0_combout\);

-- Location: LABCELL_X30_Y2_N21
\syncUpCounter|one|q~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|one|q~feeder_combout\ = ( \syncUpCounter|one|q~0_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \syncUpCounter|one|ALT_INV_q~0_combout\,
	combout => \syncUpCounter|one|q~feeder_combout\);

-- Location: FF_X30_Y2_N23
\syncUpCounter|one|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|one|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|one|q~q\);

-- Location: FF_X30_Y2_N47
\syncUpCounter|two|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|two|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|two|q~q\);

-- Location: LABCELL_X30_Y2_N54
\syncUpCounter|two|q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|two|q~0_combout\ = ( \syncUpCounter|one|q~q\ & ( \syncUpCounter|zero|q~DUPLICATE_q\ & ( !\syncUpCounter|two|q~q\ ) ) ) # ( !\syncUpCounter|one|q~q\ & ( \syncUpCounter|zero|q~DUPLICATE_q\ & ( \syncUpCounter|two|q~q\ ) ) ) # ( 
-- \syncUpCounter|one|q~q\ & ( !\syncUpCounter|zero|q~DUPLICATE_q\ & ( \syncUpCounter|two|q~q\ ) ) ) # ( !\syncUpCounter|one|q~q\ & ( !\syncUpCounter|zero|q~DUPLICATE_q\ & ( \syncUpCounter|two|q~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000111111111111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \syncUpCounter|two|ALT_INV_q~q\,
	datae => \syncUpCounter|one|ALT_INV_q~q\,
	dataf => \syncUpCounter|zero|ALT_INV_q~DUPLICATE_q\,
	combout => \syncUpCounter|two|q~0_combout\);

-- Location: LABCELL_X30_Y2_N45
\syncUpCounter|two|q~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|two|q~feeder_combout\ = ( \syncUpCounter|two|q~0_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \syncUpCounter|two|ALT_INV_q~0_combout\,
	combout => \syncUpCounter|two|q~feeder_combout\);

-- Location: FF_X30_Y2_N46
\syncUpCounter|two|q~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|two|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|two|q~DUPLICATE_q\);

-- Location: FF_X30_Y2_N8
\syncUpCounter|three|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|three|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|three|q~q\);

-- Location: LABCELL_X30_Y2_N12
\syncUpCounter|three|q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|three|q~0_combout\ = ( \syncUpCounter|one|q~q\ & ( \syncUpCounter|zero|q~DUPLICATE_q\ & ( !\syncUpCounter|three|q~q\ $ (!\syncUpCounter|two|q~q\) ) ) ) # ( !\syncUpCounter|one|q~q\ & ( \syncUpCounter|zero|q~DUPLICATE_q\ & ( 
-- \syncUpCounter|three|q~q\ ) ) ) # ( \syncUpCounter|one|q~q\ & ( !\syncUpCounter|zero|q~DUPLICATE_q\ & ( \syncUpCounter|three|q~q\ ) ) ) # ( !\syncUpCounter|one|q~q\ & ( !\syncUpCounter|zero|q~DUPLICATE_q\ & ( \syncUpCounter|three|q~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001111001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \syncUpCounter|three|ALT_INV_q~q\,
	datad => \syncUpCounter|two|ALT_INV_q~q\,
	datae => \syncUpCounter|one|ALT_INV_q~q\,
	dataf => \syncUpCounter|zero|ALT_INV_q~DUPLICATE_q\,
	combout => \syncUpCounter|three|q~0_combout\);

-- Location: LABCELL_X30_Y2_N6
\syncUpCounter|three|q~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \syncUpCounter|three|q~feeder_combout\ = ( \syncUpCounter|three|q~0_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \syncUpCounter|three|ALT_INV_q~0_combout\,
	combout => \syncUpCounter|three|q~feeder_combout\);

-- Location: FF_X30_Y2_N7
\syncUpCounter|three|q~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => tBase(24),
	d => \syncUpCounter|three|q~feeder_combout\,
	clrn => \externalRst~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syncUpCounter|three|q~DUPLICATE_q\);

-- Location: LABCELL_X43_Y51_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


