LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity cla16bit is
port (

A, B : in std_logic_vector (15 downto 0);
Ci: in std_logic;
S : out std_logic_vector(15 downto 0);
Co, PG, GG : out std_logic);
end cla16bit;


architecture Structure of cla16bit is
component CLA4 port (
-- Inputs
A, B : in std_logic_vector(3 downto 0);
C_in : in std_logic;
-- outputs
S : buffer std_logic_vector(3 downto 0);
C_out, PG, GG : buffer std_logic
);

end component;

component GPFullAdder port

(
-- Inputs
X, Y, Cin : in std_logic;
-- Outputs
G, P, Sum : buffer std_logic );
end component;

component CLALogic
port (
-- Inputs
G, P : in std_logic_vector(3 downto 0);
Ci : in std_logic;
-- Outputs
C: buffer std_logic_vector(3 downto 1);
Co, PG, GG : buffer std_logic );

end component;


signal S0, S1, S2, S3, G, P : std_logic_vector(3 downto 0);
signal C: std_logic_vector(3 downto 1);
alias A0: std_logic_vector(3 downto 0) is A(3 downto 0);
alias A1: std_logic_vector(3 downto 0) is A(7 downto 4);
alias A2: std_logic_vector(3 downto 0) is A(11 downto 8);
alias A3: std_logic_vector(3 downto 0) is A(15 downto 12);

alias B0: std_logic_vector(3 downto 0) is B(3 downto 0);
alias B1: std_logic_vector(3 downto 0) is B(7 downto 4);
alias B2: std_logic_vector(3 downto 0) is B(11 downto 8);
alias B3: std_logic_vector(3 downto 0) is B(15 downto 12);

begin

CarryLogic: CLALogic port map(G, P, Ci, C, Co, PG, GG);
CLAa : CLA4 port map (A0, B0, Ci, S0, open, P(0), G(0));
CLAb : CLA4 port map (A1, B1, C(1), S1, open, P(1), G(1));
CLAc : CLA4 port map (A2, B2, C(2), S2, open, P(2), G(2));
CLAd : CLA4 port map (A3, B3, C(3), S3, open, P(3), G(3));

S <= S3 & S2 & S1 &S0;


end Structure;