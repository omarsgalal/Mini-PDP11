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
        IR <= "0001110001101101";        
        WAIT FOR CLK_period; 
        
        ASSERT(aluOperation = "0001")        
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

        
        ASSERT(nextState = "010")        
        REPORT "nextState"
        SEVERITY ERROR;

        IR <= "0000001100000000";        
        WAIT FOR CLK_period; 
        
        ASSERT(aluOperation = "00010")        
        REPORT "aluOperation"
        SEVERITY ERROR;

        ASSERT(dst = "000")        
        REPORT "dst"
        SEVERITY ERROR;

        ASSERT(dstAddressingMode = "000")        
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


        IR <= "0000001010101101";        
        WAIT FOR CLK_period; 


        ASSERT(nextState = "011")        
        REPORT "nextState"
        SEVERITY ERROR;
        ASSERT(aluOperation="01010")
        REPORT "alu operation"
        severity error;



        

        WAIT;
    END PROCESS;	
	
END architecture;