-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: CNTR_LOAD
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
LIBRARY IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

ENTITY CNTR_LOAD IS
   PORT (
      CLK                     : IN std_logic;   
      RST                     : IN std_logic;   
      C_IN                    : IN std_logic_vector(47 DOWNTO 0);   
      LOAD                    : IN std_logic;   
                              --  1 => output = C_IN +1, 0 => output = P + 1;
      ADD_SUB                 : IN std_logic;   
                              --  0 = up counter, 1 = down counter
      CNTR_OUT                : OUT std_logic_vector(47 DOWNTO 0));   
END CNTR_LOAD;

ARCHITECTURE CNTR_LOAD OF CNTR_LOAD IS

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


   SIGNAL CNTR_OUT_INT             :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL OPMODE                   :  std_logic_vector(6 DOWNTO 0);   
   SIGNAL LOAD_REG                 :  std_logic;   
	SIGNAL ADD_SUB_REG              :  std_logic;   
   SIGNAL C_IN_REG                 :  std_logic_vector(47 DOWNTO 0);   

-- Instantiation block 1

BEGIN

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         LOAD_REG <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         LOAD_REG <= LOAD;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         ADD_SUB_REG <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         ADD_SUB_REG <= ADD_SUB;    
      END IF;
   END PROCESS;
   
   -- register C_IN input 
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         C_IN_REG <= (others => '0'); 
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         C_IN_REG <= C_IN;    
      END IF;
   END PROCESS;

     DSP48_1 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 0, -- Number of pipeline registers on the B input, 0, 1 or 2
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
     OPMODEREG => 1, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 1) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => CNTR_OUT_INT,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => (others => '0'),          -- 18-bit A data input
     B => (others => '0'),          -- 18-bit B data input
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C => C_IN_REG,         -- 48-bit cascade input
     CARRYIN => '1',    -- Carry input signal
     CARRYINSEL => "00", -- 2-bit carry input select
     CEA => '1',        -- A data clock enable input
     CEB => '1',        -- B data clock enable input
     CEC => '1',        -- C data clock enable input
     CECARRYIN => '0',  -- CARRYIN clock enable input
     CECINSUB => '1',   -- CINSUB clock enable input
     CECTRL => '1',     -- Clock Enable input for CTRL registers
     CEM => '1',        -- Clock Enable input for multiplier registers
     CEP => '1',        -- Clock Enable input for P registers
     CLK => CLK,         -- Clock input
     OPMODE(6) => '0',
     OPMODE(5) => '1',
     OPMODE(4) => LOAD_REG ,
     OPMODE(3 downto 0) => "0000", 
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => ADD_SUB_REG    -- SUBTRACT input
  );
    -- End of DSP48_1 instantiation

   
--register C_IN input 

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CNTR_OUT <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CNTR_OUT <= CNTR_OUT_INT;    
      END IF;
   END PROCESS;
   --//////////////////////////////////////////////////////////////////////////////

END CNTR_LOAD;
