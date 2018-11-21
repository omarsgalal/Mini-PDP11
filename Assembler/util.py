def cleanInstruction(instr):
    instr = instr.strip() # remove any spaces and \n in the end of the line
    instr = instr.upper()
    semiColon = instr.find(';')
    if(semiColon != -1):
        instr = instr[0:semiColon]
    return str(instr.strip())


def strToBinary16(numStr, fill=16):
    # // numStr = str(numStr)
    # // binary = bin(numStr)[2:]
    # // sixtyFill = binary.zfill(fill)
    # // return sixtyFill
    return str(bin(int(str(numStr))))[2:].zfill(fill)


