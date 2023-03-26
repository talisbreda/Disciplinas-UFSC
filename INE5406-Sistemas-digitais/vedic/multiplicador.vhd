LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplicador IS
GENERIC(
	N : integer := 8
);
PORT (CLK, INICIAR: in std_logic;
		A, B: in std_logic_vector(N-1 downto 0);
		R: out std_logic;
		S: out std_logic_vector((2*N)-1 downto 0));
END multiplicador;

ARCHITECTURE estrutura OF multiplicador IS

	COMPONENT bc IS
	PORT (CLK, INICIO : in std_logic;
			ini, pronto : out std_logic);
	END COMPONENT;
	
	COMPONENT registrador IS
   GENERIC(N : integer);
	PORT
   (  load, clk: IN STD_LOGIC;
		data : in std_logic_vector (N-1 downto 0);
      q: OUT STD_LOGIC_vector(N-1 downto 0)
   );
	END COMPONENT;
	
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
	
	Signal ini : std_logic; 
	Signal A_in, B_in : std_logic_vector(N-1 downto 0);
	
BEGIN
	
	BC1: bc port map (CLK, INICIAR, ini, R);
	
	regA: registrador generic map (n) port map (ini, CLK, A, A_in);
	regB: registrador generic map (n) port map (ini, CLK, B, B_in);
	
	multi: if N = 4 generate
		mult4 : fourbitmult port map (CLK, A, B, S);
	end generate multi;
	mult1: if N = 8 generate
		mult8 : eightbitmult port map (CLK, A, B, S);
	end generate mult1;
	mult2: if N = 16 generate
		mult16 : sixteenbitmult port map (CLK, A, B, S);
	end generate mult2;
	
	
END estrutura;