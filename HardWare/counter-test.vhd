LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;

entity counterTest is
    generic (n: integer :=2);
end counterTest;


ARCHITECTURE counterTestArch OF counterTest IS 
    
signal load: std_logic_vector(n-1 downto 0);
signal count: std_logic_vector(n-1 downto 0);
signal reset, clk, isLoad: std_logic;

constant CLK_period : time := 100 ps;
 
BEGIN

sp : entity work.counter port map(load,count,reset, clk, isLoad);

CLKprocess : process
begin
    clk <= '0';
    wait for CLK_period/2;
    clkT <= '1';
    wait for CLK_period/2;
end process;


allProcess : PROCESS
    BEGIN
        
        WAIT FOR CLK_period; 
        ASSERT(count = "00")        
        REPORT "before reset is equal 0 also"
        SEVERITY ERROR;

        isLoad <= '0';
        reset <= '1';
        WAIT FOR CLK_period; 
        ASSERT(count = "00")        
        REPORT "reset is equal 0 also"
        reset <= '0';
        



        WAIT FOR CLK_period; 
        ASSERT(count = "01")        
        REPORT "clk not work"
        SEVERITY ERROR;
        
        WAIT FOR CLK_period; 
        ASSERT(count = "10")        
        REPORT "clk not work"
        SEVERITY ERROR;

        WAIT FOR CLK_period; 
        ASSERT(count = "11")        
        REPORT "clk not work"
        SEVERITY ERROR;

        WAIT FOR CLK_period; 
        ASSERT(count = "00")        
        REPORT "clk not work"
        SEVERITY ERROR;

        isLoad <= '1';
        load <= "11";
        WAIT FOR CLK_period; 
        ASSERT(count = "11")        
        REPORT "load not work"
        SEVERITY ERROR;

        reset <= '1';
        isload <= '1';
        load <= "10";
        WAIT FOR CLK_period; 
        ASSERT(count = "10")        
        REPORT "load with reset not work"
        SEVERITY ERROR;

        WAIT;
    END PROCESS;	
	
END architecture;