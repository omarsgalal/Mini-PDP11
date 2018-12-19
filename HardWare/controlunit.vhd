library IEEE ;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity controlUnit is 
port(
    state:in std_logic_vector(2 downto 0);
    modeSrc, modeDst:in std_logic_vector(2 downto 0);
    counter:in std_logic_vector(1 downto 0); 
    Signals: out std_logic_vector(Signalscount-3 downto 0);
    IROperation: in std_logic_vector(4 downto 0);
    Flags: in std_logic_vector(15 downto 0);
    finishSrc, finishDst: out std_logic);
end entity;



architecture controlUnitArch of controlUnit is
--type signalsArray is array (0 to SignalsCount-1) of std_logic;
--type FlagsArray is array (0 to flagsCount-1) of std_logic;

    signal SignalsTemp1, SignalsTemp2, SignalsTemp3: std_logic_vector(Signalscount-1 downto 0);
    signal finalSignals: std_logic_vector(Signalscount-1 downto 0);
    --signal Flags:std_logic_vector(Signalscount-1 downto 0);
    --signal Flags:FlagsArray;
    --    signal: Signals: ARRAY(SignalsCount-1) OF std_logic;
    --    signal: Flags:Array(flagsCount-1) of std_logic;

    begin

        SignalsTemp1 <= 
            -- fetch instrucion
            (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0') 
                when state = stateFetchInstruction and counter="00" 
            else (MDRRAMoutA => '1', IRinA => '1', others => '0') 
                when state = stateFetchInstruction and counter="01"

            -------------------------------------- Bonus ----------------------------------------------

            -- JSR
            else (enableSrcDecoderBusA => '1', R6outA => '1', dec => '1', enableDstDecoderBusB => '1', R6inB => '1', MARinB => '1', enableSrcDecoderBusC => '1', R7outC => '1', writeSignal => '1', MDRCPUinC => '1', WMFC => '1', others => '0')
                when state = stateFetchDst and IROperation = JSR and counter = "00"

            else (enableSrcDecoderBusA => '1', dstIsSrcA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0')
                when state = stateFetchDst and IROperation = JSR and counter = "01"

            else (MDRRAMoutC => '1', transfer => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0')
                when (state = stateFetchDst and IROperation = JSR and counter = "10")



            --RTS
            else (enableSrcDecoderBusA => '1', R6outA => '1', inc => '1', enableDstDecoderBusB => '1', R6inB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0')
                when state = stateNoOperand and IROperation = RTS and counter = "00"

            else (MDRRAMoutA => '1', inc => '1', enableDstDecoderBusB => '1', R7inB => '1', EndSignal => '1', others => '0')
                when (state = stateNoOperand and IROperation = RTS and counter = "01")

            ----------------------------------------------------------------------------------------
            
            
            
            
            
            --fetch source

            --register direct src
            else (enableSrcDecoderBusC => '1', tempInC => '1', appendDstToSrc => '1', others => '0') 
                when state = stateFetchSource and modeSrc = registerDirect

            --autoincrement t0  src
            else (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = autoIncrementDirect(1 downto 0) and counter="00"        

            -- auto decrement t0 src
            else (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', srcIsDst => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = autoDecrementDirect(1 downto 0) and counter="00"
            
            
            -- indexed t0 src only
            else (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = indexedDirect(1 downto 0) and counter="00"

            -- indexed t1 src and dst
            else (MDRRAMoutA => '1', enableSrcDecoderBusC => '1', dstIsSrcC => state(0), ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when ((state = stateFetchSource and modeSrc(1 downto 0) = indexedDirect(1 downto 0)) or (state = stateFetchDst and modeDst(1 downto 0) = indexedDirect(1 downto 0))) and counter="01"
            
                
            -- register indirect t0 src
            else (enableSrcDecoderBusA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc = registerIndirect and counter="00"

            -- indirect get from memory and read from it again (before last time slot )
            else (MDRRAMoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when (state = stateFetchSource and modeSrc(2) = '1' and ((counter="01" and ((modeSrc(0) xor modeSrc(1)) = '1')) or (counter="10" and modeSrc(1 downto 0) = "11")))
                or  (state = stateFetchDst and modeDst(2) = '1' and ((counter="01" and ((modeDst(0) xor modeDst(1)) = '1')) or (counter="10" and modeDst(1 downto 0) = "11")))
            
            --last time slot in fetching src
            else (MDRRAMoutC => '1', tempInC => '1', appendDstToSrc => '1', others => '0') 
                when state = stateFetchSource
            
            --when one operand instruction
            else (appendDstToSrc => '1', others => '0') 
                when state = stateFetchDst and counter="00"
        
            --last time slot in fetching dst
            else (MDRRAMoutA => '1', appendOperToDst => '1', others => '0') 
                when state = stateFetchDst
            
            --branch instructions
            else (IRout => '1', R7outC => '1', R7inB => '1', enableSrcDecoderBusC => '1', ADD => '1', enableDstDecoderBusB => '1', EndSignal => '1', others => '0') 
                when state = stateBranch and ((modeSrc="000") or (modeSrc="001" and Flags(zFlag)='1') or (modeSrc="010" and Flags(zFlag)='0') or (modeSrc="011" and Flags(cFlag)='0') or (modeSrc="100" and (Flags(cFlag)='0' or Flags(zFlag)='1')) or (modeSrc="101" and Flags(cFlag)='1') or (modeSrc="110" and (Flags(cFlag)='1' or Flags(zFlag)='1')))
                       
            --else end for all
            else (EndSignal => '1', others => '0');
            -- else (others => '0');


        SignalsTemp2 <= 
            --register direct dist
            (enableSrcDecoderBusA => '1', dstIsSrcA => '1', appendOperToDst => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst = registerDirect

            --autoincrement t0  dst
            else (enableSrcDecoderBusA => '1', dstIsSrcA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = autoIncrementDirect(1 downto 0)        

            -- auto decrement t0 dst
            else (enableSrcDecoderBusA => '1', dstIsSrcA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = autoDecrementDirect(1 downto 0)
            
            
            -- indexed t0 dst
            else (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', enableDstDecoderBusB => '1', inc => '1', R7inB => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = indexedDirect(1 downto 0)
                
            -- inderect regester t0 dst
            else (enableSrcDecoderBusA => '1', dstIsSrcA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst = registerIndirect

            else (others => '0');




        SignalsTemp3 <= 
            ---Save operation

            --compare
            (Operation => '1', compare => '1', TempoutC =>'1', EndSignal => '1', others => '0') 
                when IROperation = CMP and  ( SignalsTemp1(appendOperToDst) or  SignalsTemp2(appendOperToDst) ) = '1'
            else (enableDstDecoderBusB => '1', Operation => '1', TempoutC =>'1', EndSignal => '1', others => '0') 
                when ( SignalsTemp1(appendOperToDst) or  SignalsTemp2(appendOperToDst) ) = '1' and modeDst = registerDirect
            else (MDRCPUinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0') 
                when ( SignalsTemp1(appendOperToDst) or  SignalsTemp2(appendOperToDst) ) = '1'
            else (others => '0');


        finalSignals <= (SignalsTemp1 or SignalsTemp2 or SignalsTemp3);
        Signals <= finalSignals(SignalsCount-3 downto 0);
        finishSrc <= finalSignals(SignalsCount-2);
        finishDst <= finalSignals(SignalsCount-1);
        
end architecture;