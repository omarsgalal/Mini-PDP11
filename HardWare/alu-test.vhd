library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
entity ALUtest is

end entity;

ARCHITECTURE ALUtestArch of ALUtest is
	signal A, B:  std_logic_vector(15 downto 0);
	signal F:  std_logic_vector(15 downto 0);
	signal operationControl:  std_logic_vector(4 downto 0);
	signal flagIn:  std_logic_vector(15 downto 0);
    signal flagOut:  std_logic_vector(15 downto 0);
    constant CLK_period : time := 100 ps;

    begin


    c: entity work.alu port map(A,B,F,operationControl,flagIn,flagOut);

    process
        TYPE ramType IS ARRAY(0 TO 20) OF std_logic_vector(15 DOWNTO 0);
        CONSTANT outCases : ramType:= ((others => 'Z'),
                                        x"00F0",
                                        x"00FF",
                                        x"0100",
                                        x"FF1F",
                                        x"FF1F",
                                        x"0000",
                                        x"00FF",
                                        x"FF00",
                                        (others => 'Z'),
                                        x"0010",
                                        x"000E",
                                        x"0000",
                                        x"FFF0",
                                        x"0007",
                                        x"8007",
                                        x"8007",
                                        x"0007",
                                        x"001E",
                                        x"001E",
                                        x"001F"
                                        );

        --operation codes

        -- INV (not B) --> 01101
        -- all one operand operation are on B
        -- LSR --> 01110
        -- ROR --> 01111
        -- RRC --> 10000
        -- ASR --> 10001
        -- LSL --> 10010
        -- ROL --> 10011
        -- RLC --> 10100    

        begin
        A<=X"00F0";
        B<=X"000F";
        flagIn<=X"0001";

        for i in 1 to 20 LOOP
            operationControl <= std_logic_vector(to_unsigned(i,5));

            WAIT FOR CLK_period; 
            ASSERT(F = outCases(i))        
            REPORT "error in i = "&integer'image(i)
            SEVERITY ERROR;
    
        end loop;
        wait;
    end process;

end ARCHITECTURE;





