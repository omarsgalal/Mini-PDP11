
# coding: utf-8

# In[1]:


import os


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
twoOperandInst = {0:'ADD', 1:'ADC', 2:'SUB', 3:'SBC', 4:'AND', 5:'OR', 6:'XNOR'}
oneOperandInst = {0: 'INC', 1: 'DEC', 2: 'INV', 3: 'LSR', 4: 'ROR', 5: 'RRC', 6: 'ASR', 7: 'LSL', 8: 'ROL', 9: 'RLC'}

notNormal = {0:'MOV', 1:'CMP', 2: 'CLR'}
noOperandInst = {0:'HLT', 1:'NOP'}
branchInst = {0: 'BR', 1: 'BEQ', 2: 'BNE', 3: 'BLO', 4: 'BLS', 5: 'BHI', 6: 'BHS'}


# In[3]:


fetchInst = [
    'R7 outA, inc R7, MAR inA, Read, WMFC',
    'MDR outA, IR inA'
]

memoryOut = ['MDR out$, ^ in']
memoryInOut = ['MDR outA, MAR inA, Read, WMFC']

# the # for number of registers 
# the $ for last bus name (A,B)
# the ^ for temp in source, and (A,B) in distencation
fetchOperand = {}

fetchOperand[modes[0]] = [
    'R# out$, ^ in'
]
fetchOperand[modes[1]] = [
    'R# outA, F = A+1, Z in, Z outB, R# inB, MAR inA, Read, WMFC',
    memoryOut[0]
]
fetchOperand[modes[2]] = [
    'R# outA, F=A-1, Z in, Z outB, R# inB, MAR inB, Read, WMFC',
    memoryOut[0]
]
fetchOperand[modes[3]] = [
    fetchInst[0],
    'MDR outA, X in, R# outB, Y in',
    'X out, Y out,  F = A+B, Z in, Z outA, MAR inA, Read, WMFC',
    memoryOut[0]
]
fetchOperand[modes[4]] = [
    memoryInOut[0],
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
    fetchOperand[modes[3]][2],
    memoryInOut[0],
    memoryOut[0]
]

# the # for number of registers 
save = {}
save[modes[0]] = [
    'R# inA',
]
save[modes[1]] = [
    'MDR inA, Write, WMFC',
]
for i in range(1,8):
    save[modes[i]] = save[modes[1]]


# In[4]:


preOperationTwo = 'X out, Temp outB, Y in, Y out,'
postOperation = ' Z in, Z out, '
operationTwo = {'ADC': ' F = A + B + Carry,',
 'ADD': ' F = A + B,',
 'AND': ' F = A AND B,',
 'OR': ' F = A OR B,',
 'SBC': ' F = A - B + Carry,',
 'SUB': ' F = A - B,',
 'XNOR': ' F = A XNOR B,'}

preOperationOne = 'X out,'
operationOne = {'ASR': ' F = A ASR,',
 'DEC': ' F = A - 1,',
 'INC': ' F = A + 1,',
 'INV': ' F = not A,',
 'LSL': ' F = A << 1,',
 'LSR': ' F = A >> 1,',
 'RLC': ' F = A RLC,',
 'ROL': ' F = A ROL,',
 'ROR': ' F = A ROR,',
 'RRC': ' F = A RRC,'}


# In[5]:


f = open("microInstructions.txt",'w')
totalCount = 0
numInst = 0

# two operand instractrions
for operandKey,operandValue in twoOperandInst.items():
    for modeFKey, modeFValue in modes.items():
        for modeSKey, modeSValue in modes.items():
            f.write('\t\t\tInstruction: {} {},{}\n'.format(operandValue,modeFValue.replace('#','1'),modeSValue.replace('#','2')))
            count = 0
            
            # fetch instruction
            for line in fetchInst:
                f.write('T{}: {}\n'.format(count,line))
                count += 1
                
            # fetch source
            for line in fetchOperand[modeFValue]:
                f.write('T{}: '.format(count) + line.replace('#','1').replace('$','A').replace('^','Temp') + '\n')
                count += 1

            # fetch destination
            for line in fetchOperand[modeSValue]:
                f.write('T{}: '.format(count) + line.replace('#','1').replace('$','A').replace('^','X') + '\n')
                count += 1
            
            # Operation
            f.write('T{}: {}{}{}'.format(count,preOperationTwo,operationTwo[operandValue],postOperation))
            count += 1
            
            # Save
            f.write('{}\n'.format(save[modeSValue][0]).replace('#','1'))
            
            # END
            f.write('T{}: END\n\n\n'.format(count))
            
            totalCount += count
            numInst += 1

            
            
# one operand instractrions
for operandKey,operandValue in oneOperandInst.items():
    for modeKey, modeValue in modes.items():
        f.write('\t\t\tInstruction: {} {}\n'.format(operandValue,modeValue.replace('#','1')))
        count = 0

        # fetch instruction
        for line in fetchInst:
            f.write('T{}: {}\n'.format(count,line))
            count += 1

        # fetch operand
        for line in fetchOperand[modeValue]:
            f.write('T{}: '.format(count) + line.replace('#','1').replace('$','A').replace('^','X') + '\n')
            count += 1
        
        # remove \n from last line
        f.seek(-1, 2)
        f.truncate()

        # Operation
        f.write(', {}{}{}'.format(preOperationOne,operationOne[operandValue],postOperation))

        # Save
        f.write('{}\n'.format(save[modeValue][0]).replace('#','1'))

        # END
        f.write('T{}: END\n\n\n'.format(count))

        totalCount += count
        numInst += 1

            
                
                
f.close()


# In[6]:


print (totalCount, numInst, totalCount /(1.0 * numInst))
