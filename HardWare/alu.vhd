library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity alu is
    generic(n: integer := 16;
            m: integer := 5);

    port(
        A, B: in std_logic_vector(n-1 downto 0);
        F: out std_logic_vector(n-1 downto 0);
        operationControl: in std_logic_vector(m-1 downto 0);
        flagIn: in std_logic_vector(n-1 downto 0);
        flagOut: out std_logic_vector(n-1 downto 0));
end entity alu;



architecture aluArch of alu is


    signal tempA, tempB, tempF: std_logic_vector(n-1 downto 0);
    signal tempCarryIn, tempCarryOut: std_logic;
    signal zeroSignal: std_logic_vector(n-1 downto 0);

    signal FTemp: std_logic_vector(n-1 downto 0);

    begin

        F <= FTemp;
        zeroSignal <= (others => '0');

        --operation codes
        -- transfer (A) --> 00001 
        -- ADD (A + B) --> 00010 
        -- ADC (A + B + carry) --> 00011 
        -- SUB (B - A) --> 00100 
        -- SBC (B - A - carry) --> 00101 
        -- AND (A and B) --> 00110 
        -- OR (A or B) --> 00111 
        -- XNOR (A xnor B) --> 01000       
        -- INC (B + 1) --> 01010
        -- DEC (B - 1) --> 01011
        -- CLR --> 01100
        -- INV (not B) --> 01101
        -- all one operand operation are on B
        -- LSR --> 01110
        -- ROR --> 01111
        -- RRC --> 10000
        -- ASR --> 10001
        -- LSL --> 10010
        -- ROL --> 10011
        -- RLC --> 10100    


        fAdder: entity work.nbitsAdder generic map(n) port map(tempB, tempA, tempCarryIn, tempF, tempCarryOut);

        tempB <= B;

        tempA <= not(A) when operationControl = OperationSUB or operationControl = OperationSBC 
        else (others => '0') when operationControl = OperationINC
        else (others => '1') when operationControl = OperationDEC
        else A;

        tempCarryIn <= '0' when operationControl = OperationADD or operationControl = OperationDEC
        else '1' when operationControl = OperationSUB or operationControl = OperationINC
        else flagIn(cFlag);

        FTemp <= A                                      when operationControl = transferAOperation
        else tempF                                  when (operationControl = OperationADD or operationControl = OperationADC or operationControl = OperationSUB
                                                            or operationControl = OperationSBC or operationControl = OperationINC or operationControl = OperationDEC)
        else (A and B)                              when operationControl = OperationAND
        else (A or B)                               when operationControl = OperationOR
        else (A xnor B)                             when operationControl = OperationXNOR
        else (others => '0')                        when operationControl = OperationCLR
        else not(B)                                 when operationControl = OperationINV
        else '0' & B(n-1 downto 1)                  when operationControl = OperationLSR
        else B(0) & B(n-1 downto 1)                 when operationControl = OperationROR
        else flagIn(cFlag) & B(n-1 downto 1)    when operationControl = OperationRRC
        else B(n-1) & B(n-1 downto 1)               when operationControl = OperationASR
        else B(n-2 downto 0) & '0'                  when operationControl = OperationLSL
        else B(n-2 downto 0) & B(n-1)               when operationControl = OperationROL
        else B(n-2 downto 0) & flagIn(cFlag)    when operationControl = OperationRLC
        else (others => 'Z');

        flagOut(cFlag) <= tempCarryOut          when operationControl = OperationADD or operationControl = OperationADC  or operationControl = OperationSUB  
                                                            or operationControl = OperationSBC  or  operationControl = OperationINC or  operationControl = OperationDEC
        else B(0)                                   when  operationControl = OperationROR or  operationControl = OperationRRC or  operationControl = OperationASR
        else B(n-1)                                 when operationControl = OperationLSL or operationControl = OperationROL or operationControl = OperationRLC
        else flagIn(cFlag);
        
        flagOut(zFlag) <= '1' when  FTemp = zeroSignal
        else flagIn(zFlag);

        flagOut(nFlag) <= '1' when FTemp(n-1) = '1'
        else flagIn(nFlag);
        
        
        flagOut(pFlag) <= '1' when FTemp(0) = '0'
        else flagIn(pFlag);

        --overflow

        flagOut(n-1 downto vFlag+1) <= flagIn(n-1 downto vFlag+1);
        

        --overflow flag has to be done
        -- if(A(n-1) ) then
        --     flagOut(zFlag) <= '1';
        -- end if;

        -- process  is

        --     begin

        --         flagOut <= flagIn;
        --         tempB <= B;
        --         if operationControl = "00001" then
        --             FTemp <= A;
        --             flagOut <= flagIn;
        --         elsif operationControl = "00010" then
        --             tempA <= A;
        --             tempCarryIn <= '0';
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "00011" then
        --             tempA <= A;
        --             tempCarryIn <= flagIn(cFlag);
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "00100" then
        --             tempA <= not(A);
        --             tempCarryIn <= '1';
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "00101" then
        --             tempA <= A;
        --             tempCarryIn <= flagIn(cFlag);
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "00110" then
        --             FTemp <= A and B;
        --         elsif operationControl = "00111" then
        --             FTemp <= A or B;
        --         elsif operationControl = "01000" then
        --             FTemp <= A xnor B;
        --         elsif operationControl = "01010" then
        --             tempA <= (others => '0');
        --             tempCarryIn <= '1';
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "01011" then
        --             tempA <= (others => '1');
        --             tempCarryIn <= '0';
        --             FTemp <= tempF;
        --             flagOut(cFlag) <= tempCarryOut;
        --         elsif operationControl = "01100" then
        --             FTemp <= (others => '0');
        --         elsif operationControl = "01101" then
        --             FTemp <= not(B);
        --         elsif operationControl = "01110" then
        --             FTemp <= '0' & B(n-1 downto 1);
        --             flagOut(cFlag) <= B(0);
        --         elsif operationControl = "01111" then
        --             FTemp <= B(0) & B(n-1 downto 1);
        --             -- tooooooooooo be checked
        --             flagOut(cFlag) <= B(0);
        --         elsif operationControl = "10000" then
        --             FTemp <= flagIn(cFlag) & B(n-1 downto 1);
        --             flagOut(cFlag) <= B(0);
        --         elsif operationControl = "10001" then
        --             FTemp <= B(n-1) & B(n-1 downto 1);
        --             flagOut(cFlag) <= B(0);
        --         elsif operationControl = "10010" then
        --             FTemp <= B(n-2 downto 0) & '0';
        --             flagOut(cFlag) <= B(n-1);
        --         elsif operationControl = "10011" then
        --             FTemp <= B(n-2 downto 0) & B(n-1);
        --             --cheeeeeeeeeeeeeeeeeeeeeeck
        --             flagOut(cFlag) <= B(n-1);
        --         elsif operationControl = "10100" then
        --             FTemp <= B(n-2 downto 0) & flagIn(cFlag);
        --             flagOut(cFlag) <= B(n-1);
        --         end if;
        -- wait for 1 ps;
        -- end process;

end architecture;