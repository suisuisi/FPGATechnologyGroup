//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: MULT35X18_SEQUENTIAL_PIPE 
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
// Module: MULT35X18_SEQUENTIAL_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// 35 x 18 sequential multiplier. The macro uses 1 DSP
// slices.  
//
// Dynamic OPMODE. OPMODE is an input signal for the macro.
// External muxing logic required to make dynamic changes on the
// A_IN and B_IN input registers. Muxing circuit chooses A_IN and
// B_IN when OPMODE[7] = 0 to implement the 1st cycle. A_IN and
// B_IN through 1 register is chosen when OPMODE[7] = 1.
//
// OPMODE for 1st cycle = 0000101. OPMODE for 2nd cycle = 1100101.
//
// The 17 bit output from the 1st cycle is stored in a register till
// the output from the 2nd cycle is available. The 53bit final output is 
// then available at the PROD_OUT output pin.
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module MULT35X18_SEQUENTIAL_PIPE (CLK, RST, A_IN, B_IN, PROD_OUT);
	
input           CLK, RST;
input   [34:0]  A_IN;
input   [17:0]  B_IN;
//input   [6:0]   OPMODE;
output  [52:0]  PROD_OUT;


reg[34:0] A_IN_REG;
reg[17:0] B_IN_REG;
reg    [17:0]   SEL_A, SEL_B;
reg     [16:0]   POUT_REG1;
wire    [47:0]   POUT;
reg[6:0] OPMODE, OPMODE_REG;
wire[34:0] A_IN_WIRE;
wire[17:0] B_IN_WIRE;
reg[1:0] cntr4;
reg  [52:0]  PROD_OUT;


// Register inputs A1_IN and B_IN.

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       cntr4 <= 2'b11;
       end
   else if (cntr4 < 2'b11)
       begin
       cntr4 <= cntr4 + 1;
       end
   else 
       begin
       cntr4 <= 2'b00;
       end
   end

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       A_IN_REG <= 18'b0; B_IN_REG <= 18'b0;
       end
   else if (cntr4[0] == 1'b1)
       begin
       A_IN_REG <= A_IN; B_IN_REG <= B_IN;
       end
   else 
       begin
       A_IN_REG <= A_IN_REG; B_IN_REG <= B_IN_REG;
       end
   end

assign A_IN_WIRE = A_IN_REG;
assign B_IN_WIRE = B_IN_REG;

always @ (posedge RST or posedge CLK)
begin
    if (RST)
       begin  
         SEL_A <= 9'b0; SEL_B <= 1'b0; OPMODE <= 7'b0; 
       end
    else 
       begin
       case (cntr4[0])
       1'b1: begin 
              SEL_A <= ({"0", A_IN_WIRE[16:0]}); 
              SEL_B <= (B_IN_WIRE[17:0]); 
              OPMODE <= 7'b1100101; 
              end
       1'b0: begin 
              SEL_A <= A_IN_WIRE[34:17]; 
              SEL_B <= (B_IN_WIRE[17:0]); 
              OPMODE <= 7'b0000101; 
              end
       endcase
       end
end


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       OPMODE_REG <= 7'b0;
       end
   else
       begin
       OPMODE_REG <= OPMODE;
       end
   end

// Product[16:0], cycle1; Product[52:17] cycle 2
//
DSP48 #(
   .AREG(0),           
   .BREG(0),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("MULT18X18"),           
   .MREG(0),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_1 
  (
    .A(SEL_A),        // Input A to Multiplier
    .B(SEL_B),              // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),           //
    .PCIN(48'b0),           //
    .OPMODE(OPMODE_REG),   //
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
    .P(POUT),         //
    .PCOUT()               //
  );

/*
//synthesis translate_off 
   defparam DSP48_1.AREG = 0; 
   defparam DSP48_1.BREG = 0; 
   defparam DSP48_1.B_INPUT = "DIRECT"; 
   defparam DSP48_1.CARRYINREG = 0; 
   defparam DSP48_1.CARRYINSELREG = 0; 
   defparam DSP48_1.CREG = 0; 
   defparam DSP48_1.LEGACY_MODE = "MULT18X18"; 
   defparam DSP48_1.MREG = 0; 
   defparam DSP48_1.OPMODEREG = 0; 
   defparam DSP48_1.PREG = 1; 
   defparam DSP48_1.SUBTRACTREG = 0; 
//synthesis translate_on 
*/


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin POUT_REG1 <= 17'b0; end
   else 
       begin POUT_REG1 <= POUT[16:0]; end       
   end


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin PROD_OUT <= 53'b0; end
   else if (cntr4 == 2'b00)
       begin PROD_OUT <= {POUT[35:0],POUT_REG1}; end   
   else     
       begin PROD_OUT <= PROD_OUT; end   
   end


//assign PROD_OUT = {POUT[35:0],POUT_REG1};

//
////////////////////////////////////////////////////////////////////////////////////

endmodule


