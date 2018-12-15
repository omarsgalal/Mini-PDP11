LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity decodingCircuitTest is
end decodingCircuitTest;


ARCHITECTURE decodingCircuitTestArch OF decodingCircuitTest IS 

signal IR: std_logic_vector(15 downto 0);
signal aluOperation: std_logic_vector(4 downto 0);
signal src, dst, srcAddressingMode, dstAddressingMode, branch: std_logic_vector(2 downto 0);
signal nextState: std_logic_vector(2 downto 0);


constant CLK_period : time := 100 ps;

BEGIN

sp : entity work.decodingCircuit port map(IR, aluOperation, src, dst, srcAddressingMode, dstAddressingMode, branch, nextState);

allProcess : PROCESS
    BEGIN
        IR <= "1010110001101101";        
        WAIT FOR CLK_period; 
        
        ASSERT(aluOperation = "01010")        
        REPORT "aluOperation"
        SEVERITY ERROR;

        ASSERT(src = "001")        
        REPORT "src"
        SEVERITY ERROR;

        ASSERT(dst = "101")        
        REPORT "dst"
        SEVERITY ERROR;

        ASSERT(srcAddressingMode = "110")        
        REPORT "srcAddressingMode"
        SEVERITY ERROR;

        ASSERT(dstAddressingMode = "101")        
        REPORT "dstAddressingMode"
        SEVERITY ERROR;

        ASSERT(branch = "100")        
        REPORT "branch "
        SEVERITY ERROR;

        ASSERT(nextState = "010")        
        REPORT "nextState"
        SEVERITY ERROR;

        IR <= "0000010001101101";        
        WAIT FOR CLK_period; 
        
        ASSERT(aluOperation = "10001")        
        REPORT "aluOperation"
        SEVERITY ERROR;

        ASSERT(dst = "101")        
        REPORT "dst"
        SEVERITY ERROR;

        ASSERT(dstAddressingMode = "101")        
        REPORT "dstAddressingMode"
        SEVERITY ERROR;


        ASSERT(nextState = "011")        
        REPORT "nextState"
        SEVERITY ERROR;


        IR <= "0000110001101101";        
        WAIT FOR CLK_period; 


        ASSERT(branch = "100")        
        REPORT "branch "
        SEVERITY ERROR;

        ASSERT(nextState = "001")        
        REPORT "nextState"
        SEVERITY ERROR;


        IR <= "0000000001101101";        
        WAIT FOR CLK_period; 


        ASSERT(nextState = "111")        
        REPORT "nextState"
        SEVERITY ERROR;



        

        WAIT;
    END PROCESS;	
	
END architecture;