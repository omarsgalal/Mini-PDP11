import numpy as np
import re
from lockuptable import getMachineCode
################################### special instructions #############################################################
'''
example         desc                                                                                        status        function          mark

label:          ; save to lock up table, not occupy address                                                 [done1]                         handled immediately   
Add #100, R0    ; immediate addressing transformed to auto increment                                        [done1]                         handled immediately   
                ; empty line                                                                                [done1]                         handled immediately 
5000            ; value of next instruction of indexed or after some transformation above                   [done1]                         handled immediately                      
JSR             ; the JSR operation should handled to 2 words                                               [done1]                         $AVAR, will result to two words, scd one will be marked $AVAR
Add R0, N       ; variable transformed to indexed (src)                                                     [done1]                         $AVAR, will result to 2 words, scd word should be marked as "$AVAR" shorthand for arithmetic variable
Add N, R0       ; variable transformed to indexed (dst)                                                     [done1]                         $AVAR, // // // // // // //
Add N, M        ; variable transformed to indexed (both)                                                    [done1]                         $AVAR, as above but will mark to two marked words
CLR N           ; one operand with data                                                                     [done1]                         $AVAR, as above
N               ; value from variable of next instruction of indexed or after some transformation above     [done1]                         $VAR, marked $VAR                                
BEQ label       ; calc offsets and replace it                                                               [done1]                         $BCH, mark it $BCH
ADD #100, N     ; immediate addressing with variables, should be handled                                    [    ]      
'''

re_immediateAddressing = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")
re_validInstr = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")

assemblyFile = open("program.txt", 'r') # code
assemblesFile = open("program.pdp", 'w') # machine code for pdp
lines = assemblyFile.readlines()

symbolTable = {"N": "N address", "M": "M address"}

addressTransforming = 0 # current address that is begin transformed to machine code
def incAddress():
    global addressTransforming
    addressTransforming += 1
    return addressTransforming

def assemble(lines):
    for instruction in lines:
        instruction = cleanInstruction(instruction)

        if(not instruction):  # empty line
            continue
        if(instruction.isdigit()): # value
            appendMachineCode(strToBinary16(instruction))
            continue
        if(instruction.find(":") != -1):    # label
            label = instruction[0:instruction.find(":")]
            symbolTable[label] = addressTransforming
            continue

        if(instruction[0:3] == "JSR"):
            handleJSR(instruction)
            continue


        elif(re_immediateAddressing.match(instruction)):
            handleImmediate(instruction)
            continue

        commaIndex = instruction.find(',')
        spaceIndex = instruction.find(' ')
        if (commaIndex != -1):
             # 2 operand
            # # # # # operation = instruction[0:spaceIndex].strip()
            operands = instruction[spaceIndex + 1:commaIndex].strip(), instruction[commaIndex + 1:].strip()
            # TODO require to move first on data and append only names
            isVariables = symbolTable.get(operands[0]), symbolTable.get(operands[1])
            if(isVariables[0] and isVariables[1]):
                handle2VariablesOperation(instruction)
                continue
            elif(isVariables[0]):
                handle1VariableOperation(instruction, 0)
                continue
            elif(isVariables[1]):
                handle1VariableOperation(instruction, 1)

            # # # # # else:
                # # # # # # not special instruction
                # # # # # instructionMachineCode = twoOperand(operation, operand1, operand2)
                # # # # # appendMachineCode(instructionMachineCode)
                # # # # # incAddress()
                # # # # # continue
        elif(spaceIndex == -1):
            # zero operand
            if(symbolTable.get(instruction)):
                # [DONE]: mark the address to return to it to override N with address
                appendMachineCode(instruction, mark='$VAR')
                continue
            # # # # # instructionMachineCode = zeroOperand(instruction)
            # # # # # incAddress()
            # # # # # continue
        else:
            operation = instruction[0:spaceIndex].strip()
            operand = instruction[spaceIndex + 1:].strip()
            if(operation[0] == "B"):
                appendMachineCode(instruction, mark="$BCH")
            elif(symbolTable.get(operand)):
                # one operand with variable, e.g 'CLR N'
                handleVariableOperation1(instruction)
                continue
            # # # # # else:
            # # # # #     # 1 operand
            # # # # #     instructionMachineCode = oneOperand(instruction, spaceIndex)
            # # # # #     appendMachineCode(instructionMachineCode)
            # # # # #     incAddress()
            # # # # #     continue
        # instruction is direct instruction
        toMachineCode(instruction)
  
    assemblesFile.close()


####################################################################################################################
def handleImmediate(instruction):
    splittedInstruction = instruction.split(",")
    temp=splittedInstruction[0].split("#")
    toMachineCode(temp[0]+" (R7)+,"+splittedInstruction[1])
    appendMachineCode(format(int(temp[1]), "b"))

def handleJSR(instruction):
    splittedInstruction=instruction.split(" ")
    #address=dictionary.get(splittedInstruction[1])
    #print( splittedInstruction[0]+" X(R7)+",address-pc-2)
    toMachineCode(splittedInstruction[0]+" X(R7)")
    appendMachineCode("$AVAR{}-{}".format(splittedInstruction[1], addressTransforming-2))

def handle1VariableOperation(instruction, varOperandIndex):#0 means N is the 1st operand 1 means N is the 2nd operand
    operation, firstOp, ScdOp = splitInstruction(instruction)
    if(varOperandIndex == 0):
    	label = firstOp
    	firstOp = "(R7)+"
    else:
    	label = ScdOp
    	ScdOp = "(R7)+"
    toMachineCode("{} {},{}".format(operation, firstOp, ScdOp))
    appendMachineCode("$VAR" + label)

def handle2VariablesOperation(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {},{}".format(operation, "(R7)+", "(R7)+"))
    appendMachineCode("$VAR" + firstOp)
    appendMachineCode("$VAR" + ScdOp)
    # splittedInstruction = instruction.split(" ")
    # operands = splittedInstruction.split(",")
    # toMachineCode(splittedInstruction[0]+"(R7)+,(R7)+")
    # appendMachineCode("$VAR"+operands[0])
    # appendMachineCode("$VAR"+operands[1])

def handleVariableOperation1(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {}".format(operation, "(R7)+"))
    appendMachineCode("$VAR" + firstOp)

    # splittedInstruction = instruction.split(" ")
    # toMachineCode(splittedInstruction[0]+"(R7)+")
    # appendMachineCode("$VAR" + splittedInstruction[1])
####################################################################################################################


def appendMachineCode(machineCode, mark=''):
    assemblesFile.write("{}{}\n".format(mark, machineCode))
    incAddress()

def toMachineCode(instruction):
    ''' 
    take a clean instruction that doesn't contain any:
    additional spaces,
    comments,
    values
    special instructions(those who need to be transformed to other instructions) or
    special chars at the end
    '''
    operation, operand1, operand2 = splitInstruction(instruction)
    if(operand1 and operand2):
        mc = twoOperand(operation, operand1, operand2)
    elif(operand1):
        mc = oneOperand(operation, operand1)
    else:
        mc = zeroOperand(operation)
    appendMachineCode(mc)
    
def zeroOperand(instruction):
    machineCode = getMachineCode(instruction)
    return machineCode

def oneOperand(operation, operand):
    reg, addressingMode = analyzeOperand(operand)
    if not reg:
        raise Exception("can't analaze instruction", operation,operand)

    return "{}{}{}".format(getMachineCode(operation), getMachineCode(addressingMode), getMachineCode(reg))

def twoOperand(operation, operand1, operand2):
    reg1, addressingMode1 = analyzeOperand(operand1)
    reg2, addressingMode2 = analyzeOperand(operand2)
    if not reg1 or not reg2:
        raise Exception("can't analaze instruction", operation,operand1,operand2)
    mc = getMachineCode
    return "{}{}{}{}{}".format(mc(operation), mc(addressingMode1), mc(reg1),mc(reg2),mc(addressingMode2))


def strToBinary16(numStr):
    return str(bin(int("5")))[2:].zfill(16)

def cleanInstruction(instr):
    instr = instr.strip() # remove any spaces and \n in the end of the line
    instr = instr.upper()
    semiColon = instr.find(';')
    if(semiColon != -1):
        instr = instr[0:semiColon]
    return str(instr.strip())


def analyzeOperand(operand):
    addressMode = ""
    operand = str(operand)
    if(not isDirect(operand)):
        addressMode = "indirect"
        operand = operand.replace('@', '', 1)
    # optimize for combiling the prog in global
    autoDec = re.fullmatch(r"-\([Rr][0-7]\)$", operand)
    autoInc = re.fullmatch(r"\([Rr][0-7]\)\+$", operand)
    indexed = re.fullmatch(r"[xX]\([Rr][0-7]\)$", operand)
    register = re.fullmatch(r"[Rr][0-7]$", operand)
    if(register):
        return operand[0:2], addressMode + "register"
    if (autoDec):
        return operand[2:4], addressMode + "autodecrement"
    if (autoInc):
        return operand[1:3], addressMode + "autoincrement"
    if (indexed):
        return operand[2:4], addressMode + "indexed"
    # print(operand, '-> ', addressMode, autoDec, autoInc, indexed, register)
    return None, None


def splitInstruction(instruction):
    operation, operand1, operand2 = instruction, None, None
    commaIndex = instruction.find(',')
    spaceIndex = instruction.find(' ')
    if(spaceIndex != -1 ):
        operation = instruction[0:spaceIndex].strip()
        if(commaIndex != -1):
            operand1 = instruction[spaceIndex + 1:commaIndex].strip()
            operand2 = instruction[commaIndex + 1:].strip()
            return operation, operand1, operand2
        operand1 = instruction[spaceIndex + 1:].strip()
    return operation, operand1, operand2

def isDirect(operand):
    return operand.find('@') == -1

def analyzeFromSymbolTable(operand):
    return symbolTable.get(operand)


assemble(lines)