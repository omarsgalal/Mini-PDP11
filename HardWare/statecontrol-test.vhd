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
        
        WAIT FOR CLK_period;
        
        
       
----------------------------------------------------------------------------------------------------------------------

        
                
        secondState <= stateFetchSource;
        srcAddressingMode <= autoIncrementDirect;
        dstAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto increment src t0"
        SEVERITY ERROR;
        
        
        
	tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto increment src t1"
        SEVERITY ERROR;

        
	tempSignal <= (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto decrement src t0"
        SEVERITY ERROR;
        
        
        
	tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto decrement src t1"
        SEVERITY ERROR;

        
	tempSignal <= (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "indexed src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "indexed src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
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


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "register indirect src t3"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "register indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "register indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto increment indirect src t0"
        SEVERITY ERROR;
        
        
        
	tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto increment indirect src t1"
        SEVERITY ERROR;

        
	tempSignal <= (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto increment indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto increment indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "auto decrement indirect src t0"
        SEVERITY ERROR;
        
        
        
	tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "auto decrement indirect src t1"
        SEVERITY ERROR;

        
	tempSignal <= (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t2"
        SEVERITY ERROR;


        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t3"
        SEVERITY ERROR;


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "auto decrement indirect src t4"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "auto decrement indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
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

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "indexed indirect src t0"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "indexed indirect src t1"
        SEVERITY ERROR;

        
	    tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
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


        tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "indexed indirect src t5"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', dstIsSrc => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t6"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t7"
        SEVERITY ERROR;

        tempSignal <= (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal)        
        REPORT "indexed indirect src t8"
        SEVERITY ERROR;


         ------------------------------------------

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        secondState <= stateFetchSource;
        srcAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');
         dstAddressingMode <=  registerDirect;
         
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal)        
         REPORT "t0 reg dir"
         SEVERITY ERROR;
         
         
         
        tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t1 reg dir"
         SEVERITY ERROR;
 
         
         tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t2 reg dir"
         SEVERITY ERROR;
 
 
 
         tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t3 reg dir"
         SEVERITY ERROR;
 
 
         tempSignal <= (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t4 reg dir"
         SEVERITY ERROR;
             
         tempSignal <= (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', enableDstDecoderBusB => '1', operation => '1', TempoutC =>'1', EndSignal => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t5 reg dir"
         SEVERITY ERROR;
         
         
         
         
         ------------------------------------------
         
         dstAddressingMode <=  autoIncrementDirect;
                 
 
         tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
         
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal)        
         REPORT "t0 reg dir"
         SEVERITY ERROR;
         
         
         
             tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t1 reg dir"
         SEVERITY ERROR;
 
         
         tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t2 reg dir"
         SEVERITY ERROR;
 
 
 
         tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t3 reg dir"
         SEVERITY ERROR;
 
 
         tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t4 reg dir"
         SEVERITY ERROR;
             
         tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1',  others => '0');
         
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t5 auto inc"
         SEVERITY ERROR;
         
         tempSignal <=   (MDRoutA => '1',MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1',  others => '0'); 
         
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t6 auto inc"
         SEVERITY ERROR;
 
 
         ------------------------------------------
         
         dstAddressingMode <=  autoDecrementDirect;
         tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');        
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal)        
         REPORT "t0 reg dir"
         SEVERITY ERROR;
         
         
         
        tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t1 reg dir"
         SEVERITY ERROR;
 
         
         tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
         WAIT FOR CLK_period;
         ASSERT(signals = tempSignal )        
         REPORT "t2 reg dir"
         SEVERITY ERROR;
 
 
 
         tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t3 reg dir"
         SEVERITY ERROR;
 
 
         tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t4 reg dir"
         SEVERITY ERROR;
             
         tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t5 auto dec"
         SEVERITY ERROR;
 
         tempSignal <=   (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0'); 
         WAIT FOR CLK_period;
         ASSERT(signals =tempSignal )        
         REPORT "t6 auto dec"
         SEVERITY ERROR;
 


        ------------------------------------------
        dstAddressingMode <=  IndexedDirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
        tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;


        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 indexed"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 indexed"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 indexed"
        SEVERITY ERROR;
        
        ------------------------------------------
        dstAddressingMode <=  registerIndirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');    
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 reg indir"
        SEVERITY ERROR;


        tempSignal <=   (MDRoutA => '1',MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1',  others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 reg indir"
        SEVERITY ERROR;
        

        ------------------------------------------
        
        dstAddressingMode <=  autoIncrementIndirect;
                

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1',  others => '0'); 
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 auto inc indirect"
        SEVERITY ERROR;


        
        tempSignal <=   (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 auto inc indirect"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1',MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1',  others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 auto inc indirect"
        SEVERITY ERROR;


        ------------------------------------------
        
        dstAddressingMode <=  autoDecrementIndirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 auto dec indirect"
        SEVERITY ERROR;

        tempSignal <=   (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 auto dec indirect"
        SEVERITY ERROR;


        tempSignal <=   (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 auto dec indirect"
        SEVERITY ERROR;

        
        
        ------------------------------------------
        dstAddressingMode <=  IndexedIndirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 indexed indirect"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 indexed indirect"
        SEVERITY ERROR;

        tempSignal <=   (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 indirect indexed indirect"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', MDRinB => '1', operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t8 indexed indirect"
        SEVERITY ERROR;
   
        

-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "000";
        flags <= (others => '0');

        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BR"
        SEVERITY ERROR;


-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "001";
        flags <= (zFlag => '1', others => '0');

        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BEQ0"
        SEVERITY ERROR;



        secondState <= stateBranch;
        branch <= "001";
        flags <= (others => '0');

        tempSignal <= (EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BEQ1"
        SEVERITY ERROR;


-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "010";
        flags <= (zFlag => '1', others => '0');

        tempSignal <= (EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BNE0"
        SEVERITY ERROR;
        
        
        
        secondState <= stateBranch;
        flags <= (others => '0');
        
        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BNE1"
        SEVERITY ERROR;



-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "011";
        flags <= (cFlag => '1', others => '0');

        tempSignal <= (EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BLO0"
        SEVERITY ERROR;
        
        
        
        secondState <= stateBranch;
        flags <= (others => '0');
        
        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BLO1"
        SEVERITY ERROR;




-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "100";
        flags <= (cFlag => '1', others => '0');
        
        tempSignal <= (EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BLS0"
        SEVERITY ERROR;
        
        
        
        secondState <= stateBranch;
        flags <= (cFlag => '0', zFlag => '1', others => '0');
        
        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');

        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BLS1"
        SEVERITY ERROR;



-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "101";
        flags <= (others => '0');

        tempSignal <= (EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BHI0"
        SEVERITY ERROR;
        
        
        
        secondState <= stateBranch;
        flags <= (cFlag => '1', others => '0');
        
        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BHI1"
        SEVERITY ERROR;

        

-------------------------------------------------------------------------------------------------------------------



        secondState <= stateBranch;
        branch <= "110";
        flags <= (others => '0');

        tempSignal <= (EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BHS0"
        SEVERITY ERROR;
        
        
        
        secondState <= stateBranch;
        flags <= (cFlag => '1', zFlag => '1', others => '0');
        
        tempSignal <= (IRout => '1', enableSrcDecoderBusC => '1', R7outC => '1', Add => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0');
        
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "BHS1"
        SEVERITY ERROR;
        
        
        WAIT;
    END PROCESS;	
	
END architecture;