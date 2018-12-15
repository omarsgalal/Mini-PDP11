LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity aluControlTest is
end aluControlTest;


ARCHITECTURE aluControlTestArch OF aluControlTest IS 

signal controlSignals: std_logic_vector(SignalsCount-3 downto 0);
signal IROperation: std_logic_vector(4 downto 0);
signal aluOperation: std_logic_vector(4 downto 0);


constant CLK_period : time := 100 ps;

BEGIN

sp : entity work.aluControl port map(controlSignals, IROperation, aluOperation);

allProcess : PROCESS
    BEGIN
        
        controlSignals <= (operation => '1', others => '0');
        IROperation <= "01111";
        WAIT FOR CLK_period;  
        
        
        ASSERT(aluOperation = IROperation)
        REPORT "controlIR"
        SEVERITY ERROR;

        ----------------------------------------------------------------
        
        controlSignals <= (inc => '1', others => '0');
        IROperation <= "01111";
        WAIT FOR CLK_period;  
        
        
        ASSERT(aluOperation = OperationINC)
        REPORT "controlIR"
        SEVERITY ERROR;

        ---------------------------------------------------------------
        
        controlSignals <= (dec => '1', others => '0');
        IROperation <= "01111";
        WAIT FOR CLK_period;  
        
        
        ASSERT(aluOperation = OperationDEC)
        REPORT "controlIR"
        SEVERITY ERROR;

        ------------------------------------------------------------------
        
        controlSignals <= (Add => '1', others => '0');
        IROperation <= "01111";
        WAIT FOR CLK_period;  
        
        
        ASSERT(aluOperation = OperationADD)
        REPORT "controlIR"
        SEVERITY ERROR;

        ------------------------------------------------------------------
        
        controlSignals <= (others => '0');
        IROperation <= "01111";
        WAIT FOR CLK_period;  
        
        
        ASSERT(aluOperation = IROperation)
        REPORT "controlIR"
        SEVERITY ERROR;

        WAIT;
    END PROCESS;	
	
END architecture;