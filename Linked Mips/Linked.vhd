LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Linked IS
	PORT(
		  reset							: IN  STD_LOGIC;
        slow_clock, fast_clock	: IN  STD_LOGIC;
        PC_out, Instruction_out	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		  Read_reg1_out				: OUT STD_LOGIC_VECTOR( 4 DOWNTO 0);
		  Read_reg2_out				: OUT STD_LOGIC_VECTOR( 4 DOWNTO 0);
		  Write_reg_out				: OUT STD_LOGIC_VECTOR( 4 DOWNTO 0);
		  Read_data1_out				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		  Read_data2_out				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		  Write_data_out				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END Linked;

ARCHITECTURE hashcat OF Linked IS

	COMPONENT counter
			PORT(	PC_IN				: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
					clock,reset		: IN	STD_LOGIC;
					PC_OUT			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	END COMPONENT;

	COMPONENT ALU_Block
		PORT(ALUControl         	: IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			  inputA, inputB     	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  shamt              	: IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
			  Zero               	: OUT STD_LOGIC;
			  ALU_Result         	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
	END COMPONENT;

	COMPONENT control_block
		PORT(opcode, funct         : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
			  RegDst, ALUSrc     	: OUT STD_LOGIC;
			  Jump, Jal, Jr      	: OUT STD_LOGIC;
			  Beq, Bne           	: OUT STD_LOGIC;
			  MemRead, MemWrite  	: OUT STD_LOGIC;
			  RegWrite, MemtoReg 	: OUT STD_LOGIC;
			  ALUControl         	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
	END COMPONENT;

	COMPONENT register_block
	  PORT( clock, reset, RegWrite : IN  STD_LOGIC;
			  read_reg1, read_reg2   : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
			  write_reg              : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
			  write_data             : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  read_data1, read_data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
	END COMPONENT;

	COMPONENT memory
		PORT(clock, init				: IN  STD_LOGIC;
			  dataout					: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			  init_busy, ram_wren	: OUT STD_LOGIC;
			  ram_address				: OUT STD_LOGIC_VECTOR(5 DOWNTO 0) );
	END COMPONENT;

	COMPONENT Extend
		PORT(input						: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
			  output						: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
	END COMPONENT;

	COMPONENT rom
		PORT( address					: IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
				clock						: IN  STD_LOGIC;
				q							: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	END COMPONENT;

	COMPONENT Mem
		PORT(	address					: IN  STD_LOGIC_VECTOR (5 DOWNTO 0);
				clock						: IN  STD_LOGIC;
				data						: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
				wren						: IN  STD_LOGIC ;
				q							: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	END COMPONENT;

	SIGNAL	RegDst_sig, 		ALUSrc_sig,     	Jump_sig, 		Jal_sig, 		Jr_sig,   
				Beq_sig, 			Bne_sig,        	MemRead_sig, 	MemWrite_sig,	RegWrite_sig, 		 
				MemtoReg_sig,		zero_sig,			branch														: STD_LOGIC;
	SIGNAL  	ALUControl_sig         																				: STD_LOGIC_VECTOR(3  DOWNTO 0);
	SIGNAL  	reg1_sig,			reg2_sig,			shamt_sig,		writedata_sig,	writejal_sig	: STD_LOGIC_VECTOR(4  DOWNTO 0);
	SIGNAL	opcode_sig, 		funct_sig,			address_sig												: STD_LOGIC_VECTOR(5  DOWNTO 0);
	SIGNAL	extin_sig																								: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	instruction,		extout_sig,			Data1,        	Data2,			Data2_sig,
				datain_sig,			ALU_Result_sig,	memin_sig,		memout_sig,		PC_plus_four,
				memdata_sig,		Branch_mux,			rom_address, 	pc_counter,		jaldatain_sig	: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 
	PCC: counter port map 	(	rom_address,		slow_clock,		reset,			pc_counter);

	ROM_COMP: rom	port map	(	rom_address (7 DOWNTO 0),			fast_clock,		instruction	);
										
	MEM_COMP: Mem	port map	(	ALU_Result_sig (5 DOWNTO 0), 		fast_clock,		memdata_sig,
										MemWrite_sig,		memout_sig);

	ALU: ALU_Block port map	(	ALUControl_sig,	Data1,		Data2,		
										shamt_sig,			zero_sig,	ALU_Result_sig);
										
	CTL: control_block port map( opcode_sig,		funct_sig,	RegDst_sig,
										ALUSrc_sig,			Jump_sig, 	Jal_sig ,
										Jr_sig,	 			Beq_sig,		Bne_sig,
										MemRead_sig,		MemWrite_sig,RegWrite_sig,
										MemtoReg_sig, 		ALUControl_sig);
					
										
	REG: register_block port map(	slow_clock, 	reset, 		RegWrite_sig,
										reg1_sig, 			reg2_sig,	writejal_sig,
										jaldatain_sig,		Data1, 		Data2_sig );
										
	EXT: Extend	port map		(	extin_sig, 			extout_sig);

	reg1_sig			<= instruction (25 DOWNTO 21);
	reg2_sig			<= instruction (20 DOWNTO 16);
	funct_sig		<= instruction	(5  DOWNTO  0);
	extin_sig		<= instruction (15 DOWnTO  0) WHEN (Jr_sig		 = '0') ELSE Data1 (15 DOWNTO  0);
	memdata_sig		<= Data2_sig;
	shamt_sig		<= instruction (10 DOWNTO  6);
	writedata_sig	<= instruction (20 DOWNTO 16)	WHEN (RegDst_sig   = '0') ELSE instruction (15 DOWNTO 11);
	Data2				<=	Data2_sig						WHEN (ALUSrc_sig 	 = '0') ELSE extout_sig;
	datain_sig		<= ALU_Result_sig					WHEN (MemtoReg_sig = '0') ELSE memout_sig;
	writejal_sig	<= writedata_sig					WHEN (Jal_sig		 = '0') ELSE "11111";
	jaldatain_sig	<= datain_sig						WHEN (Jal_sig		 = '0') ELSE PC_plus_four;
	
	
	PC_plus_four	<= rom_address + 4;
	rom_address		<= Branch_mux						WHEN (jump_sig		 = '0') ELSE PC_plus_four (31 DOWNTO 28) & instruction (25 DOWNTO  0) & "00";
	branch			<= (beq_sig AND zero_sig) OR (bne_sig AND (NOT zero_sig));
	Branch_mux		<= PC_plus_four					WHEN (branch 		 = '0') ELSE ( PC_plus_four + (extout_sig (31 DOWNTO 2) & "00"));
	
	PC_out 			<= pc_counter;
	Instruction_out<= instruction;
	Read_reg1_out	<= reg1_sig;
	Read_reg2_out	<= reg2_sig;
	Write_reg_out	<= writejal_sig;
	Read_data1_out	<= Data1;
	Read_data2_out	<= Data2_sig;
	Write_data_out	<= jaldatain_sig;
	
END hashcat;
