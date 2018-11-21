from symbolTable import ST 
from util import strToBinary16
from lockuptable import getMachineCode

def assemblePh3(code):
    # // out = open("output.txt", 'w')
    # // linesAgain = open(assemblesFile.name, 'r').readlines()
    ph3_out = ''
    addressNumber = 0
    for line in code.splitlines(True):
        if(line.find('$') != -1):
            if(line.find('$VAR') != -1):
                line = line.replace('$VAR', '')
                line = ST.get(line[0:-1])
                ph3_out += strToBinary16(str(line)) + '\n'
            elif(line.find('$AVAR') != -1):
                line = line.replace('$AVAR', '')
                minusIndex = line.find('-')
                variable, offset = line.strip()[0:minusIndex], line.strip()[minusIndex+1:]
                value = int(ST.get(variable)) - int(offset) # strToBinary
                ph3_out += strToBinary16(str(value)) + '\n'
            elif(line.find('$BCH') != -1):
                line = line.replace('$BCH', '')
                branchOperation, label = line.strip().split(' ')
                offset = strToBinary16(str(int(ST.get(label)) - addressNumber),fill=7) # TODO (مش فاكر البرانش بياخد قد ايه)
                ph3_out += "{}{}\n".format(getMachineCode(branchOperation), offset)
        else:
            ph3_out += line
        addressNumber += 1
    return ph3_out
