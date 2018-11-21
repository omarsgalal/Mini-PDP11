from util import cleanInstruction
from symbolTable import ST

def assemblePh1(AllCodeText):
    variablesStartIndex = AllCodeText.find('DEFINE')
    if(variablesStartIndex == -1):
        return
    variablesLines = (AllCodeText[variablesStartIndex - 1:].split('\n'))[1:]
    for var in variablesLines:
        var = cleanInstruction(var)
        if(not var):  # empty line
            continue
        var = var.replace('DEFINE ', '')
        varName, varValue = var.split(' ')
        ST.remember(varName)