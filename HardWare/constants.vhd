library IEEE;
USE IEEE.std_logic_1164.all;
package constants is    

--Signals
constant R7outA: integer:=0;
constant MARinA: integer :=1;
constant readSignal:integer :=2;
constant INC_R7 :integer :=3;
constant WMFC: integer:=4;
constant MDRoutA: integer:=5;
constant IRinA:integer :=6;
constant enableSrcDecoderBusA: integer :=7;---the decoder from GPRF to bus A
constant enableSrcDecoderBusC: integer :=8;-----the decoder from GPRF to bus C
constant tempInC:integer :=9;
constant inc:integer :=10;--F=B+1
constant enableDstDecoderBusB:integer :=11;----decoder from bus b to GPRF
constant MDRoutC: integer :=12;
constant dec: integer :=13; --F=B-1
constant MARinB : integer :=14;
constant Add:integer :=15;
constant IRout:integer:=16;
constant writeSignal:integer:=17;
constant EndSignal:integer:=18;
constant MDRinB:integer:=19;
constant R7outC: integer:=20;
constant R7inB: integer:=21;
constant MDRinC: integer:=22;
constant FlagoutA: integer:=23;
constant FlaginA: integer:=24;
constant FlagModify: integer:=25;
constant Operation: integer:=26;
constant TempoutC: integer:=27;
constant srcIsDst: integer:= 28;
constant appendDstToSrc:integer:=29;
constant appendOperToDst:integer:=30;

constant signalsCount: integer :=31;

--flags 
constant flagsCount: integer :=5;
constant cFlag: integer :=0;
constant zFlag: integer :=1;
constant nFlag: integer :=2;
constant pFlag: integer :=3;
constant vFlag: integer :=4;


--instruction types
constant twoOperandInstruction: std_logic_vector(1 downto 0) := "00";
constant oneOperandInstruction: std_logic_vector(1 downto 0) := "01";
constant branchInstruction: std_logic_vector(1 downto 0) := "10";
constant noOperandInstruction: std_logic_vector(1 downto 0) := "11";

--states
constant stateFetchInstruction: std_logic_vector(2 downto 0) := "000";
constant stateBranch: std_logic_vector(2 downto 0) := "001";
constant stateFetchSource: std_logic_vector(2 downto 0) := "010";
constant stateFetchDst: std_logic_vector(2 downto 0) := "011";
constant stateFetchSpecial: std_logic_vector(2 downto 0) := "100";
constant stateOperation: std_logic_vector(2 downto 0) := "101";
constant stateSave: std_logic_vector(2 downto 0) := "110";
constant stateNoOperand: std_logic_vector(2 downto 0) := "111";

--addressing modes
constant registerDirect: std_logic_vector(2 downto 0) := "000";
constant autoIncrementDirect: std_logic_vector(2 downto 0) := "001";
constant autoDecrementDirect: std_logic_vector(2 downto 0) := "010";
constant IndexedDirect: std_logic_vector(2 downto 0) := "011";
constant registerIndirect: std_logic_vector(2 downto 0) := "100";
constant autoIncrementIndirect: std_logic_vector(2 downto 0) := "101";
constant autoDecrementIndirect: std_logic_vector(2 downto 0) := "110";
constant IndexedIndirect: std_logic_vector(2 downto 0) := "111";


--registers
constant R0: std_logic_vector(2 downto 0) := "000";
constant R1: std_logic_vector(2 downto 0) := "001";
constant R2: std_logic_vector(2 downto 0) := "010";
constant R3: std_logic_vector(2 downto 0) := "011";
constant R4: std_logic_vector(2 downto 0) := "100";
constant R5: std_logic_vector(2 downto 0) := "101";
constant R6: std_logic_vector(2 downto 0) := "110";
constant R7: std_logic_vector(2 downto 0) := "111";


--operations
constant transferAOperation: std_logic_vector(4 downto 0) := "00001";
constant OperationADD: std_logic_vector(4 downto 0) := "00010";
constant OperationADC: std_logic_vector(4 downto 0) := "00011";
constant OperationSUB: std_logic_vector(4 downto 0) := "00100";
constant OperationSBC: std_logic_vector(4 downto 0) := "00101";
constant OperationAND: std_logic_vector(4 downto 0) := "00110";
constant OperationOR: std_logic_vector(4 downto 0) := "00111";
constant OperationXNOR: std_logic_vector(4 downto 0) := "01000";
constant OperationINC: std_logic_vector(4 downto 0) := "01010";
constant OperationDEC: std_logic_vector(4 downto 0) := "01011";
constant OperationCLR: std_logic_vector(4 downto 0) := "01100";
constant OperationINV: std_logic_vector(4 downto 0) := "01101";
constant OperationLSR: std_logic_vector(4 downto 0) := "01110";
constant OperationROR: std_logic_vector(4 downto 0) := "01111";
constant OperationRRC: std_logic_vector(4 downto 0) := "10000";
constant OperationASR: std_logic_vector(4 downto 0) := "10001";
constant OperationLSL: std_logic_vector(4 downto 0) := "10010";
constant OperationROL: std_logic_vector(4 downto 0) := "10011";
constant OperationRLC: std_logic_vector(4 downto 0) := "10100";


end constants;
 