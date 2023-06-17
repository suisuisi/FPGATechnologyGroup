-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: mult59x59
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


ENTITY mult59x59 IS
   PORT (
      clk                     : IN std_logic;   
      en                      : IN std_logic;   
      rst                     : IN std_logic;   
      R                       : IN std_logic_vector(58 DOWNTO 0);   
      S                       : IN std_logic_vector(58 DOWNTO 0);   
      multout                 : OUT std_logic_vector(117 DOWNTO 0));   
END mult59x59;

ARCHITECTURE mult59x59_arch OF mult59x59 IS


   --en is not hooked up - since each DSP48E CE pin has a different pipeline depth.

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
   SIGNAL one                      :  std_logic;   
   SIGNAL zero                     :  std_logic;   
   SIGNAL R1                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S1                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R2                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S2                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R3                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S3                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R4                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S4                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R5                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S5                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R6                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S6                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R7                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S7                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R8                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S8                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL R9                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL S9                       :  std_logic_vector(58 DOWNTO 0);   
   SIGNAL P10                      :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P1                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P2                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P3                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P4                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P5                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P6                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P7                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P8                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P9                       :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout1                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout2                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout3                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout4                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout5                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout6                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout7                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout8                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL pcout9                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL P1_1                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_2                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_3                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_4                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_5                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_6                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_7                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_8                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P1_9                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_1                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_2                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_3                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_4                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_5                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_6                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P3_7                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P6_1                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P6_2                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P6_3                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P6_4                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P8_1                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P8_2                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL P9_1                     :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL acout6                   :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL acout8                   :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL acout9                   :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL bcout1                   :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL bcout3                   :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_A1                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_B1                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_A2                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_A3                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_B3                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_A4                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_A5                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_B5                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_A6                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_B6                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_B7                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_A8                  :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL temp_B8                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_B9                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL temp_B10                 :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL LOW_18bit                :  std_logic_vector(17 downto 0);
   SIGNAL LOW_30bit                :  std_logic_vector(29 downto 0);
   SIGNAL LOW_48bit                :  std_logic_vector(47 downto 0);

-- Architecture Section: 


BEGIN
   
   LOW_18bit        <= "000000000000000000";
   LOW_30bit        <= "000000000000000000000000000000";
   LOW_48bit        <= "000000000000000000000000000000000000000000000000";
   one <= '1' ;
   zero <= '0' ;
   multout <= P10(32 DOWNTO 0) & P9_1 & P8_1 & P6_1 & P3_1 & P1_1;

   PROCESS (clk)
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         P1_1 <= P1_2;    
         P1_2 <= P1_3;    
         P1_3 <= P1_4;    
         P1_4 <= P1_5;    
         P1_5 <= P1_6;    
         P1_6 <= P1_7;    
         P1_7 <= P1_8;    
         P1_8 <= P1_9;    
         P1_9 <= P1(16 DOWNTO 0);    
         P3_1 <= P3_2;    
         P3_2 <= P3_3;    
         P3_3 <= P3_4;    
         P3_4 <= P3_5;    
         P3_5 <= P3_6;    
         P3_6 <= P3_7;    
         P3_7 <= P3(16 DOWNTO 0);    
         P6_1 <= P6_2;    
         P6_2 <= P6_3;    
         P6_3 <= P6_4;    
         P6_4 <= P6(16 DOWNTO 0);    
         P8_1 <= P8_2;    
         P8_2 <= P8(16 DOWNTO 0);    
         P9_1 <= P9(16 DOWNTO 0);    
      END IF;
   END PROCESS;

   PROCESS (clk)
   BEGIN
      IF (clk'EVENT AND clk = '1') THEN
         R1 <= R;    
         S1 <= S;    
         R2 <= R1;    
         S2 <= S1;    
         R3 <= R2;    
         S3 <= S2;    
         R4 <= R3;    
         S4 <= S3;    
         R5 <= R4;    
         S5 <= S4;    
         R6 <= R5;    
         S6 <= S5;    
         R7 <= R6;    
         S7 <= S6;    
         R8 <= R7;    
         S8 <= S7;    
         R9 <= R8;    
         S9 <= S8;    
      END IF;
   END PROCESS;
   temp_A1 <= "0000000000000" & R(16 DOWNTO 0);
   temp_B1 <= '0' & S(16 DOWNTO 0);

   DSP48E_1 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 1,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 1,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P1,
         ACOUT => open,
         BCOUT => bcout1,
         PCOUT => pcout1,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A1,
         B => temp_B1,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => LOW_18bit,
         PCIN => LOW_48bit,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
        ALUMODE => "0000",
         OPMODE => "0000101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => zero,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => zero,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_A2 <= "0000000000000" & R(33 DOWNTO 17);
   
   DSP48E_2 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 1,
         B_INPUT => "CASCADE",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P2,
         ACOUT => open,
         BCOUT => open,
         PCOUT => pcout2,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A2,
         B => LOW_18bit,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => bcout1,
         PCIN => pcout1,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "1010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => zero,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   


   temp_A3 <= "0000000000000" & R1(16 DOWNTO 0);
   temp_B3 <= '0' & S1(33 DOWNTO 17);
   

   DSP48E_3 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 2,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P3,
         ACOUT => open,
         BCOUT => bcout3,
         PCOUT => pcout3,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A3,
         B => temp_B3,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => LOW_18bit,
         PCIN => pcout2,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "0010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   
   
   temp_A4 <= "0000000000000" & R2(33 DOWNTO 17);
   

   DSP48E_4 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 1,
         B_INPUT => "CASCADE",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P4,
         ACOUT => open,
         BCOUT => open,
         PCOUT => pcout4,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A4,
         B => LOW_18bit,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => bcout3,
         PCIN => pcout3,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "1010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => zero,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   
   

   temp_A5 <= "00000" & R3(58 DOWNTO 34);
   temp_B5 <= '0' & S3(16 DOWNTO 0);

   DSP48E_5 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P5,
         ACOUT => open,
         BCOUT => open,
         PCOUT => pcout5,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A5,
         B => temp_B5,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => LOW_18bit,
         PCIN => pcout4,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "0010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_A6 <= "00000" & S4(58 DOWNTO 34);
   temp_B6 <= '0' & R4(16 DOWNTO 0);

   DSP48E_6 : DSP48E 
      GENERIC MAP (
         ACASCREG => 2,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P6,
         ACOUT => acout6,
         BCOUT => open,
         PCOUT => pcout6,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A6,
         B => temp_B6,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => LOW_18bit,
         PCIN => pcout5,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "0010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_B7 <= '0' & R5(33 DOWNTO 17);

   DSP48E_7 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 1,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "CASCADE",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P7,
         ACOUT => open,
         BCOUT => open,
         PCOUT => pcout7,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => LOW_30bit,
         B => temp_B7,
         C => LOW_48bit,
         ACIN => acout6,
         BCIN => LOW_18bit,
         PCIN => pcout6,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "1010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => zero,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_A8 <= "00000" & R6(58 DOWNTO 34);
   temp_B8 <= '0' & S6(33 DOWNTO 17);

   DSP48E_8 : DSP48E 
      GENERIC MAP (
         ACASCREG => 2,
         ALUMODEREG => 1,
         AREG => 2,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "DIRECT",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P8,
         ACOUT => acout8,
         BCOUT => open,
         PCOUT => pcout8,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => temp_A8,
         B => temp_B8,
         C => LOW_48bit,
         ACIN => LOW_30bit,
         BCIN => LOW_18bit,
         PCIN => pcout7,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "0010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => one,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_B9 <= '0' & S7(50 DOWNTO 34);
   
   DSP48E_9 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 1,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "CASCADE",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P9,
         ACOUT => acout9,
         BCOUT => open,
         PCOUT => pcout9,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => LOW_30bit,
         B => temp_B9,
         C => LOW_48bit,
         ACIN => acout8,
         BCIN => LOW_18bit,
         PCIN => pcout8,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "1010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => zero,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   

   temp_B10 <= S8(58) & S8(58) & S8(58) & S8(58) & S8(58) & S8(58) & 
   S8(58) & S8(58) & S8(58) & S8(58) & S8(58 DOWNTO 51);

   DSP48E_10 : DSP48E 
      GENERIC MAP (
         ACASCREG => 1,
         ALUMODEREG => 1,
         AREG => 1,
         AUTORESET_PATTERN_DETECT => FALSE,
         AUTORESET_PATTERN_DETECT_OPTINV => "MATCH",
         A_INPUT => "CASCADE",
         BCASCREG => 1,
         BREG => 2,
         B_INPUT => "DIRECT",
         CARRYINREG => 1,
         CARRYINSELREG => 1,
         CREG => 1,
         MASK => X"000000000000",
         MREG => 1,
         MULTCARRYINREG => 1,
         OPMODEREG => 1,
         PATTERN => X"ffffffffffff",
         PREG => 1,
         SEL_MASK => "MASK",
         SEL_PATTERN => "PATTERN",
         SEL_ROUNDING_MASK => "SEL_MASK",
         USE_MULT => "MULT_S",
         USE_PATTERN_DETECT => "NO_PATDET",
         USE_SIMD => "ONE48")
      PORT MAP (
         P => P10,
         ACOUT => open,
         BCOUT => open,
         PCOUT => open,
         CARRYOUT => open,
         CARRYCASCOUT => open,
         MULTSIGNOUT => open,
         PATTERNDETECT => open,
         PATTERNBDETECT => open,
         OVERFLOW => open,
         UNDERFLOW => open,
         A => LOW_30bit,
         B => temp_B10,
         C => LOW_48bit,
         ACIN => acout9,
         BCIN => LOW_18bit,
         PCIN => pcout9,
         CARRYCASCIN => '0',
         MULTSIGNIN => '0',
         ALUMODE => "0000",
         OPMODE => "1010101",
         CARRYIN => '0',
         CARRYINSEL => "000",
         CLK => clk,
         CEA1 => zero,
         CEA2 => one,
         CEALUMODE => one,
         CEB1 => one,
         CEB2 => one,
         CEC => zero,
         CECARRYIN => one,
         CECTRL => one,
         CEMULTCARRYIN => one,
         CEM => one,
         CEP => one,
         RSTA => rst,
         RSTALUMODE => rst,
         RSTB => rst,
         RSTC => rst,
         RSTALLCARRYIN => rst,
         RSTCTRL => rst,
         RSTM => rst,
         RSTP => rst);   
   


END mult59x59_arch;
