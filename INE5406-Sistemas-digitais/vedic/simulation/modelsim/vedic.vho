-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "11/23/2022 22:32:27"

-- 
-- Device: Altera EP4CGX15BF14A7 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	multiplicador IS
    PORT (
	CLK : IN std_logic;
	INICIAR : IN std_logic;
	A : IN std_logic_vector(7 DOWNTO 0);
	B : IN std_logic_vector(7 DOWNTO 0);
	R : OUT std_logic;
	S : OUT std_logic_vector(15 DOWNTO 0)
	);
END multiplicador;

-- Design Ports Information
-- INICIAR	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[0]	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[1]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[2]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[3]	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[4]	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[5]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[6]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[7]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[8]	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[9]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[10]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[11]	=>  Location: PIN_K11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[12]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[13]	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[14]	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[15]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[4]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[4]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[5]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[5]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[6]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[6]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[7]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[7]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF multiplicador IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_INICIAR : std_logic;
SIGNAL ww_A : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_R : std_logic;
SIGNAL ww_S : std_logic_vector(15 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|cla2|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|ha2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|or2bit~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|ha2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm4|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm4|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm4|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm1|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm1|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm1|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm1|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm1|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm1|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA2|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA2|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA3|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA3|G~combout\ : std_logic;
SIGNAL \INICIAR~input_o\ : std_logic;
SIGNAL \R~output_o\ : std_logic;
SIGNAL \S[0]~output_o\ : std_logic;
SIGNAL \S[1]~output_o\ : std_logic;
SIGNAL \S[2]~output_o\ : std_logic;
SIGNAL \S[3]~output_o\ : std_logic;
SIGNAL \S[4]~output_o\ : std_logic;
SIGNAL \S[5]~output_o\ : std_logic;
SIGNAL \S[6]~output_o\ : std_logic;
SIGNAL \S[7]~output_o\ : std_logic;
SIGNAL \S[8]~output_o\ : std_logic;
SIGNAL \S[9]~output_o\ : std_logic;
SIGNAL \S[10]~output_o\ : std_logic;
SIGNAL \S[11]~output_o\ : std_logic;
SIGNAL \S[12]~output_o\ : std_logic;
SIGNAL \S[13]~output_o\ : std_logic;
SIGNAL \S[14]~output_o\ : std_logic;
SIGNAL \S[15]~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm4|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|S[0]~feeder_combout\ : std_logic;
SIGNAL \mult1:mult8|S[0]~feeder_combout\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm4|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|S[1]~feeder_combout\ : std_logic;
SIGNAL \mult1:mult8|S[1]~feeder_combout\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm2|and4~combout\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm3|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm4|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA1|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA1|G~combout\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm3|ha1|S~combout\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm2|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|PFA2|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm4|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|S[3]~feeder_combout\ : std_logic;
SIGNAL \B[4]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm4|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm3|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm1|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA3|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm2|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA2|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm3|ha2|Cout~0_combout\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm1|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA4|S~combout\ : std_logic;
SIGNAL \B[5]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm4|ha1|S~combout\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm4|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|sum[1]~0_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[2]~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm1|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm2|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|or2bit~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|or2bit~2_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|or2bit~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla1|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|PFA3|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|cla2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|or2bit~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm2|and4~combout\ : std_logic;
SIGNAL \B[6]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm3|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA1|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm4|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm3|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA1|P~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[3]~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm4|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[2]~0_combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[3]~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|tbm1|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult4|ha2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm2|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|c2~0_combout\ : std_logic;
SIGNAL \B[7]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm3|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm1|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm3|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|PFA2|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA3|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA2|S~combout\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm2|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm3|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|PFA2|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm2|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|S[3]~feeder_combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[4]~2_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[4]~2_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm4|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm2|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm3|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA3|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[5]~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm4|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[5]~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm2|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm1|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm2|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla2|PFA4|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm3|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm2|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|c3~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA4|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[6]~4_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[6]~5_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[6]~6_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[6]~7_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm3|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|cla1|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|or2bit~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|or2bit~2_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|or2bit~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|or2bit~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|tbm1|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult3|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|tbm1|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|PFA3|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|cla1|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|or2bit~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|or2bit~2_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|or2bit~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|or2bit~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[6]~4_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm4|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm3|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm2|and4~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA1|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_in_internal[7]~8_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm4|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA1|P~combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_in_internal[7]~5_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm3|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm2|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm3|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|c2~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA3|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla2|carry_out~0_combout\ : std_logic;
SIGNAL \mult1:mult8|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|PFA3|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm2|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|PFA2|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA2|G~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm1|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm2|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|c3~1_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|PFA4|S~combout\ : std_logic;
SIGNAL \mult1:mult8|ha2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|ha3|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult2|ha2|S~combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_out~0_combout\ : std_logic;
SIGNAL \mult1:mult8|cla1|carry_out~1_combout\ : std_logic;
SIGNAL \mult1:mult8|ha3|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm1|ha2|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla1|PFA4|P~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|cla2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm3|ha2|Cout~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|or2bit~2_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|or2bit~0_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|or2bit~3_combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|ha1|S~combout\ : std_logic;
SIGNAL \mult1:mult8|ha4|S~0_combout\ : std_logic;
SIGNAL \mult1:mult8|ha4|S~combout\ : std_logic;
SIGNAL \mult1:mult8|mult1|tbm1|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|cla2|h_sum\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|cla2|sum\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|mult1|S\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|cla1|h_sum\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|S\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \mult1:mult8|mult1|tbm2|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult1|tbm3|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult1|tbm4|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult2|S\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|mult2|tbm1|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult2|tbm2|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult2|tbm3|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult2|tbm4|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult3|S\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|mult3|tbm1|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult3|tbm2|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult3|tbm3|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult3|tbm4|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|S\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|tbm1|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|tbm2|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|tbm3|S\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mult1:mult8|mult4|tbm4|S\ : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_CLK <= CLK;
ww_INICIAR <= INICIAR;
ww_A <= A;
ww_B <= B;
R <= ww_R;
S <= ww_S;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);

-- Location: LCCOMB_X26_Y20_N30
\mult1:mult8|cla1|h_sum[5]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(5) = \mult1:mult8|mult3|S\(5) $ (\mult1:mult8|mult2|S\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|S\(5),
	datad => \mult1:mult8|mult2|S\(5),
	combout => \mult1:mult8|cla1|h_sum\(5));

-- Location: FF_X27_Y20_N29
\mult1:mult8|mult3|S[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|ha2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(7));

-- Location: LCCOMB_X26_Y20_N22
\mult1:mult8|cla1|h_sum[7]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(7) = \mult1:mult8|mult2|S\(7) $ (\mult1:mult8|mult3|S\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|S\(7),
	datad => \mult1:mult8|mult3|S\(7),
	combout => \mult1:mult8|cla1|h_sum\(7));

-- Location: FF_X27_Y22_N25
\mult1:mult8|mult1|S[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|ha2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(7));

-- Location: LCCOMB_X23_Y19_N20
\mult1:mult8|mult4|cla2|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|c2~0_combout\ = (\mult1:mult8|mult4|cla2|PFA1|G~combout\ & ((\mult1:mult8|mult4|tbm4|S\(3)) # (\mult1:mult8|mult4|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult4|cla1|PFA2|P~combout\)))) # (!\mult1:mult8|mult4|cla2|PFA1|G~combout\ & 
-- (\mult1:mult8|mult4|tbm4|S\(3) & (\mult1:mult8|mult4|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult4|cla1|PFA2|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla2|PFA1|G~combout\,
	datab => \mult1:mult8|mult4|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult4|tbm4|S\(3),
	datad => \mult1:mult8|mult4|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult4|cla2|c2~0_combout\);

-- Location: LCCOMB_X23_Y19_N12
\mult1:mult8|mult4|cla1|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|c3~0_combout\ = (\mult1:mult8|mult4|tbm3|S\(2) & ((\mult1:mult8|mult4|tbm2|S\(2)) # ((\mult1:mult8|mult4|tbm3|S\(1) & \mult1:mult8|mult4|tbm2|S\(1))))) # (!\mult1:mult8|mult4|tbm3|S\(2) & (\mult1:mult8|mult4|tbm3|S\(1) & 
-- (\mult1:mult8|mult4|tbm2|S\(2) & \mult1:mult8|mult4|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm3|S\(1),
	datab => \mult1:mult8|mult4|tbm3|S\(2),
	datac => \mult1:mult8|mult4|tbm2|S\(2),
	datad => \mult1:mult8|mult4|tbm2|S\(1),
	combout => \mult1:mult8|mult4|cla1|c3~0_combout\);

-- Location: FF_X25_Y20_N27
\mult1:mult8|mult3|tbm4|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm4|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm4|S\(2));

-- Location: LCCOMB_X24_Y19_N24
\mult1:mult8|mult4|cla1|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|Cout~0_combout\ = (\mult1:mult8|mult4|tbm3|S\(3) & ((\mult1:mult8|mult4|tbm2|S\(3)) # ((\mult1:mult8|mult4|tbm2|S\(2) & \mult1:mult8|mult4|tbm3|S\(2))))) # (!\mult1:mult8|mult4|tbm3|S\(3) & (\mult1:mult8|mult4|tbm2|S\(2) & 
-- (\mult1:mult8|mult4|tbm3|S\(2) & \mult1:mult8|mult4|tbm2|S\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm2|S\(2),
	datab => \mult1:mult8|mult4|tbm3|S\(3),
	datac => \mult1:mult8|mult4|tbm3|S\(2),
	datad => \mult1:mult8|mult4|tbm2|S\(3),
	combout => \mult1:mult8|mult4|cla1|Cout~0_combout\);

-- Location: FF_X26_Y21_N11
\mult1:mult8|mult2|tbm4|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm4|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm4|S\(3));

-- Location: FF_X25_Y20_N23
\mult1:mult8|mult3|tbm4|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm4|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm4|S\(3));

-- Location: FF_X25_Y21_N31
\mult1:mult8|mult2|tbm1|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm1|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm1|S\(0));

-- Location: LCCOMB_X25_Y21_N12
\mult1:mult8|mult2|cla2|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|c3~1_combout\ = (\mult1:mult8|mult2|cla2|PFA2|G~combout\ & ((\mult1:mult8|mult2|tbm1|S\(0)) # (\mult1:mult8|mult2|cla1|c2~0_combout\ $ (\mult1:mult8|mult2|cla1|PFA3|P~combout\)))) # (!\mult1:mult8|mult2|cla2|PFA2|G~combout\ & 
-- (\mult1:mult8|mult2|tbm1|S\(0) & (\mult1:mult8|mult2|cla1|c2~0_combout\ $ (\mult1:mult8|mult2|cla1|PFA3|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|cla1|c2~0_combout\,
	datab => \mult1:mult8|mult2|cla2|PFA2|G~combout\,
	datac => \mult1:mult8|mult2|tbm1|S\(0),
	datad => \mult1:mult8|mult2|cla1|PFA3|P~combout\,
	combout => \mult1:mult8|mult2|cla2|c3~1_combout\);

-- Location: FF_X25_Y21_N27
\mult1:mult8|mult2|tbm1|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm1|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm1|S\(1));

-- Location: LCCOMB_X26_Y20_N10
\mult1:mult8|mult3|cla2|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|c3~1_combout\ = (\mult1:mult8|mult3|cla2|PFA2|G~combout\ & ((\mult1:mult8|mult3|tbm1|S\(0)) # (\mult1:mult8|mult3|cla1|c2~0_combout\ $ (\mult1:mult8|mult3|cla1|PFA3|P~combout\)))) # (!\mult1:mult8|mult3|cla2|PFA2|G~combout\ & 
-- (\mult1:mult8|mult3|tbm1|S\(0) & (\mult1:mult8|mult3|cla1|c2~0_combout\ $ (\mult1:mult8|mult3|cla1|PFA3|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|cla2|PFA2|G~combout\,
	datab => \mult1:mult8|mult3|cla1|c2~0_combout\,
	datac => \mult1:mult8|mult3|cla1|PFA3|P~combout\,
	datad => \mult1:mult8|mult3|tbm1|S\(0),
	combout => \mult1:mult8|mult3|cla2|c3~1_combout\);

-- Location: LCCOMB_X25_Y21_N22
\mult1:mult8|mult2|cla1|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|Cout~0_combout\ = (\mult1:mult8|mult2|tbm2|S\(3) & ((\mult1:mult8|mult2|tbm3|S\(3)) # ((\mult1:mult8|mult2|tbm3|S\(2) & \mult1:mult8|mult2|tbm2|S\(2))))) # (!\mult1:mult8|mult2|tbm2|S\(3) & (\mult1:mult8|mult2|tbm3|S\(2) & 
-- (\mult1:mult8|mult2|tbm2|S\(2) & \mult1:mult8|mult2|tbm3|S\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm3|S\(2),
	datab => \mult1:mult8|mult2|tbm2|S\(2),
	datac => \mult1:mult8|mult2|tbm2|S\(3),
	datad => \mult1:mult8|mult2|tbm3|S\(3),
	combout => \mult1:mult8|mult2|cla1|Cout~0_combout\);

-- Location: LCCOMB_X26_Y20_N28
\mult1:mult8|mult3|cla1|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|PFA4|P~combout\ = \mult1:mult8|mult3|tbm2|S\(3) $ (\mult1:mult8|mult3|tbm3|S\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(3),
	datad => \mult1:mult8|mult3|tbm3|S\(3),
	combout => \mult1:mult8|mult3|cla1|PFA4|P~combout\);

-- Location: LCCOMB_X26_Y20_N6
\mult1:mult8|mult3|cla2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|Cout~0_combout\ = (\mult1:mult8|mult3|tbm1|S\(1) & ((\mult1:mult8|mult3|cla2|PFA3|G~combout\) # (\mult1:mult8|mult3|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult3|cla1|c3~1_combout\)))) # (!\mult1:mult8|mult3|tbm1|S\(1) & 
-- (\mult1:mult8|mult3|cla2|PFA3|G~combout\ & (\mult1:mult8|mult3|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult3|cla1|c3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm1|S\(1),
	datab => \mult1:mult8|mult3|cla1|PFA4|P~combout\,
	datac => \mult1:mult8|mult3|cla2|PFA3|G~combout\,
	datad => \mult1:mult8|mult3|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult3|cla2|Cout~0_combout\);

-- Location: FF_X25_Y21_N7
\mult1:mult8|mult2|tbm1|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm1|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm1|S\(3));

-- Location: FF_X27_Y20_N23
\mult1:mult8|mult3|tbm1|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm1|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm1|S\(3));

-- Location: LCCOMB_X27_Y20_N28
\mult1:mult8|mult3|ha2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|ha2|S~combout\ = \mult1:mult8|mult3|tbm1|S\(3) $ (((\mult1:mult8|mult3|tbm1|S\(2) & \mult1:mult8|mult3|or2bit~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult3|tbm1|S\(2),
	datac => \mult1:mult8|mult3|tbm1|S\(3),
	datad => \mult1:mult8|mult3|or2bit~3_combout\,
	combout => \mult1:mult8|mult3|ha2|S~combout\);

-- Location: FF_X27_Y22_N7
\mult1:mult8|mult1|tbm1|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm1|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm1|S\(0));

-- Location: LCCOMB_X26_Y22_N2
\mult1:mult8|mult1|cla2|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|c3~0_combout\ = (\mult1:mult8|mult1|cla2|PFA1|G~combout\ & (\mult1:mult8|mult1|tbm4|S\(3) $ (\mult1:mult8|mult1|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult1|cla1|PFA2|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm4|S\(3),
	datab => \mult1:mult8|mult1|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult1|cla1|PFA2|P~combout\,
	datad => \mult1:mult8|mult1|cla2|PFA1|G~combout\,
	combout => \mult1:mult8|mult1|cla2|c3~0_combout\);

-- Location: LCCOMB_X26_Y22_N12
\mult1:mult8|mult1|cla1|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|c3~0_combout\ = (\mult1:mult8|mult1|tbm3|S\(2) & ((\mult1:mult8|mult1|tbm2|S\(2)) # ((\mult1:mult8|mult1|tbm2|S\(1) & \mult1:mult8|mult1|tbm3|S\(1))))) # (!\mult1:mult8|mult1|tbm3|S\(2) & (\mult1:mult8|mult1|tbm2|S\(1) & 
-- (\mult1:mult8|mult1|tbm3|S\(1) & \mult1:mult8|mult1|tbm2|S\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm2|S\(1),
	datab => \mult1:mult8|mult1|tbm3|S\(1),
	datac => \mult1:mult8|mult1|tbm3|S\(2),
	datad => \mult1:mult8|mult1|tbm2|S\(2),
	combout => \mult1:mult8|mult1|cla1|c3~0_combout\);

-- Location: LCCOMB_X25_Y22_N14
\mult1:mult8|mult1|or2bit~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|or2bit~1_combout\ = (\mult1:mult8|mult1|tbm3|S\(1) & ((\mult1:mult8|mult1|tbm2|S\(1)) # ((\mult1:mult8|mult1|tbm3|S\(0) & \mult1:mult8|mult1|tbm2|S\(0))))) # (!\mult1:mult8|mult1|tbm3|S\(1) & (\mult1:mult8|mult1|tbm3|S\(0) & 
-- (\mult1:mult8|mult1|tbm2|S\(0) & \mult1:mult8|mult1|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm3|S\(0),
	datab => \mult1:mult8|mult1|tbm3|S\(1),
	datac => \mult1:mult8|mult1|tbm2|S\(0),
	datad => \mult1:mult8|mult1|tbm2|S\(1),
	combout => \mult1:mult8|mult1|or2bit~1_combout\);

-- Location: LCCOMB_X27_Y22_N10
\mult1:mult8|mult1|cla1|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|Cout~0_combout\ = (\mult1:mult8|mult1|tbm3|S\(3) & ((\mult1:mult8|mult1|tbm2|S\(3)) # ((\mult1:mult8|mult1|tbm3|S\(2) & \mult1:mult8|mult1|tbm2|S\(2))))) # (!\mult1:mult8|mult1|tbm3|S\(3) & (\mult1:mult8|mult1|tbm3|S\(2) & 
-- (\mult1:mult8|mult1|tbm2|S\(3) & \mult1:mult8|mult1|tbm2|S\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm3|S\(3),
	datab => \mult1:mult8|mult1|tbm3|S\(2),
	datac => \mult1:mult8|mult1|tbm2|S\(3),
	datad => \mult1:mult8|mult1|tbm2|S\(2),
	combout => \mult1:mult8|mult1|cla1|Cout~0_combout\);

-- Location: FF_X27_Y22_N31
\mult1:mult8|mult1|tbm1|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm1|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm1|S\(3));

-- Location: LCCOMB_X27_Y22_N24
\mult1:mult8|mult1|ha2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|ha2|S~combout\ = \mult1:mult8|mult1|tbm1|S\(3) $ (((\mult1:mult8|mult1|tbm1|S\(2) & \mult1:mult8|mult1|or2bit~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm1|S\(3),
	datac => \mult1:mult8|mult1|tbm1|S\(2),
	datad => \mult1:mult8|mult1|or2bit~3_combout\,
	combout => \mult1:mult8|mult1|ha2|S~combout\);

-- Location: LCCOMB_X25_Y20_N26
\mult1:mult8|mult3|tbm4|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm4|ha2|S~0_combout\ = (\B[5]~input_o\ & (\A[1]~input_o\ & ((!\A[0]~input_o\) # (!\B[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \B[5]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult3|tbm4|ha2|S~0_combout\);

-- Location: LCCOMB_X26_Y21_N10
\mult1:mult8|mult2|tbm4|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm4|ha2|Cout~0_combout\ = (\B[0]~input_o\ & (\A[4]~input_o\ & (\A[5]~input_o\ & \B[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[4]~input_o\,
	datac => \A[5]~input_o\,
	datad => \B[1]~input_o\,
	combout => \mult1:mult8|mult2|tbm4|ha2|Cout~0_combout\);

-- Location: LCCOMB_X25_Y20_N22
\mult1:mult8|mult3|tbm4|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm4|ha2|Cout~0_combout\ = (\B[4]~input_o\ & (\B[5]~input_o\ & (\A[0]~input_o\ & \A[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \B[5]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult3|tbm4|ha2|Cout~0_combout\);

-- Location: LCCOMB_X25_Y21_N30
\mult1:mult8|mult2|tbm1|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm1|and4~combout\ = (\A[6]~input_o\ & \B[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datac => \B[2]~input_o\,
	combout => \mult1:mult8|mult2|tbm1|and4~combout\);

-- Location: LCCOMB_X25_Y21_N26
\mult1:mult8|mult2|tbm1|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm1|ha1|S~combout\ = (\A[6]~input_o\ & (\B[3]~input_o\ $ (((\B[2]~input_o\ & \A[7]~input_o\))))) # (!\A[6]~input_o\ & (((\B[2]~input_o\ & \A[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm1|ha1|S~combout\);

-- Location: LCCOMB_X25_Y21_N6
\mult1:mult8|mult2|tbm1|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm1|ha2|Cout~0_combout\ = (\A[6]~input_o\ & (\B[3]~input_o\ & (\B[2]~input_o\ & \A[7]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm1|ha2|Cout~0_combout\);

-- Location: LCCOMB_X27_Y20_N22
\mult1:mult8|mult3|tbm1|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm1|ha2|Cout~0_combout\ = (\A[3]~input_o\ & (\B[7]~input_o\ & (\A[2]~input_o\ & \B[6]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[7]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm1|ha2|Cout~0_combout\);

-- Location: LCCOMB_X27_Y22_N6
\mult1:mult8|mult1|tbm1|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm1|and4~combout\ = (\A[6]~input_o\ & \B[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[6]~input_o\,
	datac => \B[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm1|and4~combout\);

-- Location: LCCOMB_X27_Y22_N30
\mult1:mult8|mult1|tbm1|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm1|ha2|Cout~0_combout\ = (\B[7]~input_o\ & (\A[6]~input_o\ & (\B[6]~input_o\ & \A[7]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[7]~input_o\,
	datab => \A[6]~input_o\,
	datac => \B[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm1|ha2|Cout~0_combout\);

-- Location: LCCOMB_X26_Y21_N20
\mult1:mult8|mult2|cla2|PFA2|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA2|G~combout\ = (\mult1:mult8|mult2|tbm4|S\(3) & (\mult1:mult8|mult2|cla1|PFA2|P~combout\ $ (((\mult1:mult8|mult2|tbm3|S\(0) & \mult1:mult8|mult2|tbm2|S\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm4|S\(3),
	datab => \mult1:mult8|mult2|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult2|tbm3|S\(0),
	datad => \mult1:mult8|mult2|tbm2|S\(0),
	combout => \mult1:mult8|mult2|cla2|PFA2|G~combout\);

-- Location: LCCOMB_X25_Y20_N10
\mult1:mult8|mult3|cla2|PFA2|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA2|G~combout\ = (\mult1:mult8|mult3|tbm4|S\(3) & (\mult1:mult8|mult3|cla1|PFA2|P~combout\ $ (((\mult1:mult8|mult3|tbm3|S\(0) & \mult1:mult8|mult3|tbm2|S\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(3),
	datab => \mult1:mult8|mult3|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult3|tbm3|S\(0),
	datad => \mult1:mult8|mult3|tbm2|S\(0),
	combout => \mult1:mult8|mult3|cla2|PFA2|G~combout\);

-- Location: LCCOMB_X26_Y20_N26
\mult1:mult8|mult3|cla2|PFA3|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA3|G~combout\ = (\mult1:mult8|mult3|tbm1|S\(0) & (\mult1:mult8|mult3|tbm2|S\(2) $ (\mult1:mult8|mult3|cla1|c2~0_combout\ $ (\mult1:mult8|mult3|tbm3|S\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(2),
	datab => \mult1:mult8|mult3|cla1|c2~0_combout\,
	datac => \mult1:mult8|mult3|tbm3|S\(2),
	datad => \mult1:mult8|mult3|tbm1|S\(0),
	combout => \mult1:mult8|mult3|cla2|PFA3|G~combout\);

-- Location: LCCOMB_X27_Y22_N26
\mult1:mult8|mult1|cla2|PFA3|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA3|G~combout\ = (\mult1:mult8|mult1|tbm1|S\(0) & (\mult1:mult8|mult1|tbm3|S\(2) $ (\mult1:mult8|mult1|tbm2|S\(2) $ (\mult1:mult8|mult1|cla1|c2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm1|S\(0),
	datab => \mult1:mult8|mult1|tbm3|S\(2),
	datac => \mult1:mult8|mult1|tbm2|S\(2),
	datad => \mult1:mult8|mult1|cla1|c2~0_combout\,
	combout => \mult1:mult8|mult1|cla2|PFA3|G~combout\);

-- Location: IOOBUF_X10_Y0_N9
\R~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \R~output_o\);

-- Location: IOOBUF_X33_Y12_N9
\S[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(0),
	devoe => ww_devoe,
	o => \S[0]~output_o\);

-- Location: IOOBUF_X20_Y31_N2
\S[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(1),
	devoe => ww_devoe,
	o => \S[1]~output_o\);

-- Location: IOOBUF_X22_Y31_N2
\S[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(2),
	devoe => ww_devoe,
	o => \S[2]~output_o\);

-- Location: IOOBUF_X20_Y0_N2
\S[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(3),
	devoe => ww_devoe,
	o => \S[3]~output_o\);

-- Location: IOOBUF_X33_Y12_N2
\S[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(4),
	devoe => ww_devoe,
	o => \S[4]~output_o\);

-- Location: IOOBUF_X33_Y28_N2
\S[5]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(5),
	devoe => ww_devoe,
	o => \S[5]~output_o\);

-- Location: IOOBUF_X33_Y27_N2
\S[6]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(6),
	devoe => ww_devoe,
	o => \S[6]~output_o\);

-- Location: IOOBUF_X22_Y31_N9
\S[7]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(7),
	devoe => ww_devoe,
	o => \S[7]~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\S[8]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(8),
	devoe => ww_devoe,
	o => \S[8]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\S[9]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(9),
	devoe => ww_devoe,
	o => \S[9]~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\S[10]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(10),
	devoe => ww_devoe,
	o => \S[10]~output_o\);

-- Location: IOOBUF_X33_Y11_N2
\S[11]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(11),
	devoe => ww_devoe,
	o => \S[11]~output_o\);

-- Location: IOOBUF_X33_Y27_N9
\S[12]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(12),
	devoe => ww_devoe,
	o => \S[12]~output_o\);

-- Location: IOOBUF_X33_Y11_N9
\S[13]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(13),
	devoe => ww_devoe,
	o => \S[13]~output_o\);

-- Location: IOOBUF_X33_Y10_N2
\S[14]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(14),
	devoe => ww_devoe,
	o => \S[14]~output_o\);

-- Location: IOOBUF_X24_Y0_N2
\S[15]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \mult1:mult8|S\(15),
	devoe => ww_devoe,
	o => \S[15]~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\CLK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G17
\CLK~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X16_Y0_N1
\A[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: IOIBUF_X33_Y22_N1
\B[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: LCCOMB_X27_Y20_N10
\mult1:mult8|mult4|tbm4|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm4|and4~combout\ = (\A[0]~input_o\ & \B[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	combout => \mult1:mult8|mult4|tbm4|and4~combout\);

-- Location: FF_X27_Y20_N11
\mult1:mult8|mult4|tbm4|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm4|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm4|S\(0));

-- Location: LCCOMB_X27_Y20_N2
\mult1:mult8|mult4|S[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|S[0]~feeder_combout\ = \mult1:mult8|mult4|tbm4|S\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult4|tbm4|S\(0),
	combout => \mult1:mult8|mult4|S[0]~feeder_combout\);

-- Location: FF_X27_Y20_N3
\mult1:mult8|mult4|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|S[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(0));

-- Location: LCCOMB_X27_Y20_N16
\mult1:mult8|S[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|S[0]~feeder_combout\ = \mult1:mult8|mult4|S\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult4|S\(0),
	combout => \mult1:mult8|S[0]~feeder_combout\);

-- Location: FF_X27_Y20_N17
\mult1:mult8|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|S[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(0));

-- Location: IOIBUF_X33_Y25_N1
\A[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: LCCOMB_X22_Y19_N10
\mult1:mult8|mult4|tbm4|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm4|ha1|S~combout\ = (\B[1]~input_o\ & (\A[0]~input_o\ $ (((\B[0]~input_o\ & \A[1]~input_o\))))) # (!\B[1]~input_o\ & (\B[0]~input_o\ & ((\A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm4|ha1|S~combout\);

-- Location: FF_X22_Y19_N11
\mult1:mult8|mult4|tbm4|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm4|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm4|S\(1));

-- Location: LCCOMB_X22_Y19_N12
\mult1:mult8|mult4|S[1]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|S[1]~feeder_combout\ = \mult1:mult8|mult4|tbm4|S\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult4|tbm4|S\(1),
	combout => \mult1:mult8|mult4|S[1]~feeder_combout\);

-- Location: FF_X22_Y19_N13
\mult1:mult8|mult4|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|S[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(1));

-- Location: LCCOMB_X22_Y19_N24
\mult1:mult8|S[1]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|S[1]~feeder_combout\ = \mult1:mult8|mult4|S\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult4|S\(1),
	combout => \mult1:mult8|S[1]~feeder_combout\);

-- Location: FF_X22_Y19_N25
\mult1:mult8|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|S[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(1));

-- Location: IOIBUF_X33_Y15_N8
\A[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: LCCOMB_X22_Y19_N18
\mult1:mult8|mult4|tbm2|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm2|and4~combout\ = (\A[2]~input_o\ & \B[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \A[2]~input_o\,
	datad => \B[0]~input_o\,
	combout => \mult1:mult8|mult4|tbm2|and4~combout\);

-- Location: FF_X22_Y19_N19
\mult1:mult8|mult4|tbm2|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm2|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm2|S\(0));

-- Location: IOIBUF_X33_Y15_N1
\B[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: LCCOMB_X22_Y19_N4
\mult1:mult8|mult4|tbm3|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm3|and4~combout\ = (\B[2]~input_o\ & \A[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \A[0]~input_o\,
	combout => \mult1:mult8|mult4|tbm3|and4~combout\);

-- Location: FF_X22_Y19_N5
\mult1:mult8|mult4|tbm3|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm3|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm3|S\(0));

-- Location: LCCOMB_X22_Y19_N0
\mult1:mult8|mult4|tbm4|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm4|ha2|S~0_combout\ = (\B[1]~input_o\ & (\A[1]~input_o\ & ((!\A[0]~input_o\) # (!\B[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm4|ha2|S~0_combout\);

-- Location: FF_X22_Y19_N1
\mult1:mult8|mult4|tbm4|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm4|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm4|S\(2));

-- Location: LCCOMB_X22_Y19_N30
\mult1:mult8|mult4|cla2|PFA1|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA1|P~combout\ = \mult1:mult8|mult4|tbm2|S\(0) $ (\mult1:mult8|mult4|tbm3|S\(0) $ (\mult1:mult8|mult4|tbm4|S\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult4|tbm2|S\(0),
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|tbm4|S\(2),
	combout => \mult1:mult8|mult4|cla2|PFA1|P~combout\);

-- Location: FF_X22_Y19_N31
\mult1:mult8|mult4|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|cla2|PFA1|P~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(2));

-- Location: FF_X22_Y19_N27
\mult1:mult8|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult4|S\(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(2));

-- Location: LCCOMB_X22_Y19_N2
\mult1:mult8|mult4|cla2|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA1|G~combout\ = (\mult1:mult8|mult4|tbm4|S\(2) & (\mult1:mult8|mult4|tbm3|S\(0) $ (\mult1:mult8|mult4|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult4|tbm4|S\(2),
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|tbm2|S\(0),
	combout => \mult1:mult8|mult4|cla2|PFA1|G~combout\);

-- Location: IOIBUF_X24_Y31_N8
\B[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: LCCOMB_X23_Y19_N22
\mult1:mult8|mult4|tbm3|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm3|ha1|S~combout\ = (\B[2]~input_o\ & (\A[1]~input_o\ $ (((\B[3]~input_o\ & \A[0]~input_o\))))) # (!\B[2]~input_o\ & (\B[3]~input_o\ & (\A[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm3|ha1|S~combout\);

-- Location: FF_X23_Y19_N23
\mult1:mult8|mult4|tbm3|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm3|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm3|S\(1));

-- Location: IOIBUF_X33_Y14_N1
\B[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: LCCOMB_X23_Y19_N16
\mult1:mult8|mult4|tbm2|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm2|ha1|S~combout\ = (\A[3]~input_o\ & (\B[0]~input_o\ $ (((\A[2]~input_o\ & \B[1]~input_o\))))) # (!\A[3]~input_o\ & (\A[2]~input_o\ & ((\B[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \A[2]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm2|ha1|S~combout\);

-- Location: FF_X23_Y19_N17
\mult1:mult8|mult4|tbm2|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm2|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm2|S\(1));

-- Location: LCCOMB_X23_Y19_N0
\mult1:mult8|mult4|cla1|PFA2|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|PFA2|P~combout\ = \mult1:mult8|mult4|tbm3|S\(1) $ (\mult1:mult8|mult4|tbm2|S\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult4|tbm3|S\(1),
	datad => \mult1:mult8|mult4|tbm2|S\(1),
	combout => \mult1:mult8|mult4|cla1|PFA2|P~combout\);

-- Location: LCCOMB_X22_Y19_N16
\mult1:mult8|mult4|tbm4|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm4|ha2|Cout~0_combout\ = (\B[1]~input_o\ & (\B[0]~input_o\ & (\A[0]~input_o\ & \A[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm4|ha2|Cout~0_combout\);

-- Location: FF_X22_Y19_N17
\mult1:mult8|mult4|tbm4|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm4|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm4|S\(3));

-- Location: LCCOMB_X22_Y19_N28
\mult1:mult8|mult4|cla2|PFA2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA2|S~combout\ = \mult1:mult8|mult4|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult4|cla2|PFA1|G~combout\ $ (\mult1:mult8|mult4|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult4|tbm4|S\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla1|PFA1|G~combout\,
	datab => \mult1:mult8|mult4|cla2|PFA1|G~combout\,
	datac => \mult1:mult8|mult4|cla1|PFA2|P~combout\,
	datad => \mult1:mult8|mult4|tbm4|S\(3),
	combout => \mult1:mult8|mult4|cla2|PFA2|S~combout\);

-- Location: FF_X22_Y19_N29
\mult1:mult8|mult4|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|cla2|PFA2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(3));

-- Location: LCCOMB_X21_Y19_N20
\mult1:mult8|S[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|S[3]~feeder_combout\ = \mult1:mult8|mult4|S\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult4|S\(3),
	combout => \mult1:mult8|S[3]~feeder_combout\);

-- Location: FF_X21_Y19_N21
\mult1:mult8|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|S[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(3));

-- Location: IOIBUF_X33_Y22_N8
\B[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(4),
	o => \B[4]~input_o\);

-- Location: LCCOMB_X27_Y20_N0
\mult1:mult8|mult3|tbm4|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm4|and4~combout\ = (\A[0]~input_o\ & \B[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[0]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult3|tbm4|and4~combout\);

-- Location: FF_X27_Y20_N1
\mult1:mult8|mult3|tbm4|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm4|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm4|S\(0));

-- Location: FF_X26_Y19_N5
\mult1:mult8|mult3|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult3|tbm4|S\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(0));

-- Location: LCCOMB_X23_Y19_N18
\mult1:mult8|mult4|tbm3|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm3|ha2|S~0_combout\ = (\B[3]~input_o\ & (\A[1]~input_o\ & ((!\A[0]~input_o\) # (!\B[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm3|ha2|S~0_combout\);

-- Location: FF_X23_Y19_N19
\mult1:mult8|mult4|tbm3|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm3|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm3|S\(2));

-- Location: LCCOMB_X23_Y19_N26
\mult1:mult8|mult4|tbm1|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm1|and4~combout\ = (\B[2]~input_o\ & \A[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datad => \A[2]~input_o\,
	combout => \mult1:mult8|mult4|tbm1|and4~combout\);

-- Location: FF_X23_Y19_N27
\mult1:mult8|mult4|tbm1|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm1|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm1|S\(0));

-- Location: LCCOMB_X23_Y19_N10
\mult1:mult8|mult4|cla1|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|c2~0_combout\ = (\mult1:mult8|mult4|tbm3|S\(1) & ((\mult1:mult8|mult4|tbm2|S\(1)) # ((\mult1:mult8|mult4|tbm2|S\(0) & \mult1:mult8|mult4|tbm3|S\(0))))) # (!\mult1:mult8|mult4|tbm3|S\(1) & (\mult1:mult8|mult4|tbm2|S\(0) & 
-- (\mult1:mult8|mult4|tbm3|S\(0) & \mult1:mult8|mult4|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm3|S\(1),
	datab => \mult1:mult8|mult4|tbm2|S\(0),
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|tbm2|S\(1),
	combout => \mult1:mult8|mult4|cla1|c2~0_combout\);

-- Location: LCCOMB_X24_Y19_N10
\mult1:mult8|mult4|cla2|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA3|P~combout\ = \mult1:mult8|mult4|tbm2|S\(2) $ (\mult1:mult8|mult4|tbm3|S\(2) $ (\mult1:mult8|mult4|tbm1|S\(0) $ (\mult1:mult8|mult4|cla1|c2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm2|S\(2),
	datab => \mult1:mult8|mult4|tbm3|S\(2),
	datac => \mult1:mult8|mult4|tbm1|S\(0),
	datad => \mult1:mult8|mult4|cla1|c2~0_combout\,
	combout => \mult1:mult8|mult4|cla2|PFA3|P~combout\);

-- Location: LCCOMB_X26_Y19_N24
\mult1:mult8|mult4|cla2|PFA3|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA3|S~combout\ = \mult1:mult8|mult4|cla2|c2~0_combout\ $ (\mult1:mult8|mult4|cla2|PFA3|P~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla2|c2~0_combout\,
	datad => \mult1:mult8|mult4|cla2|PFA3|P~combout\,
	combout => \mult1:mult8|mult4|cla2|PFA3|S~combout\);

-- Location: FF_X26_Y19_N25
\mult1:mult8|mult4|S[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|cla2|PFA3|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(4));

-- Location: LCCOMB_X27_Y19_N28
\mult1:mult8|cla2|h_sum[0]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|h_sum\(0) = \mult1:mult8|mult2|S\(0) $ (\mult1:mult8|mult3|S\(0) $ (\mult1:mult8|mult4|S\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|S\(0),
	datac => \mult1:mult8|mult3|S\(0),
	datad => \mult1:mult8|mult4|S\(4),
	combout => \mult1:mult8|cla2|h_sum\(0));

-- Location: FF_X27_Y19_N29
\mult1:mult8|S[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|h_sum\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(4));

-- Location: LCCOMB_X23_Y19_N8
\mult1:mult8|mult4|tbm2|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm2|ha2|S~0_combout\ = (\A[3]~input_o\ & (\B[1]~input_o\ & ((!\B[0]~input_o\) # (!\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \A[2]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm2|ha2|S~0_combout\);

-- Location: FF_X23_Y19_N9
\mult1:mult8|mult4|tbm2|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm2|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm2|S\(2));

-- Location: LCCOMB_X23_Y19_N4
\mult1:mult8|mult4|cla1|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|PFA3|P~combout\ = \mult1:mult8|mult4|tbm2|S\(2) $ (\mult1:mult8|mult4|tbm3|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult4|tbm2|S\(2),
	datad => \mult1:mult8|mult4|tbm3|S\(2),
	combout => \mult1:mult8|mult4|cla1|PFA3|P~combout\);

-- Location: LCCOMB_X23_Y19_N14
\mult1:mult8|mult4|cla2|PFA2|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA2|G~combout\ = (\mult1:mult8|mult4|tbm4|S\(3) & (\mult1:mult8|mult4|cla1|PFA2|P~combout\ $ (((\mult1:mult8|mult4|tbm2|S\(0) & \mult1:mult8|mult4|tbm3|S\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm4|S\(3),
	datab => \mult1:mult8|mult4|tbm2|S\(0),
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult4|cla2|PFA2|G~combout\);

-- Location: LCCOMB_X23_Y19_N6
\mult1:mult8|mult4|cla2|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|c3~1_combout\ = (\mult1:mult8|mult4|tbm1|S\(0) & ((\mult1:mult8|mult4|cla2|PFA2|G~combout\) # (\mult1:mult8|mult4|cla1|PFA3|P~combout\ $ (\mult1:mult8|mult4|cla1|c2~0_combout\)))) # (!\mult1:mult8|mult4|tbm1|S\(0) & 
-- (\mult1:mult8|mult4|cla2|PFA2|G~combout\ & (\mult1:mult8|mult4|cla1|PFA3|P~combout\ $ (\mult1:mult8|mult4|cla1|c2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm1|S\(0),
	datab => \mult1:mult8|mult4|cla1|PFA3|P~combout\,
	datac => \mult1:mult8|mult4|cla2|PFA2|G~combout\,
	datad => \mult1:mult8|mult4|cla1|c2~0_combout\,
	combout => \mult1:mult8|mult4|cla2|c3~1_combout\);

-- Location: LCCOMB_X22_Y19_N20
\mult1:mult8|mult4|cla2|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|c3~0_combout\ = (\mult1:mult8|mult4|cla2|PFA1|G~combout\ & (\mult1:mult8|mult4|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult4|tbm4|S\(3) $ (\mult1:mult8|mult4|cla1|PFA2|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla1|PFA1|G~combout\,
	datab => \mult1:mult8|mult4|tbm4|S\(3),
	datac => \mult1:mult8|mult4|cla1|PFA2|P~combout\,
	datad => \mult1:mult8|mult4|cla2|PFA1|G~combout\,
	combout => \mult1:mult8|mult4|cla2|c3~0_combout\);

-- Location: LCCOMB_X23_Y19_N30
\mult1:mult8|mult4|tbm3|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm3|ha2|Cout~0_combout\ = (\B[2]~input_o\ & (\B[3]~input_o\ & (\A[0]~input_o\ & \A[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult4|tbm3|ha2|Cout~0_combout\);

-- Location: FF_X23_Y19_N31
\mult1:mult8|mult4|tbm3|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm3|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm3|S\(3));

-- Location: IOIBUF_X33_Y14_N8
\A[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LCCOMB_X24_Y19_N30
\mult1:mult8|mult4|tbm1|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm1|ha1|S~combout\ = (\B[3]~input_o\ & (\A[2]~input_o\ $ (((\A[3]~input_o\ & \B[2]~input_o\))))) # (!\B[3]~input_o\ & (\A[3]~input_o\ & ((\B[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \A[3]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[2]~input_o\,
	combout => \mult1:mult8|mult4|tbm1|ha1|S~combout\);

-- Location: FF_X24_Y19_N31
\mult1:mult8|mult4|tbm1|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm1|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm1|S\(1));

-- Location: LCCOMB_X22_Y19_N22
\mult1:mult8|mult4|cla1|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|PFA1|G~combout\ = (\mult1:mult8|mult4|tbm3|S\(0) & \mult1:mult8|mult4|tbm2|S\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|tbm2|S\(0),
	combout => \mult1:mult8|mult4|cla1|PFA1|G~combout\);

-- Location: LCCOMB_X23_Y19_N2
\mult1:mult8|mult4|cla1|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|c3~1_combout\ = (\mult1:mult8|mult4|cla1|c3~0_combout\) # ((\mult1:mult8|mult4|cla1|PFA2|P~combout\ & (\mult1:mult8|mult4|cla1|PFA3|P~combout\ & \mult1:mult8|mult4|cla1|PFA1|G~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla1|c3~0_combout\,
	datab => \mult1:mult8|mult4|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult4|cla1|PFA3|P~combout\,
	datad => \mult1:mult8|mult4|cla1|PFA1|G~combout\,
	combout => \mult1:mult8|mult4|cla1|c3~1_combout\);

-- Location: LCCOMB_X24_Y19_N0
\mult1:mult8|mult4|cla2|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA4|P~combout\ = \mult1:mult8|mult4|tbm2|S\(3) $ (\mult1:mult8|mult4|tbm3|S\(3) $ (\mult1:mult8|mult4|tbm1|S\(1) $ (\mult1:mult8|mult4|cla1|c3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm2|S\(3),
	datab => \mult1:mult8|mult4|tbm3|S\(3),
	datac => \mult1:mult8|mult4|tbm1|S\(1),
	datad => \mult1:mult8|mult4|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult4|cla2|PFA4|P~combout\);

-- Location: LCCOMB_X24_Y19_N18
\mult1:mult8|mult4|cla2|PFA4|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA4|S~combout\ = \mult1:mult8|mult4|cla2|PFA4|P~combout\ $ (((\mult1:mult8|mult4|cla2|c3~1_combout\) # ((\mult1:mult8|mult4|cla2|PFA3|P~combout\ & \mult1:mult8|mult4|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001111101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla2|PFA3|P~combout\,
	datab => \mult1:mult8|mult4|cla2|c3~1_combout\,
	datac => \mult1:mult8|mult4|cla2|c3~0_combout\,
	datad => \mult1:mult8|mult4|cla2|PFA4|P~combout\,
	combout => \mult1:mult8|mult4|cla2|PFA4|S~combout\);

-- Location: FF_X26_Y19_N23
\mult1:mult8|mult4|S[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult4|cla2|PFA4|S~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(5));

-- Location: IOIBUF_X29_Y31_N8
\B[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(5),
	o => \B[5]~input_o\);

-- Location: LCCOMB_X27_Y20_N26
\mult1:mult8|mult3|tbm4|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm4|ha1|S~combout\ = (\B[4]~input_o\ & (\A[1]~input_o\ $ (((\B[5]~input_o\ & \A[0]~input_o\))))) # (!\B[4]~input_o\ & (\B[5]~input_o\ & ((\A[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \B[5]~input_o\,
	datac => \A[1]~input_o\,
	datad => \A[0]~input_o\,
	combout => \mult1:mult8|mult3|tbm4|ha1|S~combout\);

-- Location: FF_X27_Y20_N27
\mult1:mult8|mult3|tbm4|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm4|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm4|S\(1));

-- Location: FF_X26_Y19_N13
\mult1:mult8|mult3|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult3|tbm4|S\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(1));

-- Location: IOIBUF_X26_Y31_N1
\A[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

-- Location: IOIBUF_X24_Y31_N1
\A[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

-- Location: LCCOMB_X25_Y22_N8
\mult1:mult8|mult2|tbm4|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm4|ha1|S~combout\ = (\B[1]~input_o\ & (\A[4]~input_o\ $ (((\B[0]~input_o\ & \A[5]~input_o\))))) # (!\B[1]~input_o\ & (((\B[0]~input_o\ & \A[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[5]~input_o\,
	combout => \mult1:mult8|mult2|tbm4|ha1|S~combout\);

-- Location: FF_X25_Y22_N9
\mult1:mult8|mult2|tbm4|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm4|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm4|S\(1));

-- Location: FF_X26_Y19_N19
\mult1:mult8|mult2|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm4|S\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(1));

-- Location: LCCOMB_X26_Y19_N12
\mult1:mult8|cla1|sum[1]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|sum[1]~0_combout\ = \mult1:mult8|mult3|S\(1) $ (\mult1:mult8|mult2|S\(1) $ (((\mult1:mult8|mult2|S\(0) & \mult1:mult8|mult3|S\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000011101111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|S\(0),
	datab => \mult1:mult8|mult3|S\(0),
	datac => \mult1:mult8|mult3|S\(1),
	datad => \mult1:mult8|mult2|S\(1),
	combout => \mult1:mult8|cla1|sum[1]~0_combout\);

-- Location: LCCOMB_X27_Y19_N14
\mult1:mult8|cla2|sum[1]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(1) = \mult1:mult8|mult4|S\(5) $ (\mult1:mult8|cla1|sum[1]~0_combout\ $ (((\mult1:mult8|cla1|h_sum\(0) & \mult1:mult8|mult4|S\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(0),
	datab => \mult1:mult8|mult4|S\(5),
	datac => \mult1:mult8|cla1|sum[1]~0_combout\,
	datad => \mult1:mult8|mult4|S\(4),
	combout => \mult1:mult8|cla2|sum\(1));

-- Location: FF_X27_Y19_N15
\mult1:mult8|S[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(5));

-- Location: LCCOMB_X26_Y19_N18
\mult1:mult8|cla1|carry_in_internal[2]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[2]~0_combout\ = (\mult1:mult8|mult2|S\(1) & ((\mult1:mult8|mult3|S\(1)) # ((\mult1:mult8|mult2|S\(0) & \mult1:mult8|mult3|S\(0))))) # (!\mult1:mult8|mult2|S\(1) & (\mult1:mult8|mult2|S\(0) & (\mult1:mult8|mult3|S\(0) & 
-- \mult1:mult8|mult3|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|S\(0),
	datab => \mult1:mult8|mult3|S\(0),
	datac => \mult1:mult8|mult2|S\(1),
	datad => \mult1:mult8|mult3|S\(1),
	combout => \mult1:mult8|cla1|carry_in_internal[2]~0_combout\);

-- Location: LCCOMB_X24_Y19_N20
\mult1:mult8|mult4|tbm1|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm1|ha2|S~0_combout\ = (\B[3]~input_o\ & (\A[3]~input_o\ & ((!\B[2]~input_o\) # (!\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \A[3]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[2]~input_o\,
	combout => \mult1:mult8|mult4|tbm1|ha2|S~0_combout\);

-- Location: FF_X24_Y19_N21
\mult1:mult8|mult4|tbm1|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm1|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm1|S\(2));

-- Location: LCCOMB_X22_Y19_N6
\mult1:mult8|mult4|tbm2|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm2|ha2|Cout~0_combout\ = (\A[2]~input_o\ & (\A[3]~input_o\ & (\B[1]~input_o\ & \B[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[2]~input_o\,
	datab => \A[3]~input_o\,
	datac => \B[1]~input_o\,
	datad => \B[0]~input_o\,
	combout => \mult1:mult8|mult4|tbm2|ha2|Cout~0_combout\);

-- Location: FF_X23_Y19_N29
\mult1:mult8|mult4|tbm2|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult4|tbm2|ha2|Cout~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm2|S\(3));

-- Location: LCCOMB_X23_Y19_N24
\mult1:mult8|mult4|or2bit~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|or2bit~1_combout\ = (\mult1:mult8|mult4|tbm3|S\(1) & ((\mult1:mult8|mult4|tbm2|S\(1)) # ((\mult1:mult8|mult4|tbm3|S\(0) & \mult1:mult8|mult4|tbm2|S\(0))))) # (!\mult1:mult8|mult4|tbm3|S\(1) & (\mult1:mult8|mult4|tbm2|S\(1) & 
-- (\mult1:mult8|mult4|tbm3|S\(0) & \mult1:mult8|mult4|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm3|S\(1),
	datab => \mult1:mult8|mult4|tbm2|S\(1),
	datac => \mult1:mult8|mult4|tbm3|S\(0),
	datad => \mult1:mult8|mult4|tbm2|S\(0),
	combout => \mult1:mult8|mult4|or2bit~1_combout\);

-- Location: LCCOMB_X23_Y19_N28
\mult1:mult8|mult4|or2bit~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|or2bit~2_combout\ = (\mult1:mult8|mult4|cla1|PFA3|P~combout\ & (\mult1:mult8|mult4|or2bit~1_combout\ & (\mult1:mult8|mult4|tbm3|S\(3) $ (\mult1:mult8|mult4|tbm2|S\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm3|S\(3),
	datab => \mult1:mult8|mult4|cla1|PFA3|P~combout\,
	datac => \mult1:mult8|mult4|tbm2|S\(3),
	datad => \mult1:mult8|mult4|or2bit~1_combout\,
	combout => \mult1:mult8|mult4|or2bit~2_combout\);

-- Location: LCCOMB_X24_Y19_N22
\mult1:mult8|mult4|or2bit~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|or2bit~0_combout\ = (\mult1:mult8|mult4|cla2|PFA3|P~combout\ & (\mult1:mult8|mult4|cla2|PFA4|P~combout\ & ((\mult1:mult8|mult4|cla2|PFA2|G~combout\) # (\mult1:mult8|mult4|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla2|PFA3|P~combout\,
	datab => \mult1:mult8|mult4|cla2|PFA2|G~combout\,
	datac => \mult1:mult8|mult4|cla2|c3~0_combout\,
	datad => \mult1:mult8|mult4|cla2|PFA4|P~combout\,
	combout => \mult1:mult8|mult4|or2bit~0_combout\);

-- Location: LCCOMB_X24_Y19_N16
\mult1:mult8|mult4|cla1|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla1|PFA4|P~combout\ = \mult1:mult8|mult4|tbm3|S\(3) $ (\mult1:mult8|mult4|tbm2|S\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult4|tbm3|S\(3),
	datad => \mult1:mult8|mult4|tbm2|S\(3),
	combout => \mult1:mult8|mult4|cla1|PFA4|P~combout\);

-- Location: LCCOMB_X24_Y19_N4
\mult1:mult8|mult4|cla2|PFA3|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|PFA3|G~combout\ = (\mult1:mult8|mult4|tbm1|S\(0) & (\mult1:mult8|mult4|tbm2|S\(2) $ (\mult1:mult8|mult4|tbm3|S\(2) $ (\mult1:mult8|mult4|cla1|c2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|tbm2|S\(2),
	datab => \mult1:mult8|mult4|tbm3|S\(2),
	datac => \mult1:mult8|mult4|tbm1|S\(0),
	datad => \mult1:mult8|mult4|cla1|c2~0_combout\,
	combout => \mult1:mult8|mult4|cla2|PFA3|G~combout\);

-- Location: LCCOMB_X24_Y19_N2
\mult1:mult8|mult4|cla2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|cla2|Cout~0_combout\ = (\mult1:mult8|mult4|tbm1|S\(1) & ((\mult1:mult8|mult4|cla2|PFA3|G~combout\) # (\mult1:mult8|mult4|cla1|c3~1_combout\ $ (\mult1:mult8|mult4|cla1|PFA4|P~combout\)))) # (!\mult1:mult8|mult4|tbm1|S\(1) & 
-- (\mult1:mult8|mult4|cla2|PFA3|G~combout\ & (\mult1:mult8|mult4|cla1|c3~1_combout\ $ (\mult1:mult8|mult4|cla1|PFA4|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla1|c3~1_combout\,
	datab => \mult1:mult8|mult4|cla1|PFA4|P~combout\,
	datac => \mult1:mult8|mult4|tbm1|S\(1),
	datad => \mult1:mult8|mult4|cla2|PFA3|G~combout\,
	combout => \mult1:mult8|mult4|cla2|Cout~0_combout\);

-- Location: LCCOMB_X24_Y19_N6
\mult1:mult8|mult4|or2bit~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|or2bit~3_combout\ = (\mult1:mult8|mult4|cla1|Cout~0_combout\) # ((\mult1:mult8|mult4|or2bit~2_combout\) # ((\mult1:mult8|mult4|or2bit~0_combout\) # (\mult1:mult8|mult4|cla2|Cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|cla1|Cout~0_combout\,
	datab => \mult1:mult8|mult4|or2bit~2_combout\,
	datac => \mult1:mult8|mult4|or2bit~0_combout\,
	datad => \mult1:mult8|mult4|cla2|Cout~0_combout\,
	combout => \mult1:mult8|mult4|or2bit~3_combout\);

-- Location: LCCOMB_X24_Y19_N26
\mult1:mult8|mult4|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|ha1|S~combout\ = \mult1:mult8|mult4|tbm1|S\(2) $ (\mult1:mult8|mult4|or2bit~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult4|tbm1|S\(2),
	datad => \mult1:mult8|mult4|or2bit~3_combout\,
	combout => \mult1:mult8|mult4|ha1|S~combout\);

-- Location: FF_X24_Y19_N27
\mult1:mult8|mult4|S[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(6));

-- Location: LCCOMB_X24_Y20_N16
\mult1:mult8|mult3|tbm2|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm2|and4~combout\ = (\A[2]~input_o\ & \B[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \A[2]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult3|tbm2|and4~combout\);

-- Location: FF_X25_Y20_N21
\mult1:mult8|mult3|tbm2|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult3|tbm2|and4~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm2|S\(0));

-- Location: IOIBUF_X33_Y24_N8
\B[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(6),
	o => \B[6]~input_o\);

-- Location: LCCOMB_X25_Y20_N14
\mult1:mult8|mult3|tbm3|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm3|and4~combout\ = (\A[0]~input_o\ & \B[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \A[0]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm3|and4~combout\);

-- Location: FF_X25_Y20_N15
\mult1:mult8|mult3|tbm3|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm3|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm3|S\(0));

-- Location: LCCOMB_X26_Y20_N4
\mult1:mult8|mult3|cla2|PFA1|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA1|P~combout\ = \mult1:mult8|mult3|tbm4|S\(2) $ (\mult1:mult8|mult3|tbm2|S\(0) $ (\mult1:mult8|mult3|tbm3|S\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(2),
	datac => \mult1:mult8|mult3|tbm2|S\(0),
	datad => \mult1:mult8|mult3|tbm3|S\(0),
	combout => \mult1:mult8|mult3|cla2|PFA1|P~combout\);

-- Location: FF_X25_Y19_N17
\mult1:mult8|mult3|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult3|cla2|PFA1|P~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(2));

-- Location: LCCOMB_X25_Y22_N30
\mult1:mult8|mult2|tbm4|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm4|ha2|S~0_combout\ = (\B[1]~input_o\ & (\A[5]~input_o\ & ((!\B[0]~input_o\) # (!\A[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[5]~input_o\,
	combout => \mult1:mult8|mult2|tbm4|ha2|S~0_combout\);

-- Location: FF_X25_Y22_N31
\mult1:mult8|mult2|tbm4|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm4|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm4|S\(2));

-- Location: LCCOMB_X26_Y21_N0
\mult1:mult8|mult2|tbm3|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm3|and4~combout\ = (\B[2]~input_o\ & \A[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datad => \A[4]~input_o\,
	combout => \mult1:mult8|mult2|tbm3|and4~combout\);

-- Location: FF_X26_Y21_N21
\mult1:mult8|mult2|tbm3|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm3|and4~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm3|S\(0));

-- Location: LCCOMB_X26_Y21_N18
\mult1:mult8|mult2|cla2|PFA1|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA1|P~combout\ = \mult1:mult8|mult2|tbm2|S\(0) $ (\mult1:mult8|mult2|tbm4|S\(2) $ (\mult1:mult8|mult2|tbm3|S\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100101100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm2|S\(0),
	datab => \mult1:mult8|mult2|tbm4|S\(2),
	datad => \mult1:mult8|mult2|tbm3|S\(0),
	combout => \mult1:mult8|mult2|cla2|PFA1|P~combout\);

-- Location: FF_X25_Y19_N7
\mult1:mult8|mult2|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|cla2|PFA1|P~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(2));

-- Location: LCCOMB_X25_Y19_N30
\mult1:mult8|cla1|h_sum[2]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(2) = \mult1:mult8|mult3|S\(2) $ (\mult1:mult8|mult2|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult3|S\(2),
	datad => \mult1:mult8|mult2|S\(2),
	combout => \mult1:mult8|cla1|h_sum\(2));

-- Location: LCCOMB_X26_Y19_N16
\mult1:mult8|cla2|sum[2]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(2) = \mult1:mult8|cla2|carry_in_internal[2]~0_combout\ $ (\mult1:mult8|cla1|carry_in_internal[2]~0_combout\ $ (\mult1:mult8|mult4|S\(6) $ (\mult1:mult8|cla1|h_sum\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla2|carry_in_internal[2]~0_combout\,
	datab => \mult1:mult8|cla1|carry_in_internal[2]~0_combout\,
	datac => \mult1:mult8|mult4|S\(6),
	datad => \mult1:mult8|cla1|h_sum\(2),
	combout => \mult1:mult8|cla2|sum\(2));

-- Location: FF_X26_Y19_N17
\mult1:mult8|S[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(6));

-- Location: LCCOMB_X26_Y19_N4
\mult1:mult8|cla1|carry_in_internal[3]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[3]~1_combout\ = (\mult1:mult8|mult3|S\(2) & ((\mult1:mult8|mult2|S\(2)) # (\mult1:mult8|cla1|carry_in_internal[2]~0_combout\))) # (!\mult1:mult8|mult3|S\(2) & (\mult1:mult8|mult2|S\(2) & 
-- \mult1:mult8|cla1|carry_in_internal[2]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(2),
	datab => \mult1:mult8|mult2|S\(2),
	datad => \mult1:mult8|cla1|carry_in_internal[2]~0_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[3]~1_combout\);

-- Location: LCCOMB_X25_Y22_N10
\mult1:mult8|mult2|tbm4|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm4|and4~combout\ = (\A[4]~input_o\ & \B[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[4]~input_o\,
	datac => \B[0]~input_o\,
	combout => \mult1:mult8|mult2|tbm4|and4~combout\);

-- Location: FF_X25_Y22_N11
\mult1:mult8|mult2|tbm4|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm4|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm4|S\(0));

-- Location: FF_X26_Y19_N27
\mult1:mult8|mult2|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm4|S\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(0));

-- Location: LCCOMB_X26_Y19_N26
\mult1:mult8|cla1|h_sum[0]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(0) = \mult1:mult8|mult2|S\(0) $ (\mult1:mult8|mult3|S\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|S\(0),
	datad => \mult1:mult8|mult3|S\(0),
	combout => \mult1:mult8|cla1|h_sum\(0));

-- Location: LCCOMB_X26_Y19_N22
\mult1:mult8|cla2|carry_in_internal[2]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[2]~0_combout\ = (\mult1:mult8|mult4|S\(5) & ((\mult1:mult8|cla1|sum[1]~0_combout\) # ((\mult1:mult8|mult4|S\(4) & \mult1:mult8|cla1|h_sum\(0))))) # (!\mult1:mult8|mult4|S\(5) & (\mult1:mult8|mult4|S\(4) & 
-- (\mult1:mult8|cla1|h_sum\(0) & \mult1:mult8|cla1|sum[1]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|S\(4),
	datab => \mult1:mult8|cla1|h_sum\(0),
	datac => \mult1:mult8|mult4|S\(5),
	datad => \mult1:mult8|cla1|sum[1]~0_combout\,
	combout => \mult1:mult8|cla2|carry_in_internal[2]~0_combout\);

-- Location: LCCOMB_X26_Y19_N0
\mult1:mult8|cla2|carry_in_internal[3]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[3]~1_combout\ = (\mult1:mult8|mult4|S\(6) & ((\mult1:mult8|cla2|carry_in_internal[2]~0_combout\) # (\mult1:mult8|cla1|carry_in_internal[2]~0_combout\ $ (\mult1:mult8|cla1|h_sum\(2))))) # (!\mult1:mult8|mult4|S\(6) & 
-- (\mult1:mult8|cla2|carry_in_internal[2]~0_combout\ & (\mult1:mult8|cla1|carry_in_internal[2]~0_combout\ $ (\mult1:mult8|cla1|h_sum\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|S\(6),
	datab => \mult1:mult8|cla1|carry_in_internal[2]~0_combout\,
	datac => \mult1:mult8|cla2|carry_in_internal[2]~0_combout\,
	datad => \mult1:mult8|cla1|h_sum\(2),
	combout => \mult1:mult8|cla2|carry_in_internal[3]~1_combout\);

-- Location: LCCOMB_X24_Y19_N28
\mult1:mult8|mult4|tbm1|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|tbm1|ha2|Cout~0_combout\ = (\B[3]~input_o\ & (\A[3]~input_o\ & (\A[2]~input_o\ & \B[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \A[3]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[2]~input_o\,
	combout => \mult1:mult8|mult4|tbm1|ha2|Cout~0_combout\);

-- Location: FF_X24_Y19_N29
\mult1:mult8|mult4|tbm1|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|tbm1|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|tbm1|S\(3));

-- Location: LCCOMB_X24_Y19_N12
\mult1:mult8|mult4|ha2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult4|ha2|S~combout\ = \mult1:mult8|mult4|tbm1|S\(3) $ (((\mult1:mult8|mult4|tbm1|S\(2) & \mult1:mult8|mult4|or2bit~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult4|tbm1|S\(3),
	datac => \mult1:mult8|mult4|tbm1|S\(2),
	datad => \mult1:mult8|mult4|or2bit~3_combout\,
	combout => \mult1:mult8|mult4|ha2|S~combout\);

-- Location: FF_X24_Y19_N13
\mult1:mult8|mult4|S[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult4|ha2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult4|S\(7));

-- Location: LCCOMB_X24_Y19_N8
\mult1:mult8|cla2|sum[3]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(3) = \mult1:mult8|cla1|h_sum\(3) $ (\mult1:mult8|cla1|carry_in_internal[3]~1_combout\ $ (\mult1:mult8|cla2|carry_in_internal[3]~1_combout\ $ (\mult1:mult8|mult4|S\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(3),
	datab => \mult1:mult8|cla1|carry_in_internal[3]~1_combout\,
	datac => \mult1:mult8|cla2|carry_in_internal[3]~1_combout\,
	datad => \mult1:mult8|mult4|S\(7),
	combout => \mult1:mult8|cla2|sum\(3));

-- Location: FF_X24_Y19_N9
\mult1:mult8|S[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(7));

-- Location: LCCOMB_X25_Y20_N18
\mult1:mult8|mult3|tbm2|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm2|ha1|S~combout\ = (\B[4]~input_o\ & (\A[3]~input_o\ $ (((\B[5]~input_o\ & \A[2]~input_o\))))) # (!\B[4]~input_o\ & (((\B[5]~input_o\ & \A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \A[3]~input_o\,
	datac => \B[5]~input_o\,
	datad => \A[2]~input_o\,
	combout => \mult1:mult8|mult3|tbm2|ha1|S~combout\);

-- Location: FF_X25_Y20_N19
\mult1:mult8|mult3|tbm2|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm2|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm2|S\(1));

-- Location: LCCOMB_X25_Y20_N20
\mult1:mult8|mult3|cla1|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|c2~0_combout\ = (\mult1:mult8|mult3|tbm3|S\(1) & ((\mult1:mult8|mult3|tbm2|S\(1)) # ((\mult1:mult8|mult3|tbm3|S\(0) & \mult1:mult8|mult3|tbm2|S\(0))))) # (!\mult1:mult8|mult3|tbm3|S\(1) & (\mult1:mult8|mult3|tbm3|S\(0) & 
-- (\mult1:mult8|mult3|tbm2|S\(0) & \mult1:mult8|mult3|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm3|S\(1),
	datab => \mult1:mult8|mult3|tbm3|S\(0),
	datac => \mult1:mult8|mult3|tbm2|S\(0),
	datad => \mult1:mult8|mult3|tbm2|S\(1),
	combout => \mult1:mult8|mult3|cla1|c2~0_combout\);

-- Location: IOIBUF_X26_Y31_N8
\B[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(7),
	o => \B[7]~input_o\);

-- Location: LCCOMB_X27_Y20_N12
\mult1:mult8|mult3|tbm3|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm3|ha2|S~0_combout\ = (\A[1]~input_o\ & (\B[7]~input_o\ & ((!\B[6]~input_o\) # (!\A[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[7]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm3|ha2|S~0_combout\);

-- Location: FF_X27_Y20_N13
\mult1:mult8|mult3|tbm3|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm3|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm3|S\(2));

-- Location: LCCOMB_X27_Y20_N24
\mult1:mult8|mult3|tbm1|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm1|and4~combout\ = (\A[2]~input_o\ & \B[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \A[2]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm1|and4~combout\);

-- Location: FF_X27_Y20_N25
\mult1:mult8|mult3|tbm1|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm1|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm1|S\(0));

-- Location: LCCOMB_X26_Y20_N20
\mult1:mult8|mult3|cla2|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA3|P~combout\ = \mult1:mult8|mult3|tbm2|S\(2) $ (\mult1:mult8|mult3|cla1|c2~0_combout\ $ (\mult1:mult8|mult3|tbm3|S\(2) $ (\mult1:mult8|mult3|tbm1|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(2),
	datab => \mult1:mult8|mult3|cla1|c2~0_combout\,
	datac => \mult1:mult8|mult3|tbm3|S\(2),
	datad => \mult1:mult8|mult3|tbm1|S\(0),
	combout => \mult1:mult8|mult3|cla2|PFA3|P~combout\);

-- Location: LCCOMB_X25_Y20_N16
\mult1:mult8|mult3|cla1|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|PFA1|G~combout\ = (\mult1:mult8|mult3|tbm3|S\(0) & \mult1:mult8|mult3|tbm2|S\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|tbm3|S\(0),
	datad => \mult1:mult8|mult3|tbm2|S\(0),
	combout => \mult1:mult8|mult3|cla1|PFA1|G~combout\);

-- Location: LCCOMB_X25_Y20_N24
\mult1:mult8|mult3|cla2|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA1|G~combout\ = (\mult1:mult8|mult3|tbm4|S\(2) & (\mult1:mult8|mult3|tbm3|S\(0) $ (\mult1:mult8|mult3|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(2),
	datac => \mult1:mult8|mult3|tbm3|S\(0),
	datad => \mult1:mult8|mult3|tbm2|S\(0),
	combout => \mult1:mult8|mult3|cla2|PFA1|G~combout\);

-- Location: LCCOMB_X25_Y20_N4
\mult1:mult8|mult3|tbm3|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm3|ha1|S~combout\ = (\B[7]~input_o\ & (\A[0]~input_o\ $ (((\B[6]~input_o\ & \A[1]~input_o\))))) # (!\B[7]~input_o\ & (\B[6]~input_o\ & ((\A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[7]~input_o\,
	datab => \B[6]~input_o\,
	datac => \A[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \mult1:mult8|mult3|tbm3|ha1|S~combout\);

-- Location: FF_X25_Y20_N5
\mult1:mult8|mult3|tbm3|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm3|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm3|S\(1));

-- Location: LCCOMB_X25_Y20_N2
\mult1:mult8|mult3|cla1|PFA2|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|PFA2|P~combout\ = \mult1:mult8|mult3|tbm3|S\(1) $ (\mult1:mult8|mult3|tbm2|S\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|tbm3|S\(1),
	datad => \mult1:mult8|mult3|tbm2|S\(1),
	combout => \mult1:mult8|mult3|cla1|PFA2|P~combout\);

-- Location: LCCOMB_X25_Y20_N0
\mult1:mult8|mult3|cla2|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|c2~0_combout\ = (\mult1:mult8|mult3|tbm4|S\(3) & ((\mult1:mult8|mult3|cla2|PFA1|G~combout\) # (\mult1:mult8|mult3|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult3|cla1|PFA2|P~combout\)))) # (!\mult1:mult8|mult3|tbm4|S\(3) & 
-- (\mult1:mult8|mult3|cla2|PFA1|G~combout\ & (\mult1:mult8|mult3|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult3|cla1|PFA2|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(3),
	datab => \mult1:mult8|mult3|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult3|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult3|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult3|cla2|c2~0_combout\);

-- Location: LCCOMB_X25_Y19_N28
\mult1:mult8|mult3|cla2|PFA3|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA3|S~combout\ = \mult1:mult8|mult3|cla2|PFA3|P~combout\ $ (\mult1:mult8|mult3|cla2|c2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|cla2|PFA3|P~combout\,
	datad => \mult1:mult8|mult3|cla2|c2~0_combout\,
	combout => \mult1:mult8|mult3|cla2|PFA3|S~combout\);

-- Location: FF_X25_Y19_N29
\mult1:mult8|mult3|S[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|cla2|PFA3|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(4));

-- Location: LCCOMB_X25_Y19_N16
\mult1:mult8|cla1|h_sum[4]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(4) = \mult1:mult8|mult2|S\(4) $ (\mult1:mult8|mult3|S\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|S\(4),
	datad => \mult1:mult8|mult3|S\(4),
	combout => \mult1:mult8|cla1|h_sum\(4));

-- Location: LCCOMB_X25_Y20_N30
\mult1:mult8|mult3|cla2|PFA2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA2|S~combout\ = \mult1:mult8|mult3|tbm4|S\(3) $ (\mult1:mult8|mult3|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult3|cla2|PFA1|G~combout\ $ (\mult1:mult8|mult3|cla1|PFA2|P~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(3),
	datab => \mult1:mult8|mult3|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult3|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult3|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult3|cla2|PFA2|S~combout\);

-- Location: FF_X25_Y20_N31
\mult1:mult8|mult3|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|cla2|PFA2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(3));

-- Location: IOIBUF_X33_Y24_N1
\A[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

-- Location: IOIBUF_X33_Y25_N8
\A[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

-- Location: LCCOMB_X27_Y21_N30
\mult1:mult8|mult2|tbm2|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm2|ha1|S~combout\ = (\B[1]~input_o\ & (\A[6]~input_o\ $ (((\B[0]~input_o\ & \A[7]~input_o\))))) # (!\B[1]~input_o\ & (\B[0]~input_o\ & ((\A[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm2|ha1|S~combout\);

-- Location: FF_X26_Y21_N31
\mult1:mult8|mult2|tbm2|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm2|ha1|S~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm2|S\(1));

-- Location: LCCOMB_X26_Y22_N28
\mult1:mult8|mult2|tbm3|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm3|ha1|S~combout\ = (\A[4]~input_o\ & (\B[3]~input_o\ $ (((\A[5]~input_o\ & \B[2]~input_o\))))) # (!\A[4]~input_o\ & (((\A[5]~input_o\ & \B[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \B[3]~input_o\,
	datac => \A[5]~input_o\,
	datad => \B[2]~input_o\,
	combout => \mult1:mult8|mult2|tbm3|ha1|S~combout\);

-- Location: FF_X26_Y21_N1
\mult1:mult8|mult2|tbm3|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm3|ha1|S~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm3|S\(1));

-- Location: LCCOMB_X26_Y21_N2
\mult1:mult8|mult2|cla1|PFA2|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|PFA2|P~combout\ = \mult1:mult8|mult2|tbm2|S\(1) $ (\mult1:mult8|mult2|tbm3|S\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|tbm2|S\(1),
	datad => \mult1:mult8|mult2|tbm3|S\(1),
	combout => \mult1:mult8|mult2|cla1|PFA2|P~combout\);

-- Location: LCCOMB_X27_Y21_N4
\mult1:mult8|mult2|tbm2|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm2|and4~combout\ = (\A[6]~input_o\ & \B[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datac => \B[0]~input_o\,
	combout => \mult1:mult8|mult2|tbm2|and4~combout\);

-- Location: FF_X27_Y21_N5
\mult1:mult8|mult2|tbm2|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm2|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm2|S\(0));

-- Location: LCCOMB_X26_Y21_N4
\mult1:mult8|mult2|cla2|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA1|G~combout\ = (\mult1:mult8|mult2|tbm4|S\(2) & (\mult1:mult8|mult2|tbm3|S\(0) $ (\mult1:mult8|mult2|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult2|tbm3|S\(0),
	datac => \mult1:mult8|mult2|tbm4|S\(2),
	datad => \mult1:mult8|mult2|tbm2|S\(0),
	combout => \mult1:mult8|mult2|cla2|PFA1|G~combout\);

-- Location: LCCOMB_X26_Y21_N28
\mult1:mult8|mult2|cla1|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|PFA1|G~combout\ = (\mult1:mult8|mult2|tbm3|S\(0) & \mult1:mult8|mult2|tbm2|S\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult2|tbm3|S\(0),
	datad => \mult1:mult8|mult2|tbm2|S\(0),
	combout => \mult1:mult8|mult2|cla1|PFA1|G~combout\);

-- Location: LCCOMB_X26_Y21_N8
\mult1:mult8|mult2|cla2|PFA2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA2|S~combout\ = \mult1:mult8|mult2|tbm4|S\(3) $ (\mult1:mult8|mult2|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult2|cla2|PFA1|G~combout\ $ (\mult1:mult8|mult2|cla1|PFA1|G~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm4|S\(3),
	datab => \mult1:mult8|mult2|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult2|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult2|cla1|PFA1|G~combout\,
	combout => \mult1:mult8|mult2|cla2|PFA2|S~combout\);

-- Location: LCCOMB_X25_Y20_N12
\mult1:mult8|mult2|S[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|S[3]~feeder_combout\ = \mult1:mult8|mult2|cla2|PFA2|S~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \mult1:mult8|mult2|cla2|PFA2|S~combout\,
	combout => \mult1:mult8|mult2|S[3]~feeder_combout\);

-- Location: FF_X25_Y20_N13
\mult1:mult8|mult2|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|S[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(3));

-- Location: LCCOMB_X25_Y20_N8
\mult1:mult8|cla1|h_sum[3]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(3) = \mult1:mult8|mult3|S\(3) $ (\mult1:mult8|mult2|S\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|S\(3),
	datad => \mult1:mult8|mult2|S\(3),
	combout => \mult1:mult8|cla1|h_sum\(3));

-- Location: LCCOMB_X26_Y19_N28
\mult1:mult8|cla2|carry_in_internal[4]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[4]~2_combout\ = (\mult1:mult8|mult4|S\(7) & ((\mult1:mult8|cla2|carry_in_internal[3]~1_combout\) # (\mult1:mult8|cla1|carry_in_internal[3]~1_combout\ $ (\mult1:mult8|cla1|h_sum\(3))))) # (!\mult1:mult8|mult4|S\(7) & 
-- (\mult1:mult8|cla2|carry_in_internal[3]~1_combout\ & (\mult1:mult8|cla1|carry_in_internal[3]~1_combout\ $ (\mult1:mult8|cla1|h_sum\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult4|S\(7),
	datab => \mult1:mult8|cla1|carry_in_internal[3]~1_combout\,
	datac => \mult1:mult8|cla1|h_sum\(3),
	datad => \mult1:mult8|cla2|carry_in_internal[3]~1_combout\,
	combout => \mult1:mult8|cla2|carry_in_internal[4]~2_combout\);

-- Location: LCCOMB_X25_Y19_N24
\mult1:mult8|cla1|carry_in_internal[4]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[4]~2_combout\ = (\mult1:mult8|mult3|S\(3) & ((\mult1:mult8|mult2|S\(3)) # (\mult1:mult8|cla1|carry_in_internal[3]~1_combout\))) # (!\mult1:mult8|mult3|S\(3) & (\mult1:mult8|mult2|S\(3) & 
-- \mult1:mult8|cla1|carry_in_internal[3]~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(3),
	datac => \mult1:mult8|mult2|S\(3),
	datad => \mult1:mult8|cla1|carry_in_internal[3]~1_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[4]~2_combout\);

-- Location: LCCOMB_X27_Y19_N20
\mult1:mult8|cla2|sum[4]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(4) = \mult1:mult8|mult1|S\(0) $ (\mult1:mult8|cla1|h_sum\(4) $ (\mult1:mult8|cla2|carry_in_internal[4]~2_combout\ $ (\mult1:mult8|cla1|carry_in_internal[4]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|S\(0),
	datab => \mult1:mult8|cla1|h_sum\(4),
	datac => \mult1:mult8|cla2|carry_in_internal[4]~2_combout\,
	datad => \mult1:mult8|cla1|carry_in_internal[4]~2_combout\,
	combout => \mult1:mult8|cla2|sum\(4));

-- Location: FF_X27_Y19_N21
\mult1:mult8|S[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(8));

-- Location: LCCOMB_X25_Y22_N22
\mult1:mult8|mult1|tbm4|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm4|ha1|S~combout\ = (\A[5]~input_o\ & (\B[4]~input_o\ $ (((\A[4]~input_o\ & \B[5]~input_o\))))) # (!\A[5]~input_o\ & (\A[4]~input_o\ & (\B[5]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[5]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult1|tbm4|ha1|S~combout\);

-- Location: FF_X25_Y22_N23
\mult1:mult8|mult1|tbm4|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm4|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm4|S\(1));

-- Location: FF_X26_Y19_N7
\mult1:mult8|mult1|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult1|tbm4|S\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(1));

-- Location: LCCOMB_X25_Y22_N0
\mult1:mult8|mult2|tbm2|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm2|ha2|S~0_combout\ = (\B[1]~input_o\ & (\A[7]~input_o\ & ((!\A[6]~input_o\) # (!\B[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[6]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm2|ha2|S~0_combout\);

-- Location: FF_X26_Y21_N19
\mult1:mult8|mult2|tbm2|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult2|tbm2|ha2|S~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm2|S\(2));

-- Location: LCCOMB_X26_Y21_N30
\mult1:mult8|mult2|cla1|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|c2~0_combout\ = (\mult1:mult8|mult2|tbm3|S\(1) & ((\mult1:mult8|mult2|tbm2|S\(1)) # ((\mult1:mult8|mult2|tbm2|S\(0) & \mult1:mult8|mult2|tbm3|S\(0))))) # (!\mult1:mult8|mult2|tbm3|S\(1) & (\mult1:mult8|mult2|tbm2|S\(0) & 
-- (\mult1:mult8|mult2|tbm2|S\(1) & \mult1:mult8|mult2|tbm3|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm2|S\(0),
	datab => \mult1:mult8|mult2|tbm3|S\(1),
	datac => \mult1:mult8|mult2|tbm2|S\(1),
	datad => \mult1:mult8|mult2|tbm3|S\(0),
	combout => \mult1:mult8|mult2|cla1|c2~0_combout\);

-- Location: LCCOMB_X26_Y21_N6
\mult1:mult8|mult2|tbm3|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm3|ha2|S~0_combout\ = (\B[3]~input_o\ & (\A[5]~input_o\ & ((!\B[2]~input_o\) # (!\A[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[2]~input_o\,
	datad => \A[5]~input_o\,
	combout => \mult1:mult8|mult2|tbm3|ha2|S~0_combout\);

-- Location: FF_X26_Y21_N7
\mult1:mult8|mult2|tbm3|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm3|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm3|S\(2));

-- Location: LCCOMB_X25_Y21_N4
\mult1:mult8|mult2|cla2|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA3|P~combout\ = \mult1:mult8|mult2|tbm1|S\(0) $ (\mult1:mult8|mult2|tbm2|S\(2) $ (\mult1:mult8|mult2|cla1|c2~0_combout\ $ (\mult1:mult8|mult2|tbm3|S\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm1|S\(0),
	datab => \mult1:mult8|mult2|tbm2|S\(2),
	datac => \mult1:mult8|mult2|cla1|c2~0_combout\,
	datad => \mult1:mult8|mult2|tbm3|S\(2),
	combout => \mult1:mult8|mult2|cla2|PFA3|P~combout\);

-- Location: LCCOMB_X26_Y21_N22
\mult1:mult8|mult2|cla2|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|c2~0_combout\ = (\mult1:mult8|mult2|tbm4|S\(3) & ((\mult1:mult8|mult2|cla2|PFA1|G~combout\) # (\mult1:mult8|mult2|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult2|cla1|PFA1|G~combout\)))) # (!\mult1:mult8|mult2|tbm4|S\(3) & 
-- (\mult1:mult8|mult2|cla2|PFA1|G~combout\ & (\mult1:mult8|mult2|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult2|cla1|PFA1|G~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm4|S\(3),
	datab => \mult1:mult8|mult2|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult2|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult2|cla1|PFA1|G~combout\,
	combout => \mult1:mult8|mult2|cla2|c2~0_combout\);

-- Location: LCCOMB_X25_Y19_N26
\mult1:mult8|mult2|cla2|PFA3|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA3|S~combout\ = \mult1:mult8|mult2|cla2|PFA3|P~combout\ $ (\mult1:mult8|mult2|cla2|c2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|cla2|PFA3|P~combout\,
	datad => \mult1:mult8|mult2|cla2|c2~0_combout\,
	combout => \mult1:mult8|mult2|cla2|PFA3|S~combout\);

-- Location: FF_X25_Y19_N27
\mult1:mult8|mult2|S[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|cla2|PFA3|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(4));

-- Location: LCCOMB_X25_Y19_N22
\mult1:mult8|cla1|carry_in_internal[5]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[5]~3_combout\ = (\mult1:mult8|mult3|S\(4) & ((\mult1:mult8|mult2|S\(4)) # (\mult1:mult8|cla1|carry_in_internal[4]~2_combout\))) # (!\mult1:mult8|mult3|S\(4) & (\mult1:mult8|mult2|S\(4) & 
-- \mult1:mult8|cla1|carry_in_internal[4]~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult3|S\(4),
	datac => \mult1:mult8|mult2|S\(4),
	datad => \mult1:mult8|cla1|carry_in_internal[4]~2_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[5]~3_combout\);

-- Location: LCCOMB_X25_Y22_N4
\mult1:mult8|mult1|tbm4|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm4|and4~combout\ = (\A[4]~input_o\ & \B[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[4]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult1|tbm4|and4~combout\);

-- Location: FF_X25_Y22_N5
\mult1:mult8|mult1|tbm4|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm4|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm4|S\(0));

-- Location: FF_X26_Y19_N11
\mult1:mult8|mult1|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult1|tbm4|S\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(0));

-- Location: LCCOMB_X26_Y19_N10
\mult1:mult8|cla2|carry_in_internal[5]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[5]~3_combout\ = (\mult1:mult8|mult1|S\(0) & ((\mult1:mult8|cla2|carry_in_internal[4]~2_combout\) # (\mult1:mult8|cla1|h_sum\(4) $ (\mult1:mult8|cla1|carry_in_internal[4]~2_combout\)))) # (!\mult1:mult8|mult1|S\(0) & 
-- (\mult1:mult8|cla2|carry_in_internal[4]~2_combout\ & (\mult1:mult8|cla1|h_sum\(4) $ (\mult1:mult8|cla1|carry_in_internal[4]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(4),
	datab => \mult1:mult8|cla1|carry_in_internal[4]~2_combout\,
	datac => \mult1:mult8|mult1|S\(0),
	datad => \mult1:mult8|cla2|carry_in_internal[4]~2_combout\,
	combout => \mult1:mult8|cla2|carry_in_internal[5]~3_combout\);

-- Location: LCCOMB_X27_Y19_N30
\mult1:mult8|cla2|sum[5]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(5) = \mult1:mult8|cla1|h_sum\(5) $ (\mult1:mult8|mult1|S\(1) $ (\mult1:mult8|cla1|carry_in_internal[5]~3_combout\ $ (\mult1:mult8|cla2|carry_in_internal[5]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(5),
	datab => \mult1:mult8|mult1|S\(1),
	datac => \mult1:mult8|cla1|carry_in_internal[5]~3_combout\,
	datad => \mult1:mult8|cla2|carry_in_internal[5]~3_combout\,
	combout => \mult1:mult8|cla2|sum\(5));

-- Location: FF_X27_Y19_N31
\mult1:mult8|S[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(9));

-- Location: LCCOMB_X25_Y20_N6
\mult1:mult8|mult3|cla2|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|c3~0_combout\ = (\mult1:mult8|mult3|cla2|PFA1|G~combout\ & (\mult1:mult8|mult3|tbm4|S\(3) $ (\mult1:mult8|mult3|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult3|cla1|PFA2|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm4|S\(3),
	datab => \mult1:mult8|mult3|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult3|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult3|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult3|cla2|c3~0_combout\);

-- Location: LCCOMB_X26_Y20_N24
\mult1:mult8|mult3|cla1|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|c3~0_combout\ = (\mult1:mult8|mult3|tbm2|S\(2) & ((\mult1:mult8|mult3|tbm3|S\(2)) # ((\mult1:mult8|mult3|tbm3|S\(1) & \mult1:mult8|mult3|tbm2|S\(1))))) # (!\mult1:mult8|mult3|tbm2|S\(2) & (\mult1:mult8|mult3|tbm3|S\(1) & 
-- (\mult1:mult8|mult3|tbm3|S\(2) & \mult1:mult8|mult3|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(2),
	datab => \mult1:mult8|mult3|tbm3|S\(1),
	datac => \mult1:mult8|mult3|tbm3|S\(2),
	datad => \mult1:mult8|mult3|tbm2|S\(1),
	combout => \mult1:mult8|mult3|cla1|c3~0_combout\);

-- Location: LCCOMB_X27_Y20_N30
\mult1:mult8|mult3|tbm2|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm2|ha2|S~0_combout\ = (\A[3]~input_o\ & (\B[5]~input_o\ & ((!\B[4]~input_o\) # (!\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[5]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult3|tbm2|ha2|S~0_combout\);

-- Location: FF_X27_Y20_N31
\mult1:mult8|mult3|tbm2|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm2|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm2|S\(2));

-- Location: LCCOMB_X27_Y20_N14
\mult1:mult8|mult3|cla1|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|PFA3|P~combout\ = \mult1:mult8|mult3|tbm2|S\(2) $ (\mult1:mult8|mult3|tbm3|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|tbm2|S\(2),
	datad => \mult1:mult8|mult3|tbm3|S\(2),
	combout => \mult1:mult8|mult3|cla1|PFA3|P~combout\);

-- Location: LCCOMB_X26_Y20_N18
\mult1:mult8|mult3|cla1|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|c3~1_combout\ = (\mult1:mult8|mult3|cla1|c3~0_combout\) # ((\mult1:mult8|mult3|cla1|PFA1|G~combout\ & (\mult1:mult8|mult3|cla1|PFA3|P~combout\ & \mult1:mult8|mult3|cla1|PFA2|P~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|cla1|PFA1|G~combout\,
	datab => \mult1:mult8|mult3|cla1|c3~0_combout\,
	datac => \mult1:mult8|mult3|cla1|PFA3|P~combout\,
	datad => \mult1:mult8|mult3|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult3|cla1|c3~1_combout\);

-- Location: LCCOMB_X27_Y20_N20
\mult1:mult8|mult3|tbm1|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm1|ha1|S~combout\ = (\A[3]~input_o\ & (\B[6]~input_o\ $ (((\B[7]~input_o\ & \A[2]~input_o\))))) # (!\A[3]~input_o\ & (\B[7]~input_o\ & (\A[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[7]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm1|ha1|S~combout\);

-- Location: FF_X27_Y20_N21
\mult1:mult8|mult3|tbm1|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm1|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm1|S\(1));

-- Location: LCCOMB_X27_Y20_N6
\mult1:mult8|mult3|tbm2|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm2|ha2|Cout~0_combout\ = (\A[3]~input_o\ & (\B[5]~input_o\ & (\A[2]~input_o\ & \B[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[5]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult3|tbm2|ha2|Cout~0_combout\);

-- Location: FF_X27_Y20_N7
\mult1:mult8|mult3|tbm2|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm2|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm2|S\(3));

-- Location: LCCOMB_X26_Y20_N0
\mult1:mult8|mult3|cla2|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA4|P~combout\ = \mult1:mult8|mult3|tbm3|S\(3) $ (\mult1:mult8|mult3|cla1|c3~1_combout\ $ (\mult1:mult8|mult3|tbm1|S\(1) $ (\mult1:mult8|mult3|tbm2|S\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm3|S\(3),
	datab => \mult1:mult8|mult3|cla1|c3~1_combout\,
	datac => \mult1:mult8|mult3|tbm1|S\(1),
	datad => \mult1:mult8|mult3|tbm2|S\(3),
	combout => \mult1:mult8|mult3|cla2|PFA4|P~combout\);

-- Location: LCCOMB_X26_Y20_N8
\mult1:mult8|mult3|cla2|PFA4|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla2|PFA4|S~combout\ = \mult1:mult8|mult3|cla2|PFA4|P~combout\ $ (((\mult1:mult8|mult3|cla2|c3~1_combout\) # ((\mult1:mult8|mult3|cla2|PFA3|P~combout\ & \mult1:mult8|mult3|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010111101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|cla2|c3~1_combout\,
	datab => \mult1:mult8|mult3|cla2|PFA3|P~combout\,
	datac => \mult1:mult8|mult3|cla2|c3~0_combout\,
	datad => \mult1:mult8|mult3|cla2|PFA4|P~combout\,
	combout => \mult1:mult8|mult3|cla2|PFA4|S~combout\);

-- Location: FF_X26_Y20_N9
\mult1:mult8|mult3|S[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|cla2|PFA4|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(5));

-- Location: LCCOMB_X25_Y21_N20
\mult1:mult8|mult2|tbm3|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm3|ha2|Cout~0_combout\ = (\A[5]~input_o\ & (\A[4]~input_o\ & (\B[2]~input_o\ & \B[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[2]~input_o\,
	datad => \B[3]~input_o\,
	combout => \mult1:mult8|mult2|tbm3|ha2|Cout~0_combout\);

-- Location: FF_X25_Y21_N21
\mult1:mult8|mult2|tbm3|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm3|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm3|S\(3));

-- Location: LCCOMB_X25_Y22_N20
\mult1:mult8|mult2|tbm2|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm2|ha2|Cout~0_combout\ = (\B[0]~input_o\ & (\A[6]~input_o\ & (\B[1]~input_o\ & \A[7]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[6]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm2|ha2|Cout~0_combout\);

-- Location: FF_X25_Y22_N21
\mult1:mult8|mult2|tbm2|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm2|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm2|S\(3));

-- Location: LCCOMB_X26_Y21_N26
\mult1:mult8|mult2|cla1|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|c3~0_combout\ = (\mult1:mult8|mult2|tbm3|S\(2) & ((\mult1:mult8|mult2|tbm2|S\(2)) # ((\mult1:mult8|mult2|tbm3|S\(1) & \mult1:mult8|mult2|tbm2|S\(1))))) # (!\mult1:mult8|mult2|tbm3|S\(2) & (\mult1:mult8|mult2|tbm3|S\(1) & 
-- (\mult1:mult8|mult2|tbm2|S\(1) & \mult1:mult8|mult2|tbm2|S\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm3|S\(2),
	datab => \mult1:mult8|mult2|tbm3|S\(1),
	datac => \mult1:mult8|mult2|tbm2|S\(1),
	datad => \mult1:mult8|mult2|tbm2|S\(2),
	combout => \mult1:mult8|mult2|cla1|c3~0_combout\);

-- Location: LCCOMB_X26_Y21_N24
\mult1:mult8|mult2|cla1|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|c3~1_combout\ = (\mult1:mult8|mult2|cla1|c3~0_combout\) # ((\mult1:mult8|mult2|cla1|PFA3|P~combout\ & (\mult1:mult8|mult2|cla1|PFA2|P~combout\ & \mult1:mult8|mult2|cla1|PFA1|G~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|cla1|PFA3|P~combout\,
	datab => \mult1:mult8|mult2|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult2|cla1|c3~0_combout\,
	datad => \mult1:mult8|mult2|cla1|PFA1|G~combout\,
	combout => \mult1:mult8|mult2|cla1|c3~1_combout\);

-- Location: LCCOMB_X25_Y21_N14
\mult1:mult8|mult2|cla2|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA4|P~combout\ = \mult1:mult8|mult2|tbm1|S\(1) $ (\mult1:mult8|mult2|tbm3|S\(3) $ (\mult1:mult8|mult2|tbm2|S\(3) $ (\mult1:mult8|mult2|cla1|c3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm1|S\(1),
	datab => \mult1:mult8|mult2|tbm3|S\(3),
	datac => \mult1:mult8|mult2|tbm2|S\(3),
	datad => \mult1:mult8|mult2|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult2|cla2|PFA4|P~combout\);

-- Location: LCCOMB_X26_Y21_N16
\mult1:mult8|mult2|cla2|c3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|c3~0_combout\ = (\mult1:mult8|mult2|cla2|PFA1|G~combout\ & (\mult1:mult8|mult2|tbm4|S\(3) $ (\mult1:mult8|mult2|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult2|cla1|PFA1|G~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm4|S\(3),
	datab => \mult1:mult8|mult2|cla1|PFA2|P~combout\,
	datac => \mult1:mult8|mult2|cla2|PFA1|G~combout\,
	datad => \mult1:mult8|mult2|cla1|PFA1|G~combout\,
	combout => \mult1:mult8|mult2|cla2|c3~0_combout\);

-- Location: LCCOMB_X25_Y21_N0
\mult1:mult8|mult2|cla2|PFA4|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA4|S~combout\ = \mult1:mult8|mult2|cla2|PFA4|P~combout\ $ (((\mult1:mult8|mult2|cla2|c3~1_combout\) # ((\mult1:mult8|mult2|cla2|PFA3|P~combout\ & \mult1:mult8|mult2|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|cla2|c3~1_combout\,
	datab => \mult1:mult8|mult2|cla2|PFA3|P~combout\,
	datac => \mult1:mult8|mult2|cla2|PFA4|P~combout\,
	datad => \mult1:mult8|mult2|cla2|c3~0_combout\,
	combout => \mult1:mult8|mult2|cla2|PFA4|S~combout\);

-- Location: FF_X25_Y21_N1
\mult1:mult8|mult2|S[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|cla2|PFA4|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(5));

-- Location: LCCOMB_X25_Y19_N20
\mult1:mult8|cla1|carry_in_internal[6]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[6]~4_combout\ = (\mult1:mult8|mult2|S\(2) & ((\mult1:mult8|mult3|S\(2)) # (\mult1:mult8|cla1|carry_in_internal[2]~0_combout\))) # (!\mult1:mult8|mult2|S\(2) & (\mult1:mult8|mult3|S\(2) & 
-- \mult1:mult8|cla1|carry_in_internal[2]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|S\(2),
	datab => \mult1:mult8|mult3|S\(2),
	datad => \mult1:mult8|cla1|carry_in_internal[2]~0_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[6]~4_combout\);

-- Location: LCCOMB_X25_Y19_N10
\mult1:mult8|cla1|carry_in_internal[6]~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[6]~5_combout\ = (\mult1:mult8|mult3|S\(3) & ((\mult1:mult8|mult2|S\(3)) # (\mult1:mult8|cla1|carry_in_internal[6]~4_combout\))) # (!\mult1:mult8|mult3|S\(3) & (\mult1:mult8|mult2|S\(3) & 
-- \mult1:mult8|cla1|carry_in_internal[6]~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(3),
	datac => \mult1:mult8|mult2|S\(3),
	datad => \mult1:mult8|cla1|carry_in_internal[6]~4_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[6]~5_combout\);

-- Location: LCCOMB_X25_Y19_N0
\mult1:mult8|cla1|carry_in_internal[6]~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[6]~6_combout\ = (\mult1:mult8|mult3|S\(4) & ((\mult1:mult8|mult2|S\(4)) # (\mult1:mult8|cla1|carry_in_internal[6]~5_combout\))) # (!\mult1:mult8|mult3|S\(4) & (\mult1:mult8|mult2|S\(4) & 
-- \mult1:mult8|cla1|carry_in_internal[6]~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult3|S\(4),
	datac => \mult1:mult8|mult2|S\(4),
	datad => \mult1:mult8|cla1|carry_in_internal[6]~5_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[6]~6_combout\);

-- Location: LCCOMB_X25_Y19_N2
\mult1:mult8|cla1|carry_in_internal[6]~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[6]~7_combout\ = (\mult1:mult8|mult3|S\(5) & ((\mult1:mult8|mult2|S\(5)) # (\mult1:mult8|cla1|carry_in_internal[6]~6_combout\))) # (!\mult1:mult8|mult3|S\(5) & (\mult1:mult8|mult2|S\(5) & 
-- \mult1:mult8|cla1|carry_in_internal[6]~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult3|S\(5),
	datac => \mult1:mult8|mult2|S\(5),
	datad => \mult1:mult8|cla1|carry_in_internal[6]~6_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[6]~7_combout\);

-- Location: LCCOMB_X27_Y20_N4
\mult1:mult8|mult3|tbm3|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm3|ha2|Cout~0_combout\ = (\A[1]~input_o\ & (\A[0]~input_o\ & (\B[7]~input_o\ & \B[6]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[7]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm3|ha2|Cout~0_combout\);

-- Location: FF_X27_Y20_N5
\mult1:mult8|mult3|tbm3|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm3|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm3|S\(3));

-- Location: LCCOMB_X26_Y20_N16
\mult1:mult8|mult3|cla1|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|cla1|Cout~0_combout\ = (\mult1:mult8|mult3|tbm2|S\(3) & ((\mult1:mult8|mult3|tbm3|S\(3)) # ((\mult1:mult8|mult3|tbm3|S\(2) & \mult1:mult8|mult3|tbm2|S\(2))))) # (!\mult1:mult8|mult3|tbm2|S\(3) & (\mult1:mult8|mult3|tbm3|S\(2) & 
-- (\mult1:mult8|mult3|tbm2|S\(2) & \mult1:mult8|mult3|tbm3|S\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(3),
	datab => \mult1:mult8|mult3|tbm3|S\(2),
	datac => \mult1:mult8|mult3|tbm2|S\(2),
	datad => \mult1:mult8|mult3|tbm3|S\(3),
	combout => \mult1:mult8|mult3|cla1|Cout~0_combout\);

-- Location: LCCOMB_X25_Y20_N28
\mult1:mult8|mult3|or2bit~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|or2bit~1_combout\ = (\mult1:mult8|mult3|tbm3|S\(1) & ((\mult1:mult8|mult3|tbm2|S\(1)) # ((\mult1:mult8|mult3|tbm2|S\(0) & \mult1:mult8|mult3|tbm3|S\(0))))) # (!\mult1:mult8|mult3|tbm3|S\(1) & (\mult1:mult8|mult3|tbm2|S\(0) & 
-- (\mult1:mult8|mult3|tbm3|S\(0) & \mult1:mult8|mult3|tbm2|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm3|S\(1),
	datab => \mult1:mult8|mult3|tbm2|S\(0),
	datac => \mult1:mult8|mult3|tbm3|S\(0),
	datad => \mult1:mult8|mult3|tbm2|S\(1),
	combout => \mult1:mult8|mult3|or2bit~1_combout\);

-- Location: LCCOMB_X27_Y20_N8
\mult1:mult8|mult3|or2bit~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|or2bit~2_combout\ = (\mult1:mult8|mult3|cla1|PFA3|P~combout\ & (\mult1:mult8|mult3|or2bit~1_combout\ & (\mult1:mult8|mult3|tbm2|S\(3) $ (\mult1:mult8|mult3|tbm3|S\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|tbm2|S\(3),
	datab => \mult1:mult8|mult3|tbm3|S\(3),
	datac => \mult1:mult8|mult3|cla1|PFA3|P~combout\,
	datad => \mult1:mult8|mult3|or2bit~1_combout\,
	combout => \mult1:mult8|mult3|or2bit~2_combout\);

-- Location: LCCOMB_X26_Y20_N2
\mult1:mult8|mult3|or2bit~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|or2bit~0_combout\ = (\mult1:mult8|mult3|cla2|PFA3|P~combout\ & (\mult1:mult8|mult3|cla2|PFA4|P~combout\ & ((\mult1:mult8|mult3|cla2|PFA2|G~combout\) # (\mult1:mult8|mult3|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|cla2|PFA2|G~combout\,
	datab => \mult1:mult8|mult3|cla2|PFA3|P~combout\,
	datac => \mult1:mult8|mult3|cla2|c3~0_combout\,
	datad => \mult1:mult8|mult3|cla2|PFA4|P~combout\,
	combout => \mult1:mult8|mult3|or2bit~0_combout\);

-- Location: LCCOMB_X26_Y20_N14
\mult1:mult8|mult3|or2bit~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|or2bit~3_combout\ = (\mult1:mult8|mult3|cla2|Cout~0_combout\) # ((\mult1:mult8|mult3|cla1|Cout~0_combout\) # ((\mult1:mult8|mult3|or2bit~2_combout\) # (\mult1:mult8|mult3|or2bit~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|cla2|Cout~0_combout\,
	datab => \mult1:mult8|mult3|cla1|Cout~0_combout\,
	datac => \mult1:mult8|mult3|or2bit~2_combout\,
	datad => \mult1:mult8|mult3|or2bit~0_combout\,
	combout => \mult1:mult8|mult3|or2bit~3_combout\);

-- Location: LCCOMB_X27_Y20_N18
\mult1:mult8|mult3|tbm1|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|tbm1|ha2|S~0_combout\ = (\A[3]~input_o\ & (\B[7]~input_o\ & ((!\B[6]~input_o\) # (!\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[7]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult3|tbm1|ha2|S~0_combout\);

-- Location: FF_X27_Y20_N19
\mult1:mult8|mult3|tbm1|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|tbm1|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|tbm1|S\(2));

-- Location: LCCOMB_X26_Y20_N12
\mult1:mult8|mult3|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult3|ha1|S~combout\ = \mult1:mult8|mult3|or2bit~3_combout\ $ (\mult1:mult8|mult3|tbm1|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|or2bit~3_combout\,
	datad => \mult1:mult8|mult3|tbm1|S\(2),
	combout => \mult1:mult8|mult3|ha1|S~combout\);

-- Location: FF_X26_Y20_N13
\mult1:mult8|mult3|S[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult3|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult3|S\(6));

-- Location: LCCOMB_X25_Y21_N8
\mult1:mult8|mult2|tbm1|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|tbm1|ha2|S~0_combout\ = (\B[3]~input_o\ & (\A[7]~input_o\ & ((!\B[2]~input_o\) # (!\A[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult2|tbm1|ha2|S~0_combout\);

-- Location: FF_X25_Y21_N9
\mult1:mult8|mult2|tbm1|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|tbm1|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|tbm1|S\(2));

-- Location: LCCOMB_X25_Y21_N18
\mult1:mult8|mult2|cla2|PFA3|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|PFA3|G~combout\ = (\mult1:mult8|mult2|tbm1|S\(0) & (\mult1:mult8|mult2|tbm2|S\(2) $ (\mult1:mult8|mult2|cla1|c2~0_combout\ $ (\mult1:mult8|mult2|tbm3|S\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm1|S\(0),
	datab => \mult1:mult8|mult2|tbm2|S\(2),
	datac => \mult1:mult8|mult2|cla1|c2~0_combout\,
	datad => \mult1:mult8|mult2|tbm3|S\(2),
	combout => \mult1:mult8|mult2|cla2|PFA3|G~combout\);

-- Location: LCCOMB_X24_Y21_N26
\mult1:mult8|mult2|cla1|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|PFA4|P~combout\ = \mult1:mult8|mult2|tbm3|S\(3) $ (\mult1:mult8|mult2|tbm2|S\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|tbm3|S\(3),
	datad => \mult1:mult8|mult2|tbm2|S\(3),
	combout => \mult1:mult8|mult2|cla1|PFA4|P~combout\);

-- Location: LCCOMB_X25_Y21_N16
\mult1:mult8|mult2|cla2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla2|Cout~0_combout\ = (\mult1:mult8|mult2|tbm1|S\(1) & ((\mult1:mult8|mult2|cla2|PFA3|G~combout\) # (\mult1:mult8|mult2|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult2|cla1|c3~1_combout\)))) # (!\mult1:mult8|mult2|tbm1|S\(1) & 
-- (\mult1:mult8|mult2|cla2|PFA3|G~combout\ & (\mult1:mult8|mult2|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult2|cla1|c3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm1|S\(1),
	datab => \mult1:mult8|mult2|cla2|PFA3|G~combout\,
	datac => \mult1:mult8|mult2|cla1|PFA4|P~combout\,
	datad => \mult1:mult8|mult2|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult2|cla2|Cout~0_combout\);

-- Location: LCCOMB_X26_Y21_N12
\mult1:mult8|mult2|cla1|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|cla1|PFA3|P~combout\ = \mult1:mult8|mult2|tbm2|S\(2) $ (\mult1:mult8|mult2|tbm3|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult2|tbm2|S\(2),
	datad => \mult1:mult8|mult2|tbm3|S\(2),
	combout => \mult1:mult8|mult2|cla1|PFA3|P~combout\);

-- Location: LCCOMB_X26_Y21_N14
\mult1:mult8|mult2|or2bit~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|or2bit~1_combout\ = (\mult1:mult8|mult2|tbm2|S\(1) & ((\mult1:mult8|mult2|tbm3|S\(1)) # ((\mult1:mult8|mult2|tbm2|S\(0) & \mult1:mult8|mult2|tbm3|S\(0))))) # (!\mult1:mult8|mult2|tbm2|S\(1) & (\mult1:mult8|mult2|tbm2|S\(0) & 
-- (\mult1:mult8|mult2|tbm3|S\(0) & \mult1:mult8|mult2|tbm3|S\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm2|S\(0),
	datab => \mult1:mult8|mult2|tbm3|S\(0),
	datac => \mult1:mult8|mult2|tbm2|S\(1),
	datad => \mult1:mult8|mult2|tbm3|S\(1),
	combout => \mult1:mult8|mult2|or2bit~1_combout\);

-- Location: LCCOMB_X24_Y21_N16
\mult1:mult8|mult2|or2bit~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|or2bit~2_combout\ = (\mult1:mult8|mult2|cla1|PFA3|P~combout\ & (\mult1:mult8|mult2|or2bit~1_combout\ & (\mult1:mult8|mult2|tbm2|S\(3) $ (\mult1:mult8|mult2|tbm3|S\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm2|S\(3),
	datab => \mult1:mult8|mult2|cla1|PFA3|P~combout\,
	datac => \mult1:mult8|mult2|tbm3|S\(3),
	datad => \mult1:mult8|mult2|or2bit~1_combout\,
	combout => \mult1:mult8|mult2|or2bit~2_combout\);

-- Location: LCCOMB_X25_Y21_N2
\mult1:mult8|mult2|or2bit~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|or2bit~0_combout\ = (\mult1:mult8|mult2|cla2|PFA3|P~combout\ & (\mult1:mult8|mult2|cla2|PFA4|P~combout\ & ((\mult1:mult8|mult2|cla2|PFA2|G~combout\) # (\mult1:mult8|mult2|cla2|c3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|cla2|PFA2|G~combout\,
	datab => \mult1:mult8|mult2|cla2|PFA3|P~combout\,
	datac => \mult1:mult8|mult2|cla2|PFA4|P~combout\,
	datad => \mult1:mult8|mult2|cla2|c3~0_combout\,
	combout => \mult1:mult8|mult2|or2bit~0_combout\);

-- Location: LCCOMB_X25_Y21_N24
\mult1:mult8|mult2|or2bit~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|or2bit~3_combout\ = (\mult1:mult8|mult2|cla1|Cout~0_combout\) # ((\mult1:mult8|mult2|cla2|Cout~0_combout\) # ((\mult1:mult8|mult2|or2bit~2_combout\) # (\mult1:mult8|mult2|or2bit~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|cla1|Cout~0_combout\,
	datab => \mult1:mult8|mult2|cla2|Cout~0_combout\,
	datac => \mult1:mult8|mult2|or2bit~2_combout\,
	datad => \mult1:mult8|mult2|or2bit~0_combout\,
	combout => \mult1:mult8|mult2|or2bit~3_combout\);

-- Location: LCCOMB_X25_Y21_N10
\mult1:mult8|mult2|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|ha1|S~combout\ = \mult1:mult8|mult2|tbm1|S\(2) $ (\mult1:mult8|mult2|or2bit~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult2|tbm1|S\(2),
	datad => \mult1:mult8|mult2|or2bit~3_combout\,
	combout => \mult1:mult8|mult2|ha1|S~combout\);

-- Location: FF_X25_Y21_N11
\mult1:mult8|mult2|S[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(6));

-- Location: LCCOMB_X27_Y19_N8
\mult1:mult8|cla1|h_sum[6]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|h_sum\(6) = \mult1:mult8|mult3|S\(6) $ (\mult1:mult8|mult2|S\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult3|S\(6),
	datad => \mult1:mult8|mult2|S\(6),
	combout => \mult1:mult8|cla1|h_sum\(6));

-- Location: LCCOMB_X26_Y19_N6
\mult1:mult8|cla2|carry_in_internal[6]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[6]~4_combout\ = (\mult1:mult8|mult1|S\(1) & ((\mult1:mult8|cla2|carry_in_internal[5]~3_combout\) # (\mult1:mult8|cla1|h_sum\(5) $ (\mult1:mult8|cla1|carry_in_internal[5]~3_combout\)))) # (!\mult1:mult8|mult1|S\(1) & 
-- (\mult1:mult8|cla2|carry_in_internal[5]~3_combout\ & (\mult1:mult8|cla1|h_sum\(5) $ (\mult1:mult8|cla1|carry_in_internal[5]~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(5),
	datab => \mult1:mult8|cla1|carry_in_internal[5]~3_combout\,
	datac => \mult1:mult8|mult1|S\(1),
	datad => \mult1:mult8|cla2|carry_in_internal[5]~3_combout\,
	combout => \mult1:mult8|cla2|carry_in_internal[6]~4_combout\);

-- Location: LCCOMB_X25_Y19_N8
\mult1:mult8|cla2|sum[6]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(6) = \mult1:mult8|mult1|S\(2) $ (\mult1:mult8|cla1|carry_in_internal[6]~7_combout\ $ (\mult1:mult8|cla1|h_sum\(6) $ (\mult1:mult8|cla2|carry_in_internal[6]~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|S\(2),
	datab => \mult1:mult8|cla1|carry_in_internal[6]~7_combout\,
	datac => \mult1:mult8|cla1|h_sum\(6),
	datad => \mult1:mult8|cla2|carry_in_internal[6]~4_combout\,
	combout => \mult1:mult8|cla2|sum\(6));

-- Location: FF_X25_Y19_N9
\mult1:mult8|S[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(10));

-- Location: LCCOMB_X25_Y22_N6
\mult1:mult8|mult1|tbm4|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm4|ha2|Cout~0_combout\ = (\A[5]~input_o\ & (\A[4]~input_o\ & (\B[5]~input_o\ & \B[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[5]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult1|tbm4|ha2|Cout~0_combout\);

-- Location: FF_X25_Y22_N7
\mult1:mult8|mult1|tbm4|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm4|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm4|S\(3));

-- Location: LCCOMB_X26_Y22_N18
\mult1:mult8|mult1|tbm3|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm3|and4~combout\ = (\A[4]~input_o\ & \B[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm3|and4~combout\);

-- Location: FF_X26_Y22_N5
\mult1:mult8|mult1|tbm3|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult1|tbm3|and4~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm3|S\(0));

-- Location: LCCOMB_X25_Y22_N24
\mult1:mult8|mult1|tbm2|and4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm2|and4~combout\ = (\B[4]~input_o\ & \A[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[4]~input_o\,
	datac => \A[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm2|and4~combout\);

-- Location: FF_X25_Y22_N25
\mult1:mult8|mult1|tbm2|S[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm2|and4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm2|S\(0));

-- Location: LCCOMB_X26_Y22_N8
\mult1:mult8|mult1|cla1|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|PFA1|G~combout\ = (\mult1:mult8|mult1|tbm3|S\(0) & \mult1:mult8|mult1|tbm2|S\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult1|tbm3|S\(0),
	datad => \mult1:mult8|mult1|tbm2|S\(0),
	combout => \mult1:mult8|mult1|cla1|PFA1|G~combout\);

-- Location: LCCOMB_X26_Y22_N30
\mult1:mult8|mult1|cla2|PFA1|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA1|G~combout\ = (\mult1:mult8|mult1|tbm4|S\(2) & (\mult1:mult8|mult1|tbm3|S\(0) $ (\mult1:mult8|mult1|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm4|S\(2),
	datab => \mult1:mult8|mult1|tbm3|S\(0),
	datad => \mult1:mult8|mult1|tbm2|S\(0),
	combout => \mult1:mult8|mult1|cla2|PFA1|G~combout\);

-- Location: LCCOMB_X26_Y22_N16
\mult1:mult8|mult1|cla2|PFA2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA2|S~combout\ = \mult1:mult8|mult1|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult1|tbm4|S\(3) $ (\mult1:mult8|mult1|cla1|PFA1|G~combout\ $ (\mult1:mult8|mult1|cla2|PFA1|G~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla1|PFA2|P~combout\,
	datab => \mult1:mult8|mult1|tbm4|S\(3),
	datac => \mult1:mult8|mult1|cla1|PFA1|G~combout\,
	datad => \mult1:mult8|mult1|cla2|PFA1|G~combout\,
	combout => \mult1:mult8|mult1|cla2|PFA2|S~combout\);

-- Location: FF_X26_Y22_N17
\mult1:mult8|mult1|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|cla2|PFA2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(3));

-- Location: LCCOMB_X25_Y19_N12
\mult1:mult8|cla1|carry_in_internal[7]~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_in_internal[7]~8_combout\ = (\mult1:mult8|mult3|S\(6) & ((\mult1:mult8|mult2|S\(6)) # (\mult1:mult8|cla1|carry_in_internal[6]~7_combout\))) # (!\mult1:mult8|mult3|S\(6) & (\mult1:mult8|mult2|S\(6) & 
-- \mult1:mult8|cla1|carry_in_internal[6]~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(6),
	datac => \mult1:mult8|mult2|S\(6),
	datad => \mult1:mult8|cla1|carry_in_internal[6]~7_combout\,
	combout => \mult1:mult8|cla1|carry_in_internal[7]~8_combout\);

-- Location: LCCOMB_X25_Y22_N2
\mult1:mult8|mult1|tbm4|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm4|ha2|S~0_combout\ = (\A[5]~input_o\ & (\B[5]~input_o\ & ((!\B[4]~input_o\) # (!\A[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \A[4]~input_o\,
	datac => \B[5]~input_o\,
	datad => \B[4]~input_o\,
	combout => \mult1:mult8|mult1|tbm4|ha2|S~0_combout\);

-- Location: FF_X25_Y22_N3
\mult1:mult8|mult1|tbm4|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm4|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm4|S\(2));

-- Location: LCCOMB_X25_Y22_N16
\mult1:mult8|mult1|cla2|PFA1|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA1|P~combout\ = \mult1:mult8|mult1|tbm3|S\(0) $ (\mult1:mult8|mult1|tbm4|S\(2) $ (\mult1:mult8|mult1|tbm2|S\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011010010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm3|S\(0),
	datab => \mult1:mult8|mult1|tbm4|S\(2),
	datac => \mult1:mult8|mult1|tbm2|S\(0),
	combout => \mult1:mult8|mult1|cla2|PFA1|P~combout\);

-- Location: FF_X25_Y22_N17
\mult1:mult8|mult1|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|cla2|PFA1|P~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(2));

-- Location: LCCOMB_X26_Y19_N8
\mult1:mult8|cla2|carry_in_internal[7]~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_in_internal[7]~5_combout\ = (\mult1:mult8|mult1|S\(2) & ((\mult1:mult8|cla2|carry_in_internal[6]~4_combout\) # (\mult1:mult8|cla1|carry_in_internal[6]~7_combout\ $ (\mult1:mult8|cla1|h_sum\(6))))) # (!\mult1:mult8|mult1|S\(2) & 
-- (\mult1:mult8|cla2|carry_in_internal[6]~4_combout\ & (\mult1:mult8|cla1|carry_in_internal[6]~7_combout\ $ (\mult1:mult8|cla1|h_sum\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|carry_in_internal[6]~7_combout\,
	datab => \mult1:mult8|mult1|S\(2),
	datac => \mult1:mult8|cla1|h_sum\(6),
	datad => \mult1:mult8|cla2|carry_in_internal[6]~4_combout\,
	combout => \mult1:mult8|cla2|carry_in_internal[7]~5_combout\);

-- Location: LCCOMB_X26_Y19_N30
\mult1:mult8|cla2|sum[7]\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|sum\(7) = \mult1:mult8|cla1|h_sum\(7) $ (\mult1:mult8|mult1|S\(3) $ (\mult1:mult8|cla1|carry_in_internal[7]~8_combout\ $ (\mult1:mult8|cla2|carry_in_internal[7]~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(7),
	datab => \mult1:mult8|mult1|S\(3),
	datac => \mult1:mult8|cla1|carry_in_internal[7]~8_combout\,
	datad => \mult1:mult8|cla2|carry_in_internal[7]~5_combout\,
	combout => \mult1:mult8|cla2|sum\(7));

-- Location: FF_X26_Y19_N31
\mult1:mult8|S[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|cla2|sum\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(11));

-- Location: LCCOMB_X26_Y22_N24
\mult1:mult8|mult1|cla2|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|c2~0_combout\ = (\mult1:mult8|mult1|tbm4|S\(3) & ((\mult1:mult8|mult1|cla2|PFA1|G~combout\) # (\mult1:mult8|mult1|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult1|cla1|PFA1|G~combout\)))) # (!\mult1:mult8|mult1|tbm4|S\(3) & 
-- (\mult1:mult8|mult1|cla2|PFA1|G~combout\ & (\mult1:mult8|mult1|cla1|PFA2|P~combout\ $ (\mult1:mult8|mult1|cla1|PFA1|G~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla1|PFA2|P~combout\,
	datab => \mult1:mult8|mult1|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult1|tbm4|S\(3),
	datad => \mult1:mult8|mult1|cla2|PFA1|G~combout\,
	combout => \mult1:mult8|mult1|cla2|c2~0_combout\);

-- Location: LCCOMB_X26_Y23_N30
\mult1:mult8|mult1|tbm3|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm3|ha2|S~0_combout\ = (\A[5]~input_o\ & (\B[7]~input_o\ & ((!\B[6]~input_o\) # (!\A[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \A[5]~input_o\,
	datac => \B[7]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm3|ha2|S~0_combout\);

-- Location: FF_X26_Y22_N31
\mult1:mult8|mult1|tbm3|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult1|tbm3|ha2|S~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm3|S\(2));

-- Location: LCCOMB_X25_Y22_N18
\mult1:mult8|mult1|tbm2|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm2|ha2|S~0_combout\ = (\B[5]~input_o\ & (\A[7]~input_o\ & ((!\A[6]~input_o\) # (!\B[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[5]~input_o\,
	datab => \B[4]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm2|ha2|S~0_combout\);

-- Location: FF_X25_Y22_N19
\mult1:mult8|mult1|tbm2|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm2|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm2|S\(2));

-- Location: LCCOMB_X26_Y23_N4
\mult1:mult8|mult1|tbm3|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm3|ha1|S~combout\ = (\A[4]~input_o\ & (\B[7]~input_o\ $ (((\A[5]~input_o\ & \B[6]~input_o\))))) # (!\A[4]~input_o\ & (\A[5]~input_o\ & ((\B[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \A[5]~input_o\,
	datac => \B[7]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm3|ha1|S~combout\);

-- Location: FF_X26_Y22_N19
\mult1:mult8|mult1|tbm3|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \mult1:mult8|mult1|tbm3|ha1|S~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm3|S\(1));

-- Location: LCCOMB_X26_Y22_N10
\mult1:mult8|mult1|cla1|c2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|c2~0_combout\ = (\mult1:mult8|mult1|tbm2|S\(1) & ((\mult1:mult8|mult1|tbm3|S\(1)) # ((\mult1:mult8|mult1|tbm3|S\(0) & \mult1:mult8|mult1|tbm2|S\(0))))) # (!\mult1:mult8|mult1|tbm2|S\(1) & (\mult1:mult8|mult1|tbm3|S\(1) & 
-- (\mult1:mult8|mult1|tbm3|S\(0) & \mult1:mult8|mult1|tbm2|S\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm2|S\(1),
	datab => \mult1:mult8|mult1|tbm3|S\(1),
	datac => \mult1:mult8|mult1|tbm3|S\(0),
	datad => \mult1:mult8|mult1|tbm2|S\(0),
	combout => \mult1:mult8|mult1|cla1|c2~0_combout\);

-- Location: LCCOMB_X27_Y22_N16
\mult1:mult8|mult1|cla2|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA3|P~combout\ = \mult1:mult8|mult1|tbm1|S\(0) $ (\mult1:mult8|mult1|tbm3|S\(2) $ (\mult1:mult8|mult1|tbm2|S\(2) $ (\mult1:mult8|mult1|cla1|c2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm1|S\(0),
	datab => \mult1:mult8|mult1|tbm3|S\(2),
	datac => \mult1:mult8|mult1|tbm2|S\(2),
	datad => \mult1:mult8|mult1|cla1|c2~0_combout\,
	combout => \mult1:mult8|mult1|cla2|PFA3|P~combout\);

-- Location: LCCOMB_X26_Y22_N26
\mult1:mult8|mult1|cla2|PFA3|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA3|S~combout\ = \mult1:mult8|mult1|cla2|c2~0_combout\ $ (\mult1:mult8|mult1|cla2|PFA3|P~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult1|cla2|c2~0_combout\,
	datad => \mult1:mult8|mult1|cla2|PFA3|P~combout\,
	combout => \mult1:mult8|mult1|cla2|PFA3|S~combout\);

-- Location: FF_X26_Y22_N27
\mult1:mult8|mult1|S[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|cla2|PFA3|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(4));

-- Location: LCCOMB_X26_Y19_N2
\mult1:mult8|cla2|carry_out~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla2|carry_out~0_combout\ = (\mult1:mult8|mult1|S\(3) & ((\mult1:mult8|cla2|carry_in_internal[7]~5_combout\) # (\mult1:mult8|cla1|h_sum\(7) $ (\mult1:mult8|cla1|carry_in_internal[7]~8_combout\)))) # (!\mult1:mult8|mult1|S\(3) & 
-- (\mult1:mult8|cla2|carry_in_internal[7]~5_combout\ & (\mult1:mult8|cla1|h_sum\(7) $ (\mult1:mult8|cla1|carry_in_internal[7]~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|h_sum\(7),
	datab => \mult1:mult8|mult1|S\(3),
	datac => \mult1:mult8|cla2|carry_in_internal[7]~5_combout\,
	datad => \mult1:mult8|cla1|carry_in_internal[7]~8_combout\,
	combout => \mult1:mult8|cla2|carry_out~0_combout\);

-- Location: LCCOMB_X26_Y19_N20
\mult1:mult8|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha1|S~combout\ = \mult1:mult8|mult1|S\(4) $ (((\mult1:mult8|cla1|carry_out~1_combout\) # (\mult1:mult8|cla2|carry_out~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001101100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|carry_out~1_combout\,
	datab => \mult1:mult8|mult1|S\(4),
	datad => \mult1:mult8|cla2|carry_out~0_combout\,
	combout => \mult1:mult8|ha1|S~combout\);

-- Location: FF_X26_Y19_N21
\mult1:mult8|S[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(12));

-- Location: LCCOMB_X26_Y22_N20
\mult1:mult8|mult1|cla1|PFA3|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|PFA3|P~combout\ = \mult1:mult8|mult1|tbm3|S\(2) $ (\mult1:mult8|mult1|tbm2|S\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult1|tbm3|S\(2),
	datad => \mult1:mult8|mult1|tbm2|S\(2),
	combout => \mult1:mult8|mult1|cla1|PFA3|P~combout\);

-- Location: LCCOMB_X25_Y22_N12
\mult1:mult8|mult1|tbm2|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm2|ha1|S~combout\ = (\B[5]~input_o\ & (\A[6]~input_o\ $ (((\B[4]~input_o\ & \A[7]~input_o\))))) # (!\B[5]~input_o\ & (\B[4]~input_o\ & ((\A[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[5]~input_o\,
	datab => \B[4]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm2|ha1|S~combout\);

-- Location: FF_X25_Y22_N13
\mult1:mult8|mult1|tbm2|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm2|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm2|S\(1));

-- Location: LCCOMB_X26_Y22_N4
\mult1:mult8|mult1|cla1|PFA2|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|PFA2|P~combout\ = \mult1:mult8|mult1|tbm3|S\(1) $ (\mult1:mult8|mult1|tbm2|S\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult1|tbm3|S\(1),
	datad => \mult1:mult8|mult1|tbm2|S\(1),
	combout => \mult1:mult8|mult1|cla1|PFA2|P~combout\);

-- Location: LCCOMB_X26_Y22_N14
\mult1:mult8|mult1|cla2|PFA2|G\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA2|G~combout\ = (\mult1:mult8|mult1|tbm4|S\(3) & (\mult1:mult8|mult1|cla1|PFA2|P~combout\ $ (((\mult1:mult8|mult1|tbm2|S\(0) & \mult1:mult8|mult1|tbm3|S\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm2|S\(0),
	datab => \mult1:mult8|mult1|tbm3|S\(0),
	datac => \mult1:mult8|mult1|tbm4|S\(3),
	datad => \mult1:mult8|mult1|cla1|PFA2|P~combout\,
	combout => \mult1:mult8|mult1|cla2|PFA2|G~combout\);

-- Location: LCCOMB_X27_Y22_N8
\mult1:mult8|mult1|cla2|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|c3~1_combout\ = (\mult1:mult8|mult1|tbm1|S\(0) & ((\mult1:mult8|mult1|cla2|PFA2|G~combout\) # (\mult1:mult8|mult1|cla1|PFA3|P~combout\ $ (\mult1:mult8|mult1|cla1|c2~0_combout\)))) # (!\mult1:mult8|mult1|tbm1|S\(0) & 
-- (\mult1:mult8|mult1|cla2|PFA2|G~combout\ & (\mult1:mult8|mult1|cla1|PFA3|P~combout\ $ (\mult1:mult8|mult1|cla1|c2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm1|S\(0),
	datab => \mult1:mult8|mult1|cla1|PFA3|P~combout\,
	datac => \mult1:mult8|mult1|cla1|c2~0_combout\,
	datad => \mult1:mult8|mult1|cla2|PFA2|G~combout\,
	combout => \mult1:mult8|mult1|cla2|c3~1_combout\);

-- Location: LCCOMB_X27_Y22_N18
\mult1:mult8|mult1|tbm1|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm1|ha1|S~combout\ = (\B[7]~input_o\ & (\A[6]~input_o\ $ (((\B[6]~input_o\ & \A[7]~input_o\))))) # (!\B[7]~input_o\ & (((\B[6]~input_o\ & \A[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[7]~input_o\,
	datab => \A[6]~input_o\,
	datac => \B[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm1|ha1|S~combout\);

-- Location: FF_X27_Y22_N19
\mult1:mult8|mult1|tbm1|S[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm1|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm1|S\(1));

-- Location: LCCOMB_X25_Y22_N28
\mult1:mult8|mult1|tbm2|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm2|ha2|Cout~0_combout\ = (\B[5]~input_o\ & (\B[4]~input_o\ & (\A[6]~input_o\ & \A[7]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[5]~input_o\,
	datab => \B[4]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm2|ha2|Cout~0_combout\);

-- Location: FF_X25_Y22_N29
\mult1:mult8|mult1|tbm2|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm2|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm2|S\(3));

-- Location: LCCOMB_X26_Y22_N22
\mult1:mult8|mult1|cla1|c3~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|c3~1_combout\ = (\mult1:mult8|mult1|cla1|c3~0_combout\) # ((\mult1:mult8|mult1|cla1|PFA1|G~combout\ & (\mult1:mult8|mult1|cla1|PFA2|P~combout\ & \mult1:mult8|mult1|cla1|PFA3|P~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla1|c3~0_combout\,
	datab => \mult1:mult8|mult1|cla1|PFA1|G~combout\,
	datac => \mult1:mult8|mult1|cla1|PFA2|P~combout\,
	datad => \mult1:mult8|mult1|cla1|PFA3|P~combout\,
	combout => \mult1:mult8|mult1|cla1|c3~1_combout\);

-- Location: LCCOMB_X27_Y22_N4
\mult1:mult8|mult1|cla2|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA4|P~combout\ = \mult1:mult8|mult1|tbm3|S\(3) $ (\mult1:mult8|mult1|tbm1|S\(1) $ (\mult1:mult8|mult1|tbm2|S\(3) $ (\mult1:mult8|mult1|cla1|c3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm3|S\(3),
	datab => \mult1:mult8|mult1|tbm1|S\(1),
	datac => \mult1:mult8|mult1|tbm2|S\(3),
	datad => \mult1:mult8|mult1|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult1|cla2|PFA4|P~combout\);

-- Location: LCCOMB_X27_Y22_N0
\mult1:mult8|mult1|cla2|PFA4|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|PFA4|S~combout\ = \mult1:mult8|mult1|cla2|PFA4|P~combout\ $ (((\mult1:mult8|mult1|cla2|c3~1_combout\) # ((\mult1:mult8|mult1|cla2|c3~0_combout\ & \mult1:mult8|mult1|cla2|PFA3|P~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla2|c3~0_combout\,
	datab => \mult1:mult8|mult1|cla2|c3~1_combout\,
	datac => \mult1:mult8|mult1|cla2|PFA4|P~combout\,
	datad => \mult1:mult8|mult1|cla2|PFA3|P~combout\,
	combout => \mult1:mult8|mult1|cla2|PFA4|S~combout\);

-- Location: FF_X27_Y22_N1
\mult1:mult8|mult1|S[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|cla2|PFA4|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(5));

-- Location: LCCOMB_X26_Y19_N14
\mult1:mult8|ha2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha2|S~combout\ = \mult1:mult8|mult1|S\(5) $ (((\mult1:mult8|mult1|S\(4) & ((\mult1:mult8|cla1|carry_out~1_combout\) # (\mult1:mult8|cla2|carry_out~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|cla1|carry_out~1_combout\,
	datab => \mult1:mult8|mult1|S\(4),
	datac => \mult1:mult8|mult1|S\(5),
	datad => \mult1:mult8|cla2|carry_out~0_combout\,
	combout => \mult1:mult8|ha2|S~combout\);

-- Location: FF_X26_Y19_N15
\mult1:mult8|S[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|ha2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(13));

-- Location: LCCOMB_X27_Y19_N22
\mult1:mult8|ha3|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha3|S~0_combout\ = (!\mult1:mult8|mult1|S\(4)) # (!\mult1:mult8|mult1|S\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult1|S\(5),
	datad => \mult1:mult8|mult1|S\(4),
	combout => \mult1:mult8|ha3|S~0_combout\);

-- Location: LCCOMB_X25_Y21_N28
\mult1:mult8|mult2|ha2|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult2|ha2|S~combout\ = \mult1:mult8|mult2|tbm1|S\(3) $ (((\mult1:mult8|mult2|tbm1|S\(2) & \mult1:mult8|mult2|or2bit~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult2|tbm1|S\(3),
	datac => \mult1:mult8|mult2|tbm1|S\(2),
	datad => \mult1:mult8|mult2|or2bit~3_combout\,
	combout => \mult1:mult8|mult2|ha2|S~combout\);

-- Location: FF_X25_Y21_N29
\mult1:mult8|mult2|S[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult2|ha2|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult2|S\(7));

-- Location: LCCOMB_X25_Y19_N18
\mult1:mult8|cla1|carry_out~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_out~0_combout\ = (\mult1:mult8|mult3|S\(6) & ((\mult1:mult8|mult2|S\(6)) # (\mult1:mult8|cla1|carry_in_internal[6]~7_combout\))) # (!\mult1:mult8|mult3|S\(6) & (\mult1:mult8|mult2|S\(6) & 
-- \mult1:mult8|cla1|carry_in_internal[6]~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(6),
	datac => \mult1:mult8|mult2|S\(6),
	datad => \mult1:mult8|cla1|carry_in_internal[6]~7_combout\,
	combout => \mult1:mult8|cla1|carry_out~0_combout\);

-- Location: LCCOMB_X25_Y19_N6
\mult1:mult8|cla1|carry_out~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|cla1|carry_out~1_combout\ = (\mult1:mult8|mult3|S\(7) & ((\mult1:mult8|mult2|S\(7)) # (\mult1:mult8|cla1|carry_out~0_combout\))) # (!\mult1:mult8|mult3|S\(7) & (\mult1:mult8|mult2|S\(7) & \mult1:mult8|cla1|carry_out~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult3|S\(7),
	datab => \mult1:mult8|mult2|S\(7),
	datad => \mult1:mult8|cla1|carry_out~0_combout\,
	combout => \mult1:mult8|cla1|carry_out~1_combout\);

-- Location: LCCOMB_X25_Y19_N14
\mult1:mult8|ha3|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha3|S~combout\ = \mult1:mult8|mult1|S\(6) $ (((!\mult1:mult8|ha3|S~0_combout\ & ((\mult1:mult8|cla1|carry_out~1_combout\) # (\mult1:mult8|cla2|carry_out~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|S\(6),
	datab => \mult1:mult8|ha3|S~0_combout\,
	datac => \mult1:mult8|cla1|carry_out~1_combout\,
	datad => \mult1:mult8|cla2|carry_out~0_combout\,
	combout => \mult1:mult8|ha3|S~combout\);

-- Location: FF_X25_Y19_N15
\mult1:mult8|S[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|ha3|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(14));

-- Location: LCCOMB_X27_Y22_N22
\mult1:mult8|mult1|tbm1|ha2|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm1|ha2|S~0_combout\ = (\B[7]~input_o\ & (\A[7]~input_o\ & ((!\B[6]~input_o\) # (!\A[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[7]~input_o\,
	datab => \A[6]~input_o\,
	datac => \B[6]~input_o\,
	datad => \A[7]~input_o\,
	combout => \mult1:mult8|mult1|tbm1|ha2|S~0_combout\);

-- Location: FF_X27_Y22_N23
\mult1:mult8|mult1|tbm1|S[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm1|ha2|S~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm1|S\(2));

-- Location: LCCOMB_X27_Y22_N14
\mult1:mult8|mult1|cla1|PFA4|P\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla1|PFA4|P~combout\ = \mult1:mult8|mult1|tbm3|S\(3) $ (\mult1:mult8|mult1|tbm2|S\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|tbm3|S\(3),
	datac => \mult1:mult8|mult1|tbm2|S\(3),
	combout => \mult1:mult8|mult1|cla1|PFA4|P~combout\);

-- Location: LCCOMB_X27_Y22_N20
\mult1:mult8|mult1|cla2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|cla2|Cout~0_combout\ = (\mult1:mult8|mult1|cla2|PFA3|G~combout\ & ((\mult1:mult8|mult1|tbm1|S\(1)) # (\mult1:mult8|mult1|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult1|cla1|c3~1_combout\)))) # (!\mult1:mult8|mult1|cla2|PFA3|G~combout\ & 
-- (\mult1:mult8|mult1|tbm1|S\(1) & (\mult1:mult8|mult1|cla1|PFA4|P~combout\ $ (\mult1:mult8|mult1|cla1|c3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla2|PFA3|G~combout\,
	datab => \mult1:mult8|mult1|tbm1|S\(1),
	datac => \mult1:mult8|mult1|cla1|PFA4|P~combout\,
	datad => \mult1:mult8|mult1|cla1|c3~1_combout\,
	combout => \mult1:mult8|mult1|cla2|Cout~0_combout\);

-- Location: LCCOMB_X26_Y22_N0
\mult1:mult8|mult1|tbm3|ha2|Cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|tbm3|ha2|Cout~0_combout\ = (\A[4]~input_o\ & (\B[7]~input_o\ & (\A[5]~input_o\ & \B[6]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \B[7]~input_o\,
	datac => \A[5]~input_o\,
	datad => \B[6]~input_o\,
	combout => \mult1:mult8|mult1|tbm3|ha2|Cout~0_combout\);

-- Location: FF_X26_Y22_N1
\mult1:mult8|mult1|tbm3|S[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|tbm3|ha2|Cout~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|tbm3|S\(3));

-- Location: LCCOMB_X26_Y22_N6
\mult1:mult8|mult1|or2bit~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|or2bit~2_combout\ = (\mult1:mult8|mult1|or2bit~1_combout\ & (\mult1:mult8|mult1|cla1|PFA3|P~combout\ & (\mult1:mult8|mult1|tbm3|S\(3) $ (\mult1:mult8|mult1|tbm2|S\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|or2bit~1_combout\,
	datab => \mult1:mult8|mult1|tbm3|S\(3),
	datac => \mult1:mult8|mult1|tbm2|S\(3),
	datad => \mult1:mult8|mult1|cla1|PFA3|P~combout\,
	combout => \mult1:mult8|mult1|or2bit~2_combout\);

-- Location: LCCOMB_X27_Y22_N12
\mult1:mult8|mult1|or2bit~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|or2bit~0_combout\ = (\mult1:mult8|mult1|cla2|PFA3|P~combout\ & (\mult1:mult8|mult1|cla2|PFA4|P~combout\ & ((\mult1:mult8|mult1|cla2|c3~0_combout\) # (\mult1:mult8|mult1|cla2|PFA2|G~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla2|c3~0_combout\,
	datab => \mult1:mult8|mult1|cla2|PFA3|P~combout\,
	datac => \mult1:mult8|mult1|cla2|PFA4|P~combout\,
	datad => \mult1:mult8|mult1|cla2|PFA2|G~combout\,
	combout => \mult1:mult8|mult1|or2bit~0_combout\);

-- Location: LCCOMB_X27_Y22_N28
\mult1:mult8|mult1|or2bit~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|or2bit~3_combout\ = (\mult1:mult8|mult1|cla1|Cout~0_combout\) # ((\mult1:mult8|mult1|cla2|Cout~0_combout\) # ((\mult1:mult8|mult1|or2bit~2_combout\) # (\mult1:mult8|mult1|or2bit~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|cla1|Cout~0_combout\,
	datab => \mult1:mult8|mult1|cla2|Cout~0_combout\,
	datac => \mult1:mult8|mult1|or2bit~2_combout\,
	datad => \mult1:mult8|mult1|or2bit~0_combout\,
	combout => \mult1:mult8|mult1|or2bit~3_combout\);

-- Location: LCCOMB_X27_Y22_N2
\mult1:mult8|mult1|ha1|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|mult1|ha1|S~combout\ = \mult1:mult8|mult1|tbm1|S\(2) $ (\mult1:mult8|mult1|or2bit~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \mult1:mult8|mult1|tbm1|S\(2),
	datad => \mult1:mult8|mult1|or2bit~3_combout\,
	combout => \mult1:mult8|mult1|ha1|S~combout\);

-- Location: FF_X27_Y22_N3
\mult1:mult8|mult1|S[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|mult1|ha1|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|mult1|S\(6));

-- Location: LCCOMB_X27_Y19_N24
\mult1:mult8|ha4|S~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha4|S~0_combout\ = (\mult1:mult8|mult1|S\(5) & (\mult1:mult8|mult1|S\(6) & \mult1:mult8|mult1|S\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \mult1:mult8|mult1|S\(5),
	datac => \mult1:mult8|mult1|S\(6),
	datad => \mult1:mult8|mult1|S\(4),
	combout => \mult1:mult8|ha4|S~0_combout\);

-- Location: LCCOMB_X25_Y19_N4
\mult1:mult8|ha4|S\ : cycloneiv_lcell_comb
-- Equation(s):
-- \mult1:mult8|ha4|S~combout\ = \mult1:mult8|mult1|S\(7) $ (((\mult1:mult8|ha4|S~0_combout\ & ((\mult1:mult8|cla1|carry_out~1_combout\) # (\mult1:mult8|cla2|carry_out~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mult1:mult8|mult1|S\(7),
	datab => \mult1:mult8|ha4|S~0_combout\,
	datac => \mult1:mult8|cla1|carry_out~1_combout\,
	datad => \mult1:mult8|cla2|carry_out~0_combout\,
	combout => \mult1:mult8|ha4|S~combout\);

-- Location: FF_X25_Y19_N5
\mult1:mult8|S[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \mult1:mult8|ha4|S~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mult1:mult8|S\(15));

-- Location: IOIBUF_X16_Y0_N8
\INICIAR~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_INICIAR,
	o => \INICIAR~input_o\);

ww_R <= \R~output_o\;

ww_S(0) <= \S[0]~output_o\;

ww_S(1) <= \S[1]~output_o\;

ww_S(2) <= \S[2]~output_o\;

ww_S(3) <= \S[3]~output_o\;

ww_S(4) <= \S[4]~output_o\;

ww_S(5) <= \S[5]~output_o\;

ww_S(6) <= \S[6]~output_o\;

ww_S(7) <= \S[7]~output_o\;

ww_S(8) <= \S[8]~output_o\;

ww_S(9) <= \S[9]~output_o\;

ww_S(10) <= \S[10]~output_o\;

ww_S(11) <= \S[11]~output_o\;

ww_S(12) <= \S[12]~output_o\;

ww_S(13) <= \S[13]~output_o\;

ww_S(14) <= \S[14]~output_o\;

ww_S(15) <= \S[15]~output_o\;
END structure;


