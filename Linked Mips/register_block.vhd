LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_block IS
  PORT( clock, reset, RegWrite : IN  STD_LOGIC;
        read_reg1, read_reg2   : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
        write_reg              : IN  STD_LOGIC_VECTOR( 4 DOWNTO 0);
        write_data             : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        read_data1, read_data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END register_block;

ARCHITECTURE regblk of register_block IS

  TYPE REG_TYPE IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL registers : REG_TYPE;

BEGIN

  read_data1 <= registers( TO_INTEGER( unsigned( read_reg1 )) );
  read_data2 <= registers( TO_INTEGER(unsigned( read_reg2 )) );

  PROCESS( reset, clock )
  BEGIN

    IF( reset = '0' ) THEN
		 registers(0 ) <= X"00000000";
		 registers(1 ) <= x"00000000";
		 registers(2 ) <= x"00000000";
		 registers(3 ) <= x"00000000";
		 registers(4 ) <= x"00000000";
		 registers(5 ) <= x"00000000";
		 registers(6 ) <= x"00000000";
		 registers(7 ) <= x"00000000";
		 registers(8 ) <= x"00000000";
		 registers(9 ) <= x"00000000";
		 registers(10) <= x"00000000";
		 registers(11) <= x"00000000";
		 registers(12) <= x"00000000";
		 registers(13) <= x"00000000";
		 registers(14) <= x"00000000";
		 registers(15) <= x"00000000";
		 registers(16) <= x"00000000";
		 registers(17) <= x"00000000";
		 registers(18) <= x"00000000";
		 registers(19) <= x"00000000";
		 registers(20) <= x"00000000";
		 registers(21) <= x"00000000";
		 registers(22) <= x"00000000";
		 registers(23) <= x"00000000";
		 registers(24) <= x"00000000";
		 registers(25) <= x"00000000";
		 registers(26) <= x"00000000";
		 registers(27) <= x"00000000";
		 registers(28) <= x"00000000";
		 registers(29) <= x"00000000";
		 registers(30) <= x"00000000";
		 registers(31) <= x"00000000";
    ELSIF( RISING_EDGE( clock ) ) THEN
		 IF(RegWrite = '1') THEN
		 registers( TO_INTEGER( unsigned(write_reg) ) ) <= write_data;
		 END IF;
    END IF;
  END PROCESS;
 
END regblk;