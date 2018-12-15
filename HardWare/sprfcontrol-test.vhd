LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity sprfControlTest is
end sprfControlTest;


ARCHITECTURE sprfControlTestArch OF sprfControlTest IS 

signal controlSignals: std_logic_vector(SignalsCount-3 downto 0);
signal controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp: std_logic_vector(1 downto 0);


constant CLK_period : time := 100 ps;

BEGIN

sp : entity work.sprfControl port map(controlSignals, controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp);

allProcess : PROCESS
    BEGIN
        
        controlSignals <= (IRinA => '1', MARinB => '1', MDRoutA => '1', MDRinB => '1', FlagoutA => '1', TempoutC => '1', others =>'0');
        WAIT FOR CLK_period;  
        
        
        ASSERT(controlIR = "01")        
        REPORT "controlIR"
        SEVERITY ERROR;

        
        ASSERT(controlMAR = "11")        
        REPORT "controlMAR"
        SEVERITY ERROR;

        
        ASSERT(controlMDRIn = "01")        
        REPORT "controlMDRIn"
        SEVERITY ERROR;

        
        ASSERT(controlMDROut = "01")        
        REPORT "controlMDROut"
        SEVERITY ERROR;

        
        ASSERT(controlFlag = "01")        
        REPORT "controlFlag"
        SEVERITY ERROR;

        
        ASSERT(controlTemp = "10")        
        REPORT "controlTemp"
        SEVERITY ERROR;


        
        controlSignals <= (IRout => '1', MARinA => '1', MDRoutC => '1', MDRinC => '1', FlaginA => '1', TempinC => '1', others =>'0');
        WAIT FOR CLK_period;  
        
        
        ASSERT(controlIR = "10")        
        REPORT "controlIR"
        SEVERITY ERROR;

        
        ASSERT(controlMAR = "10")        
        REPORT "controlMAR"
        SEVERITY ERROR;

        
        ASSERT(controlMDRIn = "10")        
        REPORT "controlMDRIn"
        SEVERITY ERROR;

        
        ASSERT(controlMDROut = "10")        
        REPORT "controlMDROut"
        SEVERITY ERROR;

        
        ASSERT(controlFlag = "10")        
        REPORT "controlFlag"
        SEVERITY ERROR;

        
        ASSERT(controlTemp = "01")        
        REPORT "controlTemp"
        SEVERITY ERROR;


        controlSignals <= (FlagModify => '1', others =>'0');
        WAIT FOR CLK_period;  
        
        
        ASSERT(controlIR = "00")        
        REPORT "controlIR"
        SEVERITY ERROR;

        
        ASSERT(controlMAR = "00")        
        REPORT "controlMAR"
        SEVERITY ERROR;

        
        ASSERT(controlMDRIn = "00")        
        REPORT "controlMDRIn"
        SEVERITY ERROR;

        
        ASSERT(controlMDROut = "00")        
        REPORT "controlMDROut"
        SEVERITY ERROR;

        
        ASSERT(controlFlag = "11")        
        REPORT "controlFlag"
        SEVERITY ERROR;

        
        ASSERT(controlTemp = "00")        
        REPORT "controlTemp"
        SEVERITY ERROR;



        WAIT;
    END PROCESS;	
	
END architecture;