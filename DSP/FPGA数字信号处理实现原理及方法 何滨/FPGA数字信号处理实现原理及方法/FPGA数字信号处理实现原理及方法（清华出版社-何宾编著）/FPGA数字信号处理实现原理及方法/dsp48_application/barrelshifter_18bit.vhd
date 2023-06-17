-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: BARRELSHIFTER_18BIT 
--  /   /        Date Last Modified:  June 23, 2004 
-- /___/   /\    Date Created: June 23, 2004 
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
--
-- Module: BARRELSHIFTER_18BIT
--
-- Description: Verilog instantiation template for 
-- DSP48 embedded MAC blocks arranged as a pipelined
-- 18 bit barrel shifter. The macro uses 2 DSP
-- slices 
--
-- Device: Whitney Family
--
-- Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
--
-----------------------------------------------------------------------

LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

--Library UNISIM;
--use UNISIM.vcomponents.all;


entity BARRELSHIFTER_18BIT is
   port (
      CLK                     : in std_logic;   
      RST                     : in std_logic;   
      A_IN                    : in std_logic_vector(17 downto 0);   
      SHIFT_IN                : in std_logic_vector(17 downto 0);   
      SHIFT_OUT                  : out std_logic_vector(17 downto 0));   
end entity BARRELSHIFTER_18BIT;

architecture BARRELSHIFTER_18BIT_ARCH of BARRELSHIFTER_18BIT is
--
------------------------------------------------------------------------
--
-- Component Declarations:
--

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
        CARRYIN                 : in  std_logic;
        CARRYINSEL              : in  std_logic_vector(1 downto 0);
        CEA                     : in  std_logic;
        CEB                     : in  std_logic;
        CEC                     : in  std_logic;
        CECARRYIN               : in  std_logic;
        CECINSUB                : in  std_logic;
        CECTRL                  : in  std_logic;
        CEM                     : in  std_logic;
        CEP                     : in  std_logic;
        CLK                     : in  std_logic;
        OPMODE                  : in  std_logic_vector(6 downto 0);
        PCIN                    : in  std_logic_vector(47 downto 0);
        RSTA                    : in  std_logic;
        RSTB                    : in  std_logic;
        RSTC                    : in  std_logic;
        RSTCARRYIN              : in  std_logic;
        RSTCTRL                 : in  std_logic;
        RSTM                    : in  std_logic;
        RSTP                    : in  std_logic;
        SUBTRACT                : in  std_logic
      );
  end component;

-----------------------------------------------------------------
--Signal Declarations:
signal BCOUT_1                  :  std_logic_vector(17 downto 0);
signal PCOUT_1                  :  std_logic_vector(47 downto 0);   
signal POUT_2                   :  std_logic_vector(47 downto 0);   
signal A_IN_TEMP                :  std_logic_vector(17 downto 0);
signal LOW_18bit                :  std_logic_vector(17 downto 0);
signal LOW_48bit                :  std_logic_vector(47 downto 0);
signal LOW_1bit                 :  std_logic;
signal HIGH_1bit                :  std_logic;
signal CARRYINSEL_bit           :  std_logic_vector(1 downto 0);
signal OPMODE_bit1              :  std_logic_vector(6 downto 0);
signal OPMODE_bit2              :  std_logic_vector(6 downto 0);
signal SHIFT_MSB_REG1           :  std_logic;
signal SHIFT_MSB_REG2           :  std_logic;


------------------------------------------------------------------
-- Architecture Section: instantiation block 1


BEGIN

LOW_18bit        <= "000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';
CARRYINSEL_bit <= "00";
OPMODE_bit1 <= "0000101";
OPMODE_bit2 <= "1010101";

PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         SHIFT_MSB_REG1 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         SHIFT_MSB_REG1 <= SHIFT_IN(17);    
      END IF;
   END PROCESS;

PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         SHIFT_MSB_REG2 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         SHIFT_MSB_REG2 <= SHIFT_MSB_REG1;    
      END IF;
   END PROCESS;


A_IN_TEMP <=  "0" & A_IN(17 downto 1);

     DSP48_1 : DSP48 generic map (
     AREG => 1, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 0, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 1) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IN_TEMP,
         B => SHIFT_IN,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => LOW_48bit,
         OPMODE => OPMODE_bit1,
         SUBTRACT => SHIFT_MSB_REG1,
         CARRYIN => LOW_1bit,
         CARRYINSEL => CARRYINSEL_bit,
         CLK => CLK,
         CEA => HIGH_1bit,
         CEB => HIGH_1bit,
         CEC => LOW_1bit,
         CEP => HIGH_1bit,
         CEM => HIGH_1bit,
         CECTRL => LOW_1bit,
         CECARRYIN => LOW_1bit,
         CECINSUB => HIGH_1bit,
         RSTA => RST,
         RSTB => RST,
         RSTC => RST,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => BCOUT_1,
         P => open,
         PCOUT => PCOUT_1);   
   

-----------------------------------------------------------------


     DSP48_2 : DSP48 generic map (
     AREG => 2, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "CASCADE", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 0, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18S", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 1, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 1) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IN,
         B => LOW_18bit,
         C => LOW_48bit,
         BCIN => BCOUT_1,
         PCIN => PCOUT_1,
         OPMODE => OPMODE_bit2,
         SUBTRACT => SHIFT_MSB_REG1,
         CARRYIN => LOW_1bit,
         CARRYINSEL => CARRYINSEL_bit,
         CLK => CLK,
         CEA => HIGH_1bit,
         CEB => HIGH_1bit,
         CEC => LOW_1bit,
         CEP => HIGH_1bit,
         CEM => HIGH_1bit,
         CECTRL => LOW_1bit,
         CECARRYIN => LOW_1bit,
         CECINSUB => HIGH_1bit,
         RSTA => RST,
         RSTB => RST,
         RSTC => RST,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => open,
         P => POUT_2,
         PCOUT => open);   
   
SHIFT_OUT <= POUT_2(17 downto 0) ;
    
--
-------------------------------------------------------------
--
end BARRELSHIFTER_18BIT_ARCH;

