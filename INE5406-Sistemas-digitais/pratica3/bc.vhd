LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
      Az, Bz : IN STD_LOGIC;
      pronto : OUT STD_LOGIC;
      mA, cA, cB, mP, cP, cmult: OUT STD_LOGIC );
END bc;


ARCHITECTURE estrutura OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4);
	SIGNAL state: state_type;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, Reset)
	BEGIN
		if(Reset = '1') THEN
			state <= S0 ;
		ELSIF (clk'EVENT AND clk = '1') THEN
			CASE state IS
				WHEN S0 =>
					if (inicio = '1') then
						state <= S1;
					end if;
						
				WHEN S1 =>
					state <= S2;

				WHEN S2 =>
					if (Az = '1' and Bz = '1') then
						state <= S3;
					elsif (Az = '0' and Bz = '0') then
						state <= S4;
					end if;

				WHEN S3 =>
					state <= S2;

				WHEN S4 =>
					state <= S0;

			END CASE;
		END IF;
	END PROCESS;
	
	-- Logica de saida
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				pronto <= '1';
				
			WHEN S1 =>
				pronto <= '0';
				mA <= '1';
				cA <= '1';
				cB <= '1';
				mP <= '1';
				cP <= '1';
				
			WHEN S2 =>
			
			WHEN S3 =>
				mP <= '0';
				cP <= '1';
				mA <= '0';
				cA <= '1';
				
			WHEN S4 =>
				cmult <= '1';
			
				
		END CASE;
	END PROCESS;
END estrutura;