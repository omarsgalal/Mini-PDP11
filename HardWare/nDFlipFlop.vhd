LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity nDFlipFlop is
    generic (n: integer := 16);

    port(	D: in std_logic_vector(n-1 downto 0); 
            CLK, SET, RST, enable: in std_logic;
            Q: out std_logic_vector(n-1 downto 0));

end nDFlipFlop;


architecture nDFlipFlopArch of nDFlipFlop is

    begin

        loop1: for i in 0 to n-1 generate
            FF : entity work.DFlipFlop port map(D(i), CLK, SET, RST,enable, Q(i));
        end generate;

end architecture;