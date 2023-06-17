//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: COMPLEX_MULT_PIPE 
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
////////////////////////////////////////////////////////////////////////////////////
//
// Module: COMPLEX_MULT_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// complex multiplier. Macro uses 4 slices, 2 slices 
// used to get the real part of the product and 2 
// slices to get the imaginary part of the product.
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module COMPLEX_MULT_PIPE (CLK, RST, A_REAL, B_REAL, A_IMAGINARY, B_IMAGINARY,
                          PROD_REAL, PROD_IMAGINARY);
	
input            CLK, RST;
input   [17:0]   A_REAL, B_REAL, A_IMAGINARY, B_IMAGINARY;
output  [47:0]   PROD_REAL, PROD_IMAGINARY;

wire    [47:0]   PCOUT_1, PCOUT_3;


//          
// Real Product Instantiation block 1
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
    .A(A_REAL),            // Input A to Multiplier
    .B(B_REAL),            // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),          //
    .PCIN(48'b0),          //
    .OPMODE(7'b0000101),   //
    .SUBTRACT(1'b0),       //
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
    .CECINSUB(1'b1),       //
    .RSTA(RST),            //
    .RSTB(RST),            //
    .RSTC(RST),            //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(),                  //
    .PCOUT(PCOUT_1)        //
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
// Real Product Instantiation block 2
//

DSP48 #(
   .AREG(2),           
   .BREG(2),           
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
DSP48_2 
  (
    .A(A_IMAGINARY),       // Input A to Multiplier
    .B(B_IMAGINARY),       // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),          //
    .PCIN(PCOUT_1),        //
    .OPMODE(7'b0010101),   //
    .SUBTRACT(1'b1),       //
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
    .CECINSUB(1'b1),       //
    .RSTA(RST),            //
    .RSTB(RST),            //
    .RSTC(RST),            //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(PROD_REAL),         //
    .PCOUT()               //
  );

/*
//synthesis translate_off 
   defparam DSP48_2.AREG = 2; 
   defparam DSP48_2.BREG = 2; 
   defparam DSP48_2.B_INPUT = "DIRECT"; 
   defparam DSP48_2.CARRYINREG = 0; 
   defparam DSP48_2.CARRYINSELREG = 0; 
   defparam DSP48_2.CREG = 0; 
   defparam DSP48_2.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_2.MREG = 1; 
   defparam DSP48_2.OPMODEREG = 0; 
   defparam DSP48_2.PREG = 1; 
   defparam DSP48_2.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

//          
// Imaginary Product Instantiation block 3
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
DSP48_3 
  (
    .A(A_REAL),            // Input A to Multiplier
    .B(B_IMAGINARY),       // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),          //
    .PCIN(48'b0),          //
    .OPMODE(7'b0000101),   //
    .SUBTRACT(1'b0),       //
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
    .CECINSUB(1'b1),       //
    .RSTA(RST),            //
    .RSTB(RST),            //
    .RSTC(RST),            //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(),                  //
    .PCOUT(PCOUT_3)        //
  );

/*
//synthesis translate_off 
   defparam DSP48_3.AREG = 1; 
   defparam DSP48_3.BREG = 1; 
   defparam DSP48_3.B_INPUT = "DIRECT"; 
   defparam DSP48_3.CARRYINREG = 0; 
   defparam DSP48_3.CARRYINSELREG = 0; 
   defparam DSP48_3.CREG = 0; 
   defparam DSP48_3.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_3.MREG = 1; 
   defparam DSP48_3.OPMODEREG = 0; 
   defparam DSP48_3.PREG = 1; 
   defparam DSP48_3.SUBTRACTREG = 0; 
//synthesis translate_on 
*/


//          
// Imaginary Product Instantiation block 4
//
DSP48 #(
   .AREG(2),           
   .BREG(2),           
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
DSP48_4 
  (
    .A(A_IMAGINARY),       // Input A to Multiplier
    .B(B_REAL),            // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),          //
    .PCIN(PCOUT_3),        //
    .OPMODE(7'b0010101),   //
    .SUBTRACT(1'b0),       //
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
    .CECINSUB(1'b1),       //
    .RSTA(RST),            //
    .RSTB(RST),            //
    .RSTC(RST),            //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(PROD_IMAGINARY),    //
    .PCOUT()               //
  );


/*
//synthesis translate_off 
   defparam DSP48_4.AREG = 2; 
   defparam DSP48_4.BREG = 2; 
   defparam DSP48_4.B_INPUT = "DIRECT"; 
   defparam DSP48_4.CARRYINREG = 0; 
   defparam DSP48_4.CARRYINSELREG = 0; 
   defparam DSP48_4.CREG = 0; 
   defparam DSP48_4.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_4.MREG = 1; 
   defparam DSP48_4.OPMODEREG = 0; 
   defparam DSP48_4.PREG = 1; 
   defparam DSP48_4.SUBTRACTREG = 0; 
//synthesis translate_on 
*/

//
////////////////////////////////////////////////////////////////////////////////////

endmodule




