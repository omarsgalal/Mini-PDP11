LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

-- this entity 
entity stateControl is

    port(
        instructionType: in std_logic_vector(1 downto 0);
        srcAddressingMode, dstAddressingMode, branch: in std_logic_vector(2 downto 0);
        clk: in std_logic;
        state, mode:out std_logic_vector(2 downto 0);
        counter:out std_logic_vector(1 downto 0)
    );

end stateControl;


architecture stateControlArch of stateControl is

    

    begin

        

end architecture;