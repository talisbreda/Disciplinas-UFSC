LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity CLALogic is
port (
-- Inputs
G, P : in std_logic_vector(3 downto 0);
Ci : in std_logic;
-- Outputs
C: buffer std_logic_vector(3 downto 1);
Co, PG, GG : buffer std_logic );

end CLALogic;

architecture Equations of CLALogic is

signal GG_int, PG_int : std_logic;

begin

-- Concurrent assignment statements with delays
C(1) <= G(0) or (P(0) and Ci) after 100 ns;
C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Ci) after 100 ns;
C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Ci) after 100 ns;

PG_int <= P(3) and P(2) and P(1) and P(0) after 100 ns;
GG_int <= G(3) or (P(3) and G(2) ) or (P(3) and P(2) and G(1)) or
(P(3) and P(2) and P(1) and G(0)) after 100 ns;

Co <= GG_int or (PG_int and Ci);
PG <= PG_int;
GG <= GG_int;

end Equations;