
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: MULT35X35_PARALLEL_PIPE 
--  /   /        Date Last Modified: JUNE 02, 2005 
-- /___/   /\    Date Created: OCTOBER 05, 2004 
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
--
-- Module: MULT35X35_PARALLEL_PIPE
--
-- Description: Verilog instantiation template for 
-- DSP48 embedded MAC blocks arranged as a pipelined
-- 35 x 35 multiplier. The macro uses 4 DSP
-- slices . Product[16:0] done in slice1, product[33:17
-- done in slice3 and product[69:34] done in slice4.
--
-- Device: Whitney Family
--
-- Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
--
-------------------------------------------------------------------------

LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


ENTITY MULT35X35_PARALLEL_PIPE IS
   PORT (
      CLK           : IN std_logic;   
      RST           : IN std_logic;   
      A_IN          : IN std_logic_vector(34 DOWNTO 0);   
      B_IN          : IN std_logic_vector(34 DOWNTO 0);   
   PROD_OUT                : OUT std_logic_vector(69 DOWNTO 0));   
END MULT35X35_PARALLEL_PIPE;

architecture MULT35X35_PARALLEL_PIPE_ARCH of MULT35X35_PARALLEL_PIPE is

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

   SIGNAL BCOUT_1                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL BCOUT_3                  :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL PCOUT_1                  :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL PCOUT_2                  :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL PCOUT_3                  :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL POUT_1                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL POUT_3                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL POUT_4                   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL POUT_1_REG1              :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL POUT_1_REG2              :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL POUT_1_REG3              :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL POUT_3_REG1              :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL A_IN_3_REG1              :  std_logic_vector(16 DOWNTO 0);   
   SIGNAL A_IN_4_REG1              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL A_IN_4_REG2              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL B_IN_3_REG1              :  std_logic_vector(17 DOWNTO 0);   
   --SIGNAL A_IN_WIRE                :  std_logic_vector(34 DOWNTO 0);   
   --SIGNAL B_IN_WIRE                :  std_logic_vector(34 DOWNTO 0);   
   SIGNAL A_IN1,B_IN1              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL A_IN_3                   :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL LOW_18bit                :  std_logic_vector(17 downto 0);
   SIGNAL LOW_48bit                :  std_logic_vector(47 downto 0);
   SIGNAL LOW_1bit                 :  std_logic;
   SIGNAL HIGH_1bit                :  std_logic;
   SIGNAL CARRYINSEL_bit           :  std_logic_vector(1 downto 0);
   SIGNAL OPMODE_bit1              :  std_logic_vector(6 downto 0);
   SIGNAL OPMODE_bit2              :  std_logic_vector(6 downto 0);
   SIGNAL OPMODE_bit3              :  std_logic_vector(6 downto 0);
   SIGNAL OPMODE_bit4              :  std_logic_vector(6 downto 0);

BEGIN

LOW_18bit        <= "000000000000000000";
LOW_48bit        <= "000000000000000000000000000000000000000000000000";
LOW_1bit         <= '0';
HIGH_1bit        <= '1';
CARRYINSEL_bit <= "00";
OPMODE_bit1 <= "0000101";
OPMODE_bit2 <= "1010101";
OPMODE_bit3 <= "0010101";
OPMODE_bit4 <= "1010101";

A_IN1 <= '0' & A_IN(16 downto 0);
B_IN1 <= '0' & B_IN(16 downto 0);

-- Product[16:0] Instantiation block 1

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
         A => A_IN1,
         B => B_IN1,
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
         RSTC => LOW_1bit,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => BCOUT_1,
         P => POUT_1,
         PCOUT => PCOUT_1);   

   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         POUT_1_REG1 <= "00000000000000000";    
         POUT_1_REG2 <= "00000000000000000";    
         POUT_1_REG3 <= "00000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         POUT_1_REG1 <= POUT_1(16 DOWNTO 0);    
         POUT_1_REG2 <= POUT_1_REG1;    
         POUT_1_REG3 <= POUT_1_REG2;    
      END IF;
   END PROCESS;
   PROD_OUT(16 DOWNTO 0) <= POUT_1_REG3 ;
   

   -- Instantiation block 2

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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IN(34 downto 17),
         B => LOW_18bit,
         C => LOW_48bit,
         BCIN => BCOUT_1,
         PCIN => PCOUT_1,
         OPMODE => OPMODE_bit2,
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
         RSTC => LOW_1bit,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => open,
         P => open,
         PCOUT => PCOUT_2);   

     
   -- Product[33:17] Instantiation block 3
      
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         A_IN_3_REG1 <= "00000000000000000";    
         B_IN_3_REG1 <= "000000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         A_IN_3_REG1 <= A_IN(16 DOWNTO 0);    
         B_IN_3_REG1 <= B_IN(34 DOWNTO 17);    
      END IF;
   END PROCESS;

   A_IN_3 <= '0' & A_IN_3_REG1(16 downto 0);


     DSP48_3 : DSP48 generic map (
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
         A => A_IN_3,
         B => B_IN_3_REG1,
         C => LOW_48bit,
         BCIN => LOW_18bit,
         PCIN => PCOUT_2,
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
         RSTC => LOW_1bit,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => BCOUT_3,
         P => POUT_3,
         PCOUT => PCOUT_3);   
   
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         POUT_3_REG1 <= "00000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         POUT_3_REG1 <= POUT_3(16 DOWNTO 0);    
      END IF;
   END PROCESS;
   PROD_OUT(33 DOWNTO 17) <= POUT_3_REG1 ;

   --          
   -- Product[69:34] Instantiation block 4
   --
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         A_IN_4_REG1 <= "000000000000000000";    
         A_IN_4_REG2 <= "000000000000000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         A_IN_4_REG1 <= A_IN(34 DOWNTO 17);    
         A_IN_4_REG2 <= A_IN_4_REG1;    
      END IF;
   END PROCESS;
   
DSP48_4 : DSP48 generic map (
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
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
         A => A_IN_4_REG2,
         B => LOW_18bit,
         C => LOW_48bit,
         BCIN => BCOUT_3,
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
         RSTC => LOW_1bit,
         RSTP => RST,
         RSTM => RST,
         RSTCTRL => RST,
         RSTCARRYIN => RST,
         BCOUT => open,
         P => POUT_4,
         PCOUT => open);   

   PROD_OUT(69 DOWNTO 34) <= POUT_4(35 DOWNTO 0) ;

END MULT35X35_PARALLEL_PIPE_ARCH;
