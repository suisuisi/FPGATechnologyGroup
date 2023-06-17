//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: MACC 
//  /   /        Date Last Modified:  OCTOBER 05, 2004 
// /___/   /\    Date Created: OCTOBER 05, 2004 
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
//
// Module: MACC
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a single
// MACC unit. The macro uses 1 DSP slice. 
// The output is P + A*B when ADD_SUB = 0 and
// P - A*B when ADD_SUB = 1;. 
// 
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module MACC (CLK, RST, A_IN, B_IN, ADD_SUB, PROD_OUT);
	
input           CLK, RST;
input   [17:0]  A_IN;
input   [17:0]  B_IN;
input           ADD_SUB;
output  [47:0]  PROD_OUT;


//          
// Product[35:0], Instantiation block 1
//
DSP48 #(
   .AREG(1),           
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_1 
  (
    .A(A_IN),        // Input A to Multiplier
    .B(B_IN),              // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),           //
    .PCIN(48'b0),           //
    .OPMODE(7'b0100101),   //
    .SUBTRACT(ADD_SUB),    //
    .CARRYIN(1'b0),        //
    .CARRYINSEL(2'b00),    //
    .CLK(CLK),             //
    .CEA(1'b1),            //
    .CEB(1'b1),            //
    .CEC(1'b0),            //
    .CEP(1'b1),            //
    .CEM(1'b1),            //
    .CECTRL(1'b0),         //
    .CECARRYIN(1'b0),      //
    .CECINSUB(1'b0),       //
    .RSTA(RST),            //
    .RSTB(RST),            //
    .RSTC(RST),            //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(PROD_OUT),         //
    .PCOUT()               //
  );

/*
//synthesis translate_off 
   defparam DSP48_1.AREG = 1; 
   defparam DSP48_1.BREG = 1; 
   defparam DSP48_1.B_INPUT = "DIRECT"; 
   defparam DSP48_1.CARRYINREG = 0; 
   defparam DSP48_1.CARRYINSELREG = 0; 
   defparam DSP48_1.CREG = 0; 
   defparam DSP48_1.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_1.MREG = 1; 
   defparam DSP48_1.OPMODEREG = 0; 
   defparam DSP48_1.PREG = 1; 
   defparam DSP48_1.SUBTRACTREG = 0; 
//synthesis translate_on 
*/


//
////////////////////////////////////////////////////////////////////////////////////

endmodule




