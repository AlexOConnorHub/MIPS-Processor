LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Extend IS
PORT(
	input	:	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	output:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END Extend;

ARCHITECTURE ext OF Extend IS
BEGIN
output <=	input(15) & input(15) & input(15) & input(15) & 
				input(15) & input(15) & input(15) & input(15) & 
				input(15) & input(15) & input(15) & input(15) & 
				input(15) & input(15) & input(15) & input(15) & input;
END ext;