
def cleanInstruction(instr):
    instr = instr.strip() # remove any spaces and \n in the end of the line
    instr = instr.upper()
    semiColon = instr.find(';')
    if(semiColon != -1):
        instr = instr[0:semiColon]
    return str(instr.strip())

def isImmediate(operand):
    return operand.find('#') != -1

def handelSpecialOfOperand(operand, ST):
    if(isImmediate(operand)):
        return "(R7)+"
    if(ST.isVariable(operand)):
        return "X(R7)"
    

def strToBinary16(numStr, fill=16):
    # // numStr = str(numStr)
    # // binary = bin(numStr)[2:]
    # // sixtyFill = binary.zfill(fill)
    # // return sixtyFill'
    num = int(numStr)
    binary = format(num if num >= 0 else (1 << fill) + num, "{}b".format(fill))
    return binary
    if(int(numStr) >= 0):
        return str(bin(int(str(numStr))))[2:].zfill(fill)
    else:
    	return twos_comp(str(bin(int(str(numStr)))[3:]), fill)


def twos_comp(bitString, fill):
    """compute the 2's complement of int value val"""
    val = int(bitString, 2)
    bits = len(bitString)
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)       # compute negative value
    binaryStr = str(bin(val))
    print (binaryStr)
    binaryStr = binaryStr.replace('-0b', '1')
    while(len(binaryStr) < fill):
    	binaryStr = '1' + binaryStr
    # binaryStr = binaryStr.ofill(fill)
    return binaryStr