LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity counter is

    generic (n: integer :=2);

    port(
        load: in std_logic_vector(n-1 downto 0);
        count: out std_logic_vector(n-1 downto 0);
        reset, clk, isLoad: in std_logic
    );

end counter;


architecture counterArch of counter is

    signal counterInput, countAdded, currentCount, resetOrCurrent: std_logic_vector(n-1 downto 0);

    begin

        counterReg: entity work.nDFlipFlop generic map(2) port map(counterInput, clk, '0', '1', currentCount);
        nextCount: entity work.nbitsAdder generic map(2) port map(currentCount, (others => '0'), '1', countAdded);
        muxloadOrCurrent: entity work.mux2 generic map(2) port map(resetOrCurrent, load, isLoad, counterInput);
        muxInput: entity work.mux2 generic map(2) port map(currentCount, (others => '0'), reset, resetOrCurrent);
        count <= currentCount;

end architecture;