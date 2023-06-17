**********************************************************************
**  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are
**              provided to you "as is". Xilinx and its licensors make and you
**              receive no warranties or conditions, express, implied,
**              statutory or otherwise, and Xilinx specifically disclaims any
**              implied warranties of merchantability, non-infringement,or
**              fitness for a particular purpose. Xilinx does not warrant that
**              the functions contained in these designs will meet your
**              requirements, or that the operation of these designs will be
**              uninterrupted or error free, or that defects in the Designs
**              will be corrected. Furthermore, Xilinx does not warrantor
**              make any representations regarding use or the results of the
**              use of the designs in terms of correctness, accuracy,
**              reliability, or otherwise.
**
**              LIMITATION OF LIABILITY. In no event will Xilinx or its
**              licensors be liable for any loss of data, lost profits,cost
**              or procurement of substitute goods or services, or for any
**              special, incidental, consequential, or indirect damages
**              arising from the use or operation of the designs or
**              accompanying documentation, however caused and on any theory
**              of liability. This limitation will apply even if Xilinx
**              has been advised of the possibility of such damage. This
**              limitation shall apply not-withstanding the failure of the
**              essential purpose of any limited remedies herein.
**
**  Copyright (c) 2003 Xilinx, Inc.
**  All rights reserved
**
******************************************************************************

Revision Note 

July 12, 2005. Updated Fully Pipelined 35x35 Multiplier codes. The codes are
mult35x35_parallel_pipe.v 
mult35x35_parallel_pipe.vhd

August 05, 2005. Updated HDL files for the counter. Set CEC, CECTRL, CECINSUB to 1.
Corrected OPMODE and ADD_SUB definition according to the counter section description in Chapter 2

August 11, 2005. Updated HDL files for accum48, mult35x18_sequential_pipe, and mult35x35_sequential_pipe.
Corrected LEGACY attribute to mult18x18 when MREG is 0

November 27, 2005. Added div_sub_cascade.* files.

January 30, 2006. Remeoved SIM_X_INPUT attribute from the VHDL and Verilog files.

March 10, 2006. Registered OPMODE and SUBTRACT inputs of the DSP48 in the cntr_load.v and cntr_load.vhd files.

May26, 2006. Changed the attribute passing statements in the Verilog codes.
	     Fixed functional error in fast_sqrt_mult_cascade files.
January 27, 2007 Changed the Barrelshifter code to include 17 bit shifting. This was done by using the SUBTRACT input.
******************************************************************************
basic math function zip (ug073_c02.zip) file contains 


Loadable counter design

	cntr_load.v
	cntr_load.vhd
	cntr_load.ucf

Division using multiplier (DSP48 connected in cascaded mode)
	
	div_mult_cascade.v
	div_mult_cascade.vhd
	div_mult_cascade.ucf

Division using subtrater (DSP48 connected in cascaded mode)
	
	div_sub_cascade.v
	div_sub_cascade.vhd
	div_sub_cascade.ucf

Square root using multiplier (DSP48 connected in cascaded mode)

	sqrt_mult_cascade.v
	sqrt_mult_cascade.vhd
	sqrt_mult_cascade.ucf


The verilog and vhdl synthesized and places and routed using Foundation 6.2.03i, Application 
version G-31. XST ws used for synthesis. All other synthesis and PAR settings were set to  
default.