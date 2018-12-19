LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.math_real.all;
USE work.constants.all;


entity MotherBoard is

    generic (
        n: integer := 16;
        m: integer := 11;
        numRegs: integer := 8
    );

    port (
        reset: in std_logic
    );

end MotherBoard;


architecture MotherBoardArch of MotherBoard is

    signal dataBusFromCPUToRam, dataBusFromRamToCPU: std_logic_vector(n-1 downto 0);
    signal addressBus: std_logic_vector(m-1 downto 0);
    signal writeRam, clkCPU, clkRam: std_logic;
    constant CLKperiod : time := 100 ps;


    begin
        CLKprocessCPU : process
        begin
            clkCPU <= '0';
            wait for CLKperiod/2;
            clkCPU <= '1';
            wait for CLKperiod/2;
        end process;

        CLKprocessRam : process
        begin
            clkRam <= '1';
            wait for CLKperiod/2;
            clkRam <= '0';
            wait for CLKperiod/2;
        end process;

        fcpu: entity work.cpu generic map(n, m, numRegs) port map(clkCPU, reset, dataBusFromRamToCPU, dataBusFromCPUToRam, addressBus, writeRam);
        fram: entity work.ram generic map(n, m) port map(clkRam, writeRam, addressBus, dataBusFromCPUToRam, dataBusFromRamToCPU);

        
end architecture;