*******************************************************************************
** ©2006—2007 Xilinx, Inc. All Rights Reserved.
** Confidential and proprietary information of Xilinx, Inc. 
*******************************************************************************
**   ____  ____ 
**  /   /\/   / 
** /___/  \  /   Vendor: Xilinx 
** \   \   \/    Version: 1.3
**  \   \        Filename: ug193.zip
**  /   /        Date Last Modified: 11/5/07 
** /___/   /\    Date Created: 5/22/06
** \   \  /  \ 
**  \___\/\___\ 
** 
**  Device: Virtex™-5 FPGA
**  Purpose: Application examples for the DSP48E slice.
**  Reference: Virtex-5 XtremeDSP Design Considerations
**  Revision History: 
**  November 5, 2007 Updated addaccum96.vhd file.New file name is addaccum96.vhd.
**  March 05, 2007 Corrected CEA2 and CEB2 ports on DSP48E_1 in the addaccum96.v and addaccum96.vhd files.Updated addaccum96.vhd file.
**  February 26, 2007 Corrected generic settings for AUTORESET_PATTERN_DETECT, MASK, and PATTERN in the vhdl files. Added design files for mult59x59.
**  February 21, 2007 Corrected signals tempA1 and tempB1 in mult_low_power.vhd
**  January 27, 2007 Changed the Barrelshifter code to include 17 bit shifting. This was done by using the ALUMODE[1:0] inputs.   
*******************************************************************************
**
**  Disclaimer: 
**
**		Xilinx licenses this Design to you “AS-IS” with no warranty of any kind.  
**		Xilinx does not warrant that the functions contained in the Design will 
**		meet your requirements,that the Design will operate uninterrupted or be 
**		error-free, or that errors or bugs in the Design will be corrected.  
**		Xilinx makes no warranties or representations in regard to the results 
**		obtained from your use of the Design with respect to accuracy, reliability, 
**		or otherwise.  
**
**		XILINX MAKES NO REPRESENTATIONS OR WARRANTIES, WHETHER EXPRESS OR IMPLIED, 
**		STATUTORY OR OTHERWISE, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES 
**		OF MERCHANTABILITY, NONINFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. 
**		IN NO EVENT WILL XILINX BE LIABLE FOR ANY LOSS OF DATA, LOST PROFITS, OR FOR 
**		ANY SPECIAL, INCIDENTAL, CONSEQUENTIAL, OR INDIRECT DAMAGES ARISING FROM 
**		YOUR USE OF THIS DESIGN. 

*******************************************************************************

This readme describes how to use the files that come with UG193.

*******************************************************************************

** IMPORTANT NOTES **

1) application.zip contains  the design files for the following applications.

* abs24 – absolute value of  the difference between two 24-bit values
* accum48 – 48-bit accumulator
* add4_46 --  Adding four 46-bit values
* addaccum96 – Add and accumulate a 95-bit value.
* addsub48 – Add or Subtract two 48 bit values
* addsub96 – Add or subtract two 95 bit values
* autoreset_pd – Auto reset a value using the Pattern Detector
* barrelshifter_18bit – 18-bit barrel shifter application
* cntr_load – 48-bit loadable counter
* comp_mult_pipe – Complex pipelined multiplier
* conv_round_cc – Convergent rounding using carry bit
* conv_round_lsb – Convergent rounding using LSB bit
* div_mult_cascade – Division implemented using the multiplier
* dsp_Adder12 – Adding  Four sets of two 12-bit values using SIMD mode
* dsp_Adder24 – Adding  two sets of two 24-bit values using SIMD mode
* dsp_Adder48 – Adding  one set of two 48-bit values using SIMD mode
* fast_sqrt_mult_cascade – Square root function implemented using the multiplier
* logic48 – 48-bit logic function implementation
* mult25x18_parallel_pipe – 25x18 parallel pipelined multiplier
* mult25x35_parallel_pipe – 25x35 parallel pipelined multiplier
* mult35x35_parallel_pipe – 35x35 parallel pipelined multiplier
* mult35x35_sequential_pipe – 35x35 sequential pipelined multiplier

* PolyDecFilter.zip – Polyphase Decimation Function. Behavioral VHDL design files 
* PolyIntrpFilter.zip – Polyphase Interpolation Function. Behavioral VHDL design files

2) The ZIP files contains the following files:

A sample testbench (*_test.v) in verilog for each of the above applications
The Constraint file (*.ucf) for each of the above applications
The Verilog files (*.v) for each of the above applications
The VHDL files (*.vhd) for each of the above applications


***********************************************************************

To incorporate the insert name here module into an ISE design project:

Verilog flow:

1) Use the *.v file along with the *.ucf file

VHDL flow:

1) Use the *.vhd file along with the *.ucf file

The Verilog and VHDL codes were synthesized and placed and routed using  Foundation ISE 8.2i, 
Application version I.31. XST was used for synthesis. All synthesis and PAR settings were set to default. 
The Verilog files were simulated using ModelSim SE 6.1b
