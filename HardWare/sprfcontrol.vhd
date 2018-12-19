LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;


entity SPRFControl is

    port(
        controlSignals: in std_logic_vector(SignalsCount-3 downto 0);
        controlIR, controlMAR, controlMDRIn, controlMDROut, controlFlag, controlTemp: out std_logic_vector(1 downto 0)
    );

end SPRFControl;


architecture SPRFControlArch of SPRFControl is

    begin

        controlIR <= controlSignals(IRout) & controlSignals(IRinA);

        controlMAR(1) <= controlSignals(MARinA) or controlSignals(MARinB);
        controlMAR(0) <= controlSignals(MARinB);

        controlMDRIn <= "01" when controlSignals(MDRinB) = '1'
        else "10" when controlSignals(MDRinC) = '1'
        else "11" when controlSignals(readSignal) = '1'
        else "00";

        controlMDROut <= controlSignals(MDRoutC) & controlSignals(MDRoutA);

        controlFlag <= "01" when controlSignals(FlagoutA) = '1'
        else "10" when controlSignals(FlaginA) = '1'
        else "11" when controlSignals(operation) = '1'
        else "00";

        controlTemp <= "00" when controlSignals(TempoutC) = '1' and controlSignals(tempInC) = '1'
        else controlSignals(TempoutC) & controlSignals(tempInC);

    
end architecture;