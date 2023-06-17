-------------------------------------------------------------------------------- 
-- Copyright (c) 2004 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Vendor: Xilinx 
-- \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
--  \   \        Filename: SQRT_MULT_CASCADE
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

--Library UNISIM;
--use UNISIM.vcomponents.all;

ENTITY SQRT_MULT_CASCADE IS
   PORT (
      CLK                     : IN std_logic;   
      RST                     : IN std_logic;   
      X_IN                    : IN std_logic_vector(7 DOWNTO 0);   
      SQRT_OUT                : OUT std_logic_vector(4 DOWNTO 0));   
END SQRT_MULT_CASCADE;

ARCHITECTURE SQRT_MULT OF SQRT_MULT_CASCADE IS

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


   --SIGNAL Reg_A                    :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL sub1                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL sub2                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL sub3                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL sub4                     :  std_logic_vector(47 DOWNTO 0);   
   SIGNAL sub1_reg1, sub1_reg2, sub1_reg3, sub1_reg4                :  std_logic;   
   SIGNAL sub1_reg5, sub1_reg6, sub1_reg7, sub1_reg8                :  std_logic; 
   SIGNAL sub1_reg9, sub1_reg10, sub1_reg11, sub1_reg12, sub1_reg13 :  std_logic;   
   SIGNAL sub2_reg1, sub2_reg2, sub2_reg3, sub2_reg4                :  std_logic;   
   SIGNAL sub2_reg5, sub2_reg6, sub2_reg7, sub2_reg8, sub2_reg9     :  std_logic;   
   SIGNAL sub3_reg1, sub3_reg2, sub3_reg3, sub3_reg4, sub3_reg5     :  std_logic;   
   SIGNAL sub4_reg1                :  std_logic;     
   SIGNAL Reg_IN1, Reg_IN2, Reg_IN3, Reg_IN4, Reg_IN5 :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL Reg_IN6, Reg_IN7, Reg_IN8, Reg_IN9          :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL Reg_IN10, Reg_IN11, Reg_IN12, Reg_IN13      :  std_logic_vector(7 DOWNTO 0); 
   SIGNAL Reg_IN14, Reg_IN15, Reg_IN16                :  std_logic_vector(7 DOWNTO 0); 


BEGIN
   
   PROCESS (CLK, RST)
   BEGIN
      IF (RST = '1') THEN
         Reg_IN1 <= "00000000";    Reg_IN2 <= "00000000";    
         Reg_IN3 <= "00000000";    Reg_IN4 <= "00000000";    
         Reg_IN5 <= "00000000";    Reg_IN6 <= "00000000";    
         Reg_IN7 <= "00000000";    Reg_IN8 <= "00000000";    
         Reg_IN9 <= "00000000";    Reg_IN10 <= "00000000";    
         Reg_IN11 <= "00000000";    Reg_IN12 <= "00000000";    
         Reg_IN13 <= "00000000";    Reg_IN14 <= "00000000";    
         Reg_IN15 <= "00000000";    Reg_IN16 <= "00000000";    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         Reg_IN1 <= X_IN;    Reg_IN2 <= Reg_IN1;    
         Reg_IN3 <= Reg_IN2;    Reg_IN4 <= Reg_IN3;    
         Reg_IN5 <= Reg_IN4;    Reg_IN6 <= Reg_IN5;    
         Reg_IN7 <= Reg_IN6;    Reg_IN8 <= Reg_IN7;    
         Reg_IN9 <= Reg_IN8;    Reg_IN10 <= Reg_IN9;    
         Reg_IN11 <= Reg_IN10;    Reg_IN12 <= Reg_IN11;    
         Reg_IN13 <= Reg_IN12;    Reg_IN14 <= Reg_IN13;    
         Reg_IN15 <= Reg_IN14;    Reg_IN16 <= Reg_IN15;    
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
     P => sub1,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A => ("000000000000001000"),          -- 18-bit A data input
     B => ("000000000000001000"),          -- 18-bit B data input
     BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 8) => "0000000000000000000000000000000000000000", 
                        -- 48-bit cascade input
     C (7 downto 0) => Reg_IN1(7 downto 0),
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
         sub1_reg1 <= '0';    sub1_reg2 <= '0';    
         sub1_reg3 <= '0';    sub1_reg4 <= '0';    
         sub1_reg5 <= '0';    sub1_reg6 <= '0';    
         sub1_reg7 <= '0';    sub1_reg8 <= '0';    
         sub1_reg9 <= '0';    sub1_reg10 <= '0';  
         sub1_reg11 <= '0';   sub1_reg12 <= '0';   
         sub1_reg13 <= '0';       
          
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         sub1_reg1 <= NOT sub1(47);    sub1_reg2 <= sub1_reg1;    
         sub1_reg3 <= sub1_reg2;    sub1_reg4 <= sub1_reg3;    
         sub1_reg5 <= sub1_reg4;    sub1_reg6 <= sub1_reg5;    
         sub1_reg7 <= sub1_reg6;    sub1_reg8 <= sub1_reg7;    
         sub1_reg9 <= sub1_reg8;    sub1_reg10 <= sub1_reg9;  
         sub1_reg11 <= sub1_reg10;    sub1_reg12 <= sub1_reg11;
         sub1_reg13 <= sub1_reg12;      
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
     P => sub2,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
     A(17 downto 4) => "00000000000000", 
	A(3) =>	sub1_reg1,
	A(2 downto 0) => "100",        
     B(17 downto 4) => "00000000000000", 
	B(3) =>	sub1_reg1,
	B(2 downto 0) => "100",         --
	BCIN => "000000000000000000",      -- 18-bit B cascade input
	C(47 downto 8) => "0000000000000000000000000000000000000000", 
                        -- 48-bit cascade input
     C(7 downto 0) => Reg_IN5,
                        -- 48-bit cascade input
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
         sub2_reg1 <= '0';    sub2_reg2 <= '0';    
         sub2_reg3 <= '0';    sub2_reg4 <= '0';    
         sub2_reg5 <= '0';    sub2_reg6 <= '0';
         sub2_reg6 <= '0'; sub2_reg7 <= '0';
         sub2_reg8 <= '0'; sub2_reg9 <= '0';
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         sub2_reg1 <= NOT sub2(47);    sub2_reg2 <= sub2_reg1;    
         sub2_reg3 <= sub2_reg2;    sub2_reg4 <= sub2_reg3;    
         sub2_reg5 <= sub2_reg4;    sub2_reg6 <= sub2_reg5;   
         sub2_reg7 <= sub2_reg6; sub2_reg8 <= sub2_reg7;
         sub2_reg9 <= sub2_reg8;
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
     P => sub3,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
	A(17 downto 4) => "00000000000000" , 
     A(3) =>	sub1_reg5,
	A(2) =>	sub2_reg1,
	A(1 downto 0) => "10",         -- 18-bit A data input
     B(17 downto 4) => "00000000000000" , 
     B(3) =>	sub1_reg5,
	B(2) =>	sub2_reg1,
	B(1 downto 0) => "10",         -- 18-bit A data input
	BCIN => "000000000000000000",      -- 18-bit B cascade input
     C(47 downto 8) => "0000000000000000000000000000000000000000" , 
                        -- 48-bit cascade input
     C(7 downto 0) => Reg_IN9,
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
         sub3_reg1 <= '0';    
         sub3_reg2 <= '0';    
         sub3_reg3 <= '0';    
         sub3_reg4 <= '0'; sub3_reg5 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         sub3_reg1 <= NOT sub3(47);    
         sub3_reg2 <= sub3_reg1;    
         sub3_reg3 <= sub3_reg2;    
         sub3_reg4 <= sub3_reg3;
         sub3_reg5 <= sub3_reg4;    
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
     P => sub4,          -- 48-bit product output
     PCOUT => open,    -- 48-bit cascade output
   	A(17 downto 4) => "00000000000000" ,
     A(3) =>	sub1_reg9,	 
     A(2) =>	sub2_reg5,
	A(1) =>	sub3_reg1,
	A(0) => '1',         -- 18-bit A data input
     B(17 downto 4) => "00000000000000" ,
     B(3) =>	sub1_reg9,	 
     B(2) =>	sub2_reg5,
	B(1) =>	sub3_reg1,
	B(0) => '1',         -- 18-bit A data input
     BCIN => "000000000000000000",      -- 18-bit B cascade input
	C(47 downto 8) => "0000000000000000000000000000000000000000", 
                        -- 48-bit cascade input
     C (7 downto 0) => Reg_IN13,
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
         sub4_reg1 <= '0';    
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         Sub4_reg1 <= NOT sub4(47);    
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


END SQRT_MULT;
