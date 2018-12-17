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

----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= autoIncrementDirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto increment src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto increment src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment src t6"
        SEVERITY ERROR;


----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= autoDecrementDirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto decrement src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto decrement src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement src t6"
        SEVERITY ERROR;




----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= IndexedDirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "indexed src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "indexed src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed src t7"
        SEVERITY ERROR;



----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= registerIndirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "register indirect src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "register indirect src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "register indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "register indirect src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "register indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "register indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "register indirect src t6"
        SEVERITY ERROR;



        
----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= autoIncrementIndirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto increment indirect src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto increment indirect src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment indirect src t7"
        SEVERITY ERROR;



----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= autoDecrementIndirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto decrement indirect src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto decrement indirect src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement indirect src t7"
        SEVERITY ERROR;



        
----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= IndexedIndirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "indexed indirect src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "indexed indirect src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed indirect src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed indirect src t4"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t7"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t8"
        SEVERITY ERROR;

            
        WAIT;
    END PROCESS;	
	
END architecture;