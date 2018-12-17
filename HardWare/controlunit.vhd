library IEEE ;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

entity controlUnit is 
port(
    state:in std_logic_vector(2 downto 0);
    modeSrc, modeDst:in std_logic_vector(2 downto 0);--for example 0 direct
    counter:in std_logic_vector(1 downto 0); 
    Signals: out std_logic_vector(Signalscount-3 downto 0);
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
            -- need enableSrcDecoderBusB, R7in KASEB
            (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0') 
                when state = stateFetchInstruction and counter="00" 
            else (MDRoutA => '1', IRinA => '1', others => '0') 
                when state = stateFetchInstruction and counter="01"

            --fetch source

            --register direct src
            else (enableSrcDecoderBusC => '1', tempInC => '1', appendDstToSrc => '1', others => '0') 
                when state = stateFetchSource and modeSrc = registerDirect

            --autoincrement t0  src (should have enableDstDecoderBusB not from dstenation but from source) KASEB
            else (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = autoIncrementDirect(1 downto 0) and counter="00"        

            -- auto decrement t0 src (should have enableDstDecoderBusB not from dstenation but from source) KASEB
            else (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = autoDecrementDirect(1 downto 0) and counter="00"
            
            
            -- indexed t0 src only
            -- need enableSrcDecoderBusB, R7in KASEB
            else (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc(1 downto 0) = indexedDirect(1 downto 0) and counter="00"

            -- indexed t1 src and dst
            else (MDRoutA => '1', enableSrcDecoderBusC => '1', ADD => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state(2 downto 1) = stateFetchSource(2 downto 1) and modeSrc(1 downto 0) = indexedDirect(1 downto 0) and counter="01"
            
                
            -- inderect regester t0 src
            else (enableSrcDecoderBusA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state = stateFetchSource and modeSrc = registerIndirect and counter="00"

            -- indirect get from memory and read from it again (before last time slot )
            else (MDRoutA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when state(2 downto 1) = stateFetchSource(2 downto 1) and modeSrc(2) = '1' and ((counter="01" and ((modeSrc(0) xor modeSrc(1)) = '1')) or (counter="10" and modeSrc(1 downto 0) = "11"))
            
            --last time slot in fetching src
            else (MDRoutC => '1', tempInC => '1', appendDstToSrc => '1', others => '0') 
                when state = stateFetchSource
            
            --when one operand instruction
            -- should be appendOperToDst KASEB
            else (appendDstToSrc => '1', others => '0') 
                when state = stateFetchDst and counter="00"
        
            --last time slot in fetching dst
            else (MDRoutA => '1', appendOperToDst => '1', others => '0') 
                when state = stateFetchDst
            
            
            --branch instructions
            else (IRout => '1', R7outC => '1', R7inB => '1', enableSrcDecoderBusC => '1', ADD => '1', enableDstDecoderBusB => '1', EndSignal => '1', others => '0') 
                when state = stateBranch and ((modeSrc="000") or (modeSrc="001" and Flags(zFlag)='1') or (modeSrc="010" and Flags(zFlag)='0') or (modeSrc="100" and Flags(cFlag)='0' and Flags(zFlag)='1') or (modeSrc="101" and Flags(cFlag)='1') or (modeSrc="110" and Flags(cFlag)='1' and Flags(zFlag)<='1')) 
            
            --else end for all
            else (EndSignal => '1', others => '0');
            -- else (others => '0');


        SignalsTemp2 <= 
            --register direct dist
            (enableSrcDecoderBusA => '1', appendOperToDst => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst = registerDirect

            --autoincrement t0  dst
            else (enableSrcDecoderBusA => '1', inc => '1', enableDstDecoderBusB => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = autoIncrementDirect(1 downto 0)        

            -- auto decrement t0 dst
            else (enableSrcDecoderBusA => '1', dec => '1', enableDstDecoderBusB => '1', MARinB => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = autoDecrementDirect(1 downto 0)
            
            
            -- indexed t0 dst
            else (enableSrcDecoderBusA => '1', R7outA => '1', MARinA => '1', readSignal => '1', INC_R7 => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst(1 downto 0) = indexedDirect(1 downto 0)
                
            -- inderect regester t0 dst
            else (enableSrcDecoderBusA => '1', MARinA => '1', readSignal => '1', WMFC => '1', others => '0') 
                when SignalsTemp1(appendDstToSrc) = '1' and modeDst = registerIndirect

            else (others => '0');




        SignalsTemp3 <= 
            ---Save operation
            (enableDstDecoderBusB => '1', Operation => '1', TempoutC =>'1', EndSignal => '1', others => '0') 
                when ( SignalsTemp1(appendOperToDst) or  SignalsTemp2(appendOperToDst) ) = '1' and modeDst= registerDirect
            else (MDRinB => '1', Operation => '1', TempoutC =>'1', writeSignal => '1', EndSignal => '1', others => '0') 
                when ( SignalsTemp1(appendOperToDst) or  SignalsTemp2(appendOperToDst) ) = '1'
            else (others => '0');


        finalSignals <= (SignalsTemp1 or SignalsTemp2 or SignalsTemp3);
        Signals <= finalSignals(SignalsCount-3 downto 0);
        finishSrc <= finalSignals(SignalsCount-2);
        finishDst <= finalSignals(SignalsCount-1);
        
end architecture;