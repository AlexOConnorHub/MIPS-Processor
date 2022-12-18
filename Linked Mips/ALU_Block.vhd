LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU_Block IS
  PORT( ALUControl         : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
        inputA, inputB     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        shamt              : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
        Zero               : OUT STD_LOGIC;
        ALU_Result         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END ALU_Block;

ARCHITECTURE alublk OF ALU_Block IS
	SIGNAL SLTSig,ALU_ResultSig	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	BEGIN
	SLTSig		<= inputA - inputB;
	ALU_ResultSig 	<= 	(inputA OR  inputB) 											WHEN ( ALUControl = "0001") ELSE
						(inputA  +  inputB) 													WHEN ( ALUControl = "0010") ELSE
						(inputA  -  inputB) 													WHEN ( ALUControl = "0110") ELSE
						("0000000000000000000000000000000" & SLTSig(31)) 			WHEN ( ALUControl = "0111") ELSE
						
						(inputA)																	WHEN ((ALUControl = "1000") AND (shamt  = "00000")) ELSE
						(inputA(30 DOWNTO 0) & '0')										WHEN ((ALUControl = "1000") AND (shamt  = "00001")) ELSE
						(inputA(29 DOWNTO 0) & "00")										WHEN ((ALUControl = "1000") AND (shamt  = "00010")) ELSE
						(inputA(28 DOWNTO 0) & "000")										WHEN ((ALUControl = "1000") AND (shamt  = "00011")) ELSE
						(inputA(27 DOWNTO 0) & "0000")									WHEN ((ALUControl = "1000") AND (shamt  = "00100")) ELSE
						(inputA(26 DOWNTO 0) & "00000")									WHEN ((ALUControl = "1000") AND (shamt  = "00101")) ELSE
						(inputA(25 DOWNTO 0) & "000000")									WHEN ((ALUControl = "1000") AND (shamt  = "00110")) ELSE
						(inputA(24 DOWNTO 0) & "0000000")								WHEN ((ALUControl = "1000") AND (shamt  = "00111")) ELSE
						(inputA(23 DOWNTO 0) & "00000000")								WHEN ((ALUControl = "1000") AND (shamt  = "01000")) ELSE
						(inputA(22 DOWNTO 0) & "000000000")								WHEN ((ALUControl = "1000") AND (shamt  = "01001")) ELSE
						(inputA(21 DOWNTO 0) & "0000000000")							WHEN ((ALUControl = "1000") AND (shamt  = "01010")) ELSE
						(inputA(20 DOWNTO 0) & "00000000000")							WHEN ((ALUControl = "1000") AND (shamt  = "01011")) ELSE
						(inputA(19 DOWNTO 0) & "000000000000")							WHEN ((ALUControl = "1000") AND (shamt  = "01100")) ELSE
						(inputA(18 DOWNTO 0) & "0000000000000")						WHEN ((ALUControl = "1000") AND (shamt  = "01101")) ELSE
						(inputA(17 DOWNTO 0) & "00000000000000")						WHEN ((ALUControl = "1000") AND (shamt  = "01110")) ELSE
						(inputA(16 DOWNTO 0) & "000000000000000")						WHEN ((ALUControl = "1000") AND (shamt  = "01111")) ELSE
						(inputA(15 DOWNTO 0) & "0000000000000000")					WHEN ((ALUControl = "1000") AND (shamt  = "10000")) ELSE
						(inputA(14 DOWNTO 0) & "00000000000000000")					WHEN ((ALUControl = "1000") AND (shamt  = "10001")) ELSE
						(inputA(13 DOWNTO 0) & "000000000000000000")					WHEN ((ALUControl = "1000") AND (shamt  = "10010")) ELSE
						(inputA(12 DOWNTO 0) & "0000000000000000000")				WHEN ((ALUControl = "1000") AND (shamt  = "10011")) ELSE
						(inputA(11 DOWNTO 0) & "00000000000000000000")				WHEN ((ALUControl = "1000") AND (shamt  = "10100")) ELSE
						(inputA(10 DOWNTO 0) & "000000000000000000000")				WHEN ((ALUControl = "1000") AND (shamt  = "10101")) ELSE
						(inputA(9  DOWNTO 0) & "0000000000000000000000")			WHEN ((ALUControl = "1000") AND (shamt  = "10110")) ELSE
						(inputA(8  DOWNTO 0) & "00000000000000000000000")			WHEN ((ALUControl = "1000") AND (shamt  = "10111")) ELSE
						(inputA(7  DOWNTO 0) & "000000000000000000000000")			WHEN ((ALUControl = "1000") AND (shamt  = "11000")) ELSE
						(inputA(6  DOWNTO 0) & "0000000000000000000000000")		WHEN ((ALUControl = "1000") AND (shamt  = "11001")) ELSE
						(inputA(5  DOWNTO 0) & "00000000000000000000000000")		WHEN ((ALUControl = "1000") AND (shamt  = "11010")) ELSE
						(inputA(4  DOWNTO 0) & "000000000000000000000000000")		WHEN ((ALUControl = "1000") AND (shamt  = "11011")) ELSE
						(inputA(3  DOWNTO 0) & "0000000000000000000000000000")	WHEN ((ALUControl = "1000") AND (shamt  = "11100")) ELSE
						(inputA(2  DOWNTO 0) & "00000000000000000000000000000")	WHEN ((ALUControl = "1000") AND (shamt  = "11101")) ELSE
						(inputA(1  DOWNTO 0) & "000000000000000000000000000000")	WHEN ((ALUControl = "1000") AND (shamt  = "11110")) ELSE
						(inputA(          0) & "0000000000000000000000000000000")WHEN ((ALUControl = "1000") AND (shamt  = "11111")) ELSE
						
						(inputA)																	WHEN ((ALUControl = "1001") AND (shamt  = "00000")) ELSE
						('0' & inputA(31 DOWNTO 1))										WHEN ((ALUControl = "1001") AND (shamt  = "00001")) ELSE
						("00" & inputA(31 DOWNTO 2))										WHEN ((ALUControl = "1001") AND (shamt  = "00010")) ELSE
						("000" & inputA(31 DOWNTO 3))										WHEN ((ALUControl = "1001") AND (shamt  = "00011")) ELSE
						("0000" & inputA(31 DOWNTO 4))									WHEN ((ALUControl = "1001") AND (shamt  = "00100")) ELSE
						("00000" & inputA(31 DOWNTO 5))									WHEN ((ALUControl = "1001") AND (shamt  = "00101")) ELSE
						("000000" & inputA(31 DOWNTO 6))									WHEN ((ALUControl = "1001") AND (shamt  = "00110")) ELSE
						("0000000" & inputA(31 DOWNTO 7))								WHEN ((ALUControl = "1001") AND (shamt  = "00111")) ELSE
						("00000000" & inputA(31 DOWNTO 8))								WHEN ((ALUControl = "1001") AND (shamt  = "01000")) ELSE
						("000000000" & inputA(31 DOWNTO 9))								WHEN ((ALUControl = "1001") AND (shamt  = "01001")) ELSE
						("0000000000" & inputA(31 DOWNTO 10))							WHEN ((ALUControl = "1001") AND (shamt  = "01010")) ELSE
						("00000000000" & inputA(31 DOWNTO 11))							WHEN ((ALUControl = "1001") AND (shamt  = "01011")) ELSE
						("000000000000" & inputA(31 DOWNTO 12))						WHEN ((ALUControl = "1001") AND (shamt  = "01100")) ELSE
						("0000000000000" & inputA(31 DOWNTO 13))						WHEN ((ALUControl = "1001") AND (shamt  = "01101")) ELSE
						("00000000000000" & inputA(31 DOWNTO 14))						WHEN ((ALUControl = "1001") AND (shamt  = "01110")) ELSE
						("000000000000000" & inputA(31 DOWNTO 15))					WHEN ((ALUControl = "1001") AND (shamt  = "01111")) ELSE
						("0000000000000000" & inputA(31 DOWNTO 16))					WHEN ((ALUControl = "1001") AND (shamt  = "10000")) ELSE
						("00000000000000000" & inputA(31 DOWNTO 17))					WHEN ((ALUControl = "1001") AND (shamt  = "10001")) ELSE
						("000000000000000000" & inputA(31 DOWNTO 18))				WHEN ((ALUControl = "1001") AND (shamt  = "10010")) ELSE
						("0000000000000000000" & inputA(31 DOWNTO 19))				WHEN ((ALUControl = "1001") AND (shamt  = "10011")) ELSE
						("00000000000000000000" & inputA(31 DOWNTO 20))				WHEN ((ALUControl = "1001") AND (shamt  = "10100")) ELSE
						("000000000000000000000" & inputA(31 DOWNTO 21))			WHEN ((ALUControl = "1001") AND (shamt  = "10101")) ELSE
						("0000000000000000000000" & inputA(31 DOWNTO 22))			WHEN ((ALUControl = "1001") AND (shamt  = "10110")) ELSE
						("00000000000000000000000" & inputA(31 DOWNTO 23))			WHEN ((ALUControl = "1001") AND (shamt  = "10111")) ELSE
						("000000000000000000000000" & inputA(31 DOWNTO 24))		WHEN ((ALUControl = "1001") AND (shamt  = "11000")) ELSE
						("0000000000000000000000000" & inputA(31 DOWNTO 25))		WHEN ((ALUControl = "1001") AND (shamt  = "11001")) ELSE
						("00000000000000000000000000" & inputA(31 DOWNTO 26))		WHEN ((ALUControl = "1001") AND (shamt  = "11010")) ELSE
						("000000000000000000000000000" & inputA(31 DOWNTO 27))	WHEN ((ALUControl = "1001") AND (shamt  = "11011")) ELSE
						("0000000000000000000000000000" & inputA(31 DOWNTO 28))	WHEN ((ALUControl = "1001") AND (shamt  = "11100")) ELSE
						("00000000000000000000000000000" & inputA(31 DOWNTO 29))	WHEN ((ALUControl = "1001") AND (shamt  = "11101")) ELSE
						("000000000000000000000000000000" & inputA(31 DOWNTO 30))WHEN ((ALUControl = "1001") AND (shamt  = "11110")) ELSE
						("0000000000000000000000000000000" & inputA(31))			WHEN ((ALUControl = "1001") AND (shamt  = "11111")) ELSE
						
						(inputA)																	WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00000")) ELSE
						(inputA(30 DOWNTO 0) & '0')										WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00001")) ELSE
						(inputA(29 DOWNTO 0) & "00")										WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00010")) ELSE
						(inputA(28 DOWNTO 0) & "000")										WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00011")) ELSE
						(inputA(27 DOWNTO 0) & "0000")									WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00100")) ELSE
						(inputA(26 DOWNTO 0) & "00000")									WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00101")) ELSE
						(inputA(25 DOWNTO 0) & "000000")									WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00110")) ELSE
						(inputA(24 DOWNTO 0) & "0000000")								WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "00111")) ELSE
						(inputA(23 DOWNTO 0) & "00000000")								WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01000")) ELSE
						(inputA(22 DOWNTO 0) & "000000000")								WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01001")) ELSE
						(inputA(21 DOWNTO 0) & "0000000000")							WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01010")) ELSE
						(inputA(20 DOWNTO 0) & "00000000000")							WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01011")) ELSE
						(inputA(19 DOWNTO 0) & "000000000000")							WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01100")) ELSE
						(inputA(18 DOWNTO 0) & "0000000000000")						WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01101")) ELSE
						(inputA(17 DOWNTO 0) & "00000000000000")						WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01110")) ELSE
						(inputA(16 DOWNTO 0) & "000000000000000")						WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "01111")) ELSE
						(inputA(15 DOWNTO 0) & "0000000000000000")					WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10000")) ELSE
						(inputA(14 DOWNTO 0) & "00000000000000000")					WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10001")) ELSE
						(inputA(13 DOWNTO 0) & "000000000000000000")					WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10010")) ELSE
						(inputA(12 DOWNTO 0) & "0000000000000000000")				WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10011")) ELSE
						(inputA(11 DOWNTO 0) & "00000000000000000000")				WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10100")) ELSE
						(inputA(10 DOWNTO 0) & "000000000000000000000")				WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10101")) ELSE
						(inputA(9  DOWNTO 0) & "0000000000000000000000")			WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10110")) ELSE
						(inputA(8  DOWNTO 0) & "00000000000000000000000")			WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "10111")) ELSE
						(inputA(7  DOWNTO 0) & "000000000000000000000000")			WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11000")) ELSE
						(inputA(6  DOWNTO 0) & "0000000000000000000000000")		WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11001")) ELSE
						(inputA(5  DOWNTO 0) & "00000000000000000000000000")		WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11010")) ELSE
						(inputA(4  DOWNTO 0) & "000000000000000000000000000")		WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11011")) ELSE
						(inputA(3  DOWNTO 0) & "0000000000000000000000000000")	WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11100")) ELSE
						(inputA(2  DOWNTO 0) & "00000000000000000000000000000")	WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11101")) ELSE
						(inputA(1  DOWNTO 0) & "000000000000000000000000000000")	WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11110")) ELSE
						(inputA(          0) & "0000000000000000000000000000000")WHEN ((ALUControl = "1010") AND (inputB(4 DOWNTO 0)  = "11111")) ELSE
						
						(inputA     (31 DOWNTO 0))											WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00000")) ELSE
						('0' & inputA(31 DOWNTO 1))										WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00001")) ELSE
						("00" & inputA(31 DOWNTO 2))										WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00010")) ELSE
						("000" & inputA(31 DOWNTO 3))										WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00011")) ELSE
						("0000" & inputA(31 DOWNTO 4))									WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00100")) ELSE
						("00000" & inputA(31 DOWNTO 5))									WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00101")) ELSE
						("000000" & inputA(31 DOWNTO 6))									WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00110")) ELSE
						("0000000" & inputA(31 DOWNTO 7))								WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "00111")) ELSE
						("00000000" & inputA(31 DOWNTO 8))								WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01000")) ELSE
						("000000000" & inputA(31 DOWNTO 9))								WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01001")) ELSE
						("0000000000" & inputA(31 DOWNTO 10))							WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01010")) ELSE
						("00000000000" & inputA(31 DOWNTO 11))							WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01011")) ELSE
						("000000000000" & inputA(31 DOWNTO 12))						WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01100")) ELSE
						("0000000000000" & inputA(31 DOWNTO 13))						WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01101")) ELSE
						("00000000000000" & inputA(31 DOWNTO 14))						WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01110")) ELSE
						("000000000000000" & inputA(31 DOWNTO 15))					WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "01111")) ELSE
						("0000000000000000" & inputA(31 DOWNTO 16))					WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10000")) ELSE
						("00000000000000000" & inputA(31 DOWNTO 17))					WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10001")) ELSE
						("000000000000000000" & inputA(31 DOWNTO 18))				WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10010")) ELSE
						("0000000000000000000" & inputA(31 DOWNTO 19))				WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10011")) ELSE
						("00000000000000000000" & inputA(31 DOWNTO 20))				WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10100")) ELSE
						("000000000000000000000" & inputA(31 DOWNTO 21))			WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10101")) ELSE
						("0000000000000000000000" & inputA(31 DOWNTO 22))			WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10110")) ELSE
						("00000000000000000000000" & inputA(31 DOWNTO 23))			WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "10111")) ELSE
						("000000000000000000000000" & inputA(31 DOWNTO 24))		WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11000")) ELSE
						("0000000000000000000000000" & inputA(31 DOWNTO 25))		WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11001")) ELSE
						("00000000000000000000000000" & inputA(31 DOWNTO 26))		WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11010")) ELSE
						("000000000000000000000000000" & inputA(31 DOWNTO 27))	WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11011")) ELSE
						("0000000000000000000000000000" & inputA(31 DOWNTO 28))	WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11100")) ELSE
						("00000000000000000000000000000" & inputA(31 DOWNTO 29))	WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11101")) ELSE
						("000000000000000000000000000000" & inputA(31 DOWNTO 30))WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11110")) ELSE
						("0000000000000000000000000000000" & inputA(31))			WHEN ((ALUControl = "1011") AND (inputB(4 DOWNTO 0)  = "11111")) ELSE
						
						(inputB(31 DOWNTO 16) & "0000000000000000")					WHEN ( ALUControl = "1101") ELSE
						(inputA NOR inputB) 													WHEN ( ALUControl = "1100") ELSE
						(inputA AND inputB); 
	Zero 		<= 	'1' WHEN (ALU_ResultSig = "00000000000000000000000000000000") ELSE '0';
	ALU_Result <= ALU_ResultSig;
					
END alublk;