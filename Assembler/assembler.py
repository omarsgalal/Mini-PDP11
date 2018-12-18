from lockuptable import getMachineCode
from symbolTable import ST
from AssemblerPh1 import assemblePh1
from AssemblerPh2 import assemblePh2
from AssemblerPh3 import assemblePh3
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
JSR (R0)+       ; JSR from a register                                                                       [done1]      
'''
def pipeline():
    assemblyFile = open("program.txt", 'r') # code
    AllCodeText = str(assemblyFile.read())
    AllCodeText = AllCodeText.upper()
    assemblyFile.close()
    try:
        # execute pipline
        assemblePh1(AllCodeText)
        ph2 = assemblePh2(AllCodeText)
        f = open("phase2AssembleCode.txt", 'w')
        f.write(ph2)
        f.close()

        ph3 = assemblePh3(ph2)
        f = open("out.txt", 'w')
        f.write(ph3)
        f.close()

        fBinaryOnly = open("out.txt", 'r')
        f = open("program.mem", 'w')
        formatComment = '''// memory data file (do not edit the following line - required for mem load use)
// instance=/tb_filereg/Fr/Ram/ram
// format=mti addressradix=d dataradix=b version=1.0 wordsperline=1
'''
        f.write(formatComment)
        i = 0
        for line in fBinaryOnly.readlines():
            f.write("{}: {}".format(i, line))
            i += 1
        fBinaryOnly.close()
        f.close()
    except Exception as e:
        print('an error has occurred', e)

if __name__ == '__main__':
    #print("start program")
    pipeline()
    #print("ends")