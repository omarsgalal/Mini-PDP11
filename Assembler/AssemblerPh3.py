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
                variable = ST.get(line[0:-1])
                if(not variable):
                    raise Exception("not defined variable {}".format(line[0:-1]))
                ph3_out += strToBinary16(str(variable)) + '\n'
            elif(line.find('$AVAR') != -1):
                line = line.replace('$AVAR', '')
                minusIndex = line.find('-')
                variable, offset = line.strip()[0:minusIndex], line.strip()[minusIndex+1:]
                if(not variable):
                    raise Exception("not defined variable {}".format(variable))                
                value = int(ST.get(variable)) - int(offset) # strToBinary
                ph3_out += strToBinary16(str(value)) + '\n'
            elif(line.find('$BCH') != -1):
                line = line.replace('$BCH', '')
                branchOperation, label = line.strip().split(' ')
                if(not label):
                    raise Exception("not defined label {}".format(label))
                offset = strToBinary16(str(int(ST.get(label)) - addressNumber - 1),fill=8) # TODO (مش فاكر البرانش بياخد قد ايه)
                if(len(offset)>8):
                        raise Exception("can't branch to that address ")
                ph3_out += "{}{}\n".format(getMachineCode(branchOperation), offset)
        else:
            ph3_out += line
        addressNumber += 1
    return ph3_out
