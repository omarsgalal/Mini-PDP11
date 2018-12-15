LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

-- this entity 
entity cpu is

    generic(
        n: integer := 16;
        m: integer := 11
    );

    port(
        clk: in std_logic;
        dataBusIn: in std_logic_vector(n-1 downto 0);
        dataBusOut: out std_logic_vector(n-1 downto 0);
        addressBus: out std_logic_vector(m-1 downto 0)
    );

end cpu;


architecture cpuArch of cpu is

    signal busA, busB, busC: std_logic_vector(n-1 downto 0);

    begin

        -- gprg: entitiy work.GenenralPurposeRegFile generic map(n, m) port map(busA, busC, busB, );
        

end architecture;