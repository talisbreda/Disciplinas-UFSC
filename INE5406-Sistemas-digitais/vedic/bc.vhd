LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (CLK, INICIO : in std_logic;
		ini, pronto : out std_logic);
END bc;

ARCHITECTURE estrutura OF bc IS

TYPE state_type IS (ESPERANDO, CALCULANDO);
SIGNAL STATE: state_type;

BEGIN

	process (clk)
		begin
			if (clk'EVENT AND clk = '1') THEN
				CASE state IS
				WHEN ESPERANDO =>
				pronto <= '1';
				if inicio = '1' then
					ini <= '1';
				elsif inicio = '0' then
					ini <= '0';
				end if;
				WHEN CALCULANDO =>
				pronto <= '0';
				ini <= '0';
				END CASE;
			END if;
		END process;

END estrutura;