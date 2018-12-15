LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;


entity ALUControl is

    port(
        controlSignals: in std_logic_vector(SignalsCount-3 downto 0);
        IROperation: in std_logic_vector(4 downto 0);
        aluOperation: out std_logic_vector(4 downto 0)
    );

end ALUControl;


architecture ALUControlArch of ALUControl is

    begin

        aluOperation <= OperationADD when controlSignals(Add) = '1'
        else OperationINC when controlSignals(inc) = '1'
        else OperationDEC when controlSignals(dec) = '1'
        else IROperation;
    
end architecture;