----------------------------------------------------------------------------------
-- Company: 
-- Engineer: roy2022
-- 
-- Create Date:    14:34:33 03/09/2023 
-- Design Name: 
-- Module Name:    test_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- top for testing hdb3_encoder/decoder, test_2bit--> generating datain for test
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_top is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ready : in  STD_LOGIC;
			  valid_de	:	out std_logic;
--           hdb3_code : out  STD_LOGIC_VECTOR (2 downto 0);
           data_out : out  STD_LOGIC);
end test_top;

architecture Behavioral of test_top is

	COMPONENT test_2bit
	PORT(
		clk : IN std_logic;          
		bit1out : OUT std_logic
		);
	END COMPONENT;

	COMPONENT tt_hdb3_encoder
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data_in : IN std_logic;
		ready : IN std_logic;          
		hdb3_code : OUT std_logic_vector(2 downto 0);
		valid : OUT std_logic
		);
	END COMPONENT;

	COMPONENT tt_hdb3_decoder
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		code_in : IN std_logic_vector(2 downto 0);
		ready : IN std_logic;          
		valid : OUT std_logic;
		data_out : OUT std_logic
		);
	END COMPONENT;

	signal	tttt_datain	:	std_logic;
	signal	tttt_valid	:	std_logic;
	signal	hdb3_code : STD_LOGIC_VECTOR (2 downto 0);
	
begin

	Inst_test_2bit: test_2bit PORT MAP(
		clk => not clk,
		bit1out => tttt_datain
	);

	Inst_tt_hdb3_encoder: tt_hdb3_encoder PORT MAP(
		clk => clk,
		rst => rst,
		data_in => tttt_datain,
		ready => ready,
		hdb3_code => hdb3_code,
		valid => tttt_valid
	);

	Inst_tt_hdb3_decoder: tt_hdb3_decoder PORT MAP(
		clk => clk,
		rst => rst,
		code_in => hdb3_code,
		ready => tttt_valid,
		valid => valid_de,
		data_out => data_out
	);

end Behavioral;

