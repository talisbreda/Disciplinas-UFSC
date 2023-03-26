LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY main IS
GENERIC(
	N : integer := 16
);
PORT (CLK_1Hz: in std_logic;
		A, B: in std_logic_vector(N-1 downto 0);
		S: out std_logic_vector((2*N)-1 downto 0));
END main;

ARCHITECTURE estrutura OF main IS
	
	component fourbitmult IS
	PORT (clk: in std_logic;
			A, B: in std_logic_vector(3 downto 0);
			S: out std_logic_vector(7 downto 0));
	END component;
	
	component eightbitmult IS
	PORT (clk: in std_logic;
			A, B: in std_logic_vector(7 downto 0);
			S: out std_logic_vector(15 downto 0));
	END component;
	
	component sixteenbitmult is
	PORT (clk: in std_logic;
         A, B: in std_logic_vector(15 downto 0);
			S: out std_logic_vector(31 downto 0));
	end component;
	
BEGIN
	
	multi: if N = 4 generate
		mult4 : fourbitmult port map (CLK_1Hz, A, B, S);
	end generate multi;
	mult1: if N = 8 generate
		mult8 : eightbitmult port map (CLK_1Hz, A, B, S);
	end generate mult1;
	mult2: if N = 16 generate
		mult16 : sixteenbitmult port map (CLK_1Hz, A, B, S);
	end generate mult2;
	
	
END estrutura;