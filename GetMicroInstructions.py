
# coding: utf-8

# In[1]:


import os
from pandas import DataFrame

# In[2]:


modes = {0: 'R#',
1:'(R#)+',
2:'-(R#)',
3:'X(R#)',
4:'@R#',
5:'@(R#)+',
6:'@-(R#)',
7:'@X(R#)'}
registers = {0:'R0', 1:'R1', 2:'R2', 3:'R3', 4:'R4', 5:'R5', 6:'R6', 7:'R7'}
twoOperandInst = {0:'ADD', 1:'ADC', 2:'SUB', 3:'SBC', 4:'AND', 5:'OR', 6:'XNOR', 7:'CMP'}
oneOperandInst = {0: 'INC', 1: 'DEC', 2: 'INV', 3: 'LSR', 4: 'ROR', 5: 'RRC', 6: 'ASR', 7: 'LSL', 8: 'ROL', 9: 'RLC'}
branchInst = {0: 'BR', 1: 'BEQ', 2: 'BNE', 3: 'BLO', 4: 'BLS', 5: 'BHI', 6: 'BHS'}

notNormal = {0:'MOV', 2: 'CLR'}
noOperandInst = {0:'HLT', 1:'NOP'}


# In[3]:


fetchInst = [
    'R7outA, MARinA, Read, INC_R7, WMFC\n',
    'MDRoutA, IRinA\n'
]

memoryOut = ['MDRout$^, ']
memoryInOut = ['MDRoutA, MARinA, Read, WMFC']

# the # for register nu,ber 
# the $ for last bus name 'C' in source and 'A' in distenaction
# the ^ for ', TempinC' in source, and no thing in distenaction
fetchOperand = {}

fetchOperand[modes[0]] = [
    'R#out$^, '
]
fetchOperand[modes[1]] = [
    'R#outA, F = B+1, FoutB, R#inB, MARinA, Read, WMFC\n',
    memoryOut[0]
]
fetchOperand[modes[2]] = [
    'R#outA, F = B-1, FoutB, R#inB, MARinB, Read, WMFC\n',
    memoryOut[0]
]
fetchOperand[modes[3]] = [
    fetchInst[0],
    'MDRoutA, R#outC, YinC, F=A+B, FoutB, MARinB, Read, WMFC\n',
    memoryOut[0]
]
fetchOperand[modes[4]] = [
    'R#outA, MARinA, Read, WMFC\n',
    memoryOut[0]
]
fetchOperand[modes[5]] = [
    fetchOperand[modes[1]][0],
    memoryInOut[0],
    memoryOut[0]
]
fetchOperand[modes[6]] = [
    fetchOperand[modes[2]][0],
    memoryInOut[0],
    memoryOut[0]
]
fetchOperand[modes[7]] = [
    fetchOperand[modes[3]][0],
    fetchOperand[modes[3]][1],
    memoryInOut[0],
    memoryOut[0]
]

# the # for number of registers 
save = {}
save[modes[0]] = [
    'R#inB, END\n',
]
save[modes[1]] = [
    'MDRinB, Write, WMFC\n',
    'END\n'
]
for i in range(1,8):
    save[modes[i]] = save[modes[1]]


# In[4]:


preOperationTwo = 'TempoutC, YinC,'
operationTwo = {'ADC': ' F = A + B + Carry,',
 'ADD': ' F = A + B,',
 'AND': ' F = A AND B,',
 'OR': ' F = A OR B,',
 'SBC': ' F = B - A + Carry,',
 'SUB': ' F = B - A,',
 'XNOR': ' F = A XNOR B,',
 'CMP': ' F = (B - A),'}

operationOne = {'ASR': ' F = B ASR,',
 'DEC': ' F = B - 1,',
 'INC': ' F = B + 1,',
 'INV': ' F = not B,',
 'LSL': ' F = B << 1,',
 'LSR': ' F = B >> 1,',
 'RLC': ' F = B RLC,',
 'ROL': ' F = B ROL,',
 'ROR': ' F = B ROR,',
 'RRC': ' F = B RRC,'}

operationBR = {
    'BR': [
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
    ], 
    'BEQ': [
        '(If Z=0 then End), ',
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ], 
    'BNE': [
        '(If Z=1 then End), ', 
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ], 
    'BLO': [
        '(If C=1 then End), ', 
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ], 
    'BLS': [
        '(If (C=1 and Z=0) then End), ', 
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ], 
    'BHI': [
        '(If (C=0) then End), ', 
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ], 
    'BHS': [
        '(If (C=0 and Z=0) then End), ', 
        '(Address Field of IR)out, R7outC, YinC, F=A+B, FoutB, R7inB, END\n'
        ]
}
# In[5]:


f = open("microInstructions.txt",'w')
fStat = open("stat.txt",'w')
totalCount = 0
numInst = 0

fStat = []
# two operand instractrions
for operandKey,operandValue in twoOperandInst.items():
    for modeFKey, modeFValue in modes.items():
        for modeSKey, modeSValue in modes.items():
            # for i in range(8):
            #     for j in range(8):
            Instruction = '{} {},{}'.format(operandValue,modeFValue.replace('#','1'),modeSValue.replace('#','2'))
            f.write('\n\t\t\tInstruction: {}\n'.format(Instruction))
            countMemory = 0
            count = 0
            
            # fetch instruction
            for line in fetchInst:
                f.write(line)
                countMemory += line.count('WMFC')
                count += line.count('\n')
                
                
            # fetch source
            for line in fetchOperand[modeFValue]:
                f.write(line.replace('#','1').replace('$','C').replace('^',', TempinC'))
                countMemory += line.count('WMFC')
                count += line.count('\n')

            # fetch destination
            for line in fetchOperand[modeSValue]:
                f.write(line.replace('#','2').replace('$','A').replace('^',''))
                countMemory += line.count('WMFC')
                count += line.count('\n')
            
            # Operation
            f.write('{}{}'.format(preOperationTwo,operationTwo[operandValue]))
            
            
            # Save
            if not operandValue == 'CMP':
                for line in save[modeSValue]:
                    f.write('{}'.format(line).replace('#','1'))
                    countMemory += line.count('WMFC')
                    count += line.count('\n')
            else:
                f.write(' END\n')
                count += 1
            
            totalCount += count
            numInst += 1
            fStat.append([Instruction,countMemory,count])

            
            
# one operand instractrions
for operandKey,operandValue in oneOperandInst.items():
    for modeKey, modeValue in modes.items():
        # for i in range(8):
        Instruction = '{} {}'.format(operandValue,modeValue.replace('#','1'))
        f.write('\n\t\t\tInstruction: {}\n'.format(Instruction))
        countMemory = 0
        count = 0

        # fetch instruction
        for line in fetchInst:
            f.write(line)
            countMemory += line.count('WMFC')
            count += line.count('\n')
            
        # fetch operand
        for line in fetchOperand[modeValue]:
            f.write(line.replace('#',str(1)).replace('$','A').replace('^',''))
            countMemory += line.count('WMFC')
            count += line.count('\n')

        # Operation
        f.write('{}'.format(operationOne[operandValue]))

        # Save
        for line in save[modeValue]:
            f.write('{}'.format(line).replace('#','1'))
            countMemory += line.count('WMFC')
            count += line.count('\n')

        totalCount += count
        numInst += 1
        fStat.append([Instruction,countMemory,count])


# branch operand instractrions
for operandKey,operandValue in branchInst.items():
    # for i in range(8):
    Instruction = '{} Address'.format(operandValue)
    f.write('\n\t\t\tInstruction: {}\n'.format(Instruction))
    count = 0

    # fetch instruction
    for line in fetchInst:
        f.write(line)
        count += line.count('\n')
        
    # Operation
    for line in operationBR[operandValue]:
        f.write(line)
    count += 1

    totalCount += count
    numInst += 1
    fStat.append([Instruction,0,count])

                
# # no operand instruction
for operandKey,operandValue in noOperandInst.items():
    # for i in range(8):
    f.write('\n\t\t\tInstruction: {}\n'.format(operandValue))
    count = 0

    # fetch instruction
    for line in fetchInst:
        f.write(line)
        count += line.count('\n')
        
    # Operation
    f.write('END\n')
    count += 1

    totalCount += count
    numInst += 1
    fStat.append([str(operandValue),0,count])


# # notNormal = {0:'MOV', 2: 'CLR'}
# # MOV Operation
# for modeFKey, modeFValue in modes.items():
#     for modeSKey, modeSValue in modes.items():
#         f.write('\n\t\t\tInstruction: {} {},{}\n'.format('MOV',modeFValue.replace('#','1'),modeSValue.replace('#','2')))
#         count = 0
        
#         # fetch instruction
#         for line in fetchInst:
#             f.write(line)
#             count += line.count('\n')
            
#         # fetch source
#         for line in fetchOperand[modeFValue]:
#             f.write(line.replace('#','1').replace('$','C').replace('^',', TempinC'))
#             count += line.count('\n')

#         # fetch destination
#         if modeSValue == 'R#':
#             f.write('F = A, ')
#         else:
#             for line in fetchOperand[modeSValue][:-2]:
#                 f.write(line.replace('#','2').replace('$','A').replace('^',''))
#                 count += line.count('\n')
#             f.write(line.split(', Read, WMFC\n')[0].replace('#','2').replace('$','A').replace('^','') +', ')
#             # Operation
#             f.write('F = B, ')
        
        
#         for line in save[modeSValue]:
#             f.write('{}'.format(line).replace('#','2'))
#             count += line.count('\n')
        
#         totalCount += count
#         numInst += 1


f.close()

# In[6]:
pdd = DataFrame(fStat,columns=['Instruction','Number of memory acess','Number of micro instruction'])
pdd.to_csv('Stat.csv')
print ('Total number of micro instructions= {0:0.0f}, number of instructions= {1:0.0f}, CPI= {2:0.1f}'.format(totalCount, numInst, totalCount /(1.0 * numInst)))

