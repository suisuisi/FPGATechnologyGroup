-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: MULT18X18_PARALLEL_PIPE 
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
--
-------------------------------------------------------------------------------- 

LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--Library UNISIM;
--use UNISIM.vcomponents.all;


ENTITY MULT35X18_SEQUENTIAL_PIPE IS
   PORT (
      CLK                     : IN std_logic;   
      RST                     : IN std_logic;   
      A_IN                    : IN std_logic_vector(34 DOWNTO 0);   
      B_IN                    : IN std_logic_vector(17 DOWNTO 0);   
      PROD_OUT                : OUT std_logic_vector(52 DOWNTO 0));   
END MULT35X18_SEQUENTIAL_PIPE;

ARCHITECTURE MULT35X18_SEQUENTIAL_PIPE_ARCH OF MULT35X18_SEQUENTIAL_PIPE IS

------------------------------------------------------------------------
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
signal LOW_18bit                  :  std_logic_vector(17 downto 0);
signal LOW_48bit                  :  std_logic_vector(47 downto 0);
signal LOW_1bit                   :  std_logic;
signal HIGH_1bit                  :  std_logic;
signal CARRYINSEL_bit             :  std_logic_vector(1 downto 0);
--signal OPMODE_bit                 :  std_logic_vector(6 downto 0);

   SIGNAL A_IN_REG                 :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL B_IN_REG                 :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL SEL_A                    :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL SEL_B                    :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL POUT_REG1                :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL POUT                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL OPMODE                   :  std_logic_vector(6 DOWNTO 0);   
   SIGNAL OPMODE_REG               :  std_logic_vector(6 DOWNTO 0);   
   SIGNAL A_IN_WIRE                :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL B_IN_WIRE                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL cntr4                    :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL PROD_OUT_INT             :  std_logic_vector(52 DOWNTO 0);

------------------------------------------------------------------
-- Architecture Section: instantiation block 1


BEGIN

LOW_18bit        <= "000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';
CARRYINSEL_bit <= "00";
--OPMODE_bit <= "0000101";


   -- Register inputs A1_IN and B_IN.
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         cntr4 <= "11";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4 < "11") THEN
            cntr4 <= cntr4 + "01";    
         ELSE
            cntr4 <= "00";    
         END IF;
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         A_IN_REG <= "00000000000000000000000000000000000";    
         B_IN_REG <= "000000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4(0) = '1') THEN
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
         SEL_A <= "000000000000000000";    
         SEL_B <= "000000000000000000";    
         OPMODE <= "0000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CASE cntr4(0) IS
            WHEN '1' =>
                     SEL_A <= '0' & A_IN_WIRE(16 DOWNTO 0);    
                     SEL_B <= B_IN_WIRE(17 DOWNTO 0);    
                     OPMODE <= "1100101";    
            WHEN '0' =>
                     SEL_A <= A_IN_WIRE(34 DOWNTO 17);    
                     SEL_B <= B_IN_WIRE(17 DOWNTO 0);    
                     OPMODE <= "0000101";    
            WHEN OTHERS =>
                     NULL;
            
         END CASE;
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         OPMODE_REG <= "0000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         OPMODE_REG <= OPMODE;    
      END IF;
   END PROCESS;
   
   -- Product[16:0], cycle1; Product[52:17] cycle 2
     DSP48_1 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 0, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 0, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "MULT18X18", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 0, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
port map (
         A => SEL_A,
         B => SEL_B,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => LOW_48bit,
         OPMODE => OPMODE_REG,
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
         P => POUT,
         PCOUT => open);   
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         POUT_REG1 <= "00000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         POUT_REG1 <= POUT(16 DOWNTO 0);    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         PROD_OUT_INT <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (cntr4 = "00") THEN
            PROD_OUT_INT <= POUT(35 DOWNTO 0) & POUT_REG1;
            --PROD_OUT <= POUT_REG1;    
         ELSE
            PROD_OUT_INT <= PROD_OUT_INT;    
         END IF;
      END IF;
    END PROCESS;


PROD_OUT <= PROD_OUT_INT;
-----------------------------------------------------------------

END MULT35X18_SEQUENTIAL_PIPE_ARCH;
