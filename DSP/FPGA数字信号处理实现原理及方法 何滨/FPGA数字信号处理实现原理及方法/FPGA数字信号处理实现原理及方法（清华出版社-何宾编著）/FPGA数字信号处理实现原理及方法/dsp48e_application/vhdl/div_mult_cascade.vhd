-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: div_mult_cascade
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

ENTITY div_mult_cascade IS
   PORT( 
      NUMERATOR_IN               : IN std_logic_vector(3 DOWNTO 0);   
      DENOMINATOR_IN             : IN std_logic_vector(3 DOWNTO 0);   
      CLK                        : IN std_logic;   
      RST                        : IN std_logic;   
      Q_OUT, R_OUT               : OUT std_logic_vector(3 DOWNTO 0));   
END ENTITY div_mult_cascade;

ARCHITECTURE div_mult_cascade_arch OF div_mult_cascade IS



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

   SIGNAL NUMERATOR_IN_REG1, DENOMINATOR_IN_REG1:  std_logic_vector(3 DOWNTO 0);  
   SIGNAL NUMERATOR_IN_REG2, DENOMINATOR_IN_REG2:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG3, DENOMINATOR_IN_REG3:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG4, DENOMINATOR_IN_REG4:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG5, DENOMINATOR_IN_REG5:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG6, DENOMINATOR_IN_REG6:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG7, DENOMINATOR_IN_REG7:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG8, DENOMINATOR_IN_REG8:  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG9, DENOMINATOR_IN_REG9:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL NUMERATOR_IN_REG10, DENOMINATOR_IN_REG10:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL NUMERATOR_IN_REG11, DENOMINATOR_IN_REG11:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL NUMERATOR_IN_REG12, DENOMINATOR_IN_REG12:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL NUMERATOR_IN_REG13, DENOMINATOR_IN_REG13:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL NUMERATOR_IN_REG14, DENOMINATOR_IN_REG14:  std_logic_vector(3 DOWNTO 0);   
 SIGNAL Q_OUT_REG1, Q_OUT_REG2                  :  std_logic_vector(3 DOWNTO 0);   
 SIGNAL div1, div2, div3, div4, remain          :  std_logic_vector(47 DOWNTO 0);

SIGNAL div1_reg1, div1_reg2, div1_reg3, div1_reg4, div1_reg5   :  std_logic;
SIGNAL div1_reg6, div1_reg7, div1_reg8, div1_reg9, div1_reg10  :  std_logic;
SIGNAL div1_reg11, div1_reg12                                  :  std_logic;
SIGNAL div2_reg1, div2_reg2, div2_reg3, div2_reg4, div2_reg5   :  std_logic;
SIGNAL div2_reg6, div2_reg7, div2_reg8, div2_reg9              :  std_logic;
SIGNAL div3_reg1, div3_reg2, div3_reg3, div3_reg4, div3_reg5   :  std_logic;
SIGNAL div3_reg6                                               :  std_logic;
SIGNAL div4_reg1, div4_reg2, div4_reg3                         :  std_logic;


SIGNAL tempA1, tempA2, tempA3, tempA4, tempA5  : std_logic_vector(29 DOWNTO 0);
SIGNAL tempB1, tempB2, tempB3, tempB4, tempB5  : std_logic_vector(17 DOWNTO 0);
SIGNAL tempC1, tempC2, tempC3, tempC4, tempC5  : std_logic_vector(47 DOWNTO 0);

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

tempA1 <= "00000000000000000000000000" & DENOMINATOR_IN;
tempB1 <= "000000000000001000" ;
tempC1 <= "00000000000000000000000000000000000000000000" & NUMERATOR_IN_REG1;
tempA2 <= "00000000000000000000000000" & DENOMINATOR_IN_REG3;
tempB2 <= "00000000000000" & not div1(47) & "100" ;
tempC2 <= "00000000000000000000000000000000000000000000" & NUMERATOR_IN_REG4;
tempA3 <= "00000000000000000000000000" & DENOMINATOR_IN_REG6;
tempB3 <= "00000000000000" & div1_reg3 & not div2(47) & "10" ;
tempC3 <= "00000000000000000000000000000000000000000000" & NUMERATOR_IN_REG7;
tempA4 <= "00000000000000000000000000" & DENOMINATOR_IN_REG9;
tempB4 <= "00000000000000" & div1_reg6 &  div2_reg3 & not div3(47) & '1';
tempC4 <= "00000000000000000000000000000000000000000000" & NUMERATOR_IN_REG10;
tempA5 <= "00000000000000000000000000" & DENOMINATOR_IN_REG12;
tempB5 <= "00000000000000" & div1_reg9 &  div2_reg6 & div3_reg3 & not div4(47);
tempC5 <= "00000000000000000000000000000000000000000000" & NUMERATOR_IN_REG13;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
        NUMERATOR_IN_REG1 <= "0000";   NUMERATOR_IN_REG2 <= "0000"; 
        NUMERATOR_IN_REG3 <= "0000";   NUMERATOR_IN_REG4 <= "0000"; 
        NUMERATOR_IN_REG5 <= "0000";   NUMERATOR_IN_REG6 <= "0000"; 
        NUMERATOR_IN_REG7 <= "0000";   NUMERATOR_IN_REG8 <= "0000"; 
        NUMERATOR_IN_REG9 <= "0000";   NUMERATOR_IN_REG10 <= "0000"; 
        NUMERATOR_IN_REG11 <= "0000";  NUMERATOR_IN_REG12 <= "0000"; 
        NUMERATOR_IN_REG13 <= "0000";  NUMERATOR_IN_REG14 <= "0000"; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
          NUMERATOR_IN_REG1 <= NUMERATOR_IN; 
          NUMERATOR_IN_REG2 <= NUMERATOR_IN_REG1; 
          NUMERATOR_IN_REG3 <= NUMERATOR_IN_REG2; 
          NUMERATOR_IN_REG4 <= NUMERATOR_IN_REG3; 
          NUMERATOR_IN_REG5 <= NUMERATOR_IN_REG4; 
          NUMERATOR_IN_REG6 <= NUMERATOR_IN_REG5; 
          NUMERATOR_IN_REG7 <= NUMERATOR_IN_REG6; 
          NUMERATOR_IN_REG8 <= NUMERATOR_IN_REG7; 
          NUMERATOR_IN_REG9 <= NUMERATOR_IN_REG8; 
          NUMERATOR_IN_REG10 <= NUMERATOR_IN_REG9; 
          NUMERATOR_IN_REG11 <= NUMERATOR_IN_REG10; 
          NUMERATOR_IN_REG12 <= NUMERATOR_IN_REG11; 
          NUMERATOR_IN_REG13 <= NUMERATOR_IN_REG12; 
          NUMERATOR_IN_REG14 <= NUMERATOR_IN_REG13; 
      END IF;
   END PROCESS;


   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
        DENOMINATOR_IN_REG1 <= "0000";   DENOMINATOR_IN_REG2 <= "0000"; 
        DENOMINATOR_IN_REG3 <= "0000";   DENOMINATOR_IN_REG4 <= "0000"; 
        DENOMINATOR_IN_REG5 <= "0000";   DENOMINATOR_IN_REG6 <= "0000"; 
        DENOMINATOR_IN_REG7 <= "0000";   DENOMINATOR_IN_REG8 <= "0000"; 
        DENOMINATOR_IN_REG9 <= "0000";   DENOMINATOR_IN_REG10 <= "0000"; 
        DENOMINATOR_IN_REG11 <= "0000";  DENOMINATOR_IN_REG12 <= "0000"; 
        DENOMINATOR_IN_REG13 <= "0000";  DENOMINATOR_IN_REG14 <= "0000"; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
          DENOMINATOR_IN_REG1 <= DENOMINATOR_IN; 
          DENOMINATOR_IN_REG2 <= DENOMINATOR_IN_REG1; 
          DENOMINATOR_IN_REG3 <= DENOMINATOR_IN_REG2; 
          DENOMINATOR_IN_REG4 <= DENOMINATOR_IN_REG3; 
          DENOMINATOR_IN_REG5 <= DENOMINATOR_IN_REG4; 
          DENOMINATOR_IN_REG6 <= DENOMINATOR_IN_REG5; 
          DENOMINATOR_IN_REG7 <= DENOMINATOR_IN_REG6; 
          DENOMINATOR_IN_REG8 <= DENOMINATOR_IN_REG7; 
          DENOMINATOR_IN_REG9 <= DENOMINATOR_IN_REG8; 
          DENOMINATOR_IN_REG10 <= DENOMINATOR_IN_REG9; 
          DENOMINATOR_IN_REG11 <= DENOMINATOR_IN_REG10; 
          DENOMINATOR_IN_REG12 <= DENOMINATOR_IN_REG11; 
          DENOMINATOR_IN_REG13 <= DENOMINATOR_IN_REG12; 
          DENOMINATOR_IN_REG14 <= DENOMINATOR_IN_REG13; 
      END IF;
   END PROCESS;

-- Instantiation block 1 

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
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "ONE48") 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => div1,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA1,          
   ACIN => LOW_30bit,    
   ALUMODE => "0011", 
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
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST 
);

   -- End of DSP48E_1 instantiation
  

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       div1_reg1 <= '0'; div1_reg2 <= '0'; 
       div1_reg3 <= '0'; div1_reg4 <= '0';
       div1_reg5 <= '0'; div1_reg6 <= '0'; 
       div1_reg7 <= '0'; div1_reg8 <= '0'; 
       div1_reg9 <= '0'; div1_reg10 <= '0';
       div1_reg11 <= '0'; div1_reg12 <= '0';
      ELSIF (CLK'EVENT AND CLK = '1') THEN 
       div1_reg1 <=  not div1(47);
       div1_reg2 <= div1_reg1;
       div1_reg3 <= div1_reg2;
       div1_reg4 <= div1_reg3;
       div1_reg5 <= div1_reg4;
       div1_reg6 <= div1_reg5;
       div1_reg7 <= div1_reg6;
       div1_reg8 <= div1_reg7;
       div1_reg9 <= div1_reg8;
       div1_reg10 <= div1_reg9;
       div1_reg11 <= div1_reg10;
       div1_reg12 <= div1_reg11;
      END IF;
   END PROCESS;


   -- Instantiation block 2 

DSP48E_2: DSP48E 
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
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "ONE48" 
) 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => div2,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA2,           
   ACIN => LOW_30bit,    
   ALUMODE => "0011", 
   B => tempB2,          
   BCIN => LOW_18bit,    
   C => tempC2,           
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
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST );

   -- End of DSP48E_2 instantiation

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       div2_reg1 <= '0'; div2_reg2 <= '0'; div2_reg3 <= '0'; 
       div2_reg4 <= '0'; div2_reg5 <= '0'; div2_reg6 <= '0'; 
       div2_reg7 <= '0'; div2_reg8 <= '0'; div2_reg9 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       div2_reg1 <= not div2(47);
       div2_reg2 <= div2_reg1;
       div2_reg3 <= div2_reg2;
       div2_reg4 <= div2_reg3;
       div2_reg5 <= div2_reg4;
       div2_reg6 <= div2_reg5;
       div2_reg7 <= div2_reg6;
       div2_reg8 <= div2_reg7;
       div2_reg9 <= div2_reg8;
      END IF;
   END PROCESS;


--          
-- Instantiation block 3
--

DSP48E_3: DSP48E 
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
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "ONE48" 
) 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => div3,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA3,           
   ACIN => LOW_30bit,    
   ALUMODE => "0011", 
   B => tempB3,          
   BCIN => LOW_18bit,    
   C => tempC3,           
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
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST );

-- End of DSP48E_3 instantiation

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       div3_reg1 <= '0'; div3_reg2 <= '0'; 
     	 div3_reg3 <= '0'; div3_reg4 <= '0';
       div3_reg5 <= '0'; div3_reg6 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       div3_reg1 <= not div3(47);
       div3_reg2 <= div3_reg1;
       div3_reg3 <= div3_reg2;
	    div3_reg4 <= div3_reg3;
       div3_reg5 <= div3_reg4;
	    div3_reg6 <= div3_reg5;
      END IF;
   END PROCESS;

--          
-- Instantiation block 4
--
DSP48E_4: DSP48E 
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
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "ONE48" 
) 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => div4,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA4,           
   ACIN => LOW_30bit,    
   ALUMODE => "0011", 
   B => tempB4,          
   BCIN => LOW_18bit,    
   C => tempC4,           
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
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST );

-- End of DSP48E_4 instantiation

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       div4_reg1 <= '0'; div4_reg2 <= '0'; 
	    div4_reg3 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       div4_reg1 <= not div4(47);
       div4_reg2 <= div4_reg1;
       div4_reg3 <= div4_reg2;
      END IF;
   END PROCESS;


--          
-- Instantiation block 5
--
DSP48E_5: DSP48E 
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
   SEL_ROUNDING_MASK => "SEL_MASK", 
   USE_MULT => "MULT_S", 
   USE_PATTERN_DETECT => "NO_PATDET", 
   USE_SIMD => "ONE48" 
) 
port map (
   ACOUT => open,   
   BCOUT => open,  
   CARRYCASCOUT => open, 
   CARRYOUT => open, 
   MULTSIGNOUT => open, 
   OVERFLOW => open, 
   P => remain,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => tempA5,           
   ACIN => LOW_30bit,    
   ALUMODE => "0011", 
   B => tempB5,          
   BCIN => LOW_18bit,    
   C => tempC5,           
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
   RSTC => RST,     
   RSTCTRL => RST, 
   RSTM => RST, 
   RSTP => RST );

-- End of DSP48E_5 instantiation

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       Q_OUT <= "0000";  R_OUT <= "0000"; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       Q_OUT <= div1_reg12 & div2_reg9 & div3_reg6 & div4_reg3;
	    R_OUT <= remain(3 DOWNTO 0); 
      END IF;
   END PROCESS;

END div_mult_cascade_arch;



