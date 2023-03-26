library ieee;
use ieee.std_logic_1164.all;

entity multiplicador is
generic(
        N: integer := 4 -- Mude o número de bits
    );

port(
        CLK, RST, INIT  :   in  std_logic;
        A, B	        :	in  std_logic_vector(N-1 downto 0);
        R               :   out std_logic;
        S               :   out std_logic_vector(N-1 downto 0)
    );

end entity;
		
architecture arch of multiplicador is

    component bc is
        port (
        Reset, clk, inicio          : IN STD_LOGIC;
        Az, Bz                      : IN STD_LOGIC;
        pronto                      : OUT STD_LOGIC;
        ini, CA, dec, CP            : OUT STD_LOGIC
    );
    end component;

    component bo is
        generic (N: integer);
        port (
        clk                         : IN STD_LOGIC;
        ini, CP, CA, dec            : IN STD_LOGIC;
        entA, entB                  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        Az, Bz                      : OUT STD_LOGIC;
        saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
    end component;

    signal Az, Bz, ini, CA, dec, CP : std_logic;

begin

    bloco_controle:     bc          PORT MAP (RST, CLK, INIT, 
                                    Az, Bz, 
                                    R,
                                    ini, CA, dec, CP);

    bloco_operativo:    bo          GENERIC MAP (N)
                                    PORT MAP (CLK, 
                                    ini, CP, CA, dec,
                                    A, B, 
                                    Az, Bz, 
                                    S);

end architecture; -- arch