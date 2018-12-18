LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity motherBoardTest is
    generic(
        n: integer := 16;
        m: integer := 11;
        numRegs: integer := 8
    );
    end entity;
architecture motherBoardTestArch of  motherBoardTest is
    signal dataBusFromCPUToRam, dataBusFromRamToCPU: std_logic_vector(n-1 downto 0);
    signal addressBus: std_logic_vector(m-1 downto 0);
    signal writeRam, clkCPU, clkRam: std_logic;
    signal resetRegs:  std_logic;
    constant CLK_period : time := 100 ps;
    begin
        fcpu: entity work.cpu generic map(n, m, numRegs) port map(clkCPU, resetRegs, dataBusFromRamToCPU, dataBusFromCPUToRam, addressBus, writeRam);
        fram: entity work.ram generic map(n, m) port map(clkRam, writeRam, addressBus, dataBusFromCPUToRam, dataBusFromRamToCPU);
        process 
            begin
               
--                --addressBus<=X"0000";
--                --dataBusFromCPUToRam<=x"0A0A";
--                --writeRam<='1';
--                --clkCPU<'0';
--                --ramCPU<'1';
--                --wait for CLK_period/2;
--                --clkCPU<'1';
--                --ramCPU<'0';
--                --wait for CLK_period/2;
--                -- addresBus<=x"0000";
--                -- writeRam<='0';
--                -- clkCPU<'0';
--                -- ramCPU<'1';
--                -- wait for CLK_period/2;
--                -- clkCPU<'1';
--                -- ramCPU<'0';
               
               
--               -- Assert(dataBusFromRamToCPU=X"0A0A")
--               --  REPORT "data from memory is not write"
--               --   SEVERITY ERROR;

--               -- addressBus<=x"0000";  
--               ------reset--------------------
              resetRegs<='1';
              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;
          
          
          
              resetRegs<='0';
              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              clkCPU<='0';
              clkRam<='1';
              wait for CLK_period/2;
              clkCPU<='1';
              clkRam<='0';
              wait for CLK_period/2;

              wait;
--                 -----fetch INC N
--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
              
              
              
--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;

--                 assert(dataBusFromRamToCPU<="0000001010011111")
--                 report "the binary of the instruction INC N is not valid"
--                 severity error;


--                 -------------fetch destination
--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;

--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
              
              
              
--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
--                 assert(dataBusFromRamToCPU<="0000000000000101")
--                 report "the destination of  INC N is not valid"
--                 severity error;

--                 -----perform operation

--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
--                 assert(dataBusFromCPUToRam<="0000000000000110")
--                 report "the operation of  INC N is not valid"
--                 severity error;

--                 --------------save operation

--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
              
              
              
--                 clkCPU<='0';
--                 clkRam<='1';
--                 wait for CLK_period/2;
--                 clkCPU<='1';
--                 clkRam<='0';
--                 wait for CLK_period/2;
--                 assert(dataBusFromRamToCPU<="0000000000000110")
--                 report "the save of  INC N is not valid"
--                 severity error;
               
-- -----------end inc N---------------------



--   -----fetch clr N------------------
--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;



--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;

--   assert(dataBusFromRamToCPU<="0000001100011111")
--   report "the binary of the instruction clr  N is not valid"
--   severity error;
--   -----------------------fetch N -----------------------------
--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;



--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;
--   assert(dataBusFromRamToCPU<="0000000000000000")
--   report "the binary of the instruction INC N is not valid"
--   severity error;
-- -------------------end instruction CLR N---------------------


-- ---------------fetch mov #2,R0----------------
--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;



--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;

--   assert(dataBusFromRamToCPU<="0001001111000000")
--   report "the binary of the instruction mov #2,R0 is not valid"
--   severity error;

--   -----------fetch source,save------------
--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;



--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;

--   assert(dataBusFromRamToCPU<="0000000000000010")
--   report "the source of the instruction mov #2,R0 is not valid"
--   severity error;
--   ------------------end mov #2,R0-----------




--   -------------fetch mov #3,R1-----------------------

-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;



-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;

-- assert(dataBusFromRamToCPU<="0001001111000001")
-- report "the binary of the instruction mov #3,R1 is not valid"
-- severity error;
-- -----------------fetch source and save
-- clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;



--   clkCPU<='0';
--   clkRam<='1';
--   wait for CLK_period/2;
--   clkCPU<='1';
--   clkRam<='0';
--   wait for CLK_period/2;

--   assert(dataBusFromRamToCPU<="0000000000000011")
--   report "the source of the instruction mov #2,R0 is not valid"
--   severity error;
--   -------------end mov #3,R1----------------------------------


-- -------------------------fetch ADD R0,R1-------------------------------


-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;



-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;

-- assert(dataBusFromRamToCPU<="0010000000000001")
-- report "the binary of the instruction ADD R0,R1 is not valid"
-- severity error;

-- --------------------perform operation--------------------------
-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;
-- -------------end ADD R0,R1-----------------


-- -------------------------fetch mov R1,N-------------------------------


-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;



-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;

-- assert(dataBusFromRamToCPU<="0001000001011111")
-- report "the binary of the instruction mov R1,N is not valid"
-- severity error;
-- -------------------fetch source destination ------------------

-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;



-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;

-- clkCPU<='0';
-- clkRam<='1';
-- wait for CLK_period/2;
-- clkCPU<='1';
-- clkRam<='0';
-- wait for CLK_period/2;

-- assert(dataBusFromRamToCPU<="0000000000000101")
-- report "the binary of the instruction mov R1,N is not valid"
-- severity error;            
                
--  wait;
                end process;
                end architecture;



