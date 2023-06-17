-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: fast_sqrt_mult_cascade
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

ENTITY fast_sqrt_mult_cascade IS
   PORT( 
      X_IN                       : IN std_logic_vector(7 DOWNTO 0);   
      CLK                        : IN std_logic;   
      RST                        : IN std_logic;   
      SQRT_OUT                   : OUT std_logic_vector(4 DOWNTO 0));   
END ENTITY fast_sqrt_mult_cascade;

ARCHITECTURE fast_sqrt_mult_cascade_arch OF fast_sqrt_mult_cascade IS



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

SIGNAL Reg_A                                :  std_logic_vector(3 DOWNTO 0); 
SIGNAL sub1, sub2, sub3, sub4               :  std_logic_vector(47 DOWNTO 0);
SIGNAL cntr8                                :  std_logic_vector(3 DOWNTO 0);
SIGNAL cntr3                                :  std_logic_vector(1 DOWNTO 0);
SIGNAL cntr_set                             :  std_logic_vector(3 DOWNTO 0);
SIGNAL set_bit                              :  std_logic;
SIGNAL cntr32                               :  std_logic_vector(5 DOWNTO 0);
SIGNAL sub1_reg1 , sub1_reg2 , sub1_reg3 , sub1_reg4, sub1_reg5:  std_logic;
SIGNAL sub1_reg6, sub1_reg7, sub1_reg8, sub1_reg9, sub1_reg10  :  std_logic;
SIGNAL sub1_reg11, sub1_reg12, sub1_reg13                      :  std_logic;
SIGNAL sub2_reg1 , sub2_reg2 , sub2_reg3, sub2_reg4, sub2_reg5  :  std_logic; 
SIGNAL   sub2_reg6, sub2_reg7, sub2_reg8, sub2_reg9             :  std_logic;
SIGNAL sub3_reg1 , sub3_reg2 , sub3_reg3 , sub3_reg4            :  std_logic;
SIGNAL sub3_reg5, sub4_reg1                                     :  std_logic;
SIGNAL remain                                  :  std_logic_vector(1 DOWNTO 0);
SIGNAL Reg_IN1, Reg_IN2 , Reg_IN3 , Reg_IN4    :  std_logic_vector(7 DOWNTO 0); 
SIGNAL Reg_IN5 , Reg_IN6 , Reg_IN7 , Reg_IN8   :  std_logic_vector(7 DOWNTO 0); 
SIGNAL Reg_IN9 , Reg_IN10 , Reg_IN11, Reg_IN12 :  std_logic_vector(7 DOWNTO 0);
SIGNAL Reg_IN13 , Reg_IN14 , Reg_IN15, Reg_IN16:  std_logic_vector(7 DOWNTO 0);


SIGNAL tempA1, tempA2, tempA3, tempA4: std_logic_vector(29 DOWNTO 0);
SIGNAL tempB1, tempB2, tempB3, tempB4: std_logic_vector(17 DOWNTO 0);
SIGNAL tempC1, tempC2, tempC3, tempC4: std_logic_vector(47 DOWNTO 0);

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

tempA1 <= "000000000000000000000000001000" ;
tempB1 <= "000000000000001000" ;
tempC1 <= "0000000000000000000000000000000000000000" & Reg_IN1;

tempA2 <= "00000000000000000000000000" & sub1_reg1 & "100";
tempB2 <= "00000000000000" & sub1_reg1 & "100";
tempC2 <= "0000000000000000000000000000000000000000" & Reg_IN5;

tempA3 <= "00000000000000000000000000" & sub1_reg5 & sub2_reg1 & "10";
tempB3 <= "00000000000000" & sub1_reg5 & sub2_reg1 & "10";
tempC3 <= "0000000000000000000000000000000000000000" & Reg_IN9;

tempA4 <= "00000000000000000000000000" & sub1_reg9 & sub2_reg5 & sub3_reg1 & '1';
tempB4 <= "00000000000000" & sub1_reg9 & sub2_reg5 & sub3_reg1 & '1';
tempC4 <= "0000000000000000000000000000000000000000" & Reg_IN13;


   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
        Reg_IN1 <= "00000000";   Reg_IN2 <= "00000000"; 
        Reg_IN3 <= "00000000";   Reg_IN4 <= "00000000"; 
        Reg_IN5 <= "00000000";   Reg_IN6 <= "00000000"; 
        Reg_IN7 <= "00000000";   Reg_IN8 <= "00000000"; 
        Reg_IN9 <= "00000000";   Reg_IN10 <= "00000000"; 
        Reg_IN11 <= "00000000";  Reg_IN12 <= "00000000"; 
        Reg_IN13 <= "00000000";  Reg_IN14 <= "00000000"; 
        Reg_IN15 <= "00000000";  Reg_IN16 <= "00000000"; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
          Reg_IN1 <= X_IN; Reg_IN2 <= Reg_IN1;
          Reg_IN3 <= Reg_IN2; Reg_IN4 <= Reg_IN3;
          Reg_IN5 <= Reg_IN4; Reg_IN6 <= Reg_IN5;
          Reg_IN7 <= Reg_IN6; Reg_IN8 <= Reg_IN7;
          Reg_IN9 <= Reg_IN8; Reg_IN10 <= Reg_IN9;
	    Reg_IN11 <= Reg_IN10; Reg_IN12 <= Reg_IN11;
	    Reg_IN13 <= Reg_IN12; Reg_IN14 <= Reg_IN13;
	    Reg_IN15 <= Reg_IN14; Reg_IN16 <= Reg_IN15;
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
   CARRYINSELREG => 0,  
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
   P => sub1,          
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
       sub1_reg1 <= '0'; sub1_reg2 <= '0'; 
       sub1_reg3 <= '0'; sub1_reg4 <= '0';
       sub1_reg5 <= '0'; sub1_reg6 <= '0'; 
       sub1_reg7 <= '0'; sub1_reg8 <= '0'; 
       sub1_reg9 <= '0'; sub1_reg10 <= '0';
       sub1_reg11 <= '0'; sub1_reg12 <= '0';
       sub1_reg13 <= '0';
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       sub1_reg1 <=  not sub1(47);
       sub1_reg2 <= sub1_reg1;
       sub1_reg3 <= sub1_reg2;
       sub1_reg4 <= sub1_reg3;
       sub1_reg5 <= sub1_reg4;
       sub1_reg6 <= sub1_reg5;
       sub1_reg7 <= sub1_reg6;
       sub1_reg8 <= sub1_reg7;
       sub1_reg9 <= sub1_reg8;
       sub1_reg10 <= sub1_reg9;
       sub1_reg11 <= sub1_reg10;
       sub1_reg12 <= sub1_reg11;
       sub1_reg13 <= sub1_reg12;
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
   CARRYINSELREG => 0,  
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
   P => sub2,          
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
       sub2_reg1 <= '0'; sub2_reg2 <= '0'; sub2_reg3 <= '0'; 
       sub2_reg4 <= '0'; sub2_reg5 <= '0'; sub2_reg6 <= '0'; 
       sub2_reg7 <= '0'; sub2_reg8 <= '0'; sub2_reg9 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       sub2_reg1 <= not sub2(47);
       sub2_reg2 <= sub2_reg1;
       sub2_reg3 <= sub2_reg2;
       sub2_reg4 <= sub2_reg3;
       sub2_reg5 <= sub2_reg4;
       sub2_reg6 <= sub2_reg5;
       sub2_reg7 <= sub2_reg6;
       sub2_reg8 <= sub2_reg7;
       sub2_reg9 <= sub2_reg8;
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
   CARRYINSELREG => 0,  
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
   P => sub3,          
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
       sub3_reg1 <= '0'; sub3_reg2 <= '0'; 
	 sub3_reg3 <= '0'; sub3_reg4 <= '0';
       sub3_reg5 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       sub3_reg1 <= not sub3(47);
       sub3_reg2 <= sub3_reg1;
       sub3_reg3 <= sub3_reg2;
	 sub3_reg4 <= sub3_reg3;
       sub3_reg5 <= sub3_reg4;
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
   CARRYINSELREG => 0,  
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
   P => sub4,          
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
       sub4_reg1 <= '0'; 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       sub4_reg1 <= not sub4(47);
      END IF;
   END PROCESS;



   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
       SQRT_OUT <= "00000";   
      ELSIF (CLK'EVENT AND CLK = '1') THEN
       SQRT_OUT <= '0' & sub1_reg13 & sub2_reg9 & sub3_reg5 & sub4_reg1;
      END IF;
   END PROCESS;

END fast_sqrt_mult_cascade_arch;




