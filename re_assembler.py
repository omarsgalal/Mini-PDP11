import re
# return re.sub(r'(?m)^ *#.*\n?', '', code)

codeFile = open("program.txt")
code = str(codeFile.read())

symbolTable = {}
# shiftLinesDown = 0 # represents count of shifted lines down due to flattens the code
def whatLine(index):
    return code.count("\n", 0, index)

def appendLine(newLine, indexInPrevLine):
    # append new line after first \n from indexInPrevLine
    pass

def main():
    removeComments(code)
    removeEmptyLines(code) # remove duplicate \n* to only one \n

    defineIndex = code.find("DEFINE") # retrun index at 'd' of first define word
    instructionsCode = code[0:defineIndex]
    flattedCode(instructionsCode) # change lines that take 2 words to 2 lines, JSR//#100//N  ==> in terms of variables

    replaceAddressingModes(instructionsCode)
    replaceOperations(instructionsCode)

    variablesCode = code[defineIndex:]
    appendVariables(variablesCode)
    pass

def main_LineByLine(lines):
    removeComments(code)
    removeEmptyLines(code) # remove duplicate \n* to only one \n ||||| and also if first line

    address = 0
    for line in lines:
        defineIndex = code.find("DEFINE") # retrun index at 'd' of first define word
        instructionsCode = code[0:defineIndex]
        flattedCode(instructionsCode) # change lines that take 2 words to 2 lines, JSR//#100//N  ==> in terms of variables

        replaceAddressingModes(instructionsCode)
        replaceOperations(instructionsCode)
        
        variablesCode = code[defineIndex:]
        appendVariables(variablesCode)
    pass



def toMachineCode(string):
    return {
        "direct": "0",
        "indirect": "1",
        "register": "00",
        "autoinc": "01",
        "autodec": "10",
        "indexed": "11",
    }.get(string)


if __name__:
    main()




