LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY eightbitmult IS
PORT (clk: in std_logic;
		A, B: in std_logic_vector(7 downto 0);
		S: out std_logic_vector(15 downto 0));
END eightbitmult;

ARCHITECTURE estrutura OF eightbitmult IS
	
	component fourbitmult IS
	PORT (clk: in std_logic;
			A, B: in std_logic_vector(3 downto 0);
			S: out std_logic_vector(7 downto 0));
	END component;
	
	component cla8bit is
	Port (x_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         carry_in  :  IN   STD_LOGIC;
         sum       :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
         carry_out :  OUT  STD_LOGIC
        );
	end component;
	
	component halfadder is
	port (A, B: in std_logic;
		 S, Cout: out std_logic
	  );
	end component;
	
	signal b7654, a7654, b3210, a3210: std_logic_vector(3 downto 0);
	signal smult1, smult2, smult3, smult4: std_logic_vector(7 downto 0);
	signal scla1, scla2: std_logic_vector(7 downto 0);
	signal or2bit, sha1, coutha1, sha2, coutha2, sha3, coutha3, sha4, coutha4, coutcla1, coutcla2: std_logic;
	
	signal cla2in: std_logic_vector(7 downto 0);
	
BEGIN
	
	b7654 <= B(7 downto 4);
	b3210 <= B(3 downto 0);
	a7654 <= A(7 downto 4);
	a3210 <= A(3 downto 0);
	
	mult1: fourbitmult port map (clk, b7654, a7654, smult1);
	mult2: fourbitmult port map (clk, b3210, a7654, smult2);
	mult3: fourbitmult port map (clk, b7654, a3210, smult3);
	mult4: fourbitmult port map (clk, b3210, a3210, smult4);
	
	cla2in(7 downto 4) <= smult1(3 downto 0);
	cla2in(3 downto 0) <= smult4(7 downto 4);
	
	cla1: cla8bit port map (smult2, smult3, '0', scla1, coutcla1);
	cla2: cla8bit port map (cla2in, scla1, '0', scla2, coutcla2);
	
	or2bit <= coutcla1 or coutcla2;
	
	ha1: halfadder port map (or2bit, smult1(4), sha1, coutha1);
	ha2: halfadder port map (coutha1, smult1(5), sha2, coutha2);
	ha3: halfadder port map (coutha2, smult1(6), sha3, coutha3);
	ha4: halfadder port map (coutha3, smult1(7), sha4, coutha4);
	
	
	process (clk)
	begin
		if rising_edge(clk) then
			S(3 downto 0) <= smult4(3 downto 0);
			S(11 downto 4) <= scla2;
			S(12) <= sha1;
			S(13) <= sha2;
			S(14) <= sha3;
			S(15) <= sha4;
		end if;
	end process;
	
END estrutura;