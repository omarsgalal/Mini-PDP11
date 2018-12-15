LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity SpecialPurposeRegFile is

    generic(n: integer := 16;
            m: integer := 11);

    port(
        busA, busC: inout std_logic_vector(n-1 downto 0);
        busB, flagRegisterIn: in std_logic_vector(n-1 downto 0);
        addressBus: out std_logic_vector(m-1 downto 0);
        dataBusIn: in std_logic_vector(n-1 downto 0);
        dataBusOut, flagRegisterOut, IROut: out std_logic_vector(n-1 downto 0);
        controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp: in std_logic_vector(1 downto 0);
        clk, ResetRegs:in std_logic);

end SpecialPurposeRegFile;


architecture SpecialPurposeRegFileArch of SpecialPurposeRegFile is

    signal IRReg, MARReg, MDRReg, FlagReg, TempReg, MARInput, MDRInput, FlagInput, IRaddressField: std_logic_vector(n-1 downto 0);
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
        IRaddressField <= notAddressField & IRReg(6 downto 0);
        triIR : entity work.triState generic map(n) port map (IRaddressField, busA, controlIR(1));
        RegIR : entity work.nDFlipFlop generic map(n) port map (busA, clk, ResetRegs, controlIR(0), IRReg);

        
        --MAR
        --control MAR:
        -- 0X --> don't read
        -- 10 --> read from A
        -- 11 --> read from B
        muxMAR : entity work.mux2 generic map(n) port map (busA, busB, controlMAR(0), MARInput);
        RegMAR : entity work.nDFlipFlop generic map(n) port map (MARInput, clk, ResetRegs, controlMAR(1), MARReg);


        --MDR
        --control MDRIn Read:
        -- 00 --> don't read
        -- 01 --> read from B
        -- 10 --> read from C
        -- 11 --> read from dataBusIn
        enableMDRRead <= '0' when controlMDRIn = "00"
                        else '1';
        muxMDR : entity work.mux4 generic map(n) port map (MDRReg, busB, busC, dataBusIn, controlMDRIn, MDRInput);
        RegMDR : entity work.nDFlipFlop generic map(n) port map (MARInput, clk, ResetRegs, enableMDRRead, MDRReg);

        --control MDROut write:
        -- 00 -->don't write
        -- 01 --> write to bus A
        -- 10 --> write to bus C
        -- 11 --> write to bus A and C
        triMDRA : entity work.triState generic map(n) port map (MDRReg, busA, controlMDROut(0));
        triMDRC : entity work.triState generic map(n) port map (MDRReg, busC, controlMDROut(1));


        --Flag Register
        --control Flag Register:
        -- 00 --> don't read or write
        -- 01 --> write to bus A
        -- 10 --> read from bus A
        -- 11 --> read from outside (ALU)
        
        enableFlagWrite <= controlFlag(0) and (not controlFlag(1));
        triFlag : entity work.triState generic map(n) port map (FlagReg, busA, enableFlagWrite);
        muxFlag : entity work.mux2 generic map(n) port map (busA, flagRegisterIn, controlFlag(0), FlagInput);
        RegFlag : entity work.nDFlipFlop generic map(n) port map (FlagInput, clk, ResetRegs, controlFlag(1), FlagReg);


        --Temp
        --control Temp:
        -- 00 --> don't read or write
        -- 01 --> read
        -- 10 --> write
        -- 11 --> don't care (Forbidden)
        triTemp : entity work.triState generic map(n) port map (TempReg, busC, controlTemp(1));
        RegTemp : entity work.nDFlipFlop generic map(n) port map (busC, clk, ResetRegs, controlTemp(0), TempReg);

        
        --out always to address bus
        addressBus <= MARReg(m-1 downto 0);

        --out always the IR
        IROut <= IRReg;

        --out always to data bus from MDR
        dataBusOut <= MDRReg;

        --out always flag register
        flagRegisterOut <= flagReg;

end architecture;