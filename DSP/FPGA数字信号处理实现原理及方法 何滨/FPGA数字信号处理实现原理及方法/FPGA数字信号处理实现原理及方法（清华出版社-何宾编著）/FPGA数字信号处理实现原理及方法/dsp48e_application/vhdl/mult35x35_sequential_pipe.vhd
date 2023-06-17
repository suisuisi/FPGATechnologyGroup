-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: MULT35X18_SEQUENTIAL_PIPE 
--  /   /        Date Last Modified:  MARCH 30, 2006 
-- /___/   /\    Date Created: MARCH 30, 2006 
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--
-- Revision History: 
-------------------------------------------------------------------------------- 
--   
--   XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" 
--   AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND 
--   SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, 
--   OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, 
--   APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION 
--   THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT, 
--   AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE 
--   FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY 
--   WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE 
--   IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR 
--   REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF 
--   INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
--   FOR A PARTICULAR PURPOSE. 
--
-------------------------------------------------------------------------------- 
-- Module: MULT35X18_SEQUENTIAL_PIPE
--
-- Description: Verilog instantiation template for 
-- DSP48 embedded MAC blocks arranged as a pipelined
-- 35 x 18 sequential multiplier. The macro uses 1 DSP
-- slices.  
--
-- Dynamic OPMODE. OPMODE is an input signal for the macro.
-- External muxing logic required to make dynamic changes on the
-- A_IN and B_IN input registers. Muxing circuit chooses A_IN and
-- B_IN when OPMODE[7] = 0 to implement the 1st cycle. A_IN and
-- B_IN through 1 register is chosen when OPMODE[7] = 1.
--
-- OPMODE for 1st cycle = 0000101. OPMODE for 2nd cycle = 1100101.
--
-- The 17 bit output from the 1st cycle is stored in a register till
-- the output from the 2nd cycle is available. The 53bit final output is 
-- then available at the PROD_OUT output pin.
--
-- Device: Whitney Family
--
-- Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
-----------------------------------------------------------------------
LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--Library UNISIM;
--use UNISIM.vcomponents.all;

ENTITY MULT35X35_SEQUENTIAL_PIPE IS
   PORT (
      CLK           : IN std_logic;   
      RST           : IN std_logic;   
      A_IN          : IN std_logic_vector(34 DOWNTO 0);   
      B_IN          : IN std_logic_vector(34 DOWNTO 0);    
      PROD_OUT      : OUT std_logic_vector(69 DOWNTO 0));   
END MULT35X35_SEQUENTIAL_PIPE;

ARCHITECTURE MULT35X35_SEQUENTIAL_PIPE_ARCH OF MULT35X35_SEQUENTIAL_PIPE IS

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

   COMPONENT SRL16
      PORT (
         Q                       : OUT bit;
         A0                      : IN  bit;
         A1                      : IN  bit;
         A2                      : IN  bit;
         A3                      : IN  bit;
         CLK                     : IN  bit;
         D                       : IN  bit);
   END COMPONENT;

-----------------------------------------------------------------
--Signal Declarations:

   SIGNAL A_IN_REG                 :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL B_IN_REG                 :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL SEL_A                    :  std_logic_vector(29 DOWNTO 0);   
   SIGNAL SEL_B                    :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL POUT_REG1                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL POUT_REG2                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL POUT_REG3                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL POUT                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL OPMODE                   :  std_logic_vector(6 DOWNTO 0);   
   SIGNAL OPMODE_REG               :  std_logic_vector(6 DOWNTO 0);   
   SIGNAL A_IN_WIRE                :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL B_IN_WIRE                :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL cntr4                    :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL PROD_OUT_INT             :  std_logic_vector(69 DOWNTO 0);
    
signal LOW_18bit                  :  std_logic_vector(17 downto 0);
signal LOW_30bit                  :  std_logic_vector(29 downto 0);
signal LOW_48bit                  :  std_logic_vector(47 downto 0);
signal LOW_1bit                   :  std_logic;
signal HIGH_1bit                  :  std_logic;
signal CARRYINSEL_bit             :  std_logic_vector(1 downto 0);


------------------------------------------------------------------
-- Architecture Section: instantiation block 1


BEGIN

LOW_18bit        <= "000000000000000000";
LOW_30bit        <= "000000000000000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';
CARRYINSEL_bit <= "00";


   -- Register inputs A_IN and B_IN.
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         cntr4 <= "111";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4 < "111") THEN
            cntr4 <= cntr4 + "001";    
         ELSE
            cntr4 <= "000";    
         END IF;
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         A_IN_REG <= "00000000000000000000000000000000000";    
         B_IN_REG <= "00000000000000000000000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4(1 DOWNTO 0) = "11") THEN
            A_IN_REG <= A_IN;    
            B_IN_REG <= B_IN;    
         ELSE
            A_IN_REG <= A_IN_REG;    
            B_IN_REG <= B_IN_REG;    
         END IF;
      END IF;
   END PROCESS;
   A_IN_WIRE <= A_IN_REG ;
   B_IN_WIRE <= B_IN_REG ;

   PROCESS (RST, CLK)
   BEGIN
      IF (RST = '1') THEN
         SEL_A <= (others => '0');    
         SEL_B <= (others => '0');    
         OPMODE <= "0000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CASE cntr4(1 DOWNTO 0) IS
            WHEN "00" =>
                     SEL_A <= "0000000000000" & A_IN_WIRE(16 DOWNTO 0);    
                     SEL_B <= '0' & B_IN_WIRE(16 DOWNTO 0);    
                     OPMODE <= "0000101";    -- 7'b0000101; 
            WHEN "01" =>
                     SEL_A <= "000000000000" & A_IN_WIRE(34 DOWNTO 17);    
                     SEL_B <= '0' & B_IN_WIRE(16 DOWNTO 0);    
                     OPMODE <= "1100101";    -- 7'b1100101; 
            WHEN "10" =>
                     SEL_A <= "0000000000000" & A_IN_WIRE(16 DOWNTO 0);    
                     SEL_B <= B_IN_WIRE(34 DOWNTO 17);    
                     OPMODE <= "0100101";    -- 7'b0100101; 
            WHEN "11" =>
                     SEL_A <= "000000000000" & A_IN_WIRE(34 DOWNTO 17);    
                     SEL_B <= B_IN_WIRE(34 DOWNTO 17);    
                     OPMODE <= "1100101";    -- 7'b1100101; 
            WHEN OTHERS =>
                     NULL;
            
         END CASE;
      END IF;
   END PROCESS;
   
   -- Product[16:0], cycle1; Product[33:17] cycle 3; Product[69:34] cycle 4;
   
-- Instantiation block 1 

DSP48E_1: DSP48E 
generic map (
   ACASCREG => 0,       
   ALUMODEREG => 1,     
   AREG => 0,           
   AUTORESET_PATTERN_DETECT => FALSE, 
   AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", 
   A_INPUT => "DIRECT", 
   BCASCREG => 0,       
   BREG => 0,           
   B_INPUT => "DIRECT", 
   CARRYINREG => 0,     
   CARRYINSELREG => 1,  
   CREG => 0,           
   MASK => X"3FFFFFFFFFFF", 
   MREG => 1,           
   MULTCARRYINREG => 0, 
   OPMODEREG => 1,      
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
   P => POUT,          
   PATTERNBDETECT => open, 
   PATTERNDETECT => open, 
   PCOUT => open,  
   UNDERFLOW => open, 
   A => SEL_A,          
   ACIN => LOW_30bit,    
   ALUMODE => "0000", 
   B => SEL_B,          
   BCIN => LOW_18bit,    
   C => LOW_48bit,           
   CARRYCASCIN => '0', 
   CARRYIN => '0', 
   CARRYINSEL => "000", 
   CEA1 => '0',      
   CEA2 => '1',      
   CEALUMODE => '1', 
   CEB1 => '1',      
   CEB2 => '1',      
   CEC => '0',      
   CECARRYIN => '0', 
   CECTRL => '1', 
   CEM => '1',       
   CEMULTCARRYIN => '0',
   CEP => '1',       
   CLK => CLK,       
   MULTSIGNIN => '0', 
   OPMODE => OPMODE, 
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
         POUT_REG1 <= "000000000000000000";    
         POUT_REG2 <= "000000000000000000";    
         POUT_REG3 <= "000000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         POUT_REG1 <= POUT(17 DOWNTO 0);    
         POUT_REG2 <= POUT_REG1;    
         POUT_REG3 <= POUT_REG2;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         PROD_OUT_INT <=  (others => '0');
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4(1 DOWNTO 0) = "01") THEN
         PROD_OUT_INT <= POUT(35 DOWNTO 0) & POUT_REG1(16 DOWNTO 0) & POUT_REG3(16 DOWNTO 0);    
         ELSE
            PROD_OUT_INT <= PROD_OUT_INT;    
         END IF;
      END IF;
   END PROCESS;

PROD_OUT <= PROD_OUT_INT;
      
-----------------------------------------------------------------

END MULT35X35_SEQUENTIAL_PIPE_ARCH;

