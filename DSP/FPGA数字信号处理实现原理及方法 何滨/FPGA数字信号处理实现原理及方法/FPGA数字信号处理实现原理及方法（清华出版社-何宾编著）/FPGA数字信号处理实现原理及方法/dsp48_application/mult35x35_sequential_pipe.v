//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: MULT35X35_SEQUENTIAL_PIPE 
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
// Module: MULT35X35_SEQUENTIAL_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// 35 x 35 sequential multiplier. The macro uses 1 DSP
// slices.  
//
// Dynamic OPMODE. OPMODE is an input signal for the macro.
// External muxing logic required to make dynamic changes on the
// A_IN and B_IN input registers. 
// ToggleA signal switches every clock cycle choosing A[16:0] when 
// toggleA =0 and choosing A[34:17] when toggleA = 1. ToggleB
// switches everytime toggleA = 0. The B input is B[16:0] when toggleB =0
// and A[34:17] when toggleB = 1.
//
// OPMODE for 1st cycle = 0000101. OPMODE for 2nd cycle = 1100101.
// OPMODE for 3rd cycle = 0100101. OPMODE for 4th cycle = 1100101.

// Bit [16:0] of the output is available after the 1st clock. Bits[33:17
// is avaiable after the 3rd clock and bit [69:34] is available after the 
// 4th clock.

//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
//


module MULT35X35_SEQUENTIAL_PIPE (CLK, RST, A_IN, B_IN, PROD_OUT);
	
input           CLK, RST;
input   [34:0]  A_IN;
input   [34:0]  B_IN;
output  [69:0]  PROD_OUT;

reg[34:0] A_IN_REG, B_IN_REG;
reg    [17:0]   SEL_A, SEL_B;
reg     [17:0]   POUT_REG1, POUT_REG2, POUT_REG3;
wire    [47:0]   POUT;
reg[6:0] OPMODE;
wire[34:0] A_IN_WIRE, B_IN_WIRE;
reg[2:0] cntr4;
reg  [69:0]  PROD_OUT;

// Register inputs A_IN and B_IN.

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       cntr4 <= 3'b111;
       end
   else if (cntr4 < 3'b111)
       begin
       cntr4 <= cntr4 + 1;
       end
   else 
       begin
       cntr4 <= 3'b000;
       end
   end


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       A_IN_REG <= 18'b0; B_IN_REG <= 18'b0;
       end
   else if (cntr4[1:0] == 2'b11)
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
       case (cntr4[1:0])
       2'b00: begin 
              SEL_A <= ({"0", A_IN_WIRE[16:0]}); 
              SEL_B <= ({"0", B_IN_WIRE[16:0]}); 
              OPMODE <= 7'b0000101;//7'b0000101; 
              end
       2'b01: begin 
              SEL_A <= A_IN_WIRE[34:17]; 
              SEL_B <= ({"0", B_IN_WIRE[16:0]}); 
              OPMODE <= 7'b1100101;//7'b1100101; 
              end
       2'b10: begin 
              SEL_A <= ({"0", A_IN_WIRE[16:0]}); 
              SEL_B <= B_IN_WIRE[34:17]; 
              OPMODE <= 7'b0100101;//7'b0100101; 
              end
       2'b11: begin 
              SEL_A <= A_IN_WIRE[34:17]; 
              SEL_B <= B_IN_WIRE[34:17]; 
              OPMODE <= 7'b1100101;//7'b1100101; 
              end
       endcase
       end
end


// Product[16:0], cycle1; Product[33:17] cycle 3; 
// Product[69:34] cycle 4;
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
    .OPMODE(OPMODE),   //
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



always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin POUT_REG1 <= 18'b0; POUT_REG2 <= 18'b0; POUT_REG3 <= 18'b0;end
   else 
       begin POUT_REG1 <= POUT[17:0]; 
	         POUT_REG2 <= POUT_REG1;
			 POUT_REG3 <= POUT_REG2;end       

   end


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin PROD_OUT <= 70'b0; end
   else if (cntr4[1:0] == 2'b01)
       begin PROD_OUT <= {POUT[35:0],POUT_REG1[16:0],POUT_REG3[16:0]};end   
   else     
       begin PROD_OUT <= PROD_OUT; end   
   end

//assign PROD_OUT = {POUT[35:0],POUT_REG1[16:0],POUT_REG3[16:0]};

//
////////////////////////////////////////////////////////////////////////////////////

endmodule



