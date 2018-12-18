LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

-- this entity 
entity stateControl is

    port(
        secondState: in std_logic_vector(2 downto 0);
        srcAddressingMode, dstAddressingMode, branch: in std_logic_vector(2 downto 0);
        clk, reset: in std_logic;
        signals: out std_logic_vector(Signalscount-3 downto 0);
        flags: in std_logic_vector(15 downto 0)
        );
        
end stateControl;
        
        
architecture stateControlArch of stateControl is
            
    signal currentState, nextState, modeSrc: std_logic_vector(2 downto 0);
    signal currentCount: std_logic_vector(1 downto 0);
    signal resetCounter, resetState, loadCounter, appendDstToSrc, appendOperToDst: std_logic;
    signal controlSignals: std_logic_vector(Signalscount-3 downto 0);
    signal stateClk: std_logic;

    begin

        srcOrBr: entity work.mux2 generic map(3) port map(branch, srcAddressingMode, secondState(1), modeSrc);

        resetCounter <= '1' when (currentState = "000" and currentCount = "01") or resetState = '1'
        else '0';
        loadCounter <= (appendDstToSrc or appendOperToDst) and not(resetCounter);
        cnt: entity work.counter generic map(2) port map("01", currentCount, resetCounter, stateClk, loadCounter);

        signals <= controlSignals; 
        resetState <= controlSignals(EndSignal) or reset;
       
        nextState <= secondState when currentState = "000" and currentCount = "01"
        else stateSave when appendOperToDst = '1'
        else stateFetchDst when appendDstToSrc = '1'
        else currentState;
        
        stateClk <= not clk;
        stateReg: entity work.nDFlipFlop generic map(3) port map(nextState, stateClk, setReg, resetState, '1', currentState);

        cu: entity work.controlUnit port map(
            currentState, modeSrc, dstAddressingMode, currentCount, 
            controlSignals, flags, appendDstToSrc, appendOperToDst
            );


end architecture;