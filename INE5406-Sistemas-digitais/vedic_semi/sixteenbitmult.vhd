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
	ha2: halfadder port map (coutha(1), smult1(9), sha(2), coutha(2));
	ha3: halfadder port map (coutha(2), smult1(10), sha(3), coutha(3));
	ha4: halfadder port map (coutha(3), smult1(11), sha(4), coutha(4));
	ha5: halfadder port map (coutha(4), smult1(12), sha(5), coutha(5));
	ha6: halfadder port map (coutha(5), smult1(13), sha(6), coutha(6));
	ha7: halfadder port map (coutha(6), smult1(14), sha(7), coutha(7));
	ha8: halfadder port map (coutha(7), smult1(15), sha(8), coutha(8));
	
	process (clk)
	begin
		if rising_edge(clk) then
			S(7 downto 0) <= smult4(7 downto 0);
			S(23 downto 8) <= scla2;
			S(31 downto 24) <= sha(8 downto 1);
		end if;
	end process;
	
END estrutura;