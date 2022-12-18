LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY control_block IS
  PORT( opcode             : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        funct              : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst, ALUSrc     : OUT STD_LOGIC;
        Jump, Jal, Jr      : OUT STD_LOGIC;
        Beq, Bne           : OUT STD_LOGIC;
        MemRead, MemWrite  : OUT STD_LOGIC;
        RegWrite, MemtoReg : OUT STD_LOGIC;
        ALUControl         : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END control_block;

ARCHITECTURE ctlblk OF control_block IS
SIGNAL 	
			RegDstSig,	JumpSig,		JalSig,
			JrSig,		BeqSig, 		BneSig,
			MemReadSig,	MemWriteSig	: STD_LOGIC;
BEGIN

	RegDstSig	<= '1' WHEN  (opcode = "000000") ELSE '0';
	JumpSig 		<= '1' WHEN  (opcode = "000010") ELSE '0';
	JalSig 		<= '1' WHEN  (opcode = "000011") ELSE '0';
	JrSig 		<= '1' WHEN ((opcode = "000000") AND  (funct  = "001000")) ELSE '0';
	BeqSig		<= '1' WHEN  (opcode = "000100") ELSE '0';
	BneSig		<= '1' WHEN  (opcode = "000101") ELSE '0';
	MemReadSig 	<= '1' WHEN  (opcode = "100011") ELSE '0';
	MemWriteSig	<= '1' WHEN  (opcode = "101011") ELSE '0';

	RegDst 	<= RegDstSig;
	ALUSrc 	<= NOT RegDstSig;
	Jump		<= JumpSig;
	Jal 		<= JalSig;
	Jr 		<= JrSig;
	Beq 		<= BeqSig;
	Bne 		<= BneSig;
	MemRead 	<= MemReadSig;
	MemWrite <= MemWriteSig;
	RegWrite 	<= NOT(((((JumpSig OR JalSig) OR BeqSig) OR BneSig) OR MemWriteSig) OR JrSig);
	MemtoReg	<= MemReadSig;
	ALUControl <= 	"0000" WHEN (funct  = "100100") ELSE
						"0000" WHEN (opcode = "001100") ELSE
						"0110" WHEN (opcode = "000100") ELSE
						"0110" WHEN (opcode = "000101") ELSE
						"1101" WHEN (opcode = "001111") ELSE
						"1100" WHEN (funct  = "100111") ELSE
						"0001" WHEN (funct  = "100101") ELSE
						"0001" WHEN (opcode = "001101") ELSE
						"0111" WHEN (funct  = "101010") ELSE
						"0111" WHEN (opcode = "001010") ELSE
						"0100" WHEN (funct  = "000000") ELSE
						"1001" WHEN (funct  = "000010") ELSE
						"1010" WHEN (funct  = "000100") ELSE
						"1011" WHEN (funct  = "000110") ELSE
						"0110" WHEN (funct  = "100010") ELSE
						"0110" WHEN (funct  = "100011") ELSE 
						"0010";
						
END ctlblk;