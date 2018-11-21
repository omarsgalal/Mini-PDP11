import numpy as np
import re
from lockuptable import getMachineCode
from symbolTable import ST
from AssemblerPh1 import assemblePh1
from util import *

re_immediateAddressing = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")
re_validInstr = re.compile(r".{1,4} #\d+ *, *[Rr][0-7]")

class AssemblePh2:
    def __init__(self, AllCodeText):
        self.lines = AllCodeText.splitlines()
        self.addressTransforming = 0 # current address that is begin transformed to machine code
    def incAddress(self):
        self.addressTransforming += 1
        return self.addressTransforming

    ph2_out = ''
    def assemblePh2():
        # // constructSymbolTableVariables()
        # // appender = Appender(incAddress)
        lines = AllCodeText.splitlines()
        for fileLineNumber in range(1,len(lines) + 1):
            instruction = cleanInstruction(lines[fileLineNumber - 1])

            if(not instruction):  # empty line
                continue
            if(instruction.isdigit()): # value
                appendMachineCode(strToBinary16(instruction))
                continue
            if(instruction.find(":") != -1):    # label
                label = instruction[0:instruction.find(":")]
                ST.update(label, addressTransforming)
                # // symbolTable[label] = addressTransforming
                continue
            if(instruction[0:6] == "DEFINE"):
                instruction = instruction.replace('DEFINE ', '')
                varName, varValue = instruction.split(' ')
                print('unused variable', varName) if not ST.isExist(varName) else None
                ST.update(varName, addressTransforming)
                # // symbolTable[varName] = addressTransforming
                appendMachineCode(strToBinary16(varValue))
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
                if(ST.isExist(operand1) and ST.isExist(operand2)):
                    handle2VariablesOperation(instruction)
                elif(ST.isExist(operand1)):
                    handle1VariableOperation(instruction, 0)
                elif(ST.isExist(operand2)):
                    handle1VariableOperation(instruction, 1)

            elif(not ST.isExist(operand1) and ST.isExist(operation)):
                # zero operand variable
                appendMachineCode(instruction, mark='$VAR')
            elif(operation[0] == "B"):
                appendMachineCode(instruction, mark="$BCH")
            elif(ST.isExist(operand1)):
                handleVariableOperation1(instruction)
            else:
                toMachineCode(instruction)
        return ph2_out



    ####################################################################################################################
    def handleImmediate(instruction):
        splittedInstruction = instruction.split(",")
        temp=splittedInstruction[0].split("#")
        toMachineCode(temp[0]+" (R7)+,"+splittedInstruction[1])
        appendMachineCode(strToBinary16(temp[1]))

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
        return "{}{}{}{}{}".format(mc(operation), mc(addressingMode1), mc(reg1),mc(reg2),mc(addressingMode2))


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