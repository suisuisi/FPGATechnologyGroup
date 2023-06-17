//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: SQRT_MULT_CASCADE
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


module SQRT_MULT_CASCADE (CLK, RST, X_IN, SQRT_OUT);
	
input           CLK, RST;
input   [7:0]  X_IN; 
output  [4:0]  SQRT_OUT;

reg[4:0] SQRT_OUT;

//reg[3:0] Reg_A; 
wire[47:0] sub1, sub2, sub3, sub4;



reg sub1_reg1 , sub1_reg2 , sub1_reg3 , sub1_reg4, sub1_reg5,
    sub1_reg6, sub1_reg7, sub1_reg8, sub1_reg9, sub1_reg10, sub1_reg11,
    sub1_reg12, sub1_reg13 ;
reg sub2_reg1 , sub2_reg2 , sub2_reg3, 
    sub2_reg4, sub2_reg5, sub2_reg6, sub2_reg7, sub2_reg8, sub2_reg9;
reg sub3_reg1 , sub3_reg2 , sub3_reg3 , sub3_reg4, sub3_reg5;
reg sub4_reg1;


reg[7:0] Reg_IN1, Reg_IN2 , Reg_IN3 , Reg_IN4 , 
        Reg_IN5 , Reg_IN6 , Reg_IN7 , Reg_IN8 , 
        Reg_IN9 , Reg_IN10 , Reg_IN11, Reg_IN12,
	   Reg_IN13 , Reg_IN14 , Reg_IN15, Reg_IN16;
//          
// Read in input every 32nd clock. Each bit has a latency of 4 clocks.
// So for a total of 8 bit outputs, the latency is 8*4 = 32 clocks
//

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
        Reg_IN1 <= 4'b0; Reg_IN2 <= 4'b0; Reg_IN3 <= 4'b0; Reg_IN4 <= 4'b0; 
        Reg_IN5 <= 4'b0; Reg_IN6 <= 4'b0; Reg_IN7 <= 4'b0; Reg_IN8 <= 4'b0; 
        Reg_IN9 <= 4'b0; Reg_IN10 <= 4'b0; Reg_IN11 <= 4'b0; Reg_IN12 <= 4'b0;
        Reg_IN13 <= 4'b0; Reg_IN14 <= 4'b0; Reg_IN15 <= 4'b0; Reg_IN16 <= 4'b0;
	  end
   else 
          begin 
          Reg_IN1 <= X_IN; Reg_IN2 <= Reg_IN1;
          Reg_IN3 <= Reg_IN2; Reg_IN4 <= Reg_IN3;
          Reg_IN5 <= Reg_IN4; Reg_IN6 <= Reg_IN5;
          Reg_IN7 <= Reg_IN6; Reg_IN8 <= Reg_IN7;
          Reg_IN9 <= Reg_IN8; Reg_IN10 <= Reg_IN9;
		Reg_IN11 <= Reg_IN10; Reg_IN12 <= Reg_IN11;
		Reg_IN13 <= Reg_IN12; Reg_IN14 <= Reg_IN13;
		Reg_IN15 <= Reg_IN14; Reg_IN16 <= Reg_IN15;

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
      .P(sub1),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, 4'b1000}),          // 18-bit A data input
      .B({14'b0, 4'b1000}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({40'b0, Reg_IN1}),          // 48-bit cascade input
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
       sub1_reg1 <= 1'b0; sub1_reg2 <= 1'b0; 
       sub1_reg3 <= 1'b0; sub1_reg4 <= 1'b0;
       sub1_reg5 <= 1'b0; sub1_reg6 <= 1'b0; 
       sub1_reg7 <= 1'b0; sub1_reg8 <= 1'b0; 
       sub1_reg9 <= 1'b0; sub1_reg10 <= 1'b0;
       sub1_reg11 <= 1'b0; sub1_reg12 <= 1'b0;
       sub1_reg13 <= 1'b0; 
       end
   else 
       begin
       sub1_reg1 <= !sub1[47];
       sub1_reg2 <= sub1_reg1;
       sub1_reg3 <= sub1_reg2;
       sub1_reg4 <= sub1_reg3;
       sub1_reg5 <= sub1_reg4;
       sub1_reg6 <= sub1_reg5;
       sub1_reg7 <= sub1_reg6;
       sub1_reg8 <= sub1_reg7;
       sub1_reg9 <= sub1_reg8;
       sub1_reg10 <= sub1_reg9;
       sub1_reg11 <= sub1_reg10;
       sub1_reg12 <= sub1_reg11;
       sub1_reg13 <= sub1_reg12;

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
      .P(sub2),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, sub1_reg1, 3'b100}),          // 18-bit A data input
      .B({14'b0, sub1_reg1, 3'b100}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({40'b0, Reg_IN5}),          // 48-bit cascade input
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
       sub2_reg1 <= 1'b0; sub2_reg2 <= 1'b0; sub2_reg3 <= 1'b0; 
       sub2_reg4 <= 1'b0; sub2_reg5 <= 1'b0; sub2_reg6 <= 1'b0; 
       sub2_reg7 <= 1'b0; sub2_reg8 <= 1'b0; sub2_reg9 <= 1'b0;end
   else 
       begin
       sub2_reg1 <= !sub2[47];
       sub2_reg2 <= sub2_reg1;
       sub2_reg3 <= sub2_reg2;
       sub2_reg4 <= sub2_reg3;
       sub2_reg5 <= sub2_reg4;
       sub2_reg6 <= sub2_reg5;
       sub2_reg7 <= sub2_reg6;
       sub2_reg8 <= sub2_reg7;
       sub2_reg9 <= sub2_reg8;

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
      .P(sub3),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, sub1_reg5, sub2_reg1,2'b10}),          // 18-bit A data input
      .B({14'b0, sub1_reg5, sub2_reg1,2'b10}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({40'b0, Reg_IN9}),          // 48-bit cascade input
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
       sub3_reg1 <= 1'b0; sub3_reg2 <= 1'b0; 
	    sub3_reg3 <= 1'b0; sub3_reg4 <= 1'b0;
	    sub3_reg5 <= 1'b0; end
   else 
       begin
       sub3_reg1 <= !sub3[47];
       sub3_reg2 <= sub3_reg1;
       sub3_reg3 <= sub3_reg2;
	    sub3_reg4 <= sub3_reg3;
	    sub3_reg5 <= sub3_reg4;
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
      .P(sub4),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A({14'b0, sub1_reg9, sub2_reg5, sub3_reg1,1'b1}),  // 18-bit A data input
      .B({14'b0, sub1_reg9, sub2_reg5, sub3_reg1,1'b1}),  // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C({40'b0, Reg_IN13}),          // 48-bit cascade input
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
       sub4_reg1 <= 1'b0; end
   else 
       begin
       sub4_reg1 <= !sub4[47];
       end
   end



/* The following code to used to check the functionality using modelsim */
/*

assign sub = (Reg_IN - (Reg_A * Reg_A));

*/

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       SQRT_OUT <= 4'b0;
       end
   else       
       begin
       SQRT_OUT <= ({1'b0, sub1_reg13, sub2_reg9, sub3_reg5, sub4_reg1});
       end
   end 

endmodule	  
