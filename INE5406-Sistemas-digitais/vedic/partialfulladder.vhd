library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity partialfulladder is
Port (A : in STD_LOGIC;
		B : in STD_LOGIC;
		Cin : in STD_LOGIC;
		S : out STD_LOGIC;
		P : out STD_LOGIC;
		G : out STD_LOGIC);
end partialfulladder;
 
architecture Behavioral of partialfulladder is
 
begin
 
	S <= A xor B xor Cin;
	P <= A xor B;
	G <= A and B;
 
end Behavioral;
