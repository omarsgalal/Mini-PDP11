LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;
USE IEEE.math_real.all;

entity GPRFControl is

    generic (
        numRegs: integer := 8
    );

    port(
        srcOperand, dstOperand: in std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);
        srcIsDst, dstIsSrcA, dstIsSrcC, R7OutA, R7in, R7OutC, R6OutA, R6in: in std_logic;
        finalSrcA, finalDst, finalSrcC: out std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0)
    );

end GPRFControl;


architecture GPRFControlArch of GPRFControl is

    signal currentSrcA, currentSrcC, currentDst: std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);
    signal controlSrcA, controlDstB, controlSrcC: std_logic_vector(1 downto 0);

    begin

        finalDst <= srcOperand when srcIsDst = '1'
        else R7 when R7in = '1'
        else R6 when R6in = '1'
        else dstOperand;

        finalSrcA <= dstOperand when dstIsSrcA = '1'
        else R7 when R7OutA = '1'
        else R6 when R6OutA = '1'
        else srcOperand;
        
        finalSrcC <= dstOperand when dstIsSrcC = '1'
        else R7 when R7OutC = '1'
        else srcOperand;
        
end architecture;