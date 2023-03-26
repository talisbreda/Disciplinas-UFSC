LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity CLA4 is
port (
-- Inputs
A, B : in std_logic_vector(3 downto 0);
C_in : in std_logic;
-- outputs
S : buffer std_logic_vector(3 downto 0);
C_out, PG, GG : buffer std_logic );
end CLA4;

architecture structure of CLA4 is

component GPFullAdder
port
(
-- Inputs
X, Y, Cin : in std_logic;
-- Outputs
G, P, Sum : buffer std_logic );
end component;

component CLALogic
port
(
-- Inputs
G, P : in std_logic_vector(3 downto 0);
Ci : in std_logic;
-- Outputs
C: buffer std_logic_vector(3 downto 1);
Co, PG, GG : buffer std_logic );
end component;

signal G, P : std_logic_vector(3 downto 0); -- Carry internal signal
signal C : std_logic_vector(3 downto 1);

begin

CarryLogic: CLALogic port map (G, P, C_in, C, C_out, PG, GG);

FA0 : GPFullAdder port map(A(0), B(0), C_in, G(0), P(0), S(0));
FA1 : GPFullAdder port map(A(1), B(1), C(1), G(1), P(1), S(1));
FA2 : GPFullAdder port map(A(2), B(2), C(2), G(2), P(2), S(2));
FA3 : GPFullAdder port map(A(3), B(3), C(3), G(3), P(3), S(3));


end structure;