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
signal tempSignal: std_logic_vector(Signalscount-3 downto 0);


constant CLK_period : time := 100 ps;

BEGIN

sp : entity work.stateControl port map(secondState, srcAddressingMode, dstAddressingMode, branch, clk, '0', signals, flags);

CLKprocess : process
begin
    clk <= '0';
    wait for CLK_period/2;
    clk <= '1';
    wait for CLK_period/2;
end process;

allProcess : PROCESS
    BEGIN
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        
        secondState <= stateFetchSource;
        srcAddressingMode <= registerDirect;
        dstAddressingMode <= registerDirect;
        branch <= (others => '0');
        flags <= (others => '0');

        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusC => '1', tempInC => '1', enableSrcDecoderBusA => '1', enableDstDecoderBusB => '1', Operation => '1', TempoutC =>'1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t2"
        SEVERITY ERROR;

        

            
        WAIT;
    END PROCESS;	
	
END architecture;