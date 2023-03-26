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

-- DATE "11/23/2022 22:43:20"

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
	RST : IN std_logic;
	INIT : IN std_logic;
	A : IN std_logic_vector(7 DOWNTO 0);
	B : IN std_logic_vector(7 DOWNTO 0);
	R : OUT std_logic;
	S : OUT std_logic_vector(7 DOWNTO 0)
	);
END multiplicador;

-- Design Ports Information
-- R	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[0]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[1]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[2]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[3]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[4]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[5]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[6]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[7]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- INIT	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RST	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[4]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[4]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[5]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[5]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[6]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[6]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[7]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[7]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL ww_RST : std_logic;
SIGNAL ww_INIT : std_logic;
SIGNAL ww_A : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_R : std_logic;
SIGNAL ww_S : std_logic_vector(7 DOWNTO 0);
SIGNAL \RST~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \bloco_controle|state.S5~q\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~0_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[1]~1_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~8_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[3]~3_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[4]~4_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~17_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~20_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~23_combout\ : std_logic;
SIGNAL \bloco_operativo|geraAz|Equal0~1_combout\ : std_logic;
SIGNAL \bloco_controle|state~10_combout\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[1]~1_combout\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[4]~4_combout\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[7]~7_combout\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \B[5]~input_o\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \R~output_o\ : std_logic;
SIGNAL \S[0]~output_o\ : std_logic;
SIGNAL \S[1]~output_o\ : std_logic;
SIGNAL \S[2]~output_o\ : std_logic;
SIGNAL \S[3]~output_o\ : std_logic;
SIGNAL \S[4]~output_o\ : std_logic;
SIGNAL \S[5]~output_o\ : std_logic;
SIGNAL \S[6]~output_o\ : std_logic;
SIGNAL \S[7]~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \INIT~input_o\ : std_logic;
SIGNAL \bloco_controle|Selector0~0_combout\ : std_logic;
SIGNAL \RST~input_o\ : std_logic;
SIGNAL \RST~inputclkctrl_outclk\ : std_logic;
SIGNAL \bloco_controle|state.S0~q\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[0]~0_combout\ : std_logic;
SIGNAL \bloco_controle|state~11_combout\ : std_logic;
SIGNAL \bloco_controle|state.S1~q\ : std_logic;
SIGNAL \bloco_controle|state.S2~q\ : std_logic;
SIGNAL \B[6]~input_o\ : std_logic;
SIGNAL \B[4]~input_o\ : std_logic;
SIGNAL \B[7]~input_o\ : std_logic;
SIGNAL \bloco_operativo|geraBz|Equal0~1_combout\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~11_combout\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~5_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~2_cout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~4\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~7\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~9_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[2]~2_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~10\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~12_combout\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[3]~3_combout\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[2]~2_combout\ : std_logic;
SIGNAL \bloco_operativo|geraAz|Equal0~0_combout\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \bloco_operativo|regB|q[3]~feeder_combout\ : std_logic;
SIGNAL \bloco_operativo|geraBz|Equal0~0_combout\ : std_logic;
SIGNAL \bloco_controle|process_0~0_combout\ : std_logic;
SIGNAL \bloco_controle|state~12_combout\ : std_logic;
SIGNAL \bloco_controle|state.S3~q\ : std_logic;
SIGNAL \bloco_controle|state.S4~q\ : std_logic;
SIGNAL \bloco_controle|CA~combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[0]~0_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~3_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~6_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~14_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~13\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~15_combout\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[5]~5_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[5]~5_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~16\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~18_combout\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \bloco_operativo|mux1|y[6]~6_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[6]~6_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~19\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~21_combout\ : std_logic;
SIGNAL \bloco_operativo|mux2|y[7]~7_combout\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~22\ : std_logic;
SIGNAL \bloco_operativo|somasub|Add0~24_combout\ : std_logic;
SIGNAL \bloco_operativo|regB|q\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \bloco_operativo|regP|q\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \bloco_operativo|regA|q\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_RST~inputclkctrl_outclk\ : std_logic;
SIGNAL \bloco_controle|ALT_INV_state.S1~q\ : std_logic;
SIGNAL \bloco_controle|ALT_INV_state.S0~q\ : std_logic;

BEGIN

ww_CLK <= CLK;
ww_RST <= RST;
ww_INIT <= INIT;
ww_A <= A;
ww_B <= B;
R <= ww_R;
S <= ww_S;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\RST~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \RST~input_o\);

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
\ALT_INV_RST~inputclkctrl_outclk\ <= NOT \RST~inputclkctrl_outclk\;
\bloco_controle|ALT_INV_state.S1~q\ <= NOT \bloco_controle|state.S1~q\;
\bloco_controle|ALT_INV_state.S0~q\ <= NOT \bloco_controle|state.S0~q\;

-- Location: FF_X23_Y28_N11
\bloco_controle|state.S5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_controle|state~10_combout\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S5~q\);

-- Location: LCCOMB_X23_Y28_N6
\bloco_operativo|somasub|Add0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~0_combout\ = (\bloco_operativo|regB|q\(0) & !\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regB|q\(0),
	datac => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~0_combout\);

-- Location: FF_X21_Y28_N11
\bloco_operativo|regA|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[1]~1_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(1));

-- Location: LCCOMB_X22_Y28_N30
\bloco_operativo|mux2|y[1]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[1]~1_combout\ = (\bloco_controle|state.S4~q\ & ((\bloco_operativo|regA|q\(1)))) # (!\bloco_controle|state.S4~q\ & (\bloco_operativo|regP|q\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regP|q\(1),
	datab => \bloco_controle|state.S4~q\,
	datad => \bloco_operativo|regA|q\(1),
	combout => \bloco_operativo|mux2|y[1]~1_combout\);

-- Location: FF_X23_Y28_N31
\bloco_operativo|regB|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[2]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(2));

-- Location: LCCOMB_X23_Y28_N4
\bloco_operativo|somasub|Add0~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~8_combout\ = (\bloco_operativo|regB|q\(2)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_operativo|regB|q\(2),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~8_combout\);

-- Location: LCCOMB_X22_Y28_N8
\bloco_operativo|mux2|y[3]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[3]~3_combout\ = (\bloco_controle|state.S4~q\ & (\bloco_operativo|regA|q\(3))) # (!\bloco_controle|state.S4~q\ & ((\bloco_operativo|regP|q\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S4~q\,
	datab => \bloco_operativo|regA|q\(3),
	datad => \bloco_operativo|regP|q\(3),
	combout => \bloco_operativo|mux2|y[3]~3_combout\);

-- Location: FF_X21_Y28_N13
\bloco_operativo|regA|q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[4]~4_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(4));

-- Location: LCCOMB_X22_Y28_N4
\bloco_operativo|mux2|y[4]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[4]~4_combout\ = (\bloco_controle|state.S4~q\ & (\bloco_operativo|regA|q\(4))) # (!\bloco_controle|state.S4~q\ & ((\bloco_operativo|regP|q\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S4~q\,
	datab => \bloco_operativo|regA|q\(4),
	datad => \bloco_operativo|regP|q\(4),
	combout => \bloco_operativo|mux2|y[4]~4_combout\);

-- Location: FF_X23_Y28_N3
\bloco_operativo|regB|q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[5]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(5));

-- Location: LCCOMB_X23_Y28_N2
\bloco_operativo|somasub|Add0~17\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~17_combout\ = (\bloco_operativo|regB|q\(5)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_operativo|regB|q\(5),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~17_combout\);

-- Location: LCCOMB_X23_Y28_N8
\bloco_operativo|somasub|Add0~20\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~20_combout\ = (\bloco_operativo|regB|q\(6)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_operativo|regB|q\(6),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~20_combout\);

-- Location: LCCOMB_X23_Y28_N30
\bloco_operativo|somasub|Add0~23\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~23_combout\ = (\bloco_operativo|regB|q\(7)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \bloco_operativo|regB|q\(7),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~23_combout\);

-- Location: FF_X21_Y28_N23
\bloco_operativo|regA|q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[7]~7_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(7));

-- Location: LCCOMB_X21_Y28_N8
\bloco_operativo|geraAz|Equal0~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|geraAz|Equal0~1_combout\ = (!\bloco_operativo|regA|q\(4) & (!\bloco_operativo|regA|q\(5) & (!\bloco_operativo|regA|q\(7) & !\bloco_operativo|regA|q\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regA|q\(4),
	datab => \bloco_operativo|regA|q\(5),
	datac => \bloco_operativo|regA|q\(7),
	datad => \bloco_operativo|regA|q\(6),
	combout => \bloco_operativo|geraAz|Equal0~1_combout\);

-- Location: LCCOMB_X23_Y28_N10
\bloco_controle|state~10\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|state~10_combout\ = (\bloco_controle|state.S2~q\ & \bloco_controle|process_0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \bloco_controle|state.S2~q\,
	datad => \bloco_controle|process_0~0_combout\,
	combout => \bloco_controle|state~10_combout\);

-- Location: LCCOMB_X21_Y28_N10
\bloco_operativo|mux1|y[1]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[1]~1_combout\ = (\bloco_controle|state.S1~q\ & (\A[1]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datac => \bloco_controle|state.S1~q\,
	datad => \bloco_operativo|somasub|Add0~6_combout\,
	combout => \bloco_operativo|mux1|y[1]~1_combout\);

-- Location: LCCOMB_X21_Y28_N12
\bloco_operativo|mux1|y[4]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[4]~4_combout\ = (\bloco_controle|state.S1~q\ & ((\A[4]~input_o\))) # (!\bloco_controle|state.S1~q\ & (\bloco_operativo|somasub|Add0~15_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \bloco_operativo|somasub|Add0~15_combout\,
	datad => \A[4]~input_o\,
	combout => \bloco_operativo|mux1|y[4]~4_combout\);

-- Location: LCCOMB_X21_Y28_N22
\bloco_operativo|mux1|y[7]~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[7]~7_combout\ = (\bloco_controle|state.S1~q\ & (\A[7]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~24_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \A[7]~input_o\,
	datad => \bloco_operativo|somasub|Add0~24_combout\,
	combout => \bloco_operativo|mux1|y[7]~7_combout\);

-- Location: IOIBUF_X12_Y31_N1
\A[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: IOIBUF_X31_Y31_N1
\B[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: IOIBUF_X33_Y28_N8
\A[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

-- Location: IOIBUF_X16_Y31_N1
\B[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(5),
	o => \B[5]~input_o\);

-- Location: IOIBUF_X14_Y31_N8
\A[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

-- Location: IOOBUF_X26_Y31_N9
\R~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_controle|ALT_INV_state.S0~q\,
	devoe => ww_devoe,
	o => \R~output_o\);

-- Location: IOOBUF_X12_Y31_N9
\S[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(0),
	devoe => ww_devoe,
	o => \S[0]~output_o\);

-- Location: IOOBUF_X10_Y31_N2
\S[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(1),
	devoe => ww_devoe,
	o => \S[1]~output_o\);

-- Location: IOOBUF_X33_Y25_N2
\S[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(2),
	devoe => ww_devoe,
	o => \S[2]~output_o\);

-- Location: IOOBUF_X29_Y31_N9
\S[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(3),
	devoe => ww_devoe,
	o => \S[3]~output_o\);

-- Location: IOOBUF_X33_Y25_N9
\S[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(4),
	devoe => ww_devoe,
	o => \S[4]~output_o\);

-- Location: IOOBUF_X20_Y31_N2
\S[5]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(5),
	devoe => ww_devoe,
	o => \S[5]~output_o\);

-- Location: IOOBUF_X22_Y31_N9
\S[6]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(6),
	devoe => ww_devoe,
	o => \S[6]~output_o\);

-- Location: IOOBUF_X20_Y31_N9
\S[7]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bloco_operativo|regP|q\(7),
	devoe => ww_devoe,
	o => \S[7]~output_o\);

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

-- Location: IOIBUF_X33_Y27_N1
\INIT~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_INIT,
	o => \INIT~input_o\);

-- Location: LCCOMB_X23_Y28_N20
\bloco_controle|Selector0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|Selector0~0_combout\ = (!\bloco_controle|state.S5~q\ & ((\bloco_controle|state.S0~q\) # (\INIT~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S5~q\,
	datac => \bloco_controle|state.S0~q\,
	datad => \INIT~input_o\,
	combout => \bloco_controle|Selector0~0_combout\);

-- Location: IOIBUF_X16_Y0_N22
\RST~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RST,
	o => \RST~input_o\);

-- Location: CLKCTRL_G19
\RST~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \RST~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \RST~inputclkctrl_outclk\);

-- Location: FF_X23_Y28_N21
\bloco_controle|state.S0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_controle|Selector0~0_combout\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S0~q\);

-- Location: IOIBUF_X29_Y31_N1
\A[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: LCCOMB_X21_Y28_N20
\bloco_operativo|mux1|y[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[0]~0_combout\ = (\bloco_controle|state.S1~q\ & ((\A[0]~input_o\))) # (!\bloco_controle|state.S1~q\ & (\bloco_operativo|somasub|Add0~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \bloco_operativo|somasub|Add0~3_combout\,
	datad => \A[0]~input_o\,
	combout => \bloco_operativo|mux1|y[0]~0_combout\);

-- Location: LCCOMB_X23_Y28_N12
\bloco_controle|state~11\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|state~11_combout\ = (\INIT~input_o\ & !\bloco_controle|state.S0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \INIT~input_o\,
	datad => \bloco_controle|state.S0~q\,
	combout => \bloco_controle|state~11_combout\);

-- Location: FF_X22_Y28_N3
\bloco_controle|state.S1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_controle|state~11_combout\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S1~q\);

-- Location: FF_X22_Y28_N21
\bloco_controle|state.S2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_controle|CA~combout\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S2~q\);

-- Location: IOIBUF_X33_Y24_N1
\B[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(6),
	o => \B[6]~input_o\);

-- Location: FF_X23_Y28_N9
\bloco_operativo|regB|q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[6]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(6));

-- Location: IOIBUF_X26_Y31_N1
\B[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(4),
	o => \B[4]~input_o\);

-- Location: FF_X23_Y28_N23
\bloco_operativo|regB|q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[4]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(4));

-- Location: IOIBUF_X24_Y31_N1
\B[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(7),
	o => \B[7]~input_o\);

-- Location: FF_X23_Y28_N17
\bloco_operativo|regB|q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[7]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(7));

-- Location: LCCOMB_X23_Y28_N22
\bloco_operativo|geraBz|Equal0~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|geraBz|Equal0~1_combout\ = (!\bloco_operativo|regB|q\(5) & (!\bloco_operativo|regB|q\(6) & (!\bloco_operativo|regB|q\(4) & !\bloco_operativo|regB|q\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regB|q\(5),
	datab => \bloco_operativo|regB|q\(6),
	datac => \bloco_operativo|regB|q\(4),
	datad => \bloco_operativo|regB|q\(7),
	combout => \bloco_operativo|geraBz|Equal0~1_combout\);

-- Location: IOIBUF_X14_Y31_N1
\A[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LCCOMB_X23_Y28_N16
\bloco_operativo|somasub|Add0~11\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~11_combout\ = (\bloco_operativo|regB|q\(3)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regB|q\(3),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~11_combout\);

-- Location: IOIBUF_X33_Y27_N8
\B[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: FF_X23_Y28_N15
\bloco_operativo|regB|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[1]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(1));

-- Location: LCCOMB_X23_Y28_N28
\bloco_operativo|somasub|Add0~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~5_combout\ = (\bloco_operativo|regB|q\(1)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_operativo|regB|q\(1),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~5_combout\);

-- Location: LCCOMB_X22_Y28_N10
\bloco_operativo|somasub|Add0~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~2_cout\ = CARRY(\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S4~q\,
	datad => VCC,
	cout => \bloco_operativo|somasub|Add0~2_cout\);

-- Location: LCCOMB_X22_Y28_N12
\bloco_operativo|somasub|Add0~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~3_combout\ = (\bloco_operativo|somasub|Add0~0_combout\ & ((\bloco_operativo|mux2|y[0]~0_combout\ & (\bloco_operativo|somasub|Add0~2_cout\ & VCC)) # (!\bloco_operativo|mux2|y[0]~0_combout\ & 
-- (!\bloco_operativo|somasub|Add0~2_cout\)))) # (!\bloco_operativo|somasub|Add0~0_combout\ & ((\bloco_operativo|mux2|y[0]~0_combout\ & (!\bloco_operativo|somasub|Add0~2_cout\)) # (!\bloco_operativo|mux2|y[0]~0_combout\ & 
-- ((\bloco_operativo|somasub|Add0~2_cout\) # (GND)))))
-- \bloco_operativo|somasub|Add0~4\ = CARRY((\bloco_operativo|somasub|Add0~0_combout\ & (!\bloco_operativo|mux2|y[0]~0_combout\ & !\bloco_operativo|somasub|Add0~2_cout\)) # (!\bloco_operativo|somasub|Add0~0_combout\ & 
-- ((!\bloco_operativo|somasub|Add0~2_cout\) # (!\bloco_operativo|mux2|y[0]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|somasub|Add0~0_combout\,
	datab => \bloco_operativo|mux2|y[0]~0_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~2_cout\,
	combout => \bloco_operativo|somasub|Add0~3_combout\,
	cout => \bloco_operativo|somasub|Add0~4\);

-- Location: LCCOMB_X22_Y28_N14
\bloco_operativo|somasub|Add0~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~6_combout\ = ((\bloco_operativo|mux2|y[1]~1_combout\ $ (\bloco_operativo|somasub|Add0~5_combout\ $ (!\bloco_operativo|somasub|Add0~4\)))) # (GND)
-- \bloco_operativo|somasub|Add0~7\ = CARRY((\bloco_operativo|mux2|y[1]~1_combout\ & ((\bloco_operativo|somasub|Add0~5_combout\) # (!\bloco_operativo|somasub|Add0~4\))) # (!\bloco_operativo|mux2|y[1]~1_combout\ & (\bloco_operativo|somasub|Add0~5_combout\ & 
-- !\bloco_operativo|somasub|Add0~4\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|mux2|y[1]~1_combout\,
	datab => \bloco_operativo|somasub|Add0~5_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~4\,
	combout => \bloco_operativo|somasub|Add0~6_combout\,
	cout => \bloco_operativo|somasub|Add0~7\);

-- Location: LCCOMB_X22_Y28_N16
\bloco_operativo|somasub|Add0~9\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~9_combout\ = (\bloco_operativo|somasub|Add0~8_combout\ & ((\bloco_operativo|mux2|y[2]~2_combout\ & (\bloco_operativo|somasub|Add0~7\ & VCC)) # (!\bloco_operativo|mux2|y[2]~2_combout\ & (!\bloco_operativo|somasub|Add0~7\)))) # 
-- (!\bloco_operativo|somasub|Add0~8_combout\ & ((\bloco_operativo|mux2|y[2]~2_combout\ & (!\bloco_operativo|somasub|Add0~7\)) # (!\bloco_operativo|mux2|y[2]~2_combout\ & ((\bloco_operativo|somasub|Add0~7\) # (GND)))))
-- \bloco_operativo|somasub|Add0~10\ = CARRY((\bloco_operativo|somasub|Add0~8_combout\ & (!\bloco_operativo|mux2|y[2]~2_combout\ & !\bloco_operativo|somasub|Add0~7\)) # (!\bloco_operativo|somasub|Add0~8_combout\ & ((!\bloco_operativo|somasub|Add0~7\) # 
-- (!\bloco_operativo|mux2|y[2]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|somasub|Add0~8_combout\,
	datab => \bloco_operativo|mux2|y[2]~2_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~7\,
	combout => \bloco_operativo|somasub|Add0~9_combout\,
	cout => \bloco_operativo|somasub|Add0~10\);

-- Location: FF_X22_Y28_N5
\bloco_operativo|regP|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_operativo|somasub|Add0~9_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	sload => VCC,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(2));

-- Location: LCCOMB_X22_Y28_N0
\bloco_operativo|mux2|y[2]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[2]~2_combout\ = (\bloco_controle|state.S4~q\ & (\bloco_operativo|regA|q\(2))) # (!\bloco_controle|state.S4~q\ & ((\bloco_operativo|regP|q\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regA|q\(2),
	datab => \bloco_operativo|regP|q\(2),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|mux2|y[2]~2_combout\);

-- Location: LCCOMB_X22_Y28_N18
\bloco_operativo|somasub|Add0~12\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~12_combout\ = ((\bloco_operativo|mux2|y[3]~3_combout\ $ (\bloco_operativo|somasub|Add0~11_combout\ $ (!\bloco_operativo|somasub|Add0~10\)))) # (GND)
-- \bloco_operativo|somasub|Add0~13\ = CARRY((\bloco_operativo|mux2|y[3]~3_combout\ & ((\bloco_operativo|somasub|Add0~11_combout\) # (!\bloco_operativo|somasub|Add0~10\))) # (!\bloco_operativo|mux2|y[3]~3_combout\ & (\bloco_operativo|somasub|Add0~11_combout\ 
-- & !\bloco_operativo|somasub|Add0~10\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|mux2|y[3]~3_combout\,
	datab => \bloco_operativo|somasub|Add0~11_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~10\,
	combout => \bloco_operativo|somasub|Add0~12_combout\,
	cout => \bloco_operativo|somasub|Add0~13\);

-- Location: LCCOMB_X21_Y28_N18
\bloco_operativo|mux1|y[3]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[3]~3_combout\ = (\bloco_controle|state.S1~q\ & (\A[3]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \A[3]~input_o\,
	datad => \bloco_operativo|somasub|Add0~12_combout\,
	combout => \bloco_operativo|mux1|y[3]~3_combout\);

-- Location: FF_X21_Y28_N19
\bloco_operativo|regA|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[3]~3_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(3));

-- Location: IOIBUF_X33_Y28_N1
\A[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: LCCOMB_X21_Y28_N16
\bloco_operativo|mux1|y[2]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[2]~2_combout\ = (\bloco_controle|state.S1~q\ & (\A[2]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \A[2]~input_o\,
	datad => \bloco_operativo|somasub|Add0~9_combout\,
	combout => \bloco_operativo|mux1|y[2]~2_combout\);

-- Location: FF_X21_Y28_N17
\bloco_operativo|regA|q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[2]~2_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(2));

-- Location: LCCOMB_X21_Y28_N26
\bloco_operativo|geraAz|Equal0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|geraAz|Equal0~0_combout\ = (!\bloco_operativo|regA|q\(1) & (!\bloco_operativo|regA|q\(3) & (!\bloco_operativo|regA|q\(0) & !\bloco_operativo|regA|q\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regA|q\(1),
	datab => \bloco_operativo|regA|q\(3),
	datac => \bloco_operativo|regA|q\(0),
	datad => \bloco_operativo|regA|q\(2),
	combout => \bloco_operativo|geraAz|Equal0~0_combout\);

-- Location: IOIBUF_X24_Y31_N8
\B[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: FF_X23_Y28_N13
\bloco_operativo|regB|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \B[0]~input_o\,
	sload => VCC,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(0));

-- Location: IOIBUF_X31_Y31_N8
\B[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: LCCOMB_X23_Y28_N26
\bloco_operativo|regB|q[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|regB|q[3]~feeder_combout\ = \B[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \B[3]~input_o\,
	combout => \bloco_operativo|regB|q[3]~feeder_combout\);

-- Location: FF_X23_Y28_N27
\bloco_operativo|regB|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|regB|q[3]~feeder_combout\,
	ena => \bloco_controle|state.S1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regB|q\(3));

-- Location: LCCOMB_X23_Y28_N14
\bloco_operativo|geraBz|Equal0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|geraBz|Equal0~0_combout\ = (!\bloco_operativo|regB|q\(2) & (!\bloco_operativo|regB|q\(0) & (!\bloco_operativo|regB|q\(1) & !\bloco_operativo|regB|q\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regB|q\(2),
	datab => \bloco_operativo|regB|q\(0),
	datac => \bloco_operativo|regB|q\(1),
	datad => \bloco_operativo|regB|q\(3),
	combout => \bloco_operativo|geraBz|Equal0~0_combout\);

-- Location: LCCOMB_X23_Y28_N18
\bloco_controle|process_0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|process_0~0_combout\ = (\bloco_operativo|geraAz|Equal0~1_combout\ & ((\bloco_operativo|geraAz|Equal0~0_combout\) # ((\bloco_operativo|geraBz|Equal0~1_combout\ & \bloco_operativo|geraBz|Equal0~0_combout\)))) # 
-- (!\bloco_operativo|geraAz|Equal0~1_combout\ & (\bloco_operativo|geraBz|Equal0~1_combout\ & ((\bloco_operativo|geraBz|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|geraAz|Equal0~1_combout\,
	datab => \bloco_operativo|geraBz|Equal0~1_combout\,
	datac => \bloco_operativo|geraAz|Equal0~0_combout\,
	datad => \bloco_operativo|geraBz|Equal0~0_combout\,
	combout => \bloco_controle|process_0~0_combout\);

-- Location: LCCOMB_X23_Y28_N24
\bloco_controle|state~12\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|state~12_combout\ = (\bloco_controle|state.S2~q\ & !\bloco_controle|process_0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \bloco_controle|state.S2~q\,
	datad => \bloco_controle|process_0~0_combout\,
	combout => \bloco_controle|state~12_combout\);

-- Location: FF_X23_Y28_N25
\bloco_controle|state.S3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_controle|state~12_combout\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S3~q\);

-- Location: FF_X22_Y28_N29
\bloco_controle|state.S4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_controle|state.S3~q\,
	clrn => \ALT_INV_RST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_controle|state.S4~q\);

-- Location: LCCOMB_X21_Y28_N30
\bloco_controle|CA\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_controle|CA~combout\ = (\bloco_controle|state.S1~q\) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_controle|state.S1~q\,
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_controle|CA~combout\);

-- Location: FF_X21_Y28_N21
\bloco_operativo|regA|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[0]~0_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(0));

-- Location: LCCOMB_X22_Y28_N6
\bloco_operativo|mux2|y[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[0]~0_combout\ = (\bloco_controle|state.S4~q\ & ((\bloco_operativo|regA|q\(0)))) # (!\bloco_controle|state.S4~q\ & (\bloco_operativo|regP|q\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S4~q\,
	datab => \bloco_operativo|regP|q\(0),
	datad => \bloco_operativo|regA|q\(0),
	combout => \bloco_operativo|mux2|y[0]~0_combout\);

-- Location: FF_X22_Y28_N9
\bloco_operativo|regP|q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_operativo|somasub|Add0~3_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	sload => VCC,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(0));

-- Location: FF_X22_Y28_N7
\bloco_operativo|regP|q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_operativo|somasub|Add0~6_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	sload => VCC,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(1));

-- Location: FF_X22_Y28_N31
\bloco_operativo|regP|q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_operativo|somasub|Add0~12_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	sload => VCC,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(3));

-- Location: LCCOMB_X23_Y28_N0
\bloco_operativo|somasub|Add0~14\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~14_combout\ = (\bloco_operativo|regB|q\(4)) # (\bloco_controle|state.S4~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \bloco_operativo|regB|q\(4),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|somasub|Add0~14_combout\);

-- Location: LCCOMB_X22_Y28_N20
\bloco_operativo|somasub|Add0~15\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~15_combout\ = (\bloco_operativo|mux2|y[4]~4_combout\ & ((\bloco_operativo|somasub|Add0~14_combout\ & (\bloco_operativo|somasub|Add0~13\ & VCC)) # (!\bloco_operativo|somasub|Add0~14_combout\ & 
-- (!\bloco_operativo|somasub|Add0~13\)))) # (!\bloco_operativo|mux2|y[4]~4_combout\ & ((\bloco_operativo|somasub|Add0~14_combout\ & (!\bloco_operativo|somasub|Add0~13\)) # (!\bloco_operativo|somasub|Add0~14_combout\ & ((\bloco_operativo|somasub|Add0~13\) # 
-- (GND)))))
-- \bloco_operativo|somasub|Add0~16\ = CARRY((\bloco_operativo|mux2|y[4]~4_combout\ & (!\bloco_operativo|somasub|Add0~14_combout\ & !\bloco_operativo|somasub|Add0~13\)) # (!\bloco_operativo|mux2|y[4]~4_combout\ & ((!\bloco_operativo|somasub|Add0~13\) # 
-- (!\bloco_operativo|somasub|Add0~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|mux2|y[4]~4_combout\,
	datab => \bloco_operativo|somasub|Add0~14_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~13\,
	combout => \bloco_operativo|somasub|Add0~15_combout\,
	cout => \bloco_operativo|somasub|Add0~16\);

-- Location: FF_X22_Y28_N1
\bloco_operativo|regP|q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \bloco_operativo|somasub|Add0~15_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	sload => VCC,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(4));

-- Location: IOIBUF_X16_Y31_N8
\A[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

-- Location: LCCOMB_X21_Y28_N14
\bloco_operativo|mux1|y[5]~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[5]~5_combout\ = (\bloco_controle|state.S1~q\ & (\A[5]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~18_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \A[5]~input_o\,
	datad => \bloco_operativo|somasub|Add0~18_combout\,
	combout => \bloco_operativo|mux1|y[5]~5_combout\);

-- Location: FF_X21_Y28_N15
\bloco_operativo|regA|q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[5]~5_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(5));

-- Location: LCCOMB_X22_Y28_N28
\bloco_operativo|mux2|y[5]~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[5]~5_combout\ = (\bloco_controle|state.S4~q\ & ((\bloco_operativo|regA|q\(5)))) # (!\bloco_controle|state.S4~q\ & (\bloco_operativo|regP|q\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regP|q\(5),
	datac => \bloco_controle|state.S4~q\,
	datad => \bloco_operativo|regA|q\(5),
	combout => \bloco_operativo|mux2|y[5]~5_combout\);

-- Location: LCCOMB_X22_Y28_N22
\bloco_operativo|somasub|Add0~18\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~18_combout\ = ((\bloco_operativo|somasub|Add0~17_combout\ $ (\bloco_operativo|mux2|y[5]~5_combout\ $ (!\bloco_operativo|somasub|Add0~16\)))) # (GND)
-- \bloco_operativo|somasub|Add0~19\ = CARRY((\bloco_operativo|somasub|Add0~17_combout\ & ((\bloco_operativo|mux2|y[5]~5_combout\) # (!\bloco_operativo|somasub|Add0~16\))) # (!\bloco_operativo|somasub|Add0~17_combout\ & (\bloco_operativo|mux2|y[5]~5_combout\ 
-- & !\bloco_operativo|somasub|Add0~16\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|somasub|Add0~17_combout\,
	datab => \bloco_operativo|mux2|y[5]~5_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~16\,
	combout => \bloco_operativo|somasub|Add0~18_combout\,
	cout => \bloco_operativo|somasub|Add0~19\);

-- Location: FF_X22_Y28_N23
\bloco_operativo|regP|q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|somasub|Add0~18_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(5));

-- Location: IOIBUF_X22_Y31_N1
\A[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

-- Location: LCCOMB_X21_Y28_N28
\bloco_operativo|mux1|y[6]~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux1|y[6]~6_combout\ = (\bloco_controle|state.S1~q\ & (\A[6]~input_o\)) # (!\bloco_controle|state.S1~q\ & ((\bloco_operativo|somasub|Add0~21_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S1~q\,
	datac => \A[6]~input_o\,
	datad => \bloco_operativo|somasub|Add0~21_combout\,
	combout => \bloco_operativo|mux1|y[6]~6_combout\);

-- Location: FF_X21_Y28_N29
\bloco_operativo|regA|q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|mux1|y[6]~6_combout\,
	ena => \bloco_controle|CA~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regA|q\(6));

-- Location: LCCOMB_X22_Y28_N2
\bloco_operativo|mux2|y[6]~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[6]~6_combout\ = (\bloco_controle|state.S4~q\ & (\bloco_operativo|regA|q\(6))) # (!\bloco_controle|state.S4~q\ & ((\bloco_operativo|regP|q\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_controle|state.S4~q\,
	datab => \bloco_operativo|regA|q\(6),
	datad => \bloco_operativo|regP|q\(6),
	combout => \bloco_operativo|mux2|y[6]~6_combout\);

-- Location: LCCOMB_X22_Y28_N24
\bloco_operativo|somasub|Add0~21\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~21_combout\ = (\bloco_operativo|somasub|Add0~20_combout\ & ((\bloco_operativo|mux2|y[6]~6_combout\ & (\bloco_operativo|somasub|Add0~19\ & VCC)) # (!\bloco_operativo|mux2|y[6]~6_combout\ & 
-- (!\bloco_operativo|somasub|Add0~19\)))) # (!\bloco_operativo|somasub|Add0~20_combout\ & ((\bloco_operativo|mux2|y[6]~6_combout\ & (!\bloco_operativo|somasub|Add0~19\)) # (!\bloco_operativo|mux2|y[6]~6_combout\ & ((\bloco_operativo|somasub|Add0~19\) # 
-- (GND)))))
-- \bloco_operativo|somasub|Add0~22\ = CARRY((\bloco_operativo|somasub|Add0~20_combout\ & (!\bloco_operativo|mux2|y[6]~6_combout\ & !\bloco_operativo|somasub|Add0~19\)) # (!\bloco_operativo|somasub|Add0~20_combout\ & ((!\bloco_operativo|somasub|Add0~19\) # 
-- (!\bloco_operativo|mux2|y[6]~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|somasub|Add0~20_combout\,
	datab => \bloco_operativo|mux2|y[6]~6_combout\,
	datad => VCC,
	cin => \bloco_operativo|somasub|Add0~19\,
	combout => \bloco_operativo|somasub|Add0~21_combout\,
	cout => \bloco_operativo|somasub|Add0~22\);

-- Location: FF_X22_Y28_N25
\bloco_operativo|regP|q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|somasub|Add0~21_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(6));

-- Location: LCCOMB_X21_Y28_N24
\bloco_operativo|mux2|y[7]~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|mux2|y[7]~7_combout\ = (\bloco_controle|state.S4~q\ & (\bloco_operativo|regA|q\(7))) # (!\bloco_controle|state.S4~q\ & ((\bloco_operativo|regP|q\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|regA|q\(7),
	datac => \bloco_operativo|regP|q\(7),
	datad => \bloco_controle|state.S4~q\,
	combout => \bloco_operativo|mux2|y[7]~7_combout\);

-- Location: LCCOMB_X22_Y28_N26
\bloco_operativo|somasub|Add0~24\ : cycloneiv_lcell_comb
-- Equation(s):
-- \bloco_operativo|somasub|Add0~24_combout\ = \bloco_operativo|somasub|Add0~23_combout\ $ (\bloco_operativo|somasub|Add0~22\ $ (!\bloco_operativo|mux2|y[7]~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \bloco_operativo|somasub|Add0~23_combout\,
	datad => \bloco_operativo|mux2|y[7]~7_combout\,
	cin => \bloco_operativo|somasub|Add0~22\,
	combout => \bloco_operativo|somasub|Add0~24_combout\);

-- Location: FF_X22_Y28_N27
\bloco_operativo|regP|q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \bloco_operativo|somasub|Add0~24_combout\,
	clrn => \bloco_controle|ALT_INV_state.S1~q\,
	ena => \bloco_controle|state.S3~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \bloco_operativo|regP|q\(7));

ww_R <= \R~output_o\;

ww_S(0) <= \S[0]~output_o\;

ww_S(1) <= \S[1]~output_o\;

ww_S(2) <= \S[2]~output_o\;

ww_S(3) <= \S[3]~output_o\;

ww_S(4) <= \S[4]~output_o\;

ww_S(5) <= \S[5]~output_o\;

ww_S(6) <= \S[6]~output_o\;

ww_S(7) <= \S[7]~output_o\;
END structure;


