LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY igualazero IS
GENERIC(N: integer);
PORT (a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
igual : OUT STD_LOGIC);
END igualazero;

ARCHITECTURE estrutura OF igualazero IS
signal zero: std_logic_vector(N-1 downto 0) := (others => '0');
BEGIN
	igual <= '1' WHEN A = zero ELSE '0';
END estrutura;