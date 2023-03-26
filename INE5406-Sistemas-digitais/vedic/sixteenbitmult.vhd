LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sixteenbitmult IS
PORT (clk: in std_logic;
		A, B: in std_logic_vector(15 downto 0);
		S: out std_logic_vector(31 downto 0));
END sixteenbitmult;

ARCHITECTURE estrutura OF sixteenbitmult IS
	
	component eightbitmult IS
	PORT (clk: in std_logic;
			A, B: in std_logic_vector(7 downto 0);
			S: out std_logic_vector(15 downto 0));
	END component;
	
	component cla16bit is
	PORT (
        A, B : in std_logic_vector (15 downto 0);
		  Ci: in std_logic;
		  S : out std_logic_vector(15 downto 0);
		  Co, PG, GG : out std_logic);
	end component;
	
	component halfadder is
	port (A, B: in std_logic;
		 S, Cout: out std_logic
	  );
	end component;
	
	signal b15to8, a15to8, b7to0, a7to0: std_logic_vector(7 downto 0);
	signal smult1, smult2, smult3, smult4: std_logic_vector(15 downto 0);
	signal scla1, scla2, cla2in: std_logic_vector(15 downto 0);
	signal or2bit, coutcla1, coutcla2, pg1, pg2, gg1, gg2 : std_logic; 
	signal sha, coutha: std_logic_vector(8 downto 1);
	
BEGIN
	
	b15to8 <= B(15 downto 8);
	b7to0 <= B(7 downto 0);
	a15to8 <= A(15 downto 8);
	a7to0 <= A(7 downto 0);
	
	mult1: eightbitmult port map (clk, b15to8, a15to8, smult1);
	mult2: eightbitmult port map (clk, b7to0, a15to8, smult2);
	mult3: eightbitmult port map (clk, b15to8, a7to0, smult3);
	mult4: eightbitmult port map (clk, b7to0, a7to0, smult4);
	
	cla2in <= smult1(7 downto 0) & smult4(15 downto 8);
	
	cla1: cla16bit port map (smult2, smult3, '0', scla1, coutcla1, pg1, gg1);
	cla2: cla16bit port map (cla2in, scla1, '0', scla2, coutcla2, pg1, gg1);
	
	or2bit <= coutcla1 or coutcla2;
	
	ha1: halfadder port map (or2bit, smult1(8), sha(1), coutha(1));
	
	halfadders : for i in 2 to 8 generate
		ha: halfadder port map (coutha(i-1), smult1(i+7), sha(i), coutha(i));
	end generate halfadders;
	
	process (clk)
	begin
		if rising_edge(clk) then
			S(7 downto 0) <= smult4(7 downto 0);
			S(23 downto 8) <= scla2;
			S(31 downto 24) <= sha(8 downto 1);
		end if;
	end process;
	
END estrutura;