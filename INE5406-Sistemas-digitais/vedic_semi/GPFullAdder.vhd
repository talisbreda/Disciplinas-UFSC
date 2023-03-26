LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity GPFullAdder is
port
(
-- Inputs
X, Y, Cin : in std_logic;
-- Outputs
G, P, Sum : buffer std_logic );
end GPFullAdder;

architecture Equations of GPFullAdder is

signal P_int : std_logic;

begin
G <= X and Y;
P <= P_int;
P_int <= X xor Y;

Sum <= P_int xor Cin;

end Equations;