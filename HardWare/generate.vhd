library IEEE ;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;
entity genrateEntity is 
port(
    IR: in std_logic_vector (15 downto 0);
    state:in std_logic_vector(2 downto 0);
    mode:in std_logic_vector(2 downto 0);--for example 0 direct
    counter:in std_logic_vector(1 downto 0)); 
end entity;
architecture generateArch of genrateEntity is
--type signalsArray is array (0 to SignalsCount-1) of std_logic;
--type FlagsArray is array (0 to flagsCount-1) of std_logic;

signal Signals:std_logic_vector(Signalscount-1 downto 0);
signal Flags:std_logic_vector(Signalscount-1 downto 0);
--signal Flags:FlagsArray;
--    signal: Signals: ARRAY(SignalCount-1) OF std_logic;
--    signal: Flags:Array(flagsCount-1) of std_logic;

    
    begin
        process 

			variable willBranch:bit :='0';--this variable will be equal to 1 if the current state is branch and it's condition is  satisfied 

            begin
				Signals <= (others => '0') ;
                if state="000" then ----state fetch instruction
                    if counter="00" then
                        Signals(R7outA)<='1';
                        Signals(MARinA)<='1';
                        Signals(readSignal)<='1';
                        Signals(INC_R7)<='1';
                        Signals(WMFC)<='1';
                    elsif counter="01" then
                        Signals(MDRoutA)<='1';
                        Signals(IRinA)<='1';  
                    end if;
                    --decodeInstruction(IR,state,mode);   ---this procedure will update the mode  and state 
                elsif  state="001" then ---fetch source
                        if mode="000" then --direct
                            if counter="00" then
                                Signals(enableSrcDecoderBusC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="001" then --Auto Increment
                            if counter="00" then
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(inc)<='1';
                                Signals(enableDstDecoderBusB) <='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="010" then --auto decrement
                            if counter="00" then    
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(dec)<='1';
                                Signals(enableDstDecoderBusB)<='1';
                                Signals(MARinB)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="011" then   --indexed   
                            if counter="00" then
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(INC_R7)<='1';
                                SignalS(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutA)<='1';
                                Signals(enableSrcDecoderBusC)<='1';
                                Signals(ADD)<='1';
                                Signals(MARinB)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="10" then
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="100" then --Register Indirect
                            if counter="00" then
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="101" then --Auto increment indirect
                                if counter="00" then
                                    Signals(enableSrcDecoderBusA)<='1';
                                    Signals(inc)<='1';
                                    Signals(enableDstDecoderBusB)<='1';
                                    Signals(MARinA)<='1';
                                    Signals(readSignal)<='1';
                                    Signals(WMFC)<='1';
                                elsif counter="01" then
                                    Signals(MDRoutA)<='1';
                                    Signals(MARinA)<='1';
                                    Signals(readSignal)<='1';
                                    Signals(WMFC)<='1';
                                elsif counter="10" then
                                    Signals(MDRoutC)<='1';
                                    Signals(tempInC)<='1';
                                end if;
                        elsif mode="110" then --Auto decrement indirect
                            if counter="00" then
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(dec)<='1';
                                Signals(enableDstDecoderBusB)<='1';
                                Signals(MARinB)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutA)<='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="10" then
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        elsif mode="111" then --Indexed Indirect
                            if counter="00" then
                                Signals(enableSrcDecoderBusA)<='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(INC_R7)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="01" then
                                Signals(MDRoutA)<='1';
                                Signals(enableSrcDecoderBusC)<='1';
                                Signals(ADD)<='1';
                                Signals(MARinB)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="10" then 
                                Signals(MDRoutA)<='1';
                                Signals(MARinA)<='1';
                                Signals(readSignal)<='1';
                                Signals(WMFC)<='1';
                            elsif counter="11" then 
                                Signals(MDRoutC)<='1';
                                Signals(tempInC)<='1';
                            end if;
                        end if;
                elsif state="010" then --branch instructions
                    if mode="000" then --BR
                        willBranch:='1';
                    elsif mode="001" and Flags(zFlag)='1' then ---BEQ
                        willBranch:='1';
                    elsif mode="010" and Flags(zFlag)='0' then --BNE
                        willBranch:='1';                 
                    elsif mode="011" and Flags(cFlag)='1' then --BLO
                        willBranch:='1';
                    elsif mode="100" and Flags(cFlag)='0' and Flags(zFlag)='1' then ---BLS
                    
                            willBranch:='1';
                    elsif mode="101" and Flags(cFlag)='1' then --BHI
                        willBranch:='1';
                    elsif mode="110" and Flags(cFlag)='1' and Flags(zFlag)<='1' then
                        willBranch:='1';
                    end if;
                    if willBranch='1' then
                        Signals(IRout)<='1';
                        Signals(enableSrcDecoderBusC)<='1';
                        Signals(ADD)<='1';
                        Signals(enableDstDecoderBusB)<='1';
                    end if;
                elsif state="111" then ---Save operation
                    if mode="000" then ---save to register
                        Signals(enableDstDecoderBusB)<='1';
                        signals(EndSignal)<='1';
                    elsif mode="001" then --save to memory location
                        Signals(MDRinB)<='1';
                        signals(writeSignal)<='1';
                        signals(EndSignal)<='1';
                    end if;      
                end if;        
          	
		end process;
end Architecture;


