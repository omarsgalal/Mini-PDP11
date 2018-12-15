LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.constants.all;

-- this entity takes the IR and extracts all important signals from it
-- IR register is input
-- outputs:
-- aluOperation: this is to be connected directly to the alu at the time slot of operation
-- src, dst: are the regesters specified in the IR if one or two operand
-- branch: the branch instruction from IR
-- branchOffset: the offset to be added 
-- instructionType: Two Operand or one Opeand or Branch or No Operand
entity decodingCircuit is

    port(
        IR: in std_logic_vector(15 downto 0);
        aluOperation: out std_logic_vector(4 downto 0);
        src, dst, srcAddressingMode, dstAddressingMode, branch: out std_logic_vector(2 downto 0);
        branchOffset: out std_logic_vector(7 downto 0);
        instructionType: out std_logic_vector(1 downto 0)
    );

end decodingCircuit;


architecture decodingCircuitArch of decodingCircuit is

    signal operationTwoOperand: std_logic_vector(4 downto 0);
    signal isTwoOperand: std_logic;

    begin

        -- get ALU operation from IR
        operationTwoOperand <= '0' & IR(15 downto 12);
        isTwoOperand <= IR(15) or IR(14) or IR(13) or IR(12);
        aluOp: entity work.mux2 generic map(5) port map(IR(10 downto 6), operationTwoOperand, isTwoOperand, aluOperation);

        --get src and destination registers
        src <= IR(8 downto 6);
        dst <= IR(2 downto 0);

        --get addressing modes of src and destination registers
        srcAddressingMode <= IR(11 downto 9);
        dstAddressingMode <= IR(5 downto 3);

        --get branches
        branch <= IR(10 downto 8);
        branchOffset <= IR(7 downto 0);

        --instruction type
        instructionType <= twoOperandInstruction when isTwoOperand = '1'
        else branchInstruction when IR(11) = '1' and isTwoOperand = '0'
        else oneOperandInstruction when IR(11) = '0' and isTwoOperand = '0' and (IR(10) or IR(9)) = '1'
        else noOperandInstruction;

end architecture;