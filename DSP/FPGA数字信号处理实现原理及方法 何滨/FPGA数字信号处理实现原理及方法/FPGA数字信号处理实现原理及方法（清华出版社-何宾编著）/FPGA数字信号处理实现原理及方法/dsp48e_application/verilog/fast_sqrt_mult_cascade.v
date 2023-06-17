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


module fast_sqrt_mult_cascade (CLK, RST, X_IN, SQRT_OUT);
	
input           CLK, RST;
input   [7:0]  X_IN; 
output  [4:0]  SQRT_OUT;

reg[4:0] SQRT_OUT;

reg[3:0] Reg_A; 
wire[47:0] sub1, sub2, sub3, sub4;

reg[3:0] cntr8;
reg[1:0] cntr3;
reg[3:0] cntr_set;
reg set_bit;
reg[5:0] cntr32;
reg sub1_reg1 , sub1_reg2 , sub1_reg3 , sub1_reg4, sub1_reg5,
    sub1_reg6, sub1_reg7, sub1_reg8, sub1_reg9, sub1_reg10,
    sub1_reg11, sub1_reg12, sub1_reg13;
reg sub2_reg1 , sub2_reg2 , sub2_reg3, sub2_reg4, sub2_reg5, 
    sub2_reg6, sub2_reg7, sub2_reg8, sub2_reg9;
reg sub3_reg1 , sub3_reg2 , sub3_reg3 , sub3_reg4, sub3_reg5;
reg sub4_reg1;
reg[1:0] remain;

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
        Reg_IN1 <= 8'b0; Reg_IN2 <= 8'b0; Reg_IN3 <= 8'b0; Reg_IN4 <= 8'b0; 
        Reg_IN5 <= 8'b0; Reg_IN6 <= 8'b0; Reg_IN7 <= 8'b0; Reg_IN8 <= 8'b0; 
        Reg_IN9 <= 8'b0; Reg_IN10 <= 8'b0; Reg_IN11 <= 8'b0; Reg_IN12 <= 8'b0;
        Reg_IN13 <= 8'b0; Reg_IN14 <= 8'b0; Reg_IN15 <= 8'b0; Reg_IN16 <= 8'b0;
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

DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_1 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(sub1),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, 4'b1000}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, 4'b1000}),          
   .BCIN(18'b0),    
   .C({40'b0, Reg_IN1}),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b0110101), 
   .PCIN(48'b0),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);

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
DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_2 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(sub2),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, sub1_reg1, 3'b100}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, sub1_reg1, 3'b100}),          
   .BCIN(18'b0),    
   .C({40'b0, Reg_IN5}),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b0110101), 
   .PCIN(48'b0),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);

   // End of DSP48_2 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       sub2_reg1 <= 1'b0; sub2_reg2 <= 1'b0; sub2_reg3 <= 1'b0; 
       sub2_reg4 <= 1'b0; sub2_reg5 <= 1'b0; sub2_reg6 <= 1'b0; 
       sub2_reg7 <= 1'b0; sub2_reg8 <= 1'b0; sub2_reg9 <= 1'b0; end
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
DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_3 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(sub3),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, sub1_reg5, sub2_reg1,2'b10}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, sub1_reg5, sub2_reg1,2'b10}),          
   .BCIN(18'b0),    
   .C({40'b0, Reg_IN9}),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b0110101), 
   .PCIN(48'b0),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);
  
   // End of DSP48_3 instantiation 

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin
       sub3_reg1 <= 1'b0; sub3_reg2 <= 1'b0; 
	  sub3_reg3 <= 1'b0; sub3_reg4 <= 1'b0;
	  sub3_reg5 <= 1'b0;end
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
DSP48E #(
   .ACASCREG(1),       
   .ALUMODEREG(1),     
   .AREG(1),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(1),       
   .BREG(1),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(1),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(0),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("MULT_S"), 
   .USE_PATTERN_DETECT("NO_PATDET"), 
   .USE_SIMD("ONE48") 
) 
DSP48E_4 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(sub4),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, sub1_reg9, sub2_reg5, sub3_reg1,1'b1}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, sub1_reg9, sub2_reg5, sub3_reg1,1'b1}),          
   .BCIN(18'b0),    
   .C({40'b0, Reg_IN13}),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b1),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b1),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b1),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE(7'b0110101), 
   .PCIN(48'b0),      
   .RSTA(RST),     
   .RSTALLCARRYIN(RST), 
   .RSTALUMODE(RST), 
   .RSTB(RST),     
   .RSTC(RST),     
   .RSTCTRL(RST), 
   .RSTM(RST), 
   .RSTP(RST) 
);
  
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
       SQRT_OUT <= ({1'b0,sub1_reg13, sub2_reg9, sub3_reg5, sub4_reg1});
       end
   end 

endmodule	  

