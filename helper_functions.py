def handleImmediateAddress(instruction):
	global pc
	global outputFileName

	splittedInstruction = instruction.split(",")
	temp=splittedInstruction[0].split("#")

	machineCode = getBinary(temp[0]+" (R7)+,"+splittedInstruction[1])
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
	f=open(outputFileName,"a")
	f.write(getBinary(splittedInstruction[0]+" X(R7)")+"\n")
	f.write("$AVAR "+splittedInstruction[1]+"-"+str((pc-2))+"\n")
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

if __name__ == "__main__":
	handleImmediateAddress("add #1000,R1")
	#print(hey)
			
