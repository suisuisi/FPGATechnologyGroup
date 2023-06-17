//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: CNTR_LOAD
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


module CNTR_LOAD (CLK, RST, C_IN,  LOAD, ADD_SUB, CNTR_OUT);
	
input           CLK, RST;
input   [47:0]  C_IN;
input   LOAD; // 1 => output = C_IN +1, 0 => output = P + 1;
input           ADD_SUB; // 0 = up counter, 1 = down counter
output  [47:0]  CNTR_OUT;

reg[47:0]  CNTR_OUT;
wire[47:0] CNTR_OUT_INT;
wire[6:0] OPMODE;
reg LOAD_REG, ADD_SUB_REG;
reg[47:0] C_IN_REG;
//          
// Instantiation block 1
//

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin LOAD_REG <= 1'b0; end
   else  
       begin LOAD_REG <= LOAD; end  
   end

//assign OPMODE = {1'b0, 1’b1, LOAD_REG,4'b0000};


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin ADD_SUB_REG <= 1'b0; end
   else  
       begin ADD_SUB_REG <= ADD_SUB; end  
   end

/* register C_IN input */

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin C_IN_REG <= 48'b0; end
   else         
       begin C_IN_REG <= C_IN; end  
   end


/* behavioral model */
/*always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin CNTR_OUT <= 47'b0; end
   else 
      case ({LOAD,ADD_SUB})
        2'b00: CNTR_OUT <= (CNTR_OUT - 1'b1); 
        2'b01: CNTR_OUT <= (CNTR_OUT + 1'b1);
        2'b10: CNTR_OUT <= (C_IN - 1'b1);
        2'b11: CNTR_OUT <= (C_IN + 1'b1);
      endcase       
   end	   */


//          
// Instantiation block 1
//

DSP48 #(
   .AREG(0),           
   .BREG(0),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(1),      
   .PREG(1),           
   .SUBTRACTREG(1) 
) 
DSP48_1 
  (
      .BCOUT(),  // 18-bit B cascade output
      .P(CNTR_OUT_INT),          // 48-bit product output
      .PCOUT(),  // 38-bit cascade output
      .A(18'b0),          // 18-bit A data input
      .B(18'b0),          // 18-bit B data input
      .BCIN(18'b0),    // 18-bit B cascade input
      .C(C_IN_REG),          // 48-bit cascade input
      .CARRYIN(1'b1), // Carry input signal
      .CARRYINSEL(2'b00), // 2-bit carry input select
      .CEA(1'b1),      // A data clock enable input
      .CEB(1'b1),      // B data clock enable input
      .CEC(1'b1),      // C data clock enable input
      .CECARRYIN(1'b0), // CARRYIN clock enable input
      .CECINSUB(1'b1), // CINSUB clock enable input
      .CECTRL(1'b1), // Clock Enable input for CTRL registers
      .CEM(1'b1),       // Clock Enable input for multiplier registers
      .CEP(1'b1),       // Clock Enable input for P registers
      .CLK(CLK),       // Clock input
      .OPMODE({1'b0,1'b1,LOAD_REG,4'b0000}), // 7-bit operation mode input
      .PCIN(48'b0),     // 48-bit PCIN input
      .RSTA(RST),     // Reset input for A pipeline registers
      .RSTB(RST),     // Reset input for B pipeline registers
      .RSTC(RST),     // Reset input for C pipeline registers
      .RSTCARRYIN(RST), // Reset input for CARRYIN registers
      .RSTCTRL(RST), // Reset input for CTRL registers
      .RSTM(RST), // Reset input for multiplier registers
      .RSTP(RST), // Reset input for P pipeline registers
      .SUBTRACT(ADD_SUB_REG) // SUBTRACT input
   );
  
/*
  //synthesis translate_off
   defparam DSP48_1.AREG = 0; 
   defparam DSP48_1.BREG = 0; 
   defparam DSP48_1.B_INPUT = "DIRECT"; 
   defparam DSP48_1.CARRYINREG = 0; 
   defparam DSP48_1.CARRYINSELREG = 0; 
   defparam DSP48_1.CREG = 1; 
   defparam DSP48_1.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_1.MREG = 1; 
   defparam DSP48_1.OPMODEREG = 1; 
   defparam DSP48_1.PREG = 1; 
   defparam DSP48_1.SUBTRACTREG = 1;
   //synthesis translate_on
*/

   // End of DSP48_1 instantiation 

/* register output */

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin CNTR_OUT <= 48'b0; end
   else         
       begin CNTR_OUT <= CNTR_OUT_INT; end  
   end
////////////////////////////////////////////////////////////////////////////////

endmodule


