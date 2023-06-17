//------------------------------------------------------------------------------ 
// Copyright (c) 2004 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Vendor: Xilinx 
// \   \   \/    Author: Latha Pillai, Advanced Product Group, Xilinx, Inc.
//  \   \        Filename: MULT35X35_PARALLEL_PIPE 
//  /   /        Date Last Modified: JUNE 02, 2005 
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
// Module: MULT35X35_PARALLEL_PIPE
//
// Description: Verilog instantiation template for 
// DSP48 embedded MAC blocks arranged as a pipelined
// 35 x 35 multiplier. The macro uses 4 DSP
// slices . Product[16:0] done in slice1, product[33:17
// done in slice3 and product[69:34] done in slice4.
//
// Device: Whitney Family
//
// Copyright (c) 2000 Xilinx, Inc.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////


module MULT35X35_PARALLEL_PIPE (CLK, RST, A_IN, B_IN, PROD_OUT);
	
	
input           CLK, RST;
input   [34:0]  A_IN, B_IN;
output  [69:0]  PROD_OUT;


wire    [17:0]  BCOUT_1, BCOUT_3;
wire    [47:0]  PCOUT_1, PCOUT_2, PCOUT_3; 
wire    [47:0]  POUT_1, POUT_3, POUT_4;
reg     [16:0]  POUT_1_REG1, POUT_1_REG2, POUT_1_REG3, POUT_3_REG1;

reg     [16:0]  A_IN_3_REG1;
reg     [17:0]  A_IN_4_REG1, A_IN_4_REG2, B_IN_3_REG1;
wire    [34:0]  A_IN_WIRE, B_IN_WIRE;
//          
// Product[16:0] Instantiation block 1
//

assign A_IN_WIRE = A_IN;
assign B_IN_WIRE = B_IN;

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
DSP48_1(
    .A({1'b0,A_IN_WIRE[16:0]}), // Input A to Multiplier
    .B({1'b0,B_IN_WIRE[16:0]}), // Input B to Multiplier
    .C(48'b0),                 // Input C to Adder
    .BCIN(18'b0),              //
    .PCIN(48'b0),              //
    .OPMODE(7'b0000101),       //
    .SUBTRACT(1'b0),           //
    .CARRYIN(1'b0),            //
    .CARRYINSEL(2'b00),        //
    .CLK(CLK),                 //
    .CEA(1'b1),                //
    .CEB(1'b1),                //
    .CEC(1'b0),                //
    .CEP(1'b1),                //
    .CEM(1'b1),                //
    .CECTRL(1'b0),             //
    .CECARRYIN(1'b0),          //
    .CECINSUB(1'b1),           //
    .RSTA(RST),                //
    .RSTB(RST),                //
    .RSTC(1'b0),               //
    .RSTP(RST),                //
    .RSTM(RST),                //
    .RSTCTRL(RST),             //
    .RSTCARRYIN(RST),          //
    .BCOUT(BCOUT_1),           //
    .P(POUT_1),                //
    .PCOUT(PCOUT_1)            //
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
always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin POUT_1_REG1 <= 17'b0; 
             POUT_1_REG2 <= 17'b0; 
             POUT_1_REG3 <= 17'b0; end

   else 
       begin POUT_1_REG1 <= POUT_1[16:0];        
             POUT_1_REG2 <= POUT_1_REG1;  
             POUT_1_REG3 <= POUT_1_REG2; end       
     
   end

assign PROD_OUT[16:0] = POUT_1_REG3; 



//          
// Instantiation block 2
//
DSP48 #(
   .AREG(2),           
   .BREG(1),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0) 
) 
DSP48_2(
    .A(A_IN[34:17]),       // Input A to Multiplier
    .B(18'b0),             // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(BCOUT_1),        //
    .PCIN(PCOUT_1),        //
    .OPMODE(7'b1010101),   //
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
    .RSTC(1'b0),           //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(),                  //
    .PCOUT(PCOUT_2)        //
  );
/*
//synthesis translate_off 
   defparam DSP48_2.AREG = 2;                   
   defparam DSP48_2.BREG = 1
   defparam DSP48_2.B_INPUT = "CASCADE";        
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
// Product[33:17] Instantiation block 3
//


always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin A_IN_3_REG1 <= 17'b0; 
             B_IN_3_REG1 <= 17'b0; end
   else 
       begin A_IN_3_REG1 <= (A_IN_WIRE[16:0]);        
             B_IN_3_REG1 <= B_IN_WIRE[34:17]; end 
   end

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
DSP48_3(
    .A({1'b0,A_IN_3_REG1}),       // Input A to Multiplier
    .B(B_IN_3_REG1),       // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(18'b0),          //
    .PCIN(PCOUT_2),        //
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
    .RSTC(1'b0),           //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(BCOUT_3),       //
    .P(POUT_3),            //
    .PCOUT(PCOUT_3)        //
  );

/*
//synthesis translate_off 
   defparam DSP48_3.AREG = 2;                   
   defparam DSP48_3.BREG = 2;                   
   defparam DSP48_3.B_INPUT = "DIRECT";         
   defparam DSP48_3.CARRYINREG = 0;             
   defparam DSP48_3.CARRYINSELREG = 0;          
   defparam DSP48_3.CREG = 0;                   
   defparam DSP48_3.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_3.MREG = 1;                   
   defparam DSP48_3.OPMODEREG = 0;              
   defparam DSP48_3.PREG = 1;                   
   defparam DSP48_1.SUBTRACTREG = 0;            
//synthesis translate_on 
*/
always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin POUT_3_REG1 <= 17'b0; end
   else 
       begin POUT_3_REG1 <= POUT_3[16:0]; end       
   end

assign PROD_OUT[33:17] = POUT_3_REG1;

//          
// Product[69:34] Instantiation block 4
//

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin A_IN_4_REG1 <= 17'b0; 
             A_IN_4_REG2 <= 17'b0; end

   else 
       begin A_IN_4_REG1 <= A_IN[34:17];        
             A_IN_4_REG2 <= A_IN_4_REG1; end           
   end
 
DSP48 #(
   .AREG(2),           
   .BREG(1),           
   .B_INPUT("CASCADE"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(0), 
   .LEGACY_MODE("MULT18X18S"),           
   .MREG(1),           
   .OPMODEREG(0),      
   .PREG(1),           
   .SUBTRACTREG(0)
) 
DSP48_4(
    .A(A_IN_4_REG2),       // Input A to Multiplier
    .B(18'b0),             // Input B to Multiplier
    .C(48'b0),             // Input C to Adder
    .BCIN(BCOUT_3),        //
    .PCIN(PCOUT_3),        //
    .OPMODE(7'b1010101),   //
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
    .RSTC(1'b0),           //
    .RSTP(RST),            //
    .RSTM(RST),            //
    .RSTCTRL(RST),         //
    .RSTCARRYIN(RST),      //
    .BCOUT(),              //
    .P(POUT_4),            //
    .PCOUT()               //
  );

/*
//synthesis translate_off 
   defparam DSP48_4.AREG = 2;                   
   defparam DSP48_4.BREG = 1;                   
   defparam DSP48_4.B_INPUT = "CASCADE";        
   defparam DSP48_4.CARRYINREG = 0;             
   defparam DSP48_4.CARRYINSELREG = 0;          
   defparam DSP48_4.CREG = 0;                   
   defparam DSP48_4.LEGACY_MODE = "MULT18X18S"; 
   defparam DSP48_4.MREG = 1;                   
   defparam DSP48_4.OPMODEREG = 0;              
   defparam DSP48_4.PREG = 1;                   
   defparam DSP48_1.SUBTRACTREG = 0;            
//synthesis translate_on 
*/
assign PROD_OUT[69:34] = POUT_4[35:0];

endmodule

