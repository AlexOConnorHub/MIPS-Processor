-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/06/2020 19:07:10"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Linked
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Linked_vhd_vec_tst IS
END Linked_vhd_vec_tst;
ARCHITECTURE Linked_arch OF Linked_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL fast_clock : STD_LOGIC;
SIGNAL Instruction_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PC_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Read_data1_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Read_data2_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Read_reg1_out : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Read_reg2_out : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL slow_clock : STD_LOGIC;
SIGNAL Write_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Write_reg_out : STD_LOGIC_VECTOR(4 DOWNTO 0);
COMPONENT Linked
	PORT (
	fast_clock : IN STD_LOGIC;
	Instruction_out : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	PC_out : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Read_data1_out : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Read_data2_out : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Read_reg1_out : BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0);
	Read_reg2_out : BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0);
	reset : IN STD_LOGIC;
	slow_clock : IN STD_LOGIC;
	Write_data_out : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Write_reg_out : BUFFER STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Linked
	PORT MAP (
-- list connections between master ports and signals
	fast_clock => fast_clock,
	Instruction_out => Instruction_out,
	PC_out => PC_out,
	Read_data1_out => Read_data1_out,
	Read_data2_out => Read_data2_out,
	Read_reg1_out => Read_reg1_out,
	Read_reg2_out => Read_reg2_out,
	reset => reset,
	slow_clock => slow_clock,
	Write_data_out => Write_data_out,
	Write_reg_out => Write_reg_out
	);

-- fast_clock
t_prcs_fast_clock: PROCESS
BEGIN
LOOP
	fast_clock <= '0';
	WAIT FOR 50000 ps;
	fast_clock <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 100000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_fast_clock;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '0';
	WAIT FOR 5120000 ps;
	reset <= '1';
WAIT;
END PROCESS t_prcs_reset;

-- slow_clock
t_prcs_slow_clock: PROCESS
BEGIN
LOOP
	slow_clock <= '0';
	WAIT FOR 500000 ps;
	slow_clock <= '1';
	WAIT FOR 500000 ps;
	IF (NOW >= 100000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_slow_clock;
END Linked_arch;
