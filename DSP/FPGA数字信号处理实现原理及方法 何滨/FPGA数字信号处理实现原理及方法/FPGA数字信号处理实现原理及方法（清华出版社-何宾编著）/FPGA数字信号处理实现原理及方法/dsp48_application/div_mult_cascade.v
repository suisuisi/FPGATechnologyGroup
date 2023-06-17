//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: DIV_MULT_CASCADE
//  /   /        Date Last Modified:  June 23, 2004 
// /___/   /\    Date Created: June 23, 2004 
// \   \  /  \ 
//  \___\/\___\ 
// 
//
// Revision History: 
// $Log: $
//------------------------------------------------------------------------------ 
//
//     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
//     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR
//     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION
//     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION
//     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS
//     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
//     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
//     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
//     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
//     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
//     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
//     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//     FOR A PARTICULAR PURPOSE.
//
//------------------------------------------------------------------------------ 

/**********************************************************************/
module DIV_MULT_CASCADE (CLK, RST, NUMERATOR_IN,  DENOMINATOR_IN, Q_OUT, R_OUT);
	
input           CLK, RST;
input   [3:0]  NUMERATOR_IN,  DENOMINATOR_IN;
output  [3:0]  Q_OUT, R_OUT;


reg[3:0]  NUMERATOR_IN_REG1,  DENOMINATOR_IN_REG1;
reg[3:0]  NUMERATOR_IN_REG2,  DENOMINATOR_IN_REG2;
reg[3:0]  NUMERATOR_IN_REG3,  DENOMINATOR_IN_REG3;
reg[3:0]  NUMERATOR_IN_REG4,  DENOMINATOR_IN_REG4;
reg[3:0]  NUMERATOR_IN_REG5,  DENOMINATOR_IN_REG5;
reg[3:0]  NUMERATOR_IN_REG6,  DENOMINATOR_IN_REG6;
reg[3:0]  NUMERATOR_IN_REG7,  DENOMINATOR_IN_REG7;
reg[3:0]  NUMERATOR_IN_REG8,  DENOMINATOR_IN_REG8;
reg[3:0]  NUMERATOR_IN_REG9,  DENOMINATOR_IN_REG9;
reg[3:0]  NUMERATOR_IN_REG10,  DENOMINATOR_IN_REG10;
reg[3:0]  NUMERATOR_IN_REG11,  DENOMINATOR_IN_REG11;
reg[3:0]  NUMERATOR_IN_REG12,  DENOMINATOR_IN_REG12;
reg[3:0]  NUMERATOR_IN_REG13,  DENOMINATOR_IN_REG13;
reg[3:0]  NUMERATOR_IN_REG14,  DENOMINATOR_IN_REG14;

reg[3:0] Q_OUT_REG1, Q_OUT_REG2; 
reg [3:0] Q_OUT;
wire [47:0] div1, div2, div3, div4, remain;
reg [3:0] R_OUT;
reg div1_reg1, div1_reg2, div1_reg3, div1_reg4, div1_reg5,
    div1_reg6, div1_reg7, div1_reg8, div1_reg9, div1_reg10,
    div1_reg11, div1_reg12;
reg div2_reg1, div2_reg2, div2_reg3, div2_reg4, div2_reg5,
    div2_reg6, div2_reg7, div2_reg8, div2_reg9;
reg div3_reg1, div3_reg2, div3_reg3, div3_reg4, div3_reg5,
    div3_reg6;
reg div4_reg1, div4_reg2, div4_reg3;

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
        NUMERATOR_IN_REG1 <= 4'b0;   NUMERATOR_IN_REG2 <= 4'b0; 
        NUMERATOR_IN_REG3 <= 4'b0;   NUMERATOR_IN_REG4 <= 4'b0; 
        NUMERATOR_IN_REG5 <= 4'b0;   NUMERATOR_IN_REG6 <= 4'b0; 
        NUMERATOR_IN_REG7 <= 4'b0;   NUMERATOR_IN_REG8 <= 4'b0; 
        NUMERATOR_IN_REG9 <= 4'b0;   NUMERATOR_IN_REG10 <= 4'b0; 
        NUMERATOR_IN_REG11 <= 4'b0;   NUMERATOR_IN_REG12 <= 4'b0; 
        NUMERATOR_IN_REG13 <= 4'b0;   NUMERATOR_IN_REG14 <= 4'b0; 
	  end
   else 
          begin 
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
          end
   end  

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
        DENOMINATOR_IN_REG1 <= 4'b0;   DENOMINATOR_IN_REG2 <= 4'b0; 
        DENOMINATOR_IN_REG3 <= 4'b0;   DENOMINATOR_IN_REG4 <= 4'b0; 
        DENOMINATOR_IN_REG5 <= 4'b0;   DENOMINATOR_IN_REG6 <= 4'b0; 
        DENOMINATOR_IN_REG7 <= 4'b0;   DENOMINATOR_IN_REG8 <= 4'b0; 
        DENOMINATOR_IN_REG9 <= 4'b0;   DENOMINATOR_IN_REG10 <= 4'b0; 
        DENOMINATOR_IN_REG11 <= 4'b0;   DENOMINATOR_IN_REG12 <= 4'b0; 
        DENOMINATOR_IN_REG13 <= 4'b0;   DENOMINATOR_IN_REG14 <= 4'b0; 
	  end
   else 
          begin 
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
          end
   end  


/* Output is 4 bit integer + 4 bit fraction.
 Multiplier output is 16 bits wide. 8 bit input is stored as 
 8bits + 8'b0 wide value*/

   
//          
// Instantiation block 1
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_1 
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(div1),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, DENOMINATOR_IN}),          // 18-bit A data input
      .B({14'b0, 4'b1000}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({44'b0, NUMERATOR_IN_REG1}),          // 48-bit cascade input
      .CARRYIN(1'b0), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b0), // CINSUB clock enable input
      .CECTRL(1'b0), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE(7'b0110101), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(1'b1) // SUBTRACT input
   );
  
/*
//synthesis translate_off 
   defparam DSP48_1.AREG = 1; 
   defparam DSP48_1.BREG = 1; 
   defparam DSP48_1.B_INPUT = "DIRECT"; 
   defparam DSP48_1.CARRYINREG = 0; 
   defparam DSP48_1.CARRYINSELREG = 0; 
   defparam DSP48_1.CREG = 1; 
   defparam DSP48_1.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_1.MREG = 1; 
   defparam DSP48_1.OPMODEREG = 0; 
   defparam DSP48_1.PREG = 1; 
   defparam DSP48_1.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

   // End of DSP48_1 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       div1_reg1 <= 1'b0; div1_reg2 <= 1'b0; 
       div1_reg3 <= 1'b0; div1_reg4 <= 1'b0;
       div1_reg5 <= 1'b0; div1_reg6 <= 1'b0; 
       div1_reg7 <= 1'b0; div1_reg8 <= 1'b0; 
       div1_reg9 <= 1'b0; div1_reg10 <= 1'b0;
       div1_reg11 <= 1'b0; div1_reg12 <= 1'b0;
       end
   else 
       begin
       div1_reg1 <= !div1[47];
       div1_reg2 <= div1_reg1;
       div1_reg3 <= div1_reg2;
       div1_reg4 <= div1_reg3;
       div1_reg5 <= div1_reg4;
       div1_reg6 <= div1_reg5;
       div1_reg7 <= div1_reg6;
       div1_reg8 <= div1_reg7;
       div1_reg9 <= div1_reg8;
       div1_reg10 <= div1_reg9;
       div1_reg11 <= div1_reg10;
       div1_reg12 <= div1_reg11;

       end
   end

//          
// Instantiation block 2
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_2 
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(div2),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, DENOMINATOR_IN_REG3}),          // 18-bit A data input
      .B({14'b0, !div1[47], 3'b100}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({44'b0, NUMERATOR_IN_REG4}),          // 48-bit cascade input
      .CARRYIN(1'b0), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b0), // CINSUB clock enable input
      .CECTRL(1'b0), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE(7'b0110101), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(1'b1) // SUBTRACT input
   );
  
/*
//synthesis translate_off 
   defparam DSP48_2.AREG = 1; 
   defparam DSP48_2.BREG = 1; 
   defparam DSP48_2.B_INPUT = "DIRECT"; 
   defparam DSP48_2.CARRYINREG = 0; 
   defparam DSP48_2.CARRYINSELREG = 0; 
   defparam DSP48_2.CREG = 1; 
   defparam DSP48_2.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_2.MREG = 1; 
   defparam DSP48_2.OPMODEREG = 0; 
   defparam DSP48_2.PREG = 1; 
   defparam DSP48_2.SUBTRACTREG = 0; 
//synthesis translate_on 
*/
   // End of DSP48_2 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       div2_reg1 <= 1'b0; div2_reg2 <= 1'b0; div2_reg3 <= 1'b0; 
       div2_reg4 <= 1'b0; div2_reg5 <= 1'b0; div2_reg6 <= 1'b0; 
       div2_reg7 <= 1'b0; div2_reg8 <= 1'b0; div2_reg9 <= 1'b0; end
   else 
       begin
       div2_reg1 <= !div2[47];
       div2_reg2 <= div2_reg1;
       div2_reg3 <= div2_reg2;
       div2_reg4 <= div2_reg3;
       div2_reg5 <= div2_reg4;
       div2_reg6 <= div2_reg5;
       div2_reg7 <= div2_reg6;
       div2_reg8 <= div2_reg7;
       div2_reg9 <= div2_reg8;
       end
   end

//          
// Instantiation block 3
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_3 
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(div3),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, DENOMINATOR_IN_REG6}),          // 18-bit A data input
      .B({14'b0, div1_reg3, !div2[47], 2'b10}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({44'b0, NUMERATOR_IN_REG7}),          // 48-bit cascade input
      .CARRYIN(1'b0), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b0), // CINSUB clock enable input
      .CECTRL(1'b0), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE(7'b0110101), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(1'b1) // SUBTRACT input
   );
  
/*
//synthesis translate_off 
   defparam DSP48_3.AREG = 1; 
   defparam DSP48_3.BREG = 1; 
   defparam DSP48_3.B_INPUT = "DIRECT"; 
   defparam DSP48_3.CARRYINREG = 0; 
   defparam DSP48_3.CARRYINSELREG = 0; 
   defparam DSP48_3.CREG = 1; 
   defparam DSP48_3.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_3.MREG = 1; 
   defparam DSP48_3.OPMODEREG = 0; 
   defparam DSP48_3.PREG = 1; 
   defparam DSP48_3.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

   // End of DSP48_3 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       div3_reg1 <= 1'b0; div3_reg2 <= 1'b0; 
	 div3_reg3 <= 1'b0; div3_reg4 <= 1'b0;
       div3_reg5 <= 1'b0; div3_reg6 <= 1'b0; end
   else 
       begin
       div3_reg1 <= !div3[47];
       div3_reg2 <= div3_reg1;
       div3_reg3 <= div3_reg2;
	 div3_reg4 <= div3_reg3;
       div3_reg5 <= div3_reg4;
	 div3_reg6 <= div3_reg5;
       end
   end

//          
// Instantiation block 4
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_4 
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(div4),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, DENOMINATOR_IN_REG9}),          // 18-bit A data input
      .B({14'b0, div1_reg6, div2_reg3, !div3[47], 1'b1}), // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({44'b0, NUMERATOR_IN_REG10}),          // 48-bit cascade input
      .CARRYIN(1'b0), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b0), // CINSUB clock enable input
      .CECTRL(1'b0), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE(7'b0110101), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(1'b1) // SUBTRACT input
   );
  
/*
//synthesis translate_off 
   defparam DSP48_4.AREG = 1; 
   defparam DSP48_4.BREG = 1; 
   defparam DSP48_4.B_INPUT = "DIRECT"; 
   defparam DSP48_4.CARRYINREG = 0; 
   defparam DSP48_4.CARRYINSELREG = 0; 
   defparam DSP48_4.CREG = 1; 
   defparam DSP48_4.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_4.MREG = 1; 
   defparam DSP48_4.OPMODEREG = 0; 
   defparam DSP48_4.PREG = 1; 
   defparam DSP48_4.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

   // End of DSP48_4 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       div4_reg1 <= 1'b0; div4_reg2 <= 1'b0; 
	 div4_reg3 <= 1'b0; end
   else 
       begin
       div4_reg1 <= !div4[47];
       div4_reg2 <= div4_reg1;
       div4_reg3 <= div4_reg2;
       end
   end


//          
// Instantiation block 5
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_5
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(remain),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, DENOMINATOR_IN_REG12}),          // 18-bit A data input
      .B({14'b0, div1_reg9, div2_reg6, div3_reg3, !div4[47]}), // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({44'b0, NUMERATOR_IN_REG13}),          // 48-bit cascade input
      .CARRYIN(1'b0), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b0), // CINSUB clock enable input
      .CECTRL(1'b0), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE(7'b0110101), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(1'b1) // SUBTRACT input
   );
  
/*
//synthesis translate_off 
   defparam DSP48_5.AREG = 1; 
   defparam DSP48_5.BREG = 1; 
   defparam DSP48_5.B_INPUT = "DIRECT"; 
   defparam DSP48_5.CARRYINREG = 0; 
   defparam DSP48_5.CARRYINSELREG = 0; 
   defparam DSP48_5.CREG = 1; 
   defparam DSP48_5.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_5.MREG = 1; 
   defparam DSP48_5.OPMODEREG = 0; 
   defparam DSP48_5.PREG = 1; 
   defparam DSP48_5.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

   // End of DSP48_5 instantiation 



always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       Q_OUT <= 4'b0;  R_OUT <= 4'b0; end
   else 
       begin
       Q_OUT <= {div1_reg12, div2_reg9, div3_reg6, div4_reg3};
	  R_OUT <= remain[3:0]; 
       end
   end


//assign Q_OUT  = {div1_reg12, div2_reg9, div3_reg6, div4_reg3};
//assign R_OUT = remain[3:0];

endmodule	  
//
////////////////////////////////////////////////////////////////////////////////////




