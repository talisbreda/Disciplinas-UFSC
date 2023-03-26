LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fourbitmult IS
PORT (clk: in std_logic := '1';
		A, B: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(7 downto 0));
END fourbitmult;

ARCHITECTURE estrutura OF fourbitmult IS
	
	component twobitmult IS
	PORT (clk: in std_logic;
			A, B: in std_logic_vector(1 downto 0);
			S: out std_logic_vector(3 downto 0));
	END component;
	
	component cla4bit is
	Port (A : in STD_LOGIC_VECTOR (3 downto 0);
			B : in STD_LOGIC_VECTOR (3 downto 0);
			Cin: in STD_LOGIC;
			S : out STD_LOGIC_VECTOR (3 downto 0);
			Cout : out STD_LOGIC);
	end component;
	
	component halfadder is
	port (A, B: in std_logic;
		 S, Cout: out std_logic
	  );
	end component;
	
	signal b3b2, a3a2, b1b0, a1a0: std_logic_vector(1 downto 0);
	signal smult1, smult2, smult3, smult4: std_logic_vector(3 downto 0);
	signal scla1, scla2: std_logic_vector(3 downto 0);
	signal or2bit, sha1, coutha1, sha2, coutha2, coutcla1, coutcla2: std_logic;
	
	signal cla2in: std_logic_vector(3 downto 0);
	
BEGIN
	
	b3b2 <= B(3 downto 2);
	b1b0 <= B(1 downto 0);
	a3a2 <= A(3 downto 2);
	a1a0 <= A(1 downto 0);
	
	tbm1: twobitmult port map (clk, b3b2, a3a2, smult1);
	tbm2: twobitmult port map (clk, b3b2, a1a0, smult2);
	tbm3: twobitmult port map (clk, b1b0, a3a2, smult3);
	tbm4: twobitmult port map (clk, b1b0, a1a0, smult4);
	
	cla1: cla4bit port map (smult2, smult3, '0', scla1, coutcla1);
	
	cla2in(3 downto 2) <= smult1(1 downto 0);
	cla2in(1 downto 0) <= smult4(3 downto 2);
	
	cla2: cla4bit port map (cla2in, scla1, '0', scla2, coutcla2);
	
	or2bit <= coutcla1 or coutcla2;
	
	ha1: halfadder port map (smult1(2), or2bit, sha1, coutha1);
	ha2: halfadder port map (smult1(3), coutha1, sha2, coutha2);
	
	process (clk)
	begin
		if rising_edge(clk) then
			S(1 downto 0) <= smult4(1 downto 0);
			S(5 downto 2) <= scla2;
			S(6) <= sha1;
			S(7) <= sha2;
		end if;
	end process;
	

END estrutura;