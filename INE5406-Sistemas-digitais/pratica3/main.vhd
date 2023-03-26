LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY main IS
GENERIC (
	N : integer := 8
);
PORT (reset, clk: IN STD_LOGIC;
		A, B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END main;

ARCHITECTURE estrutura OF main IS

COMPONENT bc IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
		Az, Bz : IN STD_LOGIC;
		pronto : OUT STD_LOGIC;
		mA, cA, cB, mP, cP, cmult: OUT STD_LOGIC );
END COMPONENT;

COMPONENT bo IS
PORT (clk, r : IN STD_LOGIC;
      selA, cargaA, cargaB, selP, cargaP, cargamult : IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      Azz, Bzz : OUT STD_LOGIC;
      saida: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END COMPONENT;
	SIGNAL BOpronto, BOmA, BOcA, BOcB, BOmP, BOcP, BOcmult: STD_LOGIC;
BEGIN

	bc1: bc PORT MAP (reset, clk, '1', '0', '0', BOPronto, BOmA, BOcA, BOcB, BOmP, BOcP, BOcmult);
	bo1: bo PORT MAP (clk, reset, BOmA, BOcA, BOcB, BOmP, BOcP, BOcmult, A, B);
	
	
END estrutura;