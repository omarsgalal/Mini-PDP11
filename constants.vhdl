library IEEE;
USE IEEE.std_logic_1164.all;
package constants is 
--Signals
constant signalCount: std_logic :=19;
constant R7outA: std_logic:=0;
constant MARinA: std_logic :=1;
constant readSignal:std_logic :=2;
constant INC_R7 :std_logic :=3;
constant WMFC: std_logic:=4;
constant MDRoutA: std_logic:=5;
constant IRinA:std_logic :=6;
constant enableSrcDecoderBusA: std_logic :=7;---the decoder from GPRF to bus A
constant enableSrcDecoderBusC: std_logic :=8;-----the decoder from GPRF to bus C
constant tempInC:std_logic :=9;
constant inc:std_logic :=10;--F=B+1
constant enableDstDecoderBusB:std_logic :=11;----decoder from bus b to GPRF
constant MDRoutC: std_logic :=12;
constant dec: std_logic :=13; --F=B-1
constant MARinB : std_logic :=14;
constant Add:std_logic :=15;
constant IRout:std_logic:=16;
constant writeSignal:std_logic:=17;
constant EndSignal:std_logic:=18;
constant clears :std_logic_vector(signalCount downto 0):=0;

--flags 
constant flagsCount: std_logic :=5;
constant cFlag: std_logic :=0;
constant zFlag: std_logic :=1;
constant nFlag: std_logic :=2;
constant pFlag: std_logic :=3;
constant vFlag:std_logic :=4;

end constants;
