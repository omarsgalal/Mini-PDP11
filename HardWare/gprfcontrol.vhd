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
        srcIsDst, dstIsSrc, R7OutA, R7in, R7OutC: in std_logic;
        finalSrcA, finalDst, finalSrcC: out std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0)
    );

end GPRFControl;


architecture GPRFControlArch of GPRFControl is

    signal currentSrcA, currentSrcC, currentDst: std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);

    begin

        dstControl: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(dstOperand, srcOperand, srcIsDst, currentDst);
        dstControlF: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(currentDst, R7, R7in, finalDst);

        
        srcControlA: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(srcOperand, dstOperand, dstIsSrc, currentSrcA);
        srcControlAF: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(currentSrcA, R7, R7OutA, finalSrcA);
        
        
        srcControlC: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(srcOperand, dstOperand, dstIsSrc, currentSrcC);
        srcControlCF: entity work.mux2 generic map(integer(log2(real(numRegs)))) port map(currentSrcC, R7, R7OutC, finalSrcC);

end architecture;