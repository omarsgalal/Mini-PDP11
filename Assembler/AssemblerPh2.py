import numpy as np
import re
from lockuptable import getMachineCode
from symbolTable import ST
from AssemblerPh1 import assemblePh1
from util import *

re_immediateAddressing = re.compile(r".{1,4} #\d+ *, *@?[Rr][0-7]") # todo, that doesn't always the case, consider CMP
re_validInstr = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")

addressTransforming = 0 # current address that is begin transformed to machine code
def incAddress():
    global addressTransforming
    addressTransforming += 1
    return addressTransforming

ph2_out = ''
def assemblePh2(AllCodeText):
    # // constructSymbolTableVariables()
    # // appender = Appender(incAddress)
    fileLineNumber = 0
    try:
        lines = AllCodeText.splitlines(True)
        for fileLineNumber in range(1,len(lines) + 1):
            instruction = cleanInstruction(lines[fileLineNumber - 1])
            handleOneInstruction(instruction)
        return ph2_out
    except Exception as e:
        print(e, '[',fileLineNumber, ']')

def handleOneInstruction(instruction):
    operation, operand1, operand2 = splitInstruction(instruction)
    # operand1 = handelSpecialOfOperand(operand1)
    # operand2 = handelSpecialOfOperand(operand2)
    if(not instruction):  # empty line
        return
    if(instruction.isdigit()): # value
        appendMachineCode(strToBinary16(instruction))
        return
    if(instruction.find(":") != -1):    # label
        label = instruction[0:instruction.find(":")]
        ST.update(label, addressTransforming, label=True)
        # // symbolTable[label] = addressTransforming
        return
    if(instruction[0:6] == "DEFINE"):
        instruction = instruction.replace('DEFINE ', '')
        varName, varValue = instruction.split(' ')
        print('unused variable', varName) if not ST.isExist(varName) else None
        ST.update(varName, addressTransforming, label=False)
        # // symbolTable[varName] = addressTransforming
        appendMachineCode(strToBinary16(varValue))
        return
    if(instruction[0:3] == "JSR"):
        handleJSR(instruction)
        return
    elif(instruction.find('#') != -1):
        handleImmediate(instruction)
        return

    if (operand1 and operand2):
        # 2 operand
        if(ST.isExist(operand1) and ST.isExist(operand2)):
            handle2VariablesOperation(instruction)
            return
        elif(ST.isExist(operand1)):
            handle1VariableOperation(instruction, 0)
            return
        elif(ST.isExist(operand2)):
            handle1VariableOperation(instruction, 1)
            return

    elif(not ST.isExist(operand1) and ST.isExist(operation)):
        # zero operand variable
        appendMachineCode(instruction, mark='$VAR')
        return
    #//elif(operation[0] == "B" or (operation == "JSR" and not ST.isExist(operand1) and operand1.find("R") == -1)):
    elif(operation[0] == "B"):
        appendMachineCode(instruction, mark="$BCH")
        return
    elif(ST.isExist(operand1)):
        handleVariableOperation1(instruction)
        return

    toMachineCode(instruction)

####################################################################################################################
def handleImmediate(instruction):
    operation, operand1, operand2 = splitInstruction(instruction)
    if(ST.isVariable(operand1)):
        instruction = "{} {}, {}".format(operation, operand1, "(R7)+")
        handle1VariableOperation(instruction,0)
        appendMachineCode(strToBinary16(operand2[1:]))
        return
    if(ST.isVariable(operand2)):
        instruction = "{} {}, {}".format(operation, "(R7)+", operand2)
        handle1VariableOperation(instruction, 1, middlePrint=strToBinary16(operand1[1:]))
        return
    
    if operand1.find('#') != -1:
        toMachineCode(operation+" (R7)+,"+operand2)
        appendMachineCode(strToBinary16(operand1[1:]))
    else:
        toMachineCode("{} {}, {}".format(operation, operand1, "(R7)+"))
        appendMachineCode(strToBinary16(operand2[1:]))



def handleJSR(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    # var, label, reg
    reg, addressMode = analyzeOperand(firstOp)
    isVariable = ST.isVariable(firstOp)
    if addressMode == "register":
        raise Exception("direct register in jsr operation")
    if(isVariable):
        toMachineCode("{} {}".format(operation, "X(R7)"))
        appendMachineCode("$AVAR{}-{}".format(firstOp, str(addressTransforming + 1)))
        return
    if(not reg): # and not variable for sure
        # label
        toMachineCode("JSR @(R7)+")
        appendMachineCode("$VAR{}".format(firstOp))

def handle1VariableOperation(instruction, varOperandIndex, middlePrint = None):#0 means N is the 1st operand 1 means N is the 2nd operand
    operation, firstOp, ScdOp = splitInstruction(instruction)
    if(varOperandIndex == 0):
    	label = firstOp
    	firstOp = "X(R7)"
    else:
    	label = ScdOp
    	ScdOp = "X(R7)"
    toMachineCode("{} {},{}".format(operation, firstOp, ScdOp))
    if middlePrint != None:
        appendMachineCode(middlePrint)
    appendMachineCode("$AVAR" +  "{}-{}".format(label, addressTransforming + 1))

def handle2VariablesOperation(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {},{}".format(operation, "X(R7)", "X(R7)"))
    appendMachineCode("$AVAR" + "{}-{}".format(firstOp, addressTransforming + 1))
    appendMachineCode("$AVAR" + "{}-{}".format(ScdOp, addressTransforming + 1))

def handleVariableOperation1(instruction):
    operation, firstOp, ScdOp = splitInstruction(instruction)
    toMachineCode("{} {}".format(operation, "X(R7)"))
    appendMachineCode("$AVAR" +  "{}-{}".format(firstOp, addressTransforming + 1))
####################################################################################################################



def appendMachineCode(stringToAppend, mark=''):
    # // assemblesFile.write("{}{}\n".format(mark, machineCode))
    global ph2_out
    ph2_out += "{}{}\n".format(mark, stringToAppend)
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
    return "{}{}{}{}{}".format(mc(operation), mc(addressingMode1), mc(reg1),mc(addressingMode2),mc(reg2))


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
    # // print(operand, '-> ', addressMode, autoDec, autoInc, indexed, register)
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