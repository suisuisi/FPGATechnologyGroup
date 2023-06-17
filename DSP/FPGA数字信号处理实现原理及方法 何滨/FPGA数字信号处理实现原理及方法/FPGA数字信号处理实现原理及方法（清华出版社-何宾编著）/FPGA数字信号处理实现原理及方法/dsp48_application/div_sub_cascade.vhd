-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: DIV_SUB_CASCADE
--  /   /        Date Last Modified:  November 21, 2005 
-- /___/   /\    Date Created: November 21, 2005 
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

ENTITY DIV_SUB_CASCADE IS
   PORT (
      CLK                     : IN std_logic;   
      RST                     : IN std_logic;   
      NUMERATOR_IN            : IN std_logic_vector(3 DOWNTO 0);   
      DENOMINATOR_IN          : IN std_logic_vector(3 DOWNTO 0);   
      Q_OUT                   : OUT std_logic_vector(3 DOWNTO 0);   
      R_OUT                   : OUT std_logic_vector(3 DOWNTO 0));   
END DIV_SUB_CASCADE;

ARCHITECTURE DIV_SUB_CASCADE OF DIV_SUB_CASCADE IS

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



   SIGNAL NUMERATOR_IN_REG1        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG1      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG2        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL DENOMINATOR_IN_REG2      :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG3        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG4        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG5        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG6        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL NUMERATOR_IN_REG7        :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL div1, div2, div3, div4   :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL div1_reg1, div1_reg2     :  std_logic;
   SIGNAL div1_reg3                :  std_logic;   
   SIGNAL div1_reg4, div1_reg5     :  std_logic;
   SIGNAL div1_reg6, div1_reg7     :  std_logic;   
   SIGNAL div2_reg1, div2_reg2     :  std_logic;
   SIGNAL div2_reg3, div2_reg4     :  std_logic;
   SIGNAL div2_reg5                :  std_logic;   
   SIGNAL div3_reg1, div3_reg2     :  std_logic;
   SIGNAL div3_reg3                :  std_logic;   
   SIGNAL div4_reg1                :  std_logic;   
   SIGNAL CIN_2                    :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL CIN_3                    :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL CIN_4                    :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL CIN_1                    :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL BCOUT1, BCOUT2, BCOUT3   :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL CIN_1_REG1               :  std_logic_vector(46 DOWNTO 0);   
   SIGNAL CIN_1_REG2               :  std_logic_vector(46 DOWNTO 0);   
   SIGNAL CIN_2_REG1               :  std_logic_vector(46 DOWNTO 0);   
   SIGNAL CIN_3_REG1               :  std_logic_vector(46 DOWNTO 0);   
   SIGNAL CIN_4_REG1               :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL CIN_4_REG2               :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL BIN_1                    :  std_logic_vector(17 DOWNTO 0);
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
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         NUMERATOR_IN_REG1 <= NUMERATOR_IN;    
         NUMERATOR_IN_REG2 <= NUMERATOR_IN_REG1;    
         NUMERATOR_IN_REG3 <= NUMERATOR_IN_REG2;    
         NUMERATOR_IN_REG4 <= NUMERATOR_IN_REG3;    
         NUMERATOR_IN_REG5 <= NUMERATOR_IN_REG4;    
         NUMERATOR_IN_REG6 <= NUMERATOR_IN_REG5;    
         NUMERATOR_IN_REG7 <= NUMERATOR_IN_REG6;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         DENOMINATOR_IN_REG1 <= "0000";    
         DENOMINATOR_IN_REG2 <= "0000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         DENOMINATOR_IN_REG1 <= DENOMINATOR_IN;    
         DENOMINATOR_IN_REG2 <= DENOMINATOR_IN_REG1;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_1 <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CIN_1 <= "00000000000000000000000000000000000000000000000" & 
         NUMERATOR_IN(3);    
      END IF;
   END PROCESS;

BIN_1 <= "00000000000000" & DENOMINATOR_IN_REG1;
   -- Instantiation block 1

     DSP48_1 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 1, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "DIRECT", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "NONE", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 0, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => BCOUT1,    -- 18-bit B cascade output
     P => div1,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => (others => '0'),          -- 18-bit A data input
     B => BIN_1,     -- 18-bit B data input
     BCIN =>(others => '0'),      -- 18-bit B cascade input
     C => CIN_1,         -- 48-bit cascade input
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
     OPMODE => "0110011", 
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'     -- SUBTRACT input
  );


   -- End of DSP48_1 instantiation 
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div1_reg1 <= '0';    
         div1_reg2 <= '0';    
         div1_reg3 <= '0';    
         div1_reg4 <= '0';    
         div1_reg5 <= '0';    
         div1_reg6 <= '0';    
         div1_reg7 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div1_reg1 <= NOT div1(47);    
         div1_reg2 <= div1_reg1;    
         div1_reg3 <= div1_reg2;    
         div1_reg4 <= div1_reg3;    
         div1_reg5 <= div1_reg4;    
         div1_reg6 <= div1_reg5;    
         div1_reg7 <= div1_reg6;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_1_REG1 <= (others => '0');    
         CIN_1_REG2 <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CIN_1_REG1 <= CIN_1(46 DOWNTO 0);    
         CIN_1_REG2 <= CIN_1_REG1;    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_2_REG1 <= (others => '0');
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CIN_2_REG1 <= CIN_2(46 DOWNTO 0);    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_3_REG1 <= (others => '0');
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CIN_3_REG1 <= CIN_3(46 DOWNTO 0);    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_4_REG1 <= (others => '0');
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         CIN_4_REG1 <= CIN_4;
         IF (div4(47) = '1') THEN    
          CIN_4_REG2 <= CIN_4_REG1; 
         ELSE 
          CIN_4_REG2 <=div4(47 DOWNTO 0); 
         END IF;   
      END IF;
   END PROCESS;
  


   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_2 <= (others => '0');           
      ELSIF (CLK'EVENT AND CLK = '1') THEN
        IF (div1(47) = '1') THEN    
          CIN_2 <= CIN_1_REG2(46 DOWNTO 0) & NUMERATOR_IN_REG3(2); 
        ELSE 
          CIN_2 <= div1(46 DOWNTO 0) & NUMERATOR_IN_REG3(2);
        END IF;           
      END IF;
   END PROCESS;
   
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_3 <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
        IF (div2(47) = '1') THEN    
          CIN_3 <= CIN_2_REG1(46 DOWNTO 0) & NUMERATOR_IN_REG5(1);
        ELSE 
          CIN_3 <= div2(46 DOWNTO 0) & NUMERATOR_IN_REG5(1);
        END IF; 
            
      END IF;
   END PROCESS;
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         CIN_4 <= (others => '0');    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
        IF (div3(47) = '1') THEN    
          CIN_4 <= CIN_3_REG1(46 DOWNTO 0) & NUMERATOR_IN_REG7(0);
         ELSE 
          CIN_4 <= div3(46 DOWNTO 0) & NUMERATOR_IN_REG7(0); 
        END IF; 
            
      END IF;
   END PROCESS;
   --          
   -- Instantiation block 2

     DSP48_2 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 2, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "CASCADE", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "NONE", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 0, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => BCOUT2,    -- 18-bit B cascade output
     P => div2,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => (others => '0'),          -- 18-bit A data input
     B => (others => '0'),    -- 18-bit B data input
     BCIN =>BCOUT1,      -- 18-bit B cascade input
     C => CIN_2,         -- 48-bit cascade input
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
     OPMODE => "0110011", 
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'     -- SUBTRACT input
  );


   -- End of DSP48_2 instantiation 
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div2_reg1 <= '0';    
         div2_reg2 <= '0';    
         div2_reg3 <= '0';    
         div2_reg4 <= '0';    
         div2_reg5 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div2_reg1 <= NOT div2(47);    
         div2_reg2 <= div2_reg1;    
         div2_reg3 <= div2_reg2;    
         div2_reg4 <= div2_reg3;    
         div2_reg5 <= div2_reg4;    
      END IF;
   END PROCESS;
   
   --          
   -- Instantiation block 3

     DSP48_3 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 2, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "CASCADE", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "NONE", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 0, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => BCOUT3,    -- 18-bit B cascade output
     P => div3,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => (others => '0'),          -- 18-bit A data input
     B => (others => '0'),    -- 18-bit B data input
     BCIN =>BCOUT2,      -- 18-bit B cascade input
     C => CIN_3,         -- 48-bit cascade input
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
     OPMODE => "0110011", 
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'     -- SUBTRACT input
  );



   -- End of DSP48_3 instantiation 
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div3_reg1 <= '0';    
         div3_reg2 <= '0';    
         div3_reg3 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div3_reg1 <= NOT div3(47);    
         div3_reg2 <= div3_reg1;    
         div3_reg3 <= div3_reg2;    
      END IF;
   END PROCESS;
   
   --          
   -- Instantiation block 4
   --
     DSP48_4 : DSP48 generic map (
     AREG => 0, -- Number of pipeline registers on the A input, 0, 1 or 2
     BREG => 2, -- Number of pipeline registers on the B input, 0, 1 or 2
     B_INPUT => "CASCADE", -- B input DIRECT from fabric 
                          --or CASCADE from another DSP48
     CARRYINREG => 0, -- Number of pipeline registers 
                      -- for the CARRYIN input, 0 or 1
     CARRYINSELREG => 0, -- Number of pipeline registers 
                         -- for the CARRYINSEL, 0 or 1
     CREG => 1, -- Number of pipeline registers on the C input, 0 or 1
     LEGACY_MODE => "NONE", -- Backward compatibility, NONE, 
                                  -- MULT18X18 or MULT18X18S
     MREG => 0, -- Number of multiplier pipeline registers, 0 or 1
     OPMODEREG => 0, -- Number of pipeline registers on OPMODE input, 0 or 1
     PREG => 1, -- Number of pipeline registers on the P output, 0 or 1
     SUBTRACTREG => 0) -- Number of pipeline registers on the 
                       -- SUBTRACT input, 0 or 1
  
 port map (
     BCOUT => open,    -- 18-bit B cascade output
     P => div4,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => (others => '0'),          -- 18-bit A data input
     B => (others => '0'),    -- 18-bit B data input
     BCIN =>BCOUT3,      -- 18-bit B cascade input
     C => CIN_4,         -- 48-bit cascade input
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
     OPMODE => "0110011", 
     PCIN => (others => '0'),      -- 48-bit PCIN input     
     RSTA => RST,        -- Reset input for A pipeline registers
     RSTB => RST,        -- Reset input for B pipeline registers
     RSTC => RST,        -- Reset input for C pipeline registers
     RSTCARRYIN => RST,  -- Reset input for CARRYIN registers
     RSTCTRL => RST,     -- Reset input for CTRL registers
     RSTM => RST,        -- Reset input for multiplier registers
     RSTP => RST,        -- Reset input for P pipeline registers
     SUBTRACT => '1'     -- SUBTRACT input
  );


   -- End of DSP48_4 instantiation 
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         div4_reg1 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         div4_reg1 <= NOT div4(47);    
      END IF;
   END PROCESS;

   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         Q_OUT <= "0000";    
         R_OUT <= "0000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         Q_OUT <= div1_reg7 & div2_reg5 & div3_reg3 & div4_reg1;   
         R_OUT <= CIN_4_REG2(3 DOWNTO 0);    
      END IF;
   END PROCESS;

END DIV_SUB_CASCADE;
