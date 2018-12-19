LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity SpecialPurposeRegFile is

    generic(n: integer := 16;
            m: integer := 11);

    port(
        busA, busC: inout std_logic_vector(n-1 downto 0);
        busB, flagRegisterIn: in std_logic_vector(n-1 downto 0);
        addressBus: out std_logic_vector(m-1 downto 0);
        dataBusIn: in std_logic_vector(n-1 downto 0);
        dataBusOut, flagRegisterOut, IROut: out std_logic_vector(n-1 downto 0);
        controlIR, controlMAR, controlMDRCPUIn, controlMDRRAMOut, controlFlag, controlTemp: in std_logic_vector(1 downto 0);
        enableMDRRAMRead, clk, ResetRegs:in std_logic);

end SpecialPurposeRegFile;


architecture SpecialPurposeRegFileArch of SpecialPurposeRegFile is

    signal IRReg, MARReg, MDRCPUInput, MDRCPUReg, MDRRAMReg, FlagReg, TempReg, MARInput, FlagInput, IRaddressField: std_logic_vector(n-1 downto 0);
    signal enableMDRRead, enableFlagWrite : std_logic;
    signal notAddressField: std_logic_vector(7 downto 0);


    begin

        --IR
        --control IR:
        -- 00 --> don't read or write
        -- 01 --> read
        -- 10 --> write
        -- 11 --> don't care (Forbidden)
        notAddressField <= (others => IRReg(7));
        IRaddressField <= notAddressField & IRReg(7 downto 0);
        triIR : entity work.triState generic map(n) port map (IRaddressField, busA, controlIR(1));
        RegIR : entity work.nDFlipFlop generic map(n) port map (busA, clk, setReg, ResetRegs, controlIR(0), IRReg);

        
        --MAR
        --control MAR:
        -- 0X --> don't read
        -- 10 --> read from A
        -- 11 --> read from B
        muxMAR : entity work.mux2 generic map(n) port map (busA, busB, controlMAR(0), MARInput);
        RegMAR : entity work.nDFlipFlop generic map(n) port map (MARInput, clk, setReg, ResetRegs, controlMAR(1), MARReg);


        --MDR cpu (reads from cpu only)
        --control MDRCPUIn Read:
        -- 00 --> don't read
        -- 01 --> forbidden
        -- 10 --> read from B
        -- 11 --> read from C
        muxMDRCPU : entity work.mux2 generic map(n) port map (busB, busC, controlMDRCPUIn(0), MDRCPUInput);
        RegMDRCPU : entity work.nDFlipFlop generic map(n) port map (MDRCPUInput, clk, setReg, ResetRegs, controlMDRCPUIn(1), MDRCPUReg);


        --MDR ram (reads from ram only)
        --control MDRRAMIn Read:
        -- 0 --> don't read
        -- 1 --> read
        RegMDRRAM : entity work.nDFlipFlop generic map(n) port map (dataBusIn, "not"(clk), setReg, ResetRegs, enableMDRRAMRead, MDRRAMReg);

        --control MDRRAMOut write:
        -- 00 --> don't write
        -- 01 --> write to A
        -- 10 --> write to C
        -- 11 --> forbidden
        triMDRRAMA : entity work.triState generic map(n) port map (MDRRAMReg, busA, controlMDRRAMOut(0));
        triMDRRAMC : entity work.triState generic map(n) port map (MDRRAMReg, busC, controlMDRRAMOut(1));



        --Flag Register
        --control Flag Register:
        -- 00 --> don't read or write
        -- 01 --> write to bus A
        -- 10 --> read from bus A
        -- 11 --> read from outside (ALU)
        enableFlagWrite <= controlFlag(0) and (not controlFlag(1));
        triFlag : entity work.triState generic map(n) port map (FlagReg, busA, enableFlagWrite);
        muxFlag : entity work.mux2 generic map(n) port map (busA, flagRegisterIn, controlFlag(0), FlagInput);
        RegFlag : entity work.nDFlipFlop generic map(n) port map (FlagInput, clk, setReg, ResetRegs, controlFlag(1), FlagReg);


        --Temp
        --control Temp:
        -- 00 --> don't read or write
        -- 01 --> read
        -- 10 --> write
        -- 11 --> don't care (Forbidden)
        triTemp : entity work.triState generic map(n) port map (TempReg, busC, controlTemp(1));
        RegTemp : entity work.nDFlipFlop generic map(n) port map (busC, clk, setReg, ResetRegs, controlTemp(0), TempReg);

        
        --out always to address bus
        addressBus <= MARReg(m-1 downto 0);

        --out always the IR
        IROut <= IRReg;

        --out always to data bus from MDR
        dataBusOut <= MDRCPUReg;

        --out always flag register
        flagRegisterOut <= flagReg;

end architecture;