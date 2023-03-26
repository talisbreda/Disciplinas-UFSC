LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo IS
GENERIC (
	N : integer := 8
);
PORT (clk : IN STD_LOGIC;
      selA, cargaA, cargaB, selP, cargaP, cargamult, r : IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      Azz, Bzz : OUT STD_LOGIC;
      saida: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador IS
	PORT (clk,  reset, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2para1 IS
	PORT ( a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           sel: IN STD_LOGIC;
           y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT somador IS
	PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT subtrator IS
	PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
   COMPONENT igualazero IS
	PORT (a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          igual : OUT STD_LOGIC);
	END COMPONENT;
	
	
		
	SIGNAL sMux1, sMux2, sP, sB, sA, smult, sSoma, sSub: STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	SIGNAL pronto : STD_LOGIC;

BEGIN
	mux1: mux2para1 PORT MAP ("00000000", sSoma, selP, sMux1);
	regP: registrador PORT MAP (clk, r, cargaP, sMux1, sP);
	regA: registrador PORT MAP (clk, r, cargaA, sMux2, sA);
	regB: registrador PORT MAP (clk, r, cargaB, entB, sB);
	regmult: registrador PORT MAP (clk, r, cargamult, sP, smult);
	mux2: mux2para1 PORT MAP (sSub, entA, selA, sMux2);	
	soma: somador PORT MAP (sP, sB, sSoma);
	sub: subtrator PORT MAP (sA, "11111111", sSub);
	geraAz: igualazero PORT MAP (sA, Azz);
	geraBz: igualazero PORT MAP (sB, Bzz);
	
	saida <= smult;

END estrutura;