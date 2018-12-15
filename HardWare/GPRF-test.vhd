LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity GenenralPurposeRegFileTest is
    generic(n: integer := 16;
            numRegs: integer := 8);
end GenenralPurposeRegFileTest;


ARCHITECTURE GenenralPurposeRegFileTestArch OF GenenralPurposeRegFileTest IS 
    

signal busA, busC: std_logic_vector(n-1 downto 0);
signal busB: std_logic_vector(n-1 downto 0);
signal enableDecoderA, enableDecoderB, enableDecoderC, ResetRegs, clk: std_logic; 
signal decoderA, decoderB, decoderC:std_logic_vector(integer(log2(real(numRegs))) - 1 downto 0);

constant CLK_period : time := 100 ps;
 
BEGIN

sp : entity work.GenenralPurposeRegFile port map(busA, busC, busB,enableDecoderA, enableDecoderB, enableDecoderC, ResetRegs, clk, decoderA, decoderB, decoderC);
CLKprocess : process
begin
    clk <= '0';
    wait for CLK_period/2;
    clk <= '1';
    wait for CLK_period/2;
end process;


allProcess : PROCESS
BEGIN

        ResetRegs <= '1';
        wait for clk_period;
        ResetRegs <= '0';
        
        busB <= x"0DD0";
        enableDecoderB <= '1';
        decoderB <= o"2";
        WAIT FOR CLK_period;  
        enableDecoderB <= '0';

        enableDecoderA <= '1';
        decoderA <= o"2";
        WAIT FOR CLK_period;  
        ASSERT(busA = x"0DD0")        
        REPORT "the bus not good"
        SEVERITY ERROR;
        enableDecoderA <= '0';



        enableDecoderC <= '1';
        decoderC <= o"2";
        WAIT FOR CLK_period;  
        ASSERT(busC = x"0DD0")        
        REPORT "the bus not good"
        SEVERITY ERROR;

        WAIT;
    END PROCESS;	
	
END architecture;
