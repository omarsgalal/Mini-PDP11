library IEEE;
USE IEEE.std_logic_1164.all;
package constants is 
--Signals
constant signalsCount: integer :=20;
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


--flags 
constant flagsCount: integer :=5;
constant cFlag: integer :=0;
constant zFlag: integer :=1;
constant nFlag: integer :=2;
constant pFlag: integer :=3;
constant vFlag:integer :=4;

end constants;
