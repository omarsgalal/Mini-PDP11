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
    signal tempCarryIn, tempCarryOut, tempOverflow: std_logic;
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


        fAdder: entity work.nbitsAdder generic map(n) port map(tempB, tempA, tempCarryIn, tempF, tempCarryOut, tempOverflow);

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

        --carry flag
        flagOut(cFlag) <= tempCarryOut          when operationControl = OperationADD or operationControl = OperationADC  or operationControl = OperationSUB  
                                                            or operationControl = OperationSBC  or  operationControl = OperationINC or  operationControl = OperationDEC
        else B(0)                                   when  operationControl = OperationROR or  operationControl = OperationRRC or  operationControl = OperationASR
        else B(n-1)                                 when operationControl = OperationLSL or operationControl = OperationROL or operationControl = OperationRLC
        else '0';
        
        --zero flag
        flagOut(zFlag) <= '1' when  FTemp = zeroSignal
                        else '0';
        --negative flag
        flagOut(nFlag) <= FTemp(n-1);
        --parity flag
        flagOut(pFlag) <= xor FTemp;
        --overflow flag
        flagOut(vFlag) <= tempOverflow;
        

        flagOut(n-1 downto flagsCount) <= flagIn(n-1 downto flagsCount);
        
end architecture;