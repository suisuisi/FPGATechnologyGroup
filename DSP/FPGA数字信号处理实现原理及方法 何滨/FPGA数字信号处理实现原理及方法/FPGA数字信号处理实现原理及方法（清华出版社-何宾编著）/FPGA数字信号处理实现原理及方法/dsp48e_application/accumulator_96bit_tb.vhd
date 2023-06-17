
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:10:57 08/08/2007
-- Design Name:   addaccum96
-- Module Name:   E:/home/chrisar/cases/dan_m/wide_accumulate/accumulator_96bit_tb.vhd
-- Project Name:  wide_accumulate
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: addaccum96
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY accumulator_96bit_tb_vhd IS
END accumulator_96bit_tb_vhd;

ARCHITECTURE behavior OF accumulator_96bit_tb_vhd IS 

	constant CLOCK_PERIOD      : time := 5 ns;             --200MHz clock
	constant HALF_CLOCK_PERIOD : time := CLOCK_PERIOD / 2;


	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT addaccum96
	PORT(
		AIN : IN std_logic_vector(95 downto 0);
		CLK : IN std_logic;
		RST : IN std_logic;          
		SUM_OUT : OUT std_logic_vector(95 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL RST :  std_logic := '0';
	SIGNAL AIN :  std_logic_vector(95 downto 0) := (others=>'0');

	--Outputs
	SIGNAL SUM_OUT :  std_logic_vector(95 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: addaccum96 PORT MAP(
		AIN => AIN,
		CLK => CLK,
		RST => RST,
		SUM_OUT => SUM_OUT
	);


	-- Clock
	clock_proc : process
	begin
		wait for HALF_CLOCK_PERIOD;
		CLK <= not CLK;
	end process;

	
	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Place stimulus here
		wait for CLOCK_PERIOD;
		RST <= '0';
		AIN <= x"000000000000400000000000";

                wait for CLOCK_PERIOD * 10;
		RST <= '1';
		wait for CLOCK_PERIOD * 2;
		RST <= '0';

		wait; -- will wait forever
	END PROCESS;

END;
