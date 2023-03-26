LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY twobitmult IS
PORT (clk: in std_logic;
		A, B: in std_logic_vector(1 downto 0);
		S: out std_logic_vector(3 downto 0));
END twobitmult;

ARCHITECTURE estrutura OF twobitmult IS
	
	COMPONENT halfadder is
	port (A, B: in std_logic;
		 S, Cout: out std_logic
	  );
	end component;
	
	signal and1, and2, and3, and4, has1, has2, has3, has4: std_logic;
	
BEGIN

	and1 <= A(1) and B(1);
	and2 <= A(1) and B(0);
	and3 <= A(0) and B(1);
	and4 <= A(0) and B(0);
	
	ha1: halfadder port map (and2, and3, has2, has1);
	ha2: halfadder port map (and1, has1, has3, has4);
	
	process (clk)
	begin
		if rising_edge(clk) then
			S(3) <= has4;
			S(2) <= has3;
			S(1) <= has2;
			S(0) <= and4;
		end if;
	end process;

END estrutura;