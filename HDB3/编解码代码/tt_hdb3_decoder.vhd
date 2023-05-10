----------------------------------------------------------------------------------
-- Company: 
-- Engineer: roy2022
-- 
-- Create Date:    14:53:55 03/09/2023 
-- Design Name: 
-- Module Name:    tt_hdb3_decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- hdb3 decoder
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

entity tt_hdb3_decoder is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           code_in : in  STD_LOGIC_VECTOR (2 downto 0);
           ready : in  STD_LOGIC;
           valid : out  STD_LOGIC;
           data_out : out  STD_LOGIC);
end tt_hdb3_decoder;

architecture Behavioral of tt_hdb3_decoder is

    constant    CODE_00 :   std_logic_vector(2 downto 0)    :="000";    -- 0
    constant    CODE_1P :   std_logic_vector(2 downto 0)    :="001";    -- +1
    constant    CODE_1N :   std_logic_vector(2 downto 0)    :="101";    -- -1
    constant    CODE_BP :   std_logic_vector(2 downto 0)    :="010";    -- +B
    constant    CODE_BN :   std_logic_vector(2 downto 0)    :="110";    -- -B
    constant    CODE_VP :   std_logic_vector(2 downto 0)    :="011";    -- +V
    constant    CODE_VN :   std_logic_vector(2 downto 0)    :="111";    -- -V
    
    signal  tmp_rst  :   std_logic_vector(1 downto 0)	:=	"00";
	 signal	tmp_din	:	std_logic_vector(2 downto 0)	:=	"100";	--invaild data
	 signal	tmp_ready	:	std_logic	:=	'0';

begin

Pro_decoding: process(rst, clk)
    begin
	  if rst ='1' then
			tmp_rst  <=  "00";
			valid   <=  '0';
			data_out   <=  '0';
			tmp_ready	<=	'0';
			tmp_din	<=	"100";
		elsif clk'event and clk = '1' then
			tmp_rst	<=	tmp_rst(0) & '1';
			if tmp_rst = "11" then				-- releasing after 1 clk
				tmp_ready	<=	ready;
				tmp_din	<=	code_in;
				if tmp_ready ='1' then			--after another 1clk..
					case (tmp_din) is 
						when CODE_1P =>	data_out	<=	'1';
						when CODE_1N =>	data_out	<=	'1';
						when CODE_00 =>	data_out	<=	'0';
						when CODE_BP =>	data_out	<=	'0';
						when CODE_BN =>	data_out	<=	'0';
						when CODE_VP =>	data_out	<=	'0';
						when CODE_VN =>	data_out	<=	'0';
						when others =>		null;	--error
					end case;
					valid   <=  '1';
				else
					valid   <=  '0';
					data_out   <=  '0';
				end if;
			end if;
		end if;
	end process;

end Behavioral;

