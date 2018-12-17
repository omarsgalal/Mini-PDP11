LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.dstAddressingMode <= s.all;

entity stateControlTest is
end stateControlTest;


ARCHITECTURE stateControlTestArch OF stateControlTest IS 

signal secondState: std_logic_vector(2 downto 0);
signal srcAddressingMode, dstAddressingMode, branch: std_logic_vector(2 downto 0);
signal clk: std_logic;
signal signals: std_logic_vector(Signalscount-3 downto 0);
signal flags: std_logic_vector(15 downto 0);
signal tempSignal: std_logic_vector(Signalscount-3 downto 0);


dstAddressingMode <=  CLK_period : time := 100 ps;

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
        secondState <= stateFetchSource;
        srcAddressingMode <= IndexedIndirect;
        branch <= (others => '0');
        flags <= (others => '0');
        WAIT FOR CLK_period;
        
        
        ------------------------------------------
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

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 reg dir"
        SEVERITY ERROR;
        
        
        
        
        ------------------------------------------
        
        dstAddressingMode <=  autoIncrementDirect;
                

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1',  others => '0---- 
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 auto inc"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1',MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1',  others => '0---- 
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 auto inc"
        SEVERITY ERROR;


        ------------------------------------------
        
        dstAddressingMode <=  autoDecrementDirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1',enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 auto dec"
        SEVERITY ERROR;

        tempSignal <=   (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 auto dec"
        SEVERITY ERROR;

        
        
        ------------------------------------------
        dstAddressingMode <=  IndexedDirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
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
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 indexed"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t6 indexed"
        SEVERITY ERROR;
        
        tempSignal <=   (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 indexed"
        SEVERITY ERROR;
        
        ------------------------------------------
        dstAddressingMode <=  registerIndirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');    
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t2 reg dir"
        SEVERITY ERROR;



        tempSignal <= (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0'); 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t3 reg dir"
        SEVERITY ERROR;


        tempSignal <=  (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t4 reg dir"
        SEVERITY ERROR;
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', others => '0---- 
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t5 reg indir"
        SEVERITY ERROR;
        

        ------------------------------------------
        
        dstAddressingMode <=  autoIncrementIndirect;
                

        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
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
        
        tempSignal <=   (MDRoutA => '1',MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1',  others => '0');
        
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 auto inc indirect"
        SEVERITY ERROR;


        ------------------------------------------
        
        dstAddressingMode <=  autoDecrementDirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');        
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
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


        tempSignal <=   (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t7 auto dec indirect"
        SEVERITY ERROR;

        
        
        ------------------------------------------
        dstAddressingMode <=  IndexedDirect;
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal)        
        REPORT "t0 reg dir"
        SEVERITY ERROR;
        
        
        
	    tempSignal <= (MDRoutA => '1', IRinA => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals = tempSignal )        
        REPORT "t1 reg dir"
        SEVERITY ERROR;

        
        tempSignal <= (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
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
            
        tempSignal <=   (MDRoutC => '1', tempInC => '1', enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0');
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
        
        tempSignal <=   (MDRoutA => '1', MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0');
        WAIT FOR CLK_period;
        ASSERT(signals =tempSignal )        
        REPORT "t8 indexed indirect"
        SEVERITY ERROR;
        
        
        
        WAIT;
    END PROCESS;	
	
END architecture;