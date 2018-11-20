def handleImmediateAddress(instruction):
	global pc
	global outputFileName

	splittedInstruction=instruction.split(",")
	temp=splittedInstruction[0].split("#")
	
	out=[temp[0]+" (R7)+,"+splittedInstruction[1],temp[1]]
	machineCode=getBinary(temp[0]+" (R7)+,"+splittedInstruction[1])

	f=open(outputFileName,"a")
	f.write(machineCode+"\n")
	f.write(format(int(temp[1]), "b")+"\n")
	f.closefile()
	return 


def handleJSR(instruction,pc):
	global pc 
	global outputFileName

	splittedInstruction=instruction.split(" ")
	#address=dictionary.get(splittedInstruction[1])
	
	print( splittedInstruction[0]+" X(R7)+",address-pc-2)
	return [splittedInstruction[0]+" X(R7)+",address-pc]
	f=open(outputFileName,"a")
	f.write(getBinary(splittedInstruction[0]+" X(R7)")+"\n")
	f.write("&AVAR "+splittedInstruction[1]+"-"+str((pc-2))+"\n")
	f.closefile()
	return

def handleIndexed2DirectRegister(instruction,index):#0 means N is the 1st operand 1 means N is the 2nd operand
	global outputFileName

	splittedInstruction=instruction.split(" ")
	operands=splittedInstruction[1].split(",")
	if(index==0):
		firstOperand=" (R7)+"
		seconedOperand=operands[1]
		label=operands[0]

	else:
		firstOperand=" "+operands[0]
		seconedOperand="(R7)+"
		label=operands[1]
	f=open(outputFileName,"a")
	f.write(getBinary(splittedInstruction[0]+firstOperand+","+seconedOperand)+"\n")
	f.write("$VAR "+label)
	f.closefile()
	return
def handleIndexed2Indexed(instruction):
	global outputFileName

	splittedInstruction=instruction.split(" ")
	operands=splittedInstruction.split(",")

	f=open(outputFileName,"a")
	f.write(getBinary(splittedInstruction[0]+" (R7)+,(R7)+")+"\n")
	f.write("$VAR "+operands[0]+"\n")
	f.write("$VAR"+operands[1]+"\n")
	return
def handleClr(instruction):
	global outputFileName
	splittedInstruction=instruction.split(" ")
	f=open(outputFileName,"a")
	f.write(getBinary(splittedInstruction[0]+" (R7)+")+"\n")
	f.write("$VAR "+splittedInstruction[1]+" \n")

def getMachineCode(param):
	return{
	'MOV':'0001',
	'ADD':'0010',
	'ADC':'0011',
	'SUB':'0100',
	'SBC':'0101',
	'AND':'0110',
	'OR':'0111',
	'XNOR':'1000',
	'CMP':'1001',
	'INC':'00000',
	'DEC':'00001',
	'CLR':'00010',
	'INV':'00011',
	'LSR':'00100',
	'ROR':'00101',
	'RRC':'00110',
	'ASR':'00111',
	'LSL':'01000',
	'ROL':'01001',
	'RLC':'01010',
	'BR':'000',
	'BEQ':'001',
	'BNE':'010',
	'BLO':'011',
	'BHI':'100',
	'BHS':'110',
	'HLT':'01011',
	'NOP':'01100',
	'register':'000',
	'autoincrement':'001',
	'autodecrement':'010',
	'indexed':'011',
	'indirectregister':'100',
	'indirectautoincrement':'101',
	'indirectautodecrement':'110',
	'indirectindexed':'111',
	'R0':'000',
	'R1':'001',
	'R2':'010',
	'R3':'011',
	'R4':'100',
	'R5':'101',
	'R6':'110',
	'R7':'111'
	}.get(param)	
if __name__ == "__main__":
	handleImmediateAddress("add #1000,R1")
	#print(hey)
			
