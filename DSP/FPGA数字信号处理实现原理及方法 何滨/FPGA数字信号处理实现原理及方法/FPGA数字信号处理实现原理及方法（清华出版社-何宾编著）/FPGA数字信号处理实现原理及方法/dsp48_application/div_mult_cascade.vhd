-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: DIV_MULT_CASCADE
--  /   /        Date Last Modified:  JUNE23, 2004
-- /___/   /\    Date Created: JUNE23, 2004 
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--
-- Revision History: 
-- $Log: $
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

LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

ENTITY DIV_MULT_CASCADE IS
   PORT (
      CLK                     : IN std_logic;   
      RST           : IN std_logic;   
      NUMERATOR_IN            : IN std_logic_vector(3 DOWNTO 0);   
      DENOMINATOR_IN          : IN std_logic_vector(3 DOWNTO 0);   
      Q_OUT                   : OUT std_logic_vector(3 DOWNTO 0);   
      R_OUT  : OUT std_logic_vector(3 DOWNTO 0));   
END DIV_MULT_CASCADE;

ARCHITECTURE DIV_MULT OF DIV_MULT_CASCADE IS

-- DSP48: DSP Function Block
  --        Virtex-4
  --  Xilinx HDL Language Template version 6.1i
   component DSP48
      generic( AREG : integer :=  1;
               BREG : integer :=  1;
               CREG : integer :=  1;
               PREG : integer :=  1;
               MREG : integer :=  1;
               OPMODEREG : integer :=  1;
               SUBTRACTREG : integer :=  1;
               CARRYINSELREG : integer :=  1;
               CARRYINREG : integer :=  1;
               B_INPUT : string :=  "DIRECT";
               LEGACY_MODE : string :=  "MULT18X18S" );
 port(
        BCOUT                   : out std_logic_vector(17 downto 0);
        P                       : out std_logic_vector(47 downto 0);
        PCOUT                   : out std_logic_vector(47 downto 0);

        A                       : in  std_logic_vector(17 downto 0);
        B                       : in  std_logic_vector(17 downto 0);
        BCIN                    : in  std_logic_vector(17 downto 0);
        C                       : in  std_logic_vector(47 downto 0);
        CARRYIN                 : in  std_ulogic;
        CARRYINSEL              : in  std_logic_vector(1 downto 0);
        CEA                     : in  std_ulogic;
        CEB                     : in  std_ulogic;
        CEC                     : in  std_ulogic;
        CECARRYIN               : in  std_ulogic;
        CECINSUB                : in  std_ulogic;
        CECTRL                  : in  std_ulogic;
        CEM                     : in  std_ulogic;
        CEP                     : in  std_ulogic;
        CLK                     : in  std_ulogic;
        OPMODE                  : in  std_logic_vector(6 downto 0);
        PCIN                    : in  std_logic_vector(47 downto 0);
        RSTA                    : in  std_ulogic;
        RSTB                    : in  std_ulogic;
        RSTC                    : in  std_ulogic;
        RSTCARRYIN              : in  std_ulogic;
        RSTCTRL                 : in  std_ulogic;
        RSTM                    : in  std_ulogic;
        RSTP                    : in  std_ulogic;
        SUBTRACT                : in  std_ulogic
      );
  end component;

   SIGNAL NUMERATOR_IN_REG1        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG1      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG2        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG2      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG3        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG3      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG4        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG4      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG5        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG5      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG6        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG6      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG7        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG7      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG8        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG8      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG9        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG9      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG10       :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG10     :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG11       :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG11     :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG12       :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG12     :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG13       :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG13     :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG14       :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG14     :  std_logic_vector(3 DOWNTO 0);    
   SIGNAL div1                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL div2                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL div3                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL div4                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL remain                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL div1_reg1, div1_reg2, div1_reg3, div1_reg4     :  std_logic;   
   SIGNAL div1_reg5, div1_reg6, div1_reg7, div1_reg8      :  std_logic;   
   SIGNAL div1_reg9, div1_reg10, div1_reg11, div1_reg12  :  std_logic;   
   SIGNAL div2_reg1, div2_reg2, div2_reg3, div2_reg4     :  std_logic;   
   SIGNAL div2_reg5, div2_reg6, div2_reg7, div2_reg8     :  std_logic;   
   SIGNAL div2_reg9, div3_reg1, div3_reg2                :  std_logic;   
   SIGNAL div3_reg3, div3_reg4, div3_reg5, div3_reg6     :  std_logic;   
   SIGNAL div4_reg1, div4_reg2, div4_reg3                :  std_logic;   


BEGIN

PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         NUMERATOR_IN_REG1 <= "0000";    
         NUMERATOR_IN_REG2 <= "0000";    
         NUMERATOR_IN_REG3 <= "0000";    
         NUMERATOR_IN_REG4 <= "0000";    
         NUMERATOR_IN_REG5 <= "0000";    
         NUMERATOR_IN_REG6 <= "0000";    
         NUMERATOR_IN_REG7 <= "0000";    
         NUMERATOR_IN_REG8 <= "0000";    
         NUMERATOR_IN_REG9 <= "0000";    
         NUMERATOR_IN_REG10 <= "0000";    
         NUMERATOR_IN_REG11 <= "0000";    
         NUMERATOR_IN_REG12 <= "0000";    
         NUMERATOR_IN_REG13 <= "0000";    
         NUMERATOR_IN_REG14 <= "0000";    
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
         DENOMINATOR_IN_REG1 <= "0000";    
         DENOMINATOR_IN_REG2 <= "0000";    
         DENOMINATOR_IN_REG3 <= "0000";    
         DENOMINATOR_IN_REG4 <= "0000";    
         DENOMINATOR_IN_REG5 <= "0000";    
         DENOMINATOR_IN_REG6 <= "0000";    
         DENOMINATOR_IN_REG7 <= "0000";    
         DENOMINATOR_IN_REG8 <= "0000";    
         DENOMINATOR_IN_REG9 <= "0000";    
         DENOMINATOR_IN_REG10 <= "0000";    
         DENOMINATOR_IN_REG11 <= "0000";    
         DENOMINATOR_IN_REG12 <= "0000";    
         DENOMINATOR_IN_REG13 <= "0000";    
         DENOMINATOR_IN_REG14 <= "0000";    
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

     DSP48_1 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => div1,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
     A(3 downto 0) => DENOMINATOR_IN(3 downto 0),
     B => "000000000000001000",          -- 18-bit B data input
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 4) => "00000000000000000000000000000000000000000000", 
     C(3 downto 0) => NUMERATOR_IN_REG1(3 downto 0),
     CARRYIN => '0',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '0',   -- CINSUB clock enable input
     CECTRL => '0',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE => ("0110101"), -- 7-bit operation mode input
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'    -- SUBTRACT input
  );
    -- End of DSP48_1 instantiation

   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div1_reg1 <= '0';    div1_reg2 <= '0';    
         div1_reg3 <= '0';    div1_reg4 <= '0';    
         div1_reg5 <= '0';    div1_reg6 <= '0';    
         div1_reg7 <= '0';    div1_reg8 <= '0';    
         div1_reg9 <= '0';    div1_reg10 <= '0';    
         div1_reg11 <= '0';    div1_reg12 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div1_reg1 <= NOT div1(47);    div1_reg2 <= div1_reg1;    
         div1_reg3 <= div1_reg2;    div1_reg4 <= div1_reg3;    
         div1_reg5 <= div1_reg4;    div1_reg6 <= div1_reg5;    
         div1_reg7 <= div1_reg6;    div1_reg8 <= div1_reg7;    
         div1_reg9 <= div1_reg8;    div1_reg10 <= div1_reg9;    
         div1_reg11 <= div1_reg10;    div1_reg12 <= div1_reg11;    
      END IF;
   END PROCESS;

   -- Instantiation block 2

     DSP48_2 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => div2,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
     A(3 downto 0) => DENOMINATOR_IN_REG3(3 downto 0),
     B(17 downto 4) => "00000000000000", 
     B(3) => NOT div1(47),
     B(2 downto 0) => "100",
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 4) => "00000000000000000000000000000000000000000000", 
     C(3 downto 0) => NUMERATOR_IN_REG4(3 downto 0),
     CARRYIN => '0',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '0',   -- CINSUB clock enable input
     CECTRL => '0',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE => ("0110101"), -- 7-bit operation mode input
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'    -- SUBTRACT input
  );
   -- End of DSP48_2 instantiation 
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div2_reg1 <= '0';    div2_reg2 <= '0';    
         div2_reg3 <= '0';    div2_reg4 <= '0';    
         div2_reg5 <= '0';    div2_reg6 <= '0';    
         div2_reg7 <= '0';    div2_reg8 <= '0';    
         div2_reg9 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div2_reg1 <= NOT div2(47);    div2_reg2 <= div2_reg1;    
         div2_reg3 <= div2_reg2;    div2_reg4 <= div2_reg3;    
         div2_reg5 <= div2_reg4;    div2_reg6 <= div2_reg5;    
         div2_reg7 <= div2_reg6;    div2_reg8 <= div2_reg7;    
         div2_reg9 <= div2_reg8;    
      END IF;
   END PROCESS;
   
-- Instantiation block 3

     DSP48_3 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => div3,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
     A(3 downto 0) => DENOMINATOR_IN_REG6(3 downto 0),
     B(17 downto 4) => "00000000000000", 
     B(3) => div1_reg3,
     B(2) => NOT div2(47),
     B(1 downto 0) => "10",
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 4) => "00000000000000000000000000000000000000000000", 
     C(3 downto 0) => NUMERATOR_IN_REG7(3 downto 0),
     CARRYIN => '0',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '0',   -- CINSUB clock enable input
     CECTRL => '0',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE => ("0110101"), -- 7-bit operation mode input
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'    -- SUBTRACT input
  );
   -- End of DSP48_3 instantiation 

   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div3_reg1 <= '0';    div3_reg2 <= '0';    
         div3_reg3 <= '0';    div3_reg4 <= '0';    
         div3_reg5 <= '0';    div3_reg6 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div3_reg1 <= NOT div3(47);    div3_reg2 <= div3_reg1;    
         div3_reg3 <= div3_reg2;    div3_reg4 <= div3_reg3;    
         div3_reg5 <= div3_reg4;    div3_reg6 <= div3_reg5;    
      END IF;
   END PROCESS;

-- Instantiation block 4
   
     DSP48_4 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => div4,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
     A(3 downto 0) => DENOMINATOR_IN_REG9(3 downto 0),
     B(17 downto 4) => "00000000000000", 
     B(3) => div1_reg6,
     B(2) => div2_reg3,
     B(1) => NOT div3(47),
     B(0) => '1',
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 4) => "00000000000000000000000000000000000000000000", 
     C(3 downto 0) => NUMERATOR_IN_REG10(3 downto 0),
     CARRYIN => '0',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '0',   -- CINSUB clock enable input
     CECTRL => '0',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE => ("0110101"), -- 7-bit operation mode input
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'    -- SUBTRACT input
  );
   -- End of DSP48_4 instantiation 

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div4_reg1 <= '0';    
         div4_reg2 <= '0';    
         div4_reg3 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div4_reg1 <= NOT div4(47);    
         div4_reg2 <= div4_reg1;    
         div4_reg3 <= div4_reg2;    
      END IF;
   END PROCESS;


 -- Instantiation block 5
    
     DSP48_5 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => remain,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
     A(3 downto 0) => DENOMINATOR_IN_REG12(3 downto 0),
     B(17 downto 4) => "00000000000000", 
     B(3) => div1_reg9,
     B(2) => div2_reg6,
     B(1) => div3_reg3,
     B(0) => NOT div4(47),
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 4) => "00000000000000000000000000000000000000000000", 
     C(3 downto 0) => NUMERATOR_IN_REG13(3 downto 0),
     CARRYIN => '0',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '0',   -- CINSUB clock enable input
     CECTRL => '0',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE => ("0110101"), -- 7-bit operation mode input
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'    -- SUBTRACT input
  );
   -- End of DSP48_5 instantiation 

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         Q_OUT <= "0000";    
         R_OUT <= "0000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         Q_OUT <= div1_reg12 & div2_reg9 & div3_reg6 & div4_reg3;  
         R_OUT <= remain(3 DOWNTO 0);    
      END IF;
   END PROCESS;


END DIV_MULT;
