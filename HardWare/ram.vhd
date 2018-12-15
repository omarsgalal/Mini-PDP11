LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	generic (n: integer := 16;
		    m: integer := 11);
	PORT(
		clk : IN std_logic;
		enableWrite  : IN std_logic;
		address : IN  std_logic_vector(m-1 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE ramAch OF ram IS

	TYPE ramType IS ARRAY(0 TO 2**m) OF std_logic_vector(n-1 DOWNTO 0);
	SIGNAL ram : ramType ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF enableWrite = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END architecture;