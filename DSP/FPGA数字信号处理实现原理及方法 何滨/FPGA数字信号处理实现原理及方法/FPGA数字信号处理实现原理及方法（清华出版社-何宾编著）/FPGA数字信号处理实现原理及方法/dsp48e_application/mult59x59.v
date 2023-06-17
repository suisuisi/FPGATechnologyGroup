`timescale 1ns / 1ps

module mult59x59 (clk, en, rst, R, S, multout);
    input clk;
    input en;
    input rst;
    input [58:0] R;
    input [58:0] S;
    output [117:0] multout;

//en is not hooked up - since each DSP48E CE pin has a different pipeline depth.



wire one = 1'b1;
wire zero = 1'b0;
reg [58:0] R1,S1,R2,S2,R3,S3,R4,S4,R5,S5,R6,S6,R7,S7,R8,S8,R9,S9; 
wire [47:0] P10,P1,P2,P3,P4,P5,P6,P7,P8,P9; 
wire [47:0] pcout1, pcout2, pcout3, pcout4, pcout5, pcout6, pcout7, pcout8, pcout9;
wire [117:0] multout;
reg [16:0] P1_1,P1_2,P1_3,P1_4,P1_5,P1_6,P1_7,P1_8,P1_9,P3_1,P3_2,P3_3,P3_4,P3_5,P3_6,P3_7,P6_1,P6_2,P6_3,P6_4,P8_1,P8_2,P9_1;

wire [29:0] acout6,acout8,acout9;
wire [17:0] bcout1,bcout3;


assign multout = {P10[32:0],P9_1,P8_1,P6_1,P3_1,P1_1};

always @ (posedge clk) begin
P1_1 <= P1_2;
P1_2 <= P1_3;
P1_3 <= P1_4;
P1_4 <= P1_5;
P1_5 <= P1_6;
P1_6 <= P1_7;
P1_7 <= P1_8;
P1_8 <= P1_9;
P1_9 <= P1[16:0];
P3_1 <= P3_2;
P3_2 <= P3_3;
P3_3 <= P3_4;
P3_4 <= P3_5;
P3_5 <= P3_6;
P3_6 <= P3_7;
P3_7 <= P3[16:0];
P6_1 <= P6_2;
P6_2 <= P6_3;
P6_3 <= P6_4;
P6_4 <= P6[16:0];
P8_1 <= P8_2;
P8_2 <= P8[16:0];
P9_1 <= P9[16:0];
end


always @ (posedge clk) begin
R1 <= R;
S1 <= S;
R2 <= R1;
S2 <= S1;
R3 <= R2;
S3 <= S2;
R4 <= R3;
S4 <= S3;
R5 <= R4;
S5 <= S4;
R6 <= R5;
S6 <= S5;
R7 <= R6;
S7 <= S6;
R8 <= R7;
S8 <= S7;
R9 <= R8;
S9 <= S8;
end

DSP48E DSP48E_1 (
.P(P1),
.ACOUT(),
.BCOUT(bcout1),
.PCOUT(pcout1),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({13'b0000000000000,R[16:0]}),
.B({1'b0,S[16:0]}),
.C(),
.ACIN(),
.BCIN(),
.PCIN(),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b0000101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(zero),
.CEA2(one),
.CEALUMODE(one),
.CEB1(zero),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_1 is "1"
defparam DSP48E_1.AREG = 1;
//synthesis attribute ACASCREG of DSP48E_1 is "1"
defparam DSP48E_1.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_1 is "1"
defparam DSP48E_1.BREG = 1;
//synthesis attribute BCASCREG of DSP48E_1 is "1"
defparam DSP48E_1.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_1 is "1"
defparam DSP48E_1.CREG = 1;
//synthesis attribute MREG of DSP48E_1 is "1"
defparam DSP48E_1.MREG = 1;
//synthesis attribute PREG of DSP48E_1 is "1"
defparam DSP48E_1.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_1 is "1"
defparam DSP48E_1.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_1 is "1"
defparam DSP48E_1.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_1 is "1" 
defparam DSP48E_1.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_1 is "1"
defparam DSP48E_1.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_1 is "1"
defparam DSP48E_1.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_1 is "DIRECT"
defparam DSP48E_1.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_1 is "DIRECT"
defparam DSP48E_1.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_1 is "MULT_S"
defparam DSP48E_1.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_1 is "ONE48"
defparam DSP48E_1.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_1 is 48'hffffffffffff
defparam DSP48E_1.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_1 is 48'h000000000000;
defparam DSP48E_1.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_1 is "PATTERN"
defparam DSP48E_1.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_1 is "MASK"
defparam DSP48E_1.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_1 is "SEL_MASK"
defparam DSP48E_1.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_1 is "FALSE"
defparam DSP48E_1.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_1 is "MATCH"
defparam DSP48E_1.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_1 is "NO_PATDET"
defparam DSP48E_1.USE_PATTERN_DETECT = "NO_PATDET";

DSP48E DSP48E_2 (
.P(P2),
.ACOUT(),
.BCOUT(),
.PCOUT(pcout2),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({13'b0000000000000,R[33:17]}),
.B(),
.C(),
.ACIN(),
.BCIN(bcout1),
.PCIN(pcout1),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b1010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(zero),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_2 is "2"
defparam DSP48E_2.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_2 is "1"
defparam DSP48E_2.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_2 is "1"
defparam DSP48E_2.BREG = 1;
//synthesis attribute BCASCREG of DSP48E_2 is "1"
defparam DSP48E_2.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_2 is "1"
defparam DSP48E_2.CREG = 1;
//synthesis attribute MREG of DSP48E_2 is "1"
defparam DSP48E_2.MREG = 1;
//synthesis attribute PREG of DSP48E_2 is "1"
defparam DSP48E_2.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_2 is "1"
defparam DSP48E_2.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_2 is "1"
defparam DSP48E_2.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_2 is "1" 
defparam DSP48E_2.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_2 is "1"
defparam DSP48E_2.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_2 is "1"
defparam DSP48E_2.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_2 is "DIRECT"
defparam DSP48E_2.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_2 is "CASCADE"
defparam DSP48E_2.B_INPUT = "CASCADE";
//synthesis attribute USE_MULT of DSP48E_2 is "MULT_S"
defparam DSP48E_2.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_2 is "ONE48"
defparam DSP48E_2.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_2 is 48'hffffffffffff
defparam DSP48E_2.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_2 is 48'h000000000000;
defparam DSP48E_2.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_2 is "PATTERN"
defparam DSP48E_2.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_2 is "MASK"
defparam DSP48E_2.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_2 is "SEL_MASK"
defparam DSP48E_2.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_2 is "FALSE"
defparam DSP48E_2.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_2 is "MATCH"
defparam DSP48E_2.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_2 is "NO_PATDET"
defparam DSP48E_2.USE_PATTERN_DETECT = "NO_PATDET";

DSP48E DSP48E_3 (
.P(P3),
.ACOUT(),
.BCOUT(bcout3),
.PCOUT(pcout3),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({13'b0000000000000,R1[16:0]}),
.B({1'b0,S1[33:17]}),
.C(),
.ACIN(),
.BCIN(),
.PCIN(pcout2),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b0010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_3 is "2"
defparam DSP48E_3.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_3 is "1"
defparam DSP48E_3.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_3 is "2"
defparam DSP48E_3.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_3 is "2"
defparam DSP48E_3.BCASCREG = 2;
//synthesis attribute CREG of DSP48E_3 is "1"
defparam DSP48E_3.CREG = 1;
//synthesis attribute MREG of DSP48E_3 is "1"
defparam DSP48E_3.MREG = 1;
//synthesis attribute PREG of DSP48E_3 is "1"
defparam DSP48E_3.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_3 is "1"
defparam DSP48E_3.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_3 is "1"
defparam DSP48E_3.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_3 is "1" 
defparam DSP48E_3.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_3 is "1"
defparam DSP48E_3.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_3 is "1"
defparam DSP48E_3.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_3 is "DIRECT"
defparam DSP48E_3.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_3 is "DIRECT"
defparam DSP48E_3.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_3 is "MULT_S"
defparam DSP48E_3.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_3 is "ONE48"
defparam DSP48E_3.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_3 is 48'hffffffffffff
defparam DSP48E_3.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_3 is 48'h000000000000;
defparam DSP48E_3.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_3 is "PATTERN"
defparam DSP48E_3.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_3 is "MASK"
defparam DSP48E_3.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_3 is "SEL_MASK"
defparam DSP48E_3.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_3 is "FALSE"
defparam DSP48E_3.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_3 is "MATCH"
defparam DSP48E_3.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_3 is "NO_PATDET"
defparam DSP48E_3.USE_PATTERN_DETECT = "NO_PATDET";


DSP48E DSP48E_4 (
.P(P4),
.ACOUT(),
.BCOUT(),
.PCOUT(pcout4),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({13'b0000000000000,R2[33:17]}),
.B(),
.C(),
.ACIN(),
.BCIN(bcout3),
.PCIN(pcout3),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b1010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(zero),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_4 is "2"
defparam DSP48E_4.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_4 is "1"
defparam DSP48E_4.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_4 is "1"
defparam DSP48E_4.BREG = 1;
//synthesis attribute BCASCREG of DSP48E_4 is "1"
defparam DSP48E_4.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_4 is "1"
defparam DSP48E_4.CREG = 1;
//synthesis attribute MREG of DSP48E_4 is "1"
defparam DSP48E_4.MREG = 1;
//synthesis attribute PREG of DSP48E_4 is "1"
defparam DSP48E_4.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_4 is "1"
defparam DSP48E_4.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_4 is "1"
defparam DSP48E_4.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_4 is "1" 
defparam DSP48E_4.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_4 is "1"
defparam DSP48E_4.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_4 is "1"
defparam DSP48E_4.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_4 is "DIRECT"
defparam DSP48E_4.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_4 is "CASCADE"
defparam DSP48E_4.B_INPUT = "CASCADE";
//synthesis attribute USE_MULT of DSP48E_4 is "MULT_S"
defparam DSP48E_4.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_4 is "ONE48"
defparam DSP48E_4.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_4 is 48'hffffffffffff
defparam DSP48E_4.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_4 is 48'h000000000000;
defparam DSP48E_4.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_4 is "PATTERN"
defparam DSP48E_4.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_4 is "MASK"
defparam DSP48E_4.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_4 is "SEL_MASK"
defparam DSP48E_4.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_4 is "FALSE"
defparam DSP48E_4.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_4 is "MATCH"
defparam DSP48E_4.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_4 is "NO_PATDET"
defparam DSP48E_4.USE_PATTERN_DETECT = "NO_PATDET";

DSP48E DSP48E_5 (
.P(P5),
.ACOUT(),
.BCOUT(),
.PCOUT(pcout5),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({5'b00000,R3[58:34]}),
.B({1'b0,S3[16:0]}),
.C(),
.ACIN(),
.BCIN(),
.PCIN(pcout4),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b0010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_5 is "2"
defparam DSP48E_5.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_5 is "1"
defparam DSP48E_5.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_5 is "2"
defparam DSP48E_5.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_5 is "1"
defparam DSP48E_5.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_5 is "1"
defparam DSP48E_5.CREG = 1;
//synthesis attribute MREG of DSP48E_5 is "1"
defparam DSP48E_5.MREG = 1;
//synthesis attribute PREG of DSP48E_5 is "1"
defparam DSP48E_5.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_5 is "1"
defparam DSP48E_5.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_5 is "1"
defparam DSP48E_5.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_5 is "1" 
defparam DSP48E_5.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_5 is "1"
defparam DSP48E_5.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_5 is "1"
defparam DSP48E_5.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_5 is "DIRECT"
defparam DSP48E_5.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_5 is "DIRECT"
defparam DSP48E_5.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_5 is "MULT_S"
defparam DSP48E_5.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_5 is "ONE48"
defparam DSP48E_5.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_5 is 48'hffffffffffff
defparam DSP48E_5.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_5 is 48'h000000000000;
defparam DSP48E_5.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_5 is "PATTERN"
defparam DSP48E_5.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_5 is "MASK"
defparam DSP48E_5.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_5 is "SEL_MASK"
defparam DSP48E_5.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_5 is "FALSE"
defparam DSP48E_5.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_5 is "MATCH"
defparam DSP48E_5.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_5 is "NO_PATDET"
defparam DSP48E_5.USE_PATTERN_DETECT = "NO_PATDET";




DSP48E DSP48E_6 (
.P(P6),
.ACOUT(acout6),
.BCOUT(),
.PCOUT(pcout6),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({5'b00000,S4[58:34]}),
.B({1'b0,R4[16:0]}),
.C(),
.ACIN(),
.BCIN(),
.PCIN(pcout5),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b0010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_6 is "2"
defparam DSP48E_6.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_6 is "2"
defparam DSP48E_6.ACASCREG = 2;
//synthesis attribute BREG of DSP48E_6 is "2"
defparam DSP48E_6.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_6 is "1"
defparam DSP48E_6.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_6 is "1"
defparam DSP48E_6.CREG = 1;
//synthesis attribute MREG of DSP48E_6 is "1"
defparam DSP48E_6.MREG = 1;
//synthesis attribute PREG of DSP48E_6 is "1"
defparam DSP48E_6.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_6 is "1"
defparam DSP48E_6.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_6 is "1"
defparam DSP48E_6.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_6 is "1" 
defparam DSP48E_6.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_6 is "1"
defparam DSP48E_6.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_6 is "1"
defparam DSP48E_6.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_6 is "DIRECT"
defparam DSP48E_6.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_6 is "DIRECT"
defparam DSP48E_6.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_6 is "MULT_S"
defparam DSP48E_6.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_6 is "ONE48"
defparam DSP48E_6.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_6 is 48'hffffffffffff
defparam DSP48E_6.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_6 is 48'h000000000000;
defparam DSP48E_6.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_6 is "PATTERN"
defparam DSP48E_6.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_6 is "MASK"
defparam DSP48E_6.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_6 is "SEL_MASK"
defparam DSP48E_6.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_6 is "FALSE"
defparam DSP48E_6.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_6 is "MATCH"
defparam DSP48E_6.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_6 is "NO_PATDET"
defparam DSP48E_6.USE_PATTERN_DETECT = "NO_PATDET";


DSP48E DSP48E_7 (
.P(P7),
.ACOUT(),
.BCOUT(),
.PCOUT(pcout7),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A(),
.B({1'b0,R5[33:17]}),
.C(),
.ACIN(acout6),
.BCIN(),
.PCIN(pcout6),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b1010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(zero),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_7 is "1"
defparam DSP48E_7.AREG = 1;
//synthesis attribute ACASCREG of DSP48E_7 is "1"
defparam DSP48E_7.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_7 is "2"
defparam DSP48E_7.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_7 is "1"
defparam DSP48E_7.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_7 is "1"
defparam DSP48E_7.CREG = 1;
//synthesis attribute MREG of DSP48E_7 is "1"
defparam DSP48E_7.MREG = 1;
//synthesis attribute PREG of DSP48E_7 is "1"
defparam DSP48E_7.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_7 is "1"
defparam DSP48E_7.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_7 is "1"
defparam DSP48E_7.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_7 is "1" 
defparam DSP48E_7.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_7 is "1"
defparam DSP48E_7.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_7 is "1"
defparam DSP48E_7.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_7 is "CASCADE"
defparam DSP48E_7.A_INPUT = "CASCADE";
//synthesis attribute B_INPUT of DSP48E_7 is "DIRECT"
defparam DSP48E_7.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_7 is "MULT_S"
defparam DSP48E_7.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_7 is "ONE48"
defparam DSP48E_7.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_7 is 48'hffffffffffff
defparam DSP48E_7.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_7 is 48'h000000000000;
defparam DSP48E_7.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_7 is "PATTERN"
defparam DSP48E_7.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_7 is "MASK"
defparam DSP48E_7.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_7 is "SEL_MASK"
defparam DSP48E_7.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_7 is "FALSE"
defparam DSP48E_7.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_7 is "MATCH"
defparam DSP48E_7.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_7 is "NO_PATDET"
defparam DSP48E_7.USE_PATTERN_DETECT = "NO_PATDET";


DSP48E DSP48E_8 (
.P(P8),
.ACOUT(acout8),
.BCOUT(),
.PCOUT(pcout8),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A({5'b00000,R6[58:34]}),
.B({1'b0,S6[33:17]}),
.C(),
.ACIN(),
.BCIN(),
.PCIN(pcout7),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b0010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(one),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_8 is "2"
defparam DSP48E_8.AREG = 2;
//synthesis attribute ACASCREG of DSP48E_8 is "2"
defparam DSP48E_8.ACASCREG = 2;
//synthesis attribute BREG of DSP48E_8 is "2"
defparam DSP48E_8.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_8 is "1"
defparam DSP48E_8.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_8 is "1"
defparam DSP48E_8.CREG = 1;
//synthesis attribute MREG of DSP48E_8 is "1"
defparam DSP48E_8.MREG = 1;
//synthesis attribute PREG of DSP48E_8 is "1"
defparam DSP48E_8.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_8 is "1"
defparam DSP48E_8.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_8 is "1"
defparam DSP48E_8.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_8 is "1" 
defparam DSP48E_8.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_8 is "1"
defparam DSP48E_8.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_8 is "1"
defparam DSP48E_8.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_8 is "DIRECT"
defparam DSP48E_8.A_INPUT = "DIRECT";
//synthesis attribute B_INPUT of DSP48E_8 is "DIRECT"
defparam DSP48E_8.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_8 is "MULT_S"
defparam DSP48E_8.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_8 is "ONE48"
defparam DSP48E_8.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_8 is 48'hffffffffffff
defparam DSP48E_8.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_8 is 48'h000000000000;
defparam DSP48E_8.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_8 is "PATTERN"
defparam DSP48E_8.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_8 is "MASK"
defparam DSP48E_8.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_8 is "SEL_MASK"
defparam DSP48E_8.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_8 is "FALSE"
defparam DSP48E_8.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_8 is "MATCH"
defparam DSP48E_8.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_8 is "NO_PATDET"
defparam DSP48E_8.USE_PATTERN_DETECT = "NO_PATDET";


DSP48E DSP48E_9 (
.P(P9),
.ACOUT(acout9),
.BCOUT(),
.PCOUT(pcout9),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A(),
.B({1'b0,S7[50:34]}),
.C(),
.ACIN(acout8),
.BCIN(),
.PCIN(pcout8),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b1010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(zero),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_9 is "1"
defparam DSP48E_9.AREG = 1;
//synthesis attribute ACASCREG of DSP48E_9 is "1"
defparam DSP48E_9.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_9 is "2"
defparam DSP48E_9.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_9 is "1"
defparam DSP48E_9.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_9 is "1"
defparam DSP48E_9.CREG = 1;
//synthesis attribute MREG of DSP48E_9 is "1"
defparam DSP48E_9.MREG = 1;
//synthesis attribute PREG of DSP48E_9 is "1"
defparam DSP48E_9.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_9 is "1"
defparam DSP48E_9.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_9 is "1"
defparam DSP48E_9.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_9 is "1" 
defparam DSP48E_9.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_9 is "1"
defparam DSP48E_9.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_9 is "1"
defparam DSP48E_9.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_9 is "CASCADE"
defparam DSP48E_9.A_INPUT = "CASCADE";
//synthesis attribute B_INPUT of DSP48E_9 is "DIRECT"
defparam DSP48E_9.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_9 is "MULT_S"
defparam DSP48E_9.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_9 is "ONE48"
defparam DSP48E_9.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_9 is 48'hffffffffffff
defparam DSP48E_9.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_9 is 48'h000000000000;
defparam DSP48E_9.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_9 is "PATTERN"
defparam DSP48E_9.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_9 is "MASK"
defparam DSP48E_9.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_9 is "SEL_MASK"
defparam DSP48E_9.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_9 is "FALSE"
defparam DSP48E_9.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_9 is "MATCH"
defparam DSP48E_9.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_9 is "NO_PATDET"
defparam DSP48E_9.USE_PATTERN_DETECT = "NO_PATDET";


DSP48E DSP48E_10 (
.P(P10),
.ACOUT(),
.BCOUT(),
.PCOUT(),
.CARRYOUT(),
.CARRYCASCOUT(),
.MULTSIGNOUT(),
.PATTERNDETECT(),
.PATTERNBDETECT(),
.OVERFLOW(),
.UNDERFLOW(),
.A(),
.B({S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58:51]}),
.C(),
.ACIN(acout9),
.BCIN(),
.PCIN(pcout9),
.CARRYCASCIN(),
.MULTSIGNIN(),
.ALUMODE(4'b0000),
.OPMODE(7'b1010101),
.CARRYIN(1'b0),
.CARRYINSEL(3'b000),
.CLK(clk),
.CEA1(zero),
.CEA2(one),
.CEALUMODE(one),
.CEB1(one),
.CEB2(one),
.CEC(zero),
.CECARRYIN(one),
.CECTRL(one),
.CEMULTCARRYIN(one),
.CEM(one),
.CEP(one),
.RSTA(rst),
.RSTALUMODE(rst),
.RSTB(rst),
.RSTC(rst),
.RSTALLCARRYIN(rst),
.RSTCTRL(rst),
.RSTM(rst),
.RSTP(rst)
);

//synthesis attribute AREG of DSP48E_10 is "1"
defparam DSP48E_10.AREG = 1;
//synthesis attribute ACASCREG of DSP48E_10 is "1"
defparam DSP48E_10.ACASCREG = 1;
//synthesis attribute BREG of DSP48E_10 is "2"
defparam DSP48E_10.BREG = 2;
//synthesis attribute BCASCREG of DSP48E_10 is "1"
defparam DSP48E_10.BCASCREG = 1;
//synthesis attribute CREG of DSP48E_10 is "1"
defparam DSP48E_10.CREG = 1;
//synthesis attribute MREG of DSP48E_10 is "1"
defparam DSP48E_10.MREG = 1;
//synthesis attribute PREG of DSP48E_10 is "1"
defparam DSP48E_10.PREG = 1;
//synthesis attribute OPMODEREG of DSP48E_10 is "1"
defparam DSP48E_10.OPMODEREG = 1;
//synthesis attribute ALUMODEREG of DSP48E_10 is "1"
defparam DSP48E_10.ALUMODEREG = 1;
//synthesis attribute CARRYINREG of DSP48E_10 is "1" 
defparam DSP48E_10.CARRYINREG = 1; 
//synthesis attribute MULTCARRYINREG of DSP48E_10 is "1"
defparam DSP48E_10.MULTCARRYINREG = 1;
//synthesis attribute CARRYINSELREG of DSP48E_10 is "1"
defparam DSP48E_10.CARRYINSELREG = 1;
//synthesis attribute A_INPUT of DSP48E_10 is "CASCADE"
defparam DSP48E_10.A_INPUT = "CASCADE";
//synthesis attribute B_INPUT of DSP48E_10 is "DIRECT"
defparam DSP48E_10.B_INPUT = "DIRECT";
//synthesis attribute USE_MULT of DSP48E_10 is "MULT_S"
defparam DSP48E_10.USE_MULT = "MULT_S";
//synthesis attribute USE_SIMD of DSP48E_10 is "ONE48"
defparam DSP48E_10.USE_SIMD = "ONE48";
//synthesis attribute PATTERN of DSP48E_10 is 48'hffffffffffff
defparam DSP48E_10.PATTERN = 48'hffffffffffff;
//synthesis attribute MASK of DSP48E_10 is 48'h000000000000;
defparam DSP48E_10.MASK =    48'h000000000000;
//synthesis attribute SEL_PATTERN of DSP48E_10 is "PATTERN"
defparam DSP48E_10.SEL_PATTERN = "PATTERN";
//synthesis attribute SEL_MASK of DSP48E_10 is "MASK"
defparam DSP48E_10.SEL_MASK = "MASK";
//synthesis attribute SEL_ROUNDING_MASK of DSP48E_10 is "SEL_MASK"
defparam DSP48E_10.SEL_ROUNDING_MASK = "SEL_MASK";
//synthesis attribute AUTORESET_PATTERN_DETECT of DSP48E_10 is "FALSE"
defparam DSP48E_10.AUTORESET_PATTERN_DETECT = "FALSE";
//synthesis attribute AUTORESET_PATTERN_DETECT_OPTINV of DSP48E_10 is "MATCH"
defparam DSP48E_10.AUTORESET_PATTERN_DETECT_OPTINV = "MATCH";
//synthesis attribute USE_PATTERN_DETECT of DSP48E_10 is "NO_PATDET"
defparam DSP48E_10.USE_PATTERN_DETECT = "NO_PATDET";


endmodule
