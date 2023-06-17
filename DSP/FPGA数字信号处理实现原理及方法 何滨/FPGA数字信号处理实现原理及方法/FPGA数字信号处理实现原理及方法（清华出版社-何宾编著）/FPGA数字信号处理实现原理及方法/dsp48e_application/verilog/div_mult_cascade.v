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
module div_mult_cascade (CLK, RST, NUMERATOR_IN,  DENOMINATOR_IN, Q_OUT, R_OUT);
	
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
   .CARRYINSELREG(1),  
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
   .P(div1),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, DENOMINATOR_IN}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, 4'b1000}),          
   .BCIN(18'b0),    
   .C({44'b0, NUMERATOR_IN_REG1}),          
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
   .CARRYINSELREG(1),  
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
   .P(div2),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, DENOMINATOR_IN_REG3}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, !div1[47], 3'b100}),          
   .BCIN(18'b0),    
   .C({44'b0, NUMERATOR_IN_REG4}),          
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
   .CARRYINSELREG(1),  
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
   .P(div3),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, DENOMINATOR_IN_REG6}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, div1_reg3, !div2[47], 2'b10}),          
   .BCIN(18'b0),    
   .C({44'b0, NUMERATOR_IN_REG7}),          
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
   .CARRYINSELREG(1),  
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
   .P(div4),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, DENOMINATOR_IN_REG9}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, div1_reg6, div2_reg3, !div3[47], 1'b1}),          
   .BCIN(18'b0),    
   .C({44'b0, NUMERATOR_IN_REG10}),          
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
   .CARRYINSELREG(1),  
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
DSP48E_5 (
   .ACOUT(),   
   .BCOUT(),  
   .CARRYCASCOUT(), 
   .CARRYOUT(), 
   .MULTSIGNOUT(), 
   .OVERFLOW(), 
   .P(remain),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A({26'b0, DENOMINATOR_IN_REG12}),          
   .ACIN(30'b0),    
   .ALUMODE(4'b0011), 
   .B({14'b0, div1_reg9, div2_reg6, div3_reg3, !div4[47]}),          
   .BCIN(18'b0),    
   .C({44'b0, NUMERATOR_IN_REG13}),          
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





