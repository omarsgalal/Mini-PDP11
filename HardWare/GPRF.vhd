LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity GenenralPurposeRegFile is

    generic(n: integer := 16;
            numRegs: integer := 8);

    port(busA, busC: out std_logic_vector(n-1 downto 0);
        busB: in std_logic_vector(n-1 downto 0);
        enableDecoderA, enableDecoderB, enableDecoderC, ResetRegs, clk:in std_logic; 
        decoderA, decoderB, decoderC:in std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0));

end GenenralPurposeRegFile;


architecture GenenralPurposeRegFileArch of GenenralPurposeRegFile is

    TYPE outRegsType IS ARRAY (0 TO numRegs - 1) OF std_logic_vector(n-1 DOWNTO 0);

    signal setRegs: std_logic_vector(numRegs -1 downto 0);
    signal outDecoderA, outDecoderB, outDecoderC: std_logic_vector (numRegs-1 downto 0);
    signal outRegisters: outRegsType;  

    begin

        decA : entity work.decoder generic map(integer(log2(real(numRegs)))) port map (enableDecoderA, decoderA, outDecoderA);
        decB : entity work.decoder generic map(integer(log2(real(numRegs)))) port map (enableDecoderB, decoderB, outDecoderB);
        decC : entity work.decoder generic map(integer(log2(real(numRegs)))) port map (enableDecoderC, decoderC, outDecoderC);

        setRegs <= (others => '0');

        loopGenerateRegs: for i in 0 to numRegs-1 generate
            triRegA : entity work.triState generic map(n) port map (outRegisters(i), busA, outDecoderA(i));
            triRegC : entity work.triState generic map(n) port map (outRegisters(i), busC, outDecoderC(i));
            Reg : entity work.nDFlipFlop generic map(n) port map (busB, clk, setRegs(i), ResetRegs, outDecoderB(i), outRegisters(i));
        end generate;

end architecture;