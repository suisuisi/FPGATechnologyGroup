-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: conv_round_cc 
--  /   /        Date Last Modified:  March 30, 2006 
-- /___/   /\    Date Created: March 30, 2006
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--
-- Revision History: 
-- $Log: $
-------------------------------------------------------------------------------- 
--
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
--     FOR A PARTICULAR PURPOSE.
--
-------------------------------------------------------------------------------- 
--********************************************************************

LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--Library UNISIM;
--use UNISIM.vcomponents.all;

ENTITY conv_round_cc IS
   PORT (
      AIN                     : IN std_logic_vector(24 DOWNTO 0);   
      BIN                     : IN std_logic_vector(17 DOWNTO 0);  
      CIN                     : IN std_logic_vector(47 DOWNTO 0); 
      CLK                     : IN std_logic;   
      RST                     : IN std_logic;   
      ROUND_OUT               : OUT std_logic_vector(43 DOWNTO 0));   
END ENTITY conv_round_cc;

ARCHITECTURE conv_round_cc_arch OF conv_round_cc IS



component DSP48E 
generic (
   ACASCREG : integer :=  1;       
   ALUMODEREG : integer :=  1;     
   AREG : integer :=  1;           
   AUTORESET_PATTERN_DETECT : boolean :=  FALSE; 
   AUTORESET_PATTERN_DETECT_OPTINV : string :=  "MATCH"; 
   A_INPUT : string :=  "DIRECT"; 
   BCASCREG : integer :=  1;       
   BREG : integer :=  1;           
   B_INPUT : string :=  "DIRECT";
   CARRYINREG : integer :=  1;     
   CARRYINSELREG : integer :=  1;  
   CREG : integer :=  1;           
   MASK : string :=  X"3FFFFFFFFFFF"; 
   MREG : integer :=  1;           
   MULTCARRYINREG : integer :=  1; 
   OPMODEREG : integer :=  1;      
   PATTERN : string :=  X"000000000000"; 
   PREG : integer :=  1;           
   SEL_MASK : string :=  "MASK";  
   SEL_PATTERN : string :=  "PATTERN"; 
   SEL_ROUNDING_MASK : string :=  "SEL_MASK"; 
   USE_MULT : string :=  "MULT";
   USE_PATTERN_DETECT : string :=  "NO_PATDET"; 
   USE_SIMD : string :=  "ONE48"); 
port (
   ACOUT                   : out std_logic_vector(29 downto 0);
   BCOUT                   : out std_logic_vector(17 downto 0);
   CARRYCASCOUT            : out std_logic;
   CARRYOUT                : out std_logic_vector(3 downto 0);
   MULTSIGNOUT             : out std_logic;
   OVERFLOW                : out std_logic;
   P                       : out std_logic_vector(47 downto 0);
   PATTERNBDETECT          : out std_logic;
   PATTERNDETECT           : out std_logic;
   PCOUT                   : out std_logic_vector(47 downto 0);
   UNDERFLOW               : out std_logic;
   A                       : in  std_logic_vector(29 downto 0);
   ACIN                    : in  std_logic_vector(29 downto 0);    
   ALUMODE                 : in  std_logic_vector(3 downto 0);     
   B                       : in  std_logic_vector(17 downto 0);              
   BCIN                    : in  std_logic_vector(17 downto 0);        
   C                       : in  std_logic_vector(47 downto 0);              
   CARRYCASCIN             : in  std_logic;     
   CARRYIN                 : in  std_logic;    
   CARRYINSEL              : in  std_logic_vector(2 downto 0);    
   CEA1                    : in  std_logic;    
   CEA2                    : in  std_logic;    
   CEALUMODE               : in  std_logic;    
   CEB1                    : in  std_logic;    
   CEB2                    : in  std_logic;    
   CEC                     : in  std_logic;    
   CECARRYIN               : in  std_logic;    
   CECTRL                  : in  std_logic;    
   CEM                     : in  std_logic;    
   CEMULTCARRYIN           : in  std_logic;    
   CEP                     : in  std_logic;    
   CLK                     : in  std_logic;    
   MULTSIGNIN              : in  std_logic;    
   OPMODE                  : in  std_logic_vector(6 downto 0);    
   PCIN                    : in  std_logic_vector(47 downto 0);    
   RSTA                    : in  std_logic;    
   RSTALLCARRYIN           : in  std_logic;    
   RSTALUMODE              : in  std_logic;    
   RSTB                    : in  std_logic;    
   RSTC                    : in  std_logic;    
   RSTCTRL                 : in  std_logic;    
   RSTM                    : in  std_logic;    
   RSTP                    : in  std_logic    
);
end component;

--Signal Declarations:   
   
   SIGNAL tempA1                     :  std_logic_vector(29 downto 0);
   SIGNAL POUT1                      :  std_logic_vector(47 downto 0);
   SIGNAL CIN_REG                    :  std_logic_vector(47 downto 0);
   SIGNAL ROUND_OUT_INT              :  std_logic_vector(43 downto 0);
   SIGNAL PDOUT                      :  std_logic;

   SIGNAL LOW_18bit                  :  std_logic_vector(17 downto 0);
   SIGNAL LOW_30bit                  :  std_logic_vector(29 downto 0);
   SIGNAL LOW_48bit                  :  std_logic_vector(47 downto 0);
   SIGNAL LOW_1bit                   :  std_logic;
   SIGNAL HIGH_1bit                  :  std_logic;
	
-- Architecture Section: instantiation block 1


BEGIN

LOW_18bit        <= "000000000000000000";
LOW_30bit        <= "000000000000000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';

tempA1 <= "00000" & AIN;

DSP48E_1: DSP48E 
generic map (
   ACASCREG => 1,       
   ALUMODEREG => 1,     
   AREG => 1,           
   AUTORESET_PATTERN_DETECT => FALSE, 
   AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", 
   A_INPUT => "DIRECT", 
   BCASCREG => 1,       
   BREG => 1,           
   B_INPUT => "DIRECT", 
   CARRYINREG => 0,     
   CARRYINSELREG => 1,  
   CREG => 1,           
   MASK => X"3FFFFFFFFFFF", 
   MREG => 1,           
   MULTCARRYINREG => 0, 
   OPMODEREG => 0,      
   PATTERN => X"000000000000", 
   PREG => 1,           
   SEL_MASK => "MASK",  
   SEL_PATTERN => "PATTERN", 
   SEL_ROUNDING_MASK => "MODE2", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "PATDET", 
   USE_SIMD => "ONE48") 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => POUT1,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => PDOUT, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA1,          
   ACIN => LOW_30bit,    
   ALUMODE => "0000", 
   B => BIN,          
   BCIN => LOW_18bit,    
   C => CIN_REG,           
   CARRYCASCIN => '0', 
   CARRYIN => '0', 
   CARRYINSEL => "000", 
   CEA1 => '0',      
   CEA2 => '1',      
   CEALUMODE => '1', 
   CEB1 => '0',      
   CEB2 => '1',      
   CEC => '1',      
   CECARRYIN => '0', 
   CECTRL => '1', 
   CEM => '1',       
   CEMULTCARRYIN => '0',
   CEP => '1',       
   CLK => CLK,       
   MULTSIGNIN => '0', 
   OPMODE => "0110101", 
   PCIN => LOW_48bit,      
   RSTA => RST,     
   RSTALLCARRYIN => RST, 
   RSTALUMODE => RST, 
   RSTB => RST,     
   RSTC => '0',    
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST 
);

   -- End of DSP48E_1 instantiation

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         ROUND_OUT_INT <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         ROUND_OUT_INT <= POUT1(47 DOWNTO 4) + PDOUT;    
      END IF;
   END PROCESS;

ROUND_OUT <= ROUND_OUT_INT(43 DOWNTO 0);



END conv_round_cc_arch;



