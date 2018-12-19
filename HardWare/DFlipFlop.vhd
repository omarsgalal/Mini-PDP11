LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity DFlipFlop is

    port(D, CLK, SET, RST, enable: in std_logic;
        Q: out std_logic);

end DFlipFlop;


architecture DFlipFlopArch of DFlipFlop is

begin

    process(D, CLK, RST, SET, enable) is

        begin

            if (SET = '1' and rising_edge(CLK))
            then Q <= '1';

            elsif(RST = '1' and rising_edge(CLK))
            then Q <= '0';

            elsif (rising_edge(CLK) and enable = '1')
            then Q <= D;

            end if;

    end process;

end architecture;