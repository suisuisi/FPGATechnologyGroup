//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: DIV_SUB_CASCADE
//  /   /        Date Last Modified:  November 21, 2005 
// /___/   /\    Date Created: November 21, 2005 
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
module DIV_SUB_CASCADE (CLK, RST, NUMERATOR_IN,  DENOMINATOR_IN, Q_OUT, R_OUT);
	
input           CLK, RST;
input   [3:0]  NUMERATOR_IN,  DENOMINATOR_IN;
output  [3:0]  Q_OUT, R_OUT;


reg[3:0]  NUMERATOR_IN_REG1,  DENOMINATOR_IN_REG1;
reg[3:0]  NUMERATOR_IN_REG2,  DENOMINATOR_IN_REG2;
reg[3:0]  NUMERATOR_IN_REG3;
reg[3:0]  NUMERATOR_IN_REG4;
reg[3:0]  NUMERATOR_IN_REG5;
reg[3:0]  NUMERATOR_IN_REG6;
reg[3:0]  NUMERATOR_IN_REG7;


reg [3:0] Q_OUT;
wire [47:0] div1, div2, div3, div4;
reg [3:0] R_OUT;
reg div1_reg1, div1_reg2, div1_reg3, div1_reg4, div1_reg5,
    div1_reg6, div1_reg7;
reg div2_reg1, div2_reg2, div2_reg3, div2_reg4, div2_reg5;
reg div3_reg1, div3_reg2, div3_reg3;
reg div4_reg1;
reg[47:0] CIN_2, CIN_3, CIN_4;
reg[47:0] CIN_1;
wire[17:0] BCOUT1,BCOUT2,BCOUT3;

reg[46:0] CIN_1_REG1, CIN_1_REG2;
reg[46:0] CIN_2_REG1;
reg[46:0] CIN_3_REG1;
reg[47:0] CIN_4_REG1, CIN_4_REG2;


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
        NUMERATOR_IN_REG1 <= 4'b0;   NUMERATOR_IN_REG2 <= 4'b0; 
        NUMERATOR_IN_REG3 <= 4'b0;   NUMERATOR_IN_REG4 <= 4'b0; 
        NUMERATOR_IN_REG5 <= 4'b0;   NUMERATOR_IN_REG6 <= 4'b0; 
        NUMERATOR_IN_REG7 <= 4'b0;    
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
       end
   end  

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin 
        DENOMINATOR_IN_REG1 <= 4'b0;   DENOMINATOR_IN_REG2 <= 4'b0; 
    	  end
   else 
       begin 
        DENOMINATOR_IN_REG1 <= DENOMINATOR_IN; 
        DENOMINATOR_IN_REG2 <= DENOMINATOR_IN_REG1; 
       end
   end  


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_1 <= 47'b0;
       end
   else 
       begin
       CIN_1 <= {47'b0,NUMERATOR_IN[3]};
       end
   end
   
/* Output is 4 bit integer + 4 bit fraction.
 Multiplier output is 16 bits wide. 8 bit input is stored as 
 8bits + 8'b0 wide value*/

   
//          
// Instantiation block 1
//
DSP48 #(
   .AREG(0),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("NONE"),           
   .MREG(0),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_1 
  (
      .BCOUT(BCOUT1),  // 18-bit B cascade output
      .P(div1),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A(18'b0),          // 18-bit A data input
      .B({14'b0, DENOMINATOR_IN_REG1}),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C(CIN_1),          // 48-bit cascade input
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
      .OPMODE(7'b0110011), // 7-bit operation mode input
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
   defparam DSP48_1.AREG = 0; 
   defparam DSP48_1.BREG = 1; 
   defparam DSP48_1.B_INPUT = "DIRECT"; 
   defparam DSP48_1.CARRYINREG = 0; 
   defparam DSP48_1.CARRYINSELREG = 0; 
   defparam DSP48_1.CREG = 1; 
   defparam DSP48_1.LEGACY_MODE = "NONE"; 
   defparam DSP48_1.MREG = 0; 
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
       div1_reg7 <= 1'b0; 
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
       end
   end
   
   always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_1_REG1 <= 47'b0; CIN_1_REG2 <= 47'b0;
       end
   else 
       begin
       CIN_1_REG1 <= CIN_1; CIN_1_REG2 <= CIN_1_REG1;
       end
   end

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_2_REG1 <= 47'b0; 
       end
   else 
       begin
       CIN_2_REG1 <= CIN_2; 
       end
   end

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_3_REG1 <= 47'b0; 
       end
   else 
       begin
       CIN_3_REG1 <= CIN_3; 
       end
   end

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_4_REG1 <= 48'b0; 
       end
   else 
       begin
       CIN_4_REG1 <= CIN_4;
       CIN_4_REG2 <= div4[47] ? {CIN_4_REG1} : {div4[47:0]};
       end
   end
   
always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       CIN_2 <= 48'b0;
       CIN_3 <= 48'b0;
       CIN_4 <= 48'b0;
       end
   else 
       begin
       CIN_2 <= div1[47] ? {CIN_1_REG2[46:0],NUMERATOR_IN_REG3[2]} : {div1[46:0],NUMERATOR_IN_REG3[2]};
       CIN_3 <= div2[47] ? {CIN_2_REG1[46:0],NUMERATOR_IN_REG5[1]} : {div2[46:0],NUMERATOR_IN_REG5[1]};
       CIN_4 <= div3[47] ? {CIN_3_REG1[46:0],NUMERATOR_IN_REG7[0]} : {div3[46:0],NUMERATOR_IN_REG7[0]};
       end
   end


//          
// Instantiation block 2
//
DSP48 #(
   .AREG(0),           
   .BREG(2),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("NONE"),           
   .MREG(0),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_2 
  (
      .BCOUT(BCOUT2),  // 18-bit B cascade output
      .P(div2),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A(18'b0),          // 18-bit A data input
      .B(18'b0),          // 18-bit B data input
      .BCIN(BCOUT1),    // 18-bit B cascade input
      .C(CIN_2),          // 48-bit cascade input
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
      .OPMODE(7'b0110011), // 7-bit operation mode input
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
   defparam DSP48_2.AREG = 0; 
   defparam DSP48_2.BREG = 2; 
   defparam DSP48_2.B_INPUT = "CASCADE"; 
   defparam DSP48_2.CARRYINREG = 0; 
   defparam DSP48_2.CARRYINSELREG = 0; 
   defparam DSP48_2.CREG = 0; 
   defparam DSP48_2.LEGACY_MODE = "NONE"; 
   defparam DSP48_2.MREG = 0; 
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
       div2_reg4 <= 1'b0; div2_reg5 <= 1'b0;  end
   else 
       begin
       div2_reg1 <= !div2[47];
       div2_reg2 <= div2_reg1;
       div2_reg3 <= div2_reg2;
       div2_reg4 <= div2_reg3;
       div2_reg5 <= div2_reg4;
       end
   end

//          
// Instantiation block 3
//
DSP48 #(
   .AREG(0),           
   .BREG(2),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("NONE"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_3 
  (
      .BCOUT(BCOUT3),  // 18-bit B cascade output
      .P(div3),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A(18'b0),          // 18-bit A data input
      .B(18'b0),          // 18-bit B data input
      .BCIN(BCOUT2),    // 18-bit B cascade input
      .C(CIN_3),          // 48-bit cascade input
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
      .OPMODE(7'b0110011), // 7-bit operation mode input
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
   defparam DSP48_3.AREG = 0; 
   defparam DSP48_3.BREG = 2; 
   defparam DSP48_3.B_INPUT = "CASCADE"; 
   defparam DSP48_3.CARRYINREG = 0; 
   defparam DSP48_3.CARRYINSELREG = 0; 
   defparam DSP48_3.CREG = 0; 
   defparam DSP48_3.LEGACY_MODE = "NONE"; 
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
	 div3_reg3 <= 1'b0;  end
   else 
       begin
       div3_reg1 <= !div3[47];
       div3_reg2 <= div3_reg1;
       div3_reg3 <= div3_reg2;
	 
       end
   end

//          
// Instantiation block 4
//
DSP48 #(
   .AREG(0),           
   .BREG(2),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("NONE"),           
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
      .A(18'b0),          // 18-bit A data input
      .B(18'b0),          // 18-bit B data input
      .BCIN(BCOUT3),    // 18-bit B cascade input
      .C(CIN_4),          // 48-bit cascade input
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
      .OPMODE(7'b0110011), // 7-bit operation mode input
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
   defparam DSP48_4.AREG = 0; 
   defparam DSP48_4.BREG = 2; 
   defparam DSP48_4.B_INPUT = "CASCADE"; 
   defparam DSP48_4.CARRYINREG = 0; 
   defparam DSP48_4.CARRYINSELREG = 0; 
   defparam DSP48_4.CREG = 0; 
   defparam DSP48_4.LEGACY_MODE = "NONE"; 
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
       div4_reg1 <= 1'b0;  
	 end
   else 
       begin
       div4_reg1 <= !div4[47];
      
       end
   end




always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       Q_OUT <= 4'b0;  R_OUT <= 4'b0; end
   else 
       begin
       Q_OUT <= {div1_reg7,div2_reg5, div3_reg3,div4_reg1};
	    R_OUT <= CIN_4_REG2; 
       end
   end



endmodule	  
//
////////////////////////////////////////////////////////////////////////////////////





