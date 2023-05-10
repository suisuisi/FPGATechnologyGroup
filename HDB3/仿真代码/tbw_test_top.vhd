--------------------------------------------------------------------------------
-- Company: 
-- Engineer: roy2022
--
-- Create Date:   15:11:43 03/09/2023
-- Design Name:   
-- Module Name:   F:/isework/myiic/tbw_test_top.vhd
-- Project Name:  myiic
-- Target Device:  
-- Tool versions:  
-- Description:   
-- test hdb3_encoder/decoder
-- VHDL Test Bench Created by ISE for module: test_top
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tbw_test_top IS
END tbw_test_top;
 
ARCHITECTURE behavior OF tbw_test_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT test_top
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ready : IN  std_logic;
         valid_de : OUT  std_logic;
         data_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ready : std_logic := '0';

 	--Outputs
   signal valid_de : std_logic;
   signal data_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: test_top PORT MAP (
          clk => clk,
          rst => rst,
          ready => ready,
          valid_de => valid_de,
          data_out => data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	
		rst	<=	'1';
		ready	<=	'0';
      wait for clk_period*6;
		rst	<=	'0';
      -- insert stimulus here 
		wait for clk_period*4;
		ready	<=	'1';
		
      wait;
   end process;

END;
