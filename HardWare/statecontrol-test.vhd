LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity stateControlTest is
end stateControlTest;


ARCHITECTURE stateControlTestArch OF stateControlTest IS 

signal secondState: std_logic_vector(2 downto 0);
signal srcAddressingMode, dstAddressingMode, branch: std_logic_vector(2 downto 0);
signal clk: std_logic;
signal signals: std_logic_vector(Signalscount-3 downto 0);
signal flags: std_logic_vector(15 downto 0);


constant CLK_period : time := 100 ps;

BEGIN

sp : entity work.stateControl port map(secondState, srcAddressingMode, dstAddressingMode, branch, clk, signals, flags);

CLKprocess : process
begin
    clk <= '0';
    wait for CLK_period/2;
    clk <= '1';
    wait for CLK_period/2;
end process;

allProcess : PROCESS
    BEGIN
        
        secondState <= stateFetchSource;
        srcAddressingMode <= autoIncrementDirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        WAIT FOR CLK_period; 
	WAIT FOR CLK_period; 
	WAIT FOR CLK_period; 
	WAIT FOR CLK_period;  
        
        

        
        WAIT;
    END PROCESS;	
	
END architecture;