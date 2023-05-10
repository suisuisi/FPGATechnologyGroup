----------------------------------------------------------------------------------
-- Company: 
-- Engineer: roy2022
-- 
-- Create Date:    14:20:34 03/09/2023 
-- Design Name: 
-- Module Name:    test_2bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--	test_2bit--> generating datain for test
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

entity test_2bit is
	generic(
		CONS_8bits_max:	natural	:=	10			--
	);
    Port ( clk : in  STD_LOGIC;
           bit1out : out  STD_LOGIC);
end test_2bit;

architecture Behavioral of test_2bit is
	constant	reg1	:	std_logic_vector(7 downto 0)	:=	"00000000";
	constant	reg2	:	std_logic_vector(7 downto 0)	:=	"00000000";
	constant	reg3	:	std_logic_vector(7 downto 0)	:=	"00000000";
	constant	reg4	:	std_logic_vector(7 downto 0)	:=	"11000001";
	constant	reg5	:	std_logic_vector(7 downto 0)	:=	"00000010";
	constant	reg6	:	std_logic_vector(7 downto 0)	:=	"00001000";
	constant	reg7	:	std_logic_vector(7 downto 0)	:=	"00100001";
	constant	reg8	:	std_logic_vector(7 downto 0)	:=	"11000001";
	constant	reg9	:	std_logic_vector(7 downto 0)	:=	"00000000";
	constant	reg10	:	std_logic_vector(7 downto 0)	:=	"00000000";
	signal	tmpout	:	std_logic_vector(79 downto 0);
	signal	cnttt	:	integer	range 0 to 79 :=0;
begin
	tmpout	<=	reg10 & reg9 & reg8 & reg7 & reg6 & reg5 & reg4 & reg3 & reg2 & reg1;
	process(clk)
	begin
		if clk'event and clk = '1' then
			bit1out	<=	tmpout(cnttt);
			if cnttt > 78 then
				cnttt	<=	0;
			else
				cnttt	<=	cnttt	+1;
			end if;
		end if;
	end process;

end Behavioral;

