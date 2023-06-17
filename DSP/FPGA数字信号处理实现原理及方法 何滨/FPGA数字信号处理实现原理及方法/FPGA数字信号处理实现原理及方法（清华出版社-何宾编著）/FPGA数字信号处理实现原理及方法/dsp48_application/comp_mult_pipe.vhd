-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: COMPLEX_MULT_PIPE
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
-------------------------------------------------------------------------------- --
--Module: COMPLEX_MULT_PIPE
--
-- Description: Verilog instantiation template for 
-- DSP48 embedded MAC blocks arranged as a pipelined
-- complex multiplier. Macro uses 4 slices, 2 slices 
-- used to get the real part of the product and 2 
-- slices to get the imaginary part of the product.
--
-- Device: Whitney Family
--
-- Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
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

ENTITY COMPLEX_MULT_PIPE IS
   PORT (
      CLK              : in std_logic;   
      RST              : in std_logic;   
      A_REAL           : in std_logic_vector(17 downto 0);   
      B_REAL           : in std_logic_vector(17 downto 0);   
      A_IMAGINARY      : in std_logic_vector(17 downto 0);   
      B_IMAGINARY      : in std_logic_vector(17 downto 0);   
      PROD_REAL        : out std_logic_vector(47 downto 0);   
      PROD_IMAGINARY   : out std_logic_vector(47 downto 0));   
END ENTITY COMPLEX_MULT_PIPE;

architecture COMPLEX_MULT_PIPE_ARCH of COMPLEX_MULT_PIPE is
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

------------------------------------------------------------------    
--Signal Declarations:
SIGNAL LOW_18bit                  :  std_logic_vector(17 downto 0);
SIGNAL LOW_48bit                  :  std_logic_vector(47 downto 0);
SIGNAL LOW_1bit                   :  std_logic;
SIGNAL HIGH_1bit                  :  std_logic;
SIGNAL CARRYINSEL_bit             :  std_logic_vector(1 downto 0);
SIGNAL OPMODE_bit1                :  std_logic_vector(6 downto 0);
SIGNAL OPMODE_bit2                :  std_logic_vector(6 downto 0);
SIGNAL OPMODE_bit3                :  std_logic_vector(6 downto 0);
SIGNAL OPMODE_bit4                :  std_logic_vector(6 downto 0);
SIGNAL PCOUT_1        :  std_logic_vector(47 DOWNTO 0);   
SIGNAL PCOUT_3        :  std_logic_vector(47 DOWNTO 0);   

------------------------------------------------------------------
-- Architecture Section: instantiation block 1
--          


begin

LOW_18bit        <= "000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';
CARRYINSEL_bit <= "00";
OPMODE_bit1 <= "0000101";
OPMODE_bit2 <= "0010101";
OPMODE_bit3 <= "0000101";
OPMODE_bit4 <= "0010101";

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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_REAL,
         B => B_REAL,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => LOW_48bit,
         OPMODE => OPMODE_bit1,
         SUBTRACT => LOW_1bit,
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
         P => open,
         PCOUT => PCOUT_1);   
   
 DSP48_2 : DSP48 generic map (
     AREG => 2, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 2, -- Number of pipeline registers on the B input, 0, 1 or 2
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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IMAGINARY,
         B => B_IMAGINARY,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => PCOUT_1,
         OPMODE => OPMODE_bit2,
         SUBTRACT => HIGH_1bit,
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
         P => PROD_REAL,
         PCOUT => open);   


     DSP48_3 : DSP48 generic map (
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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_REAL,
         B => B_IMAGINARY,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => LOW_48bit,
         OPMODE => OPMODE_bit3,
         SUBTRACT => LOW_1bit,
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
         P => open,
         PCOUT => PCOUT_3);   


     DSP48_4 : DSP48 generic map (
     AREG => 2, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 2, -- Number of pipeline registers on the B input, 0, 1 or 2
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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IMAGINARY,
         B => B_REAL,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => PCOUT_3,
         OPMODE => OPMODE_bit4,
         SUBTRACT => LOW_1bit,
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
         P => PROD_IMAGINARY,
         PCOUT => open);   

--
----------------------------------------------------------
--
end COMPLEX_MULT_PIPE_ARCH;

