def getMachineCode(param):
	mc = {
	'MOV':'0001',
	'ADD':'0010',
	'ADC':'0011',
	'SUB':'0100',
	'SBC':'0101',
	'AND':'0110',
	'OR' :'0111',
	'XNOR':'1000',
	'CMP':'1001',
	'INC':'0000001010',
	'DEC':'0000001011',
	'CLR':'0000001100',
	'INV':'0000001101',
	'LSR':'0000001110',
	'ROR':'0000001111',
	'RRC':'0000010000',
	'ASR':'0000010001',
	'LSL':'0000010010',
	'ROL':'0000010011',
	'RLC':'0000010100',
	'JSR':'0000010101',
	'BR' :'00001000',
	'BEQ':'00001001',
	'BNE':'00001010',
	'BLO':'00001011',
	'BLS':'00001100',
	'BHI':'00001101',
	'BHS':'00001110',
	'HLT': '0000000001000000',
	'NOP': '0000000010000000',
	'RTS': '0000000011000000',
	'IRET':'0000000100000000',
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
	'R7':'111',
	}.get(param)
	if(not mc):
		raise Exception("Not valid operation", param)
	return mc




# def getMachineCode(param):
# 	return{
# 	'MOV':'MOV',
# 	'ADD':'ADD',
# 	'ADC':'ADC',
# 	'SUB':'SUB',
# 	'SBC':'SBC',
# 	'AND':'AND',
# 	'OR' :'OR',
# 	'XNOR':'XNOR',
# 	'CMP':'CMP',
# 	'INC':'INC',
# 	'DEC':'DEC',
# 	'CLR':'CLR',
# 	'INV':'INV',
# 	'LSR':'LSR',
# 	'ROR':'ROR',
# 	'RRC':'0000000110',
# 	'ASR':'0000000111',
# 	'LSL':'0000001000',
# 	'ROL':'0000001001',
# 	'RLC':'0000001010',
# 	'JSR':'opcodeofjsr',
# 	'BR' :'BR',
# 	'BEQ':'0000001001',
# 	'BNE':'0000001010',
# 	'BLO':'0000001011',
# 	'BHI':'0000001100',
# 	'BHS':'0000001110',
# 	'HLT':'HLT',
# 	'NOP':'0000001100',
# 	'register':'register',
# 	'autoincrement':'autoincrement',
# 	'autodecrement':'autodecrement',
# 	'indexed':'indexed',
# 	'indirectregister':'indirectregister',
# 	'indirectautoincrement':'indirectautoincrement',
# 	'indirectautodecrement':'indirectautodecrement',
# 	'indirectindexed':'indirectindexed',
# 	'R0':'R0',
# 	'R1':'R1',
# 	'R2':'R2',
# 	'R3':'R3',
# 	'R4':'R4',
# 	'R5':'R5',
# 	'R6':'R6',
# 	'R7':'R7'
# 	}.get(param)