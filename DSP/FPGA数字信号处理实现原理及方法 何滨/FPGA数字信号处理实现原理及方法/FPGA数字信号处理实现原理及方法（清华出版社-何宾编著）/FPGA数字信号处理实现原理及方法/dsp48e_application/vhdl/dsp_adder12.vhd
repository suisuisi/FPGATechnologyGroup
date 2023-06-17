-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: dsp_adder12
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

ENTITY dsp_adder12 IS
   PORT (
      AIN1, AIN2, AIN3, AIN4     : IN std_logic_vector(11 DOWNTO 0);   
      BIN1, BIN2, BIN3, BIN4     : IN std_logic_vector(11 DOWNTO 0);   
      CLK                        : IN std_logic;   
      RST                        : IN std_logic;   
      OUT1, OUT2, OUT3, OUT4     : OUT std_logic_vector(12 DOWNTO 0));   
END ENTITY dsp_adder12;

ARCHITECTURE dsp_adder12_arch OF dsp_adder12 IS



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
   MASK : bit_vector :=  X"3FFFFFFFFFFF"; 
   MREG : integer :=  1;           
   MULTCARRYINREG : integer :=  1; 
   OPMODEREG : integer :=  1;      
   PATTERN : bit_vector :=  X"000000000000"; 
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

SIGNAL AIN1_REG, AIN2_REG, AIN3_REG, AIN4_REG :  std_logic_vector(11 DOWNTO 0);
SIGNAL BIN1_REG, BIN2_REG, BIN3_REG, BIN4_REG :  std_logic_vector(11 DOWNTO 0);
SIGNAL POUT_1                                 :  std_logic_vector(47 DOWNTO 0);
SIGNAL CARRYOUT_1                             :  std_logic_vector(3 DOWNTO 0);
SIGNAL OUT1_REG, OUT2_REG, OUT3_REG, OUT4_REG :  std_logic_vector(12 DOWNTO 0);
   
   SIGNAL tempA1                  :  std_logic_vector(29 downto 0);
   SIGNAL tempB1                  :  std_logic_vector(17 downto 0);
   SIGNAL tempC1                  :  std_logic_vector(47 downto 0);

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

tempA1 <= AIN4_REG & AIN3_REG & AIN2_REG(11 DOWNTO 6);
tempB1 <= AIN2_REG(5 DOWNTO 0) & AIN1_REG;
tempC1 <= BIN4_REG & BIN3_REG & BIN2_REG & BIN1_REG;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
      AIN1_REG <= "000000000000"; AIN2_REG <= "000000000000";
      AIN3_REG <= "000000000000"; AIN4_REG <= "000000000000";
      BIN1_REG <= "000000000000"; BIN2_REG <= "000000000000";
      BIN3_REG <= "000000000000"; BIN4_REG <= "000000000000";
      ELSIF (CLK'EVENT AND CLK = '1') THEN
      AIN1_REG <= AIN1; AIN2_REG <= AIN2;
      AIN3_REG <= AIN3; AIN4_REG <= AIN4;
      BIN1_REG <= BIN1; BIN2_REG <= BIN2;
      BIN3_REG <= BIN3; BIN4_REG <= BIN4;
      END IF;
   END PROCESS;


   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
      OUT1 <= "0000000000000"; OUT2 <= "0000000000000";
      OUT3 <= "0000000000000"; OUT4 <= "0000000000000";
      ELSIF (CLK'EVENT AND CLK = '1') THEN
      OUT1 <= OUT1_REG; OUT2 <= OUT2_REG;
      OUT3 <= OUT3_REG; OUT4 <= OUT4_REG;
      END IF;
   END PROCESS;


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
   CARRYINSELREG => 0,  
   CREG => 1,           
   MASK => X"3FFFFFFFFFFF", 
   MREG => 0,           
   MULTCARRYINREG => 0, 
   OPMODEREG => 0,      
   PATTERN => X"000000000000", 
   PREG => 1,           
   SEL_MASK => "MASK",  
   SEL_PATTERN => "PATTERN", 
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "NONE", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "FOUR12") 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => CARRYOUT_1, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => POUT_1,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA1,          
   ACIN => LOW_30bit,    
   ALUMODE => "0000", 
   B => tempB1,          
   BCIN => LOW_18bit,    
   C => tempC1,           
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
   CEM => '0',       
   CEMULTCARRYIN => '0',
   CEP => '1',       
   CLK => CLK,       
   MULTSIGNIN => '0', 
   OPMODE => "0110011", 
   PCIN => LOW_48bit,      
   RSTA => RST,     
   RSTALLCARRYIN => RST, 
   RSTALUMODE => RST, 
   RSTB => RST,     
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST 
);

   -- End of DSP48E_1 instantiation
   --

OUT1_REG <= CARRYOUT_1(0) & POUT_1(11 DOWNTO 0);
OUT2_REG <= CARRYOUT_1(1) & POUT_1(23 DOWNTO 12);
	
OUT3_REG <= CARRYOUT_1(2) & POUT_1(35 DOWNTO 24);
OUT4_REG <= CARRYOUT_1(3) & POUT_1(47 DOWNTO 36);


END dsp_adder12_arch;



