library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

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

    constant carryFlag: integer:= 0;
    constant zeroFlag: integer:= 1;
    constant negFlag: integer:= 2;
    constant parityFlag: integer:= 3;
    constant overflowFlag: integer:= 4;

    begin

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

        process (A, B, operationControl, flagIn) is

            begin

                flagOut <= flagIn;
                tempB <= B;
                if operationControl = "00001" then
                    F <= A;
                    flagOut <= flagIn;
                elsif operationControl = "00010" then
                    tempA <= A;
                    tempCarryIn <= '0';
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "00011" then
                    tempA <= A;
                    tempCarryIn <= flagIn(carryFlag);
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "00100" then
                    tempA <= not(A);
                    tempCarryIn <= '1';
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "00101" then
                    tempA <= A;
                    tempCarryIn <= flagIn(carryFlag);
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "00110" then
                    F <= A and B;
                elsif operationControl = "00111" then
                    F <= A or B;
                elsif operationControl = "01000" then
                    F <= A xnor B;
                elsif operationControl = "01010" then
                    tempA <= (others => '0');
                    tempCarryIn <= '1';
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "01011" then
                    tempA <= (others => '1');
                    tempCarryIn <= '0';
                    F <= tempF;
                    flagOut(carryFlag) <= tempCarryOut;
                elsif operationControl = "01100" then
                    F <= (others => '0');
                elsif operationControl = "01101" then
                    F <= not(B);
                elsif operationControl = "01110" then
                    F <= '0' & B(n-1 downto 1);
                    flagOut(carryFlag) <= B(0);
                elsif operationControl = "01111" then
                    F <= B(0) & B(n-1 downto 1);
                    -- tooooooooooo be checked
                    flagOut(carryFlag) <= B(0);
                elsif operationControl = "10000" then
                    F <= flagIn(carryFlag) & B(n-1 downto 1);
                    flagOut(carryFlag) <= B(0);
                elsif operationControl = "10001" then
                    F <= B(n-1) & B(n-1 downto 1);
                    flagOut(carryFlag) <= B(0);
                elsif operationControl = "10010" then
                    F <= B(n-2 downto 0) & '0';
                    flagOut(carryFlag) <= B(n-1);
                elsif operationControl = "10011" then
                    F <= B(n-2 downto 0) & B(n-1);
                    --cheeeeeeeeeeeeeeeeeeeeeeck
                    flagOut(carryFlag) <= B(n-1);
                elsif operationControl = "10100" then
                    F <= B(n-2 downto 0) & flagIn(carryFlag);
                    flagOut(carryFlag) <= B(n-1);
                end if;

                --change flags
                if(F = zeroSignal) then
                    flagOut(zeroFlag) <= '1';
                end if;

                if(F(n-1) = '1') then
                    flagOut(negFlag) <= '1';
                end if;

                if(F(0) = '0') then
                    flagOut(parityFlag) <= '1';
                end if;

                --overflow flag has to be done
                -- if(A(n-1) ) then
                --     flagOut(zeroFlag) <= '1';
                -- end if;
            
        end process;
end architecture;