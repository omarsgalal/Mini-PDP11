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
        clk, reset: in std_logic;
        dataBusIn: in std_logic_vector(n-1 downto 0);
        dataBusOut: out std_logic_vector(n-1 downto 0);
        addressBus: out std_logic_vector(m-1 downto 0);
        writeRam: out std_logic
    );

end cpu;


architecture cpuArch of cpu is

    signal busA, busB, busC, flagsFromALUToFlagReg, flagsFromFlagRegToOut, IRReg: std_logic_vector(n-1 downto 0);
    signal controlSignals: std_logic_vector(SignalsCount-3 downto 0);
    signal controlIR, controlMAR, controlMDRCPUIn, controlMDRRAMOut, controlFlag, controlTemp: std_logic_vector(1 downto 0);
    signal srcOperand, dstOperand: std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);
    signal aluOperation, IROperation: std_logic_vector(4 downto 0);
    signal srcAddressingMode, dstAddressingMode, branchType, secondState: std_logic_vector(2 downto 0);
    signal currentSrcA, currentSrcC, currentDst: std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);
    signal clkAll, enableMDRRAMRead: std_logic;


    begin
        clkAll <= '0' when reset = '0' and secondState = stateNoOperand and IROperation = OperationHLT
            else clk;

        gprfcontrol: entity work.GPRFControl generic map(numRegs) port map(
            srcOperand, dstOperand, controlSignals(srcIsDst), controlSignals(dstIsSrcA), controlSignals(dstIsSrcC),
            controlSignals(R7outA), controlSignals(R7inB), controlSignals(R7outC), controlSignals(R6outA), 
            controlSignals(R6inB), currentSrcA, currentDst, currentSrcC
            );

        gprf: entity work.GenenralPurposeRegFile generic map(n, numRegs) port map(
            busA, busC, busB, controlSignals(enableSrcDecoderBusA), controlSignals(enableDstDecoderBusb), 
            controlSignals(enableSrcDecoderBusC), reset, clkAll, currentSrcA, currentDst, currentSrcC
            );
        
        
        sprfControl: entity work.SPRFControl port map(
            controlSignals, controlIR, controlMAR, controlMDRCPUIn, 
            controlMDRRAMOut, controlFlag, controlTemp, enableMDRRAMRead
            );
        
        sprf: entity work.SpecialPurposeRegFile generic map(n, m) port map(
            busA, busC, busB, flagsFromALUToFlagReg, addressBus, dataBusIn, dataBusOut, 
            flagsFromFlagRegToOut, IRReg, controlIR, controlMAR, controlMDRCPUIn, controlMDRRAMOut, 
            controlFlag, controlTemp, enableMDRRAMRead, clkAll, reset
            );


        faluControl: entity work.ALUControl port map(controlSignals, IROperation, aluOperation);
        falu: entity work.alu generic map(n, 5) port map(busC, busA, busB, aluOperation, flagsFromFlagRegToOut, flagsFromALUToFlagReg);

        DC: entity work.decodingCircuit port map(
            IRReg, IROperation, srcOperand, dstOperand, 
            srcAddressingMode, dstAddressingMode, branchType, secondState
            );

        
        SC: entity work.stateControl port map(
            secondState, srcAddressingMode, dstAddressingMode, branchType, 
            IROperation, clkAll, reset, controlSignals, flagsFromFlagRegToOut);

        writeRam <= controlSignals(writeSignal);

end architecture;