LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
--Exemplo 6 slides 5T

ENTITY registrador IS
   GENERIC(
	N : integer := 8
	);
	PORT
   (
      load, clk: IN STD_LOGIC;
		data : in std_logic_vector (N-1 downto 0);
      q: OUT STD_LOGIC_vector(N-1 downto 0)
   );
END registrador;

ARCHITECTURE bhv OF registrador IS
begin
PROCESS (clk, load, data)                      
   BEGIN
       IF rising_edge(clk) and load = '1' THEN
          q <= data;
       END IF;
		end process;
	end bhv;