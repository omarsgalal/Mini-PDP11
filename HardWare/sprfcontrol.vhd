LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;


entity SPRFControl is

    port(
        controlSignals: in std_logic_vector(SignalsCount-3 downto 0);
        controlIR, controlMAR, controlMDRCPUIn, controlMDRRAMOut, controlFlag, controlTemp: out std_logic_vector(1 downto 0);
        enableMDRRAMRead: out std_logic
    );

end SPRFControl;


architecture SPRFControlArch of SPRFControl is

    begin

        controlIR <= controlSignals(IRout) & controlSignals(IRinA);

        controlMAR(1) <= controlSignals(MARinA) or controlSignals(MARinB);
        controlMAR(0) <= controlSignals(MARinB);


        controlMDRCPUIn <= "10" when controlSignals(MDRCPUinB) = '1'
        else "11" when controlSignals(MDRCPUinC) = '1'
        else "00";

        enableMDRRAMRead <= controlSignals(readSignal);

        controlMDRRAMOut <= "01" when controlSignals(MDRRAMoutA) = '1'
        else "10" when controlSignals(MDRRAMoutC) = '1'
        else "00";


        controlFlag <= "01" when controlSignals(FlagoutA) = '1'
        else "10" when controlSignals(FlaginA) = '1'
        else "11" when controlSignals(operation) = '1'
        else "00";

        controlTemp <= controlSignals(TempoutC) & controlSignals(tempInC);

    
end architecture;