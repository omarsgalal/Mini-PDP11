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
Add R0, N       ; variable transformed to indexed (src)                                                     [done1]                         $VAR, will result to 2 words, scd word should be marked as "$AVAR" shorthand for arithmetic variable
Add N, R0       ; variable transformed to indexed (dst)                                                     [done1]                         $VAR, // // // // // // //
Add N, M        ; variable transformed to indexed (both)                                                    [done1]                         $VAR, as above but will mark to two marked words
CLR N           ; one operand with data                                                                     [done1]                         $VAR, as above
N               ; value from variable of next instruction of indexed or after some transformation above     [done1]                         $VAR, marked $VAR                                
BEQ label       ; calc offsets and replace it                                                               [done1]                         $BCH, mark it $BCH
ADD #100, N     ; immediate addressing with variables, should be handled                                    [    ]      
JSR (R0)+       ; JSR from a register                                                                       [    ]      
'''

re_immediateAddressing = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")
re_validInstr = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")

assemblyFile = open("program.txt", 'r') # code
assemblesFile = open("program.pdp", 'w') # machine code for pdp
lines = assemblyFile.readlines()

# symbolTable = {"N": "N address", "M": "M address"}
symbolTable = {"N": "8", "M": "9"}

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

        operation, operand1, operand2 = splitInstruction(instruction)
        if (operand1 and operand2):
             # 2 operand
            # TODO require to move first on data and append only names
            isVariables = symbolTable.get(operand1), symbolTable.get(operand2)
            if(isVariables[0] and isVariables[1]):
                handle2VariablesOperation(instruction)
            elif(isVariables[0]):
                handle1VariableOperation(instruction, 0)
            elif(isVariables[1]):
                handle1VariableOperation(instruction, 1)

        elif(not operand1 and symbolTable.get(operation)):
            # zero operand
            appendMachineCode(instruction, mark='$VAR')
        elif(operation[0] == "B"):
            appendMachineCode(instruction, mark="$BCH")
        elif(symbolTable.get(operand1)):
            handleVariableOperation1(instruction)
        else:
            toMachineCode(instruction)
    global assemblesFile
    assemblesFile.close()
    out = open("output.txt", 'w')
    linesAgain = open(assemblesFile.name, 'r').readlines()

    addressNumber = 0
    for line in linesAgain:
        if(line.find('$') != -1):
            if(line.find('$VAR') != -1):
                line = line.replace('$VAR', '')
                line = symbolTable.get(line[0:-1])
                out.write(line)
                out.write('\n')
            elif(line.find('$AVAR') != -1):
                line = line.replace('$AVAR', '')
                minusIndex = line.find('-')
                variable, offset = line.strip()[0:minusIndex], line.strip()[minusIndex+1:]
                value = int(symbolTable.get(variable)) - int(offset) # strToBinary
                out.write(str(value))
                out.write('\n')
            elif(line.find('$BCH') != -1):
                line = line.replace('$BCH', '')
                branchOperation, label = line.strip().split(' ')
                offset = strToBinary16(str(int(symbolTable[label]) - addressNumber),fill=7) # TODO (مش فاكر البرانش بياخد قد ايه)
                out.write("{}{}\n".format(getMachineCode(branchOperation), offset))
        else:
            out.write(line)
        addressNumber += 1
    out.close()

   


####################################################################################################################
def handleImmediate(instruction):
    splittedInstruction = instruction.split(",")
    temp=splittedInstruction[0].split("#")
    toMachineCode(temp[0]+" (R7)+,"+splittedInstruction[1])
    appendMachineCode(format(int(temp[1]), "b"))

def handleJSR(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {}".format(operation, "X(R7)"))
    appendMachineCode("$AVAR{}-{}".format(firstOp, str(addressTransforming-2)))

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

def handleVariableOperation1(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {}".format(operation, "(R7)+"))
    appendMachineCode("$VAR" + firstOp)
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


def strToBinary16(numStr, fill=16):
    return str(bin(int("5")))[2:].zfill(fill)

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