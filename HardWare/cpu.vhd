LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.math_real.all;
USE work.constants.all;

-- this entity 
entity cpu is

    generic(
        n: integer := 16;
        m: integer := 11;
        numRegs: integer := 8
    );

    port(
        clk, resetRegs: in std_logic;
        dataBusIn: in std_logic_vector(n-1 downto 0);
        dataBusOut: out std_logic_vector(n-1 downto 0);
        addressBus: out std_logic_vector(m-1 downto 0);
        writeRam: out std_logic
    );

end cpu;


architecture cpuArch of cpu is

    signal busA, busB, busC, flagsFromALUToFlagReg, flagsFromFlagRegToOut, IRReg: std_logic_vector(n-1 downto 0);
    signal controlSignals: std_logic_vector(SignalsCount-3 downto 0);
    signal gprfSrcDecoderA, gprfDstDecoderB, gprfSrcDecoderC: std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);
    signal controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp: std_logic_vector(1 downto 0);
    signal aluOperation, IROperation: std_logic_vector(4 downto 0);
    signal srcAddressingMode, dstAddressingMode, branchType, secondState: std_logic_vector(2 downto 0);
    signal branchOffset: std_logic_vector(7 downto 0);

    begin

        gprf: entity work.GenenralPurposeRegFile generic map(n, numRegs) port map(
            busA, busC, busB, controlSignals(enableSrcDecoderBusA), controlSignals(enableDstDecoderBusb), 
            controlSignals(enableSrcDecoderBusC), resetRegs, clk, gprfSrcDecoderA, gprfDstDecoderB, gprfSrcDecoderC
            );
        
        
        sprfControl: entity work.SPRFControl port map(
            controlSignals, controlIR, controlMAR, controlMDRIn, 
            controlMDROut, controlFlag, controlTemp
            );
        
        sprf: entity work.SpecialPurposeRegFile generic map(n, m) port map(
            busA, busC, busB, flagsFromALUToFlagReg, addressBus, dataBusIn, dataBusOut, 
            flagsFromFlagRegToOut, IRReg, controlIR, controlMAR, controlMDRIn, 
            controlMDROut, controlFlag, controlTemp, clk, resetRegs
            );


        faluControl: entity work.ALUControl port map(controlSignals, IROperation, aluOperation);
        falu: entity work.alu generic map(n, 5) port map(busC, busA, busB, aluOperation, flagsFromFlagRegToOut, flagsFromALUToFlagReg);

        DC: entity work.decodingCircuit port map(
            IRReg, aluOperation, gprfSrcDecoderA, gprfDstDecoderB, 
            srcAddressingMode, dstAddressingMode, branchType, secondState
            );

        
        SC: entity work.stateControl port map(
            secondState, srcAddressingMode, dstAddressingMode, branchType, 
            clk, controlSignals, flagsFromFlagRegToOut);

        writeRam <= controlSignals(writeSignal);

end architecture;