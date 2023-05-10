----------------------------------------------------------------------------------
-- Company: 
-- Engineer: roy2022
-- 
-- Create Date: 2023/03/07 10:42:43
-- Design Name: 
-- Module Name: tt_hdb3_encoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- hdb3 encoder
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tt_hdb3_encoder is
    Port ( clk : in STD_LOGIC;    --1=reset
           rst : in STD_LOGIC;    --1=reset
           data_in : in STD_LOGIC;
           ready : in STD_LOGIC;    --1=data ready
           hdb3_code : out STD_LOGIC_VECTOR (2 downto 0);
           valid : out STD_LOGIC);    --1= data valid
end tt_hdb3_encoder;

architecture Behavioral of tt_hdb3_encoder is
    constant    CODE_00 :   std_logic_vector(2 downto 0)    :="000";    -- 0
    constant    CODE_1P :   std_logic_vector(2 downto 0)    :="001";    -- +1
    constant    CODE_1N :   std_logic_vector(2 downto 0)    :="101";    -- -1
    constant    CODE_BP :   std_logic_vector(2 downto 0)    :="010";    -- +B
    constant    CODE_BN :   std_logic_vector(2 downto 0)    :="110";    -- -B
    constant    CODE_VP :   std_logic_vector(2 downto 0)    :="011";    -- +V
    constant    CODE_VN :   std_logic_vector(2 downto 0)    :="111";    -- -V
    
    signal  tmp_rst  :   std_logic_vector(1 downto 0)	:=	"00";
    signal  tmp_din,tmp_ready  :   std_logic;
    type hdb3_matrix is array (3 downto 0) of std_logic_vector(2 downto 0);
    signal  tmp_dataout :   hdb3_matrix;
    signal  flag_1BPOL : std_logic := '0';   --0=-,1=+
    signal  flag_VPOL : std_logic := '0';   --0=-,1=+
    signal  cnt_tbpo  :   natural range 0 to 7 := 0;   --to be putout 0-4
	 signal  cnt_tbc  :   natural range 0 to 3 := 0;   --to be encode  0-3
    
begin

Pro_coding: process(rst, clk)
    begin
        if rst ='1' then
            tmp_rst  <=  "00";
            flag_1BPOL   <=  '0';
            flag_VPOL   <=  '0';
            cnt_tbpo    <=  0;
				cnt_tbc	<=	0;
				valid	<=	'0';
				hdb3_code	<=	CODE_00;
				tmp_ready	<=	'0';
				tmp_din	<=	'0';
        elsif clk'event and clk = '1' then
            tmp_rst	<=	tmp_rst(0) & '1';
				if tmp_rst = "11" then				-- releasing after 1 clk
--1. putout
					if cnt_tbpo = 0 then
						valid	<=	'0';
						hdb3_code	<=	CODE_00;
					elsif cnt_tbpo <5 then
						valid	<=	'1';
						hdb3_code	<=	tmp_dataout(cnt_tbpo-1);		--1st putout tmp_dataout(3)
						cnt_tbpo	<=	cnt_tbpo-1;
					else			--error
						null;
					end if;
					
					
					tmp_din	<=	data_in;
					tmp_ready	<=	ready;
--2. coding while ready(ready =0 ,null)					
					if tmp_ready ='1' then
--2.1 din=1
						if tmp_din = '1' then
							case (cnt_tbc) is 
								when 0 =>
									case (cnt_tbpo) is 
										when 0 =>
											cnt_tbpo	<=	1;		--disable cnt_tbpo-- @forward
										when 1 =>
											cnt_tbpo	<=	1;		--disable cnt_tbpo-- @forward
										when 2 =>				--tmp_dataout 0/1
											cnt_tbpo	<=	2;
											tmp_dataout(1)	<=	tmp_dataout(0);
										when 3 =>				--tmp_dataout 0/1/2
											cnt_tbpo	<=	3;
											tmp_dataout(2)	<=	tmp_dataout(1);
											tmp_dataout(1)	<=	tmp_dataout(0);
										when 4 =>
											cnt_tbpo	<=	4;
											tmp_dataout(3)	<=	tmp_dataout(2);
											tmp_dataout(2)	<=	tmp_dataout(1);
											tmp_dataout(1)	<=	tmp_dataout(0);
										when others =>		--error
											null;
									end case;
								when 1 =>
									case (cnt_tbpo) is 
										when 0 =>
											cnt_tbpo	<=	2;		--disable cnt_tbpo-- @forward
											tmp_dataout(1)	<= CODE_00;
										when 1 =>
											cnt_tbpo	<=	2;		--disable cnt_tbpo-- @forward
											tmp_dataout(1)	<= CODE_00;
										when 2 =>				--tmp_dataout 0/1
											cnt_tbpo	<=	3;
											tmp_dataout(2)	<=	tmp_dataout(0);
											tmp_dataout(1)	<=	CODE_00;
										when 3 =>				--tmp_dataout 0/1/2
											cnt_tbpo	<=	4;
											tmp_dataout(3)	<=	tmp_dataout(1);
											tmp_dataout(2)	<=	tmp_dataout(0);
											tmp_dataout(1)	<=	CODE_00;
										when others =>		--error
											null;
									end case;
								when 2 =>
									case (cnt_tbpo) is 
										when 0 =>
											cnt_tbpo	<=	3;		--disable cnt_tbpo-- @forward
											tmp_dataout(2)	<= CODE_00;
											tmp_dataout(1)	<= CODE_00;
										when 1 =>
											cnt_tbpo	<=	3;		--disable cnt_tbpo-- @forward
											tmp_dataout(2)	<= CODE_00;
											tmp_dataout(1)	<= CODE_00;
										when 2 =>				--tmp_dataout 0/1
											cnt_tbpo	<=	4;
											tmp_dataout(3)	<=	tmp_dataout(0);
											tmp_dataout(2)	<=	CODE_00;
											tmp_dataout(1)	<=	CODE_00;
										when others =>		--error
											null;
									end case;
								when 3 =>
									if cnt_tbpo=0 or cnt_tbpo =1 then
										cnt_tbpo	<=	4;
										tmp_dataout(3)	<=	CODE_00;
										tmp_dataout(2)	<=	CODE_00;
										tmp_dataout(1)	<=	CODE_00;
									else			--error
									end if;
								when others =>		--error
									null;
							end case; 
							if flag_1BPOL='1' then
								tmp_dataout(0)	<=	CODE_1N;
							else
								tmp_dataout(0)	<=	CODE_1P;
							end if;
							flag_1BPOL	<=	not flag_1BPOL;
							cnt_tbc	<=	0;
						else
--2.2 din=0
							if cnt_tbc =3 then	--the 4th 0 		cnt_tbpo=0 or 1
								if flag_VPOL = '1' then
									tmp_dataout(0)	<=	CODE_VN;
								else
									tmp_dataout(0)	<=	CODE_VP;
								end if;
								flag_VPOL	<=	not flag_VPOL;
								tmp_dataout(2)	<=	CODE_00;
								tmp_dataout(1)	<=	CODE_00;
								if flag_VPOL = flag_1BPOL then
									if flag_VPOL ='1' then
										tmp_dataout(3)	<=	CODE_BN;
										flag_1BPOL	<=	'0';
									else
										tmp_dataout(3)	<=	CODE_BP;
										flag_1BPOL	<=	'1';
									end if;
								else
									tmp_dataout(3)	<=	CODE_00;
								end if;
								cnt_tbc	<=	0;
								cnt_tbpo	<=	4;
							elsif cnt_tbc	<3 then
								cnt_tbc	<=	cnt_tbc	+1;
							else		--error
								null;
							end if;
						end if;
					end if;
				end if;
        end if;
    end process;
    
    
end Behavioral;
