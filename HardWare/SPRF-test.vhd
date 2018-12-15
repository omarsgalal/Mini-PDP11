LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity SpecialPurposeRegFileTest is
    generic(n: integer := 16;
            m: integer := 11);
end SpecialPurposeRegFileTest;


ARCHITECTURE SpecialPurposeRegFileTestArch OF SpecialPurposeRegFileTest IS 
    
signal busA, busC:std_logic_vector(n-1 downto 0);
signal busB, flagRegisterIn: std_logic_vector(n-1 downto 0);
signal addressBus: std_logic_vector(m-1 downto 0);
signal dataBusIn: std_logic_vector(n-1 downto 0);
signal dataBusOut, flagRegisterOut, IROut: std_logic_vector(n-1 downto 0);
signal controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp: std_logic_vector(1 downto 0);
signal clk, ResetRegs: std_logic;

constant CLK_period : time := 100 ps;
 
BEGIN

sp : entity work.SpecialPurposeRegFile port map(busA, busC, busB, flagRegisterIn, addressBus, dataBusIn, dataBusOut, flagRegisterOut, IROut,controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp, clk, ResetRegs);

CLKprocess : process
begin
    clk <= '0';
    wait for CLK_period/2;
    clkT <= '1';
    wait for CLK_period/2;
end process;


allProcess : PROCESS
    BEGIN
        
        ResetRegs <= '1';
        wait for clk_period;
        ResetRegs <= '0';
        -- controlIR <= "00"; 
        controlMAR <= "00"; 
        controlMDRIn <= "00"; 
        controlMDROut <= "00"; 
        controlFlag <= "00"; 
        controlTemp <= "00";

        busA <= x"0A0A";
        busC <= x"B0B0";
        busB <= x"C00C";

        controlIR <= '10';
        WAIT FOR CLK_period; 
        ASSERT(IROut = x"0A0A")        
        REPORT "IRout not good"
        SEVERITY ERROR;
        
        busA <= x"FFFF";
        controlIR <= '00';
        WAIT FOR CLK_period; 

        
        busA <= (others => 'Z');
        controlIR <= '01';
        WAIT FOR CLK_period;  
        ASSERT(busA = x"0A0A")        
        REPORT "IR not good"
        SEVERITY ERROR;

        controlIR <= '00';

        
        
        --MAR
        --control MAR:
        -- 0X --> don't read
        -- 10 --> read from A
        -- 11 --> read from B
        
        busA <= x"000F";
        controlMAR <= "10";
        WAIT FOR CLK_period;  
        ASSERT(addressBus = '000000001111')        
        REPORT "controlMAR from A"
        SEVERITY ERROR;

        busB <= x"00F0";
        controlMAR <= "11";
        WAIT FOR CLK_period;  
        ASSERT(addressBus = '000011110000')        
        REPORT "controlMAR from B"
        SEVERITY ERROR;
        controlMAR <= "00";

        --MDR
        --control MDRIn Read:
        -- 00 --> don't read
        -- 01 --> read from B
        -- 10 --> read from C
        -- 11 --> read from dataBusIn
        --control MDROut write:
        -- 00 -->don't write
        -- 01 --> write to bus A
        -- 10 --> write to bus C
        -- 11 --> write to bus A and C
        busB <= x"FFFF";
        controlMDRIn <= "01";
        WAIT FOR CLK_period;  
        ASSERT(dataBusOut = x"FFFF")        
        REPORT "dataBusOut problem B"
        SEVERITY ERROR;

        
        
        busC <= (others => 'Z');
        controlMDROut <= "10";
        WAIT FOR CLK_period;  
        ASSERT(busC = x"FFFF")        
        REPORT "MDR problem c"
        SEVERITY ERROR;


        dataBusIn <= x"00FF";
        controlMDRIn <= "11";
        WAIT FOR CLK_period;  
        
        busA <= (others => 'Z');
        controlMDROut <= "01";
        WAIT FOR CLK_period;  
        ASSERT(busA = x"00FF")        
        REPORT "MDR problem A with data bus in"
        SEVERITY ERROR;



        busC <= x"F0FF";
        controlMDRIn <= "10";
        WAIT FOR CLK_period;  
        
        busA <= (others => 'Z');
        controlMDROut <= "01";
        WAIT FOR CLK_period;  
        ASSERT(busA = x"F0FF")        
        REPORT "MDR problem A"
        SEVERITY ERROR;


        --Flag Register
        --control Flag Register:
        -- 00 --> don't read or write
        -- 01 --> write to bus A
        -- 10 --> read from bus A
        -- 11 --> read from outside (ALU)
        
        controlFlag <= "10";
        busA <= x"0F0F";
        WAIT FOR CLK_period;  
        
        busA <= x"00DD";
        WAIT FOR CLK_period;  
        
        busA <= (others => 'Z');
        controlFlag <= "01";
        WAIT FOR CLK_period;  
        ASSERT(busA = x"0F0F")        
        REPORT "Flag register A"
        SEVERITY ERROR;

        flagRegisterIn <= x"ABD0";
        controlFlag <= "11";
        WAIT FOR CLK_period; 
        ASSERT(flagRegisterOut = x"ABD0")        
        REPORT "Flag register in/out"
        SEVERITY ERROR;

        
        --Temp
        --control Temp:
        -- 00 --> don't read or write
        -- 01 --> read
        -- 10 --> write
        -- 11 --> don't care (Forbidden)
        
        controlTemp <= "01";
        busC <= x"0F0F";
        WAIT FOR CLK_period;  
        
        busC <= x"00DD";
        WAIT FOR CLK_period;  
        
        busC <= (others => 'Z');
        controlTemp <= "10";
        WAIT FOR CLK_period;  
        ASSERT(busC = x"0F0F")        
        REPORT "temp register A"
        SEVERITY ERROR;
            
        WAIT;
    END PROCESS;	
	
END architecture;