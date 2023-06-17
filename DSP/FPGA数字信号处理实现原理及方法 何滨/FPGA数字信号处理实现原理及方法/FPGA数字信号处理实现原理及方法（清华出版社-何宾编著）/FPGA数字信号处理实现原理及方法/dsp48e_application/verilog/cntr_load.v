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


module cntr_load (CLK, RST, C_IN,  LOAD, ADD_SUB, CNTR_OUT);
	
input   CLK, RST;
input [47:0]  C_IN;
input   LOAD; 
input   ADD_SUB; // 0 = up counter, 1 = down counter
output [47:0]  CNTR_OUT;

reg[47:0]  CNTR_OUT;
wire[47:0] CNTR_OUT_INT;
reg LOAD_REG;
reg[47:0] C_IN_REG;

always @ (posedge CLK or posedge RST)
   begin
   if (RST)
       begin LOAD_REG <= 1'b0; end
   else  
       begin LOAD_REG <= LOAD; end  
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

DSP48E #(
   .ACASCREG(0),       
   .ALUMODEREG(1),     
   .AREG(0),           
   .AUTORESET_PATTERN_DETECT("FALSE"), 
   .AUTORESET_PATTERN_DETECT_OPTINV("MATCH"), 
   .A_INPUT("DIRECT"), 
   .BCASCREG(0),       
   .BREG(0),           
   .B_INPUT("DIRECT"), 
   .CARRYINREG(0),     
   .CARRYINSELREG(0),  
   .CREG(1),           
   .MASK(48'h3FFFFFFFFFFF), 
   .MREG(0),           
   .MULTCARRYINREG(0), 
   .OPMODEREG(1),      
   .PATTERN(48'h000000000000), 
   .PREG(1),           
   .SEL_MASK("MASK"),  
   .SEL_PATTERN("PATTERN"), 
   .SEL_ROUNDING_MASK("SEL_MASK"), 
   .USE_MULT("NONE"), 
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
   .P(CNTR_OUT_INT),          
   .PATTERNBDETECT(), 
   .PATTERNDETECT(), 
   .PCOUT(),  
   .UNDERFLOW(), 
   .A(30'b0),          
   .ACIN(30'b0),    
   .ALUMODE({2'b00, ADD_SUB, ADD_SUB}), 
   .B(18'b0),          
   .BCIN(18'b0),    
   .C(C_IN_REG),          
   .CARRYCASCIN(1'b0), 
   .CARRYIN(1'b0), 
   .CARRYINSEL(3'b0), 
   .CEA1(1'b0),      
   .CEA2(1'b0),      
   .CEALUMODE(1'b1), 
   .CEB1(1'b0),      
   .CEB2(1'b0),      
   .CEC(1'b1),      
   .CECARRYIN(1'b0), 
   .CECTRL(1'b1), 
   .CEM(1'b0),       
   .CEMULTCARRYIN(1'b0),
   .CEP(1'b1),       
   .CLK(CLK),       
   .MULTSIGNIN(1'b0), 
   .OPMODE({1'b0,1'b1,LOAD_REG,4'b1000}), 
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


