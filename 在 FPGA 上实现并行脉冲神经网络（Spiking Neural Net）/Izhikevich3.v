// --------------------------------------------------------------------
//
// Major Functions:	Iz neuron simulation
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
// Bruce Land Nov 2008, Cornell University
// --------------------------------------------------------------------


module DE2_Default
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter
		IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	    TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output	[11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output	[17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output	[1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			OTG_INT0;				//	ISP1362 Interrupt 0
input			OTG_INT1;				//	ISP1362 Interrupt 1
input			OTG_DREQ0;				//	ISP1362 DMA Request 0
input			OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	PS2_DAT;				//	PS2 Data
input			PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
output			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			AUD_ADCDAT;				//	Audio CODEC ADC Data
output			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
output			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	[7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			TD_HS;					//	TV Decoder H_SYNC
input			TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

//	LCD ON
assign	LCD_ON		=	1'b0;
assign	LCD_BLON	=	1'b0;

//	All inout port turn to tri-state
assign	DRAM_DQ		=	16'hzzzz;
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	SD_DAT		=	1'bz;
assign	ENET_DATA	=	16'hzzzz;
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;

wire	VGA_CTRL_CLK;
wire	AUD_CTRL_CLK;
wire	DLY_RST;

assign	TD_RESET	=	1'b1;	//	Allow 27 MHz
assign	AUD_ADCLRCK	=	AUD_DACLRCK;
assign	AUD_XCK		=	AUD_CTRL_CLK;

Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(CLOCK_27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

I2C_AV_Config 		u3	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(KEY[0]),
							//	I2C Side
							.I2C_SCLK(I2C_SCLK),
							.I2C_SDAT(I2C_SDAT)	);

AUDIO_DAC_ADC 			u4	(	//	Audio Side
							.oAUD_BCK(AUD_BCLK),
							.oAUD_DATA(AUD_DACDAT),
							.oAUD_LRCK(AUD_DACLRCK),
							.iAUD_ADCDAT(AUD_ADCDAT),
							.iAUD_extL(aud_out_L),
							.iAUD_extR(aud_out_R),
							//	Control Signals
							//.iSrc_Select(SW[17]),
				            .iCLK_18_4(AUD_CTRL_CLK),
							.iRST_N(DLY_RST)
							);
							
wire [3:0] a1, b, a2;
wire signed [17:0] c,d ; // parameters
wire signed [17:0] Ibase, I1, I2, I3, I4 ;      // neuron bias current
wire signed [17:0] v1, v2, v3, v4 ;   // cell potentials
wire signed [17:0] neu1In, neu2In, neu3In, neu4In ; // total input current to each cell
wire signed [17:0] neu3In_syn3, neu1In_syn1 ; // partial current into cell 3
wire signed [17:0] w3 ; // the STDP-modified weight to synapse 3
wire s1, s2, s3, s4  ; //the action potentials (spikes)
wire [15:0] aud_out_L, aud_out_R ;

// the clock divider and reset
parameter nClk_Size = 5'd11 ;
reg [nClk_Size:0] count ; //11
wire neuronClock, neuronReset ;
	// clock divider with: reg [15:0] count ;
	always @ (posedge CLOCK_50) 
	begin
		count <= count + 1;
	end
	assign neuronClock = (count[nClk_Size]);	
	
	// and reset
	assign neuronReset = ~KEY[3]; //the reset pushbutton
	
	// bias current assignment
	assign Ibase = 17'h0_0d00 ;
	assign I1 = Ibase ; //the input bias currents
	assign I2 = Ibase + 16 ; 
	assign I3 = Ibase - 16 ; //the input bias currents
	assign I4 = Ibase - 16 ; 
	
	// output select
	assign aud_out_L = SW[0]? v1[17:2] : v2[17:2] ;
	assign aud_out_R = SW[1]? v3[17:2] : v4[17:2] ;
	
	//burster parameters
	assign a1 = 6 ;  // 0.016
	assign b =  2 ;  // 0.25
	// SCALE c, d, and I by 0.01 from Izhikevich table values
	assign c =  18'sh3_8000 ; // -0.5 Izhikevich table value (50) times 0.01
	assign d =  18'sh0_051E ; // 0.02 Izhikevich table value (2) times 0.01
	assign a2 = 6 ; 
	
	// define and connect the neurons
	
	// Two chattering burster neurons, connected to each other by weakly 
	// inhibitory synapses, so that they phase lock bursts.
	Iz_neuron neu1(v1,s1, a1,b,c,d, neu1In, neuronClock, neuronReset);
	Iz_neuron neu2(v2,s2, a2,b,c,d, neu2In, neuronClock, neuronReset);
	// The inhibitory cross-connections are two sympases of the form
	//single_synapse(out,spike,weight,tau,in,clk,reset);
	// with the weights set to -0.016 or so
	single_synapse syn1(neu1In_syn1, s2, 18'sh3_f000, 4, I1, neuronClock, neuronReset);
	single_synapse syn2(neu2In, s1, 18'sh3_f000, 4, I2, neuronClock, neuronReset);
	
	// Two more chattering burster neurons, connected to each other by weakly 
	// inhibitory synapses, so that they phase lock bursts.
	Iz_neuron neu3(v3,s3, a1,b,c,d, neu3In, neuronClock, neuronReset);
	Iz_neuron neu4(v4,s4, a2,b,c,d, neu4In, neuronClock, neuronReset);
	// The inhibitory cross-connections are two sympases of the form
	//single_synapse(out,spike,weight,tau,in,clk,reset);
	// with the weights set to -0.016 or so
	single_synapse syn3(neu3In_syn3, s4, 18'sh3_f000, 4, I3, neuronClock, neuronReset);
	single_synapse syn4(neu4In, s3, 18'sh3_f000, 4, I4, neuronClock, neuronReset);
	
	// A weak excitatory link between the two pairs (neuron 1 to 3)
	//single_synapse syn1_3(neu3In, s1, 18'sh0_0200, 4, neu3In_syn3, neuronClock, neuronReset);
	// electrical_synapse(I2_out, I1_out, v2, v1, cond, rect, in2, in1);
	electrical_synapse syn1_3(neu3In, neu1In, v3, v1, 6, 1, neu3In_syn3, neu1In_syn1);
	
	// Now we add a third neuron:
	// Regular spiking neuron driven from neuron1 above with an 
	//  synapse iwth exhibits STDP (spike time dependent learning)
	// Note that the weight (w3) is variable and controlled by stdp3 module
	// unscaled c=-65, d=8
	// scaled c=-0.7 or 18'hsh3_4CCD
	// scaled d= 0.08 or 18'h
	//Iz_neuron neu3(v3, s3, a1, b, 18'sh3_6000, 18'sh0_1000, neu3In, neuronClock, neuronReset); //neu3In
	//single_synapse syn3(neu3In, s1, w3, 4, 18'sh0_0200, neuronClock, neuronReset); //18'sh0_0200
	
	// modifiy the synaptic weight in syn3 according to activity
	// module stdp(weight_out, spike_pre, spike_post, 
			//d_weight_plus, d_weight_minus, 
			//initial_weight, max_weight, tau_stdp, clk, reset);
			/*
	// Using the s1 and s1delayed is ONLY for testing the STDP functionality
	// becuase it allows us to apply fixed phase spike trains to the STDP unit.
	stdp stdp3(w3, s1, s1delayed, 
			18'h0_0010, 18'h3_ff70, 
			18'h0_0000, 18'h0_3000, 4, neuronClock, neuronReset);
	*/
	//stdp stdp3(w3, s1, s3, 
	//	18'h0_0002, 18'h3_fffc, 
	//	18'h0_0000, 18'h0_2000, 4, neuronClock, neuronReset);
		
	
	//output spikes to parallel port
	//assign GPIO_0[1] = s1;
	//assign GPIO_0[2] = s2;
	
	// output spikes to the leds
	assign LEDR[1] = s1;
	assign LEDR[2] = s2;
	assign LEDR[3] = s3;
	assign LEDR[4] = s4;
endmodule

////////////////////////////////////////////
//// Electrical Synapse ////////////////////
////////////////////////////////////////////
// Acts to create a resistance coupling two cells 
// I (into cell 2) = (v1 - v2)*conductance
// I (into cell 1) = (v2 - v1)*conductance
// conductance is 0<conductance<15 which is a right-shift factor
// rect specifies: 
//      0=no rectification, 
//      1=current from 1 to 2
//      2=current from 2 to 1
// the 'in' allows synapes to be daisy-chained
////////////////////////////////////////
module electrical_synapse(I2_out, I1_out, v2, v1, cond, rect, in2, in1);
	output reg signed [17:0] I2_out, I1_out; 	//the simulated synaptic current
	input signed [17:0] in1, in2	;			// the input currents
	input [3:0] cond, rect ;			// conductance and rectifcation
	input signed [17:0] v1, v2 ; 
	  		
	wire signed [17:0] v_diff ; 
	reg signed [17:0] rect_v_diff ;
	assign v_diff = v1 - v2 ;
	always @(*)
	begin
		case (rect)
			0: rect_v_diff = v_diff ;  
			1: rect_v_diff = v_diff>0? v_diff : 18'd0 ; 
			2: rect_v_diff = v_diff<0? v_diff : 18'd0 ;  
		endcase
		I2_out = ((rect_v_diff)>>>cond) + in2 ; 
		I1_out = ((-rect_v_diff)>>>cond) + in1 ;
	end
endmodule

//////////////////////////////////////////////////////////
////STDP (hebbian) learnng module ///////////////////////
/////////////////////////////////////////////////////////
// spike_pre is from the synaptic input cell
// spike_post is from the synaptic output cell
// d_weight_minus is the dec due to anti-causal order and must be a neg number
// d_weight_plus is the inc due to causal order and must be a pos number
// abs(d_weight_minus) must be >= 1.1*(d_weight_plus) 
// tau_stdp is the time const of learning and is an int between 2 and 8 
// (approx 4 to 256 time steps in factors of 2)
// weight_out is feed to the weight input of a synapse module
//////////////////////////////////////////////////////////
module stdp(weight_out, spike_pre, spike_post, 
			d_weight_plus, d_weight_minus, 
			initial_weight, max_weight, tau_stdp, clk, reset);

input spike_pre, spike_post, clk, reset ;
input signed [17:0] d_weight_plus, d_weight_minus, initial_weight, max_weight ;
input [3:0] tau_stdp ;
output reg signed[17:0] weight_out ;

reg signed [17:0] weight_plus, weight_minus ;

always @ (posedge clk) 
begin
	if (reset) 
	begin
		weight_out <= initial_weight; // output to synapse before learning
		weight_plus <= 18'd0;		// time dependent weight increment
		weight_minus <= 18'd0; 		// time dependent weight decrement	
	end
	else 
	begin
		// decay the weight increments and add in new deltas
		weight_plus <= weight_plus - (weight_plus>>>tau_stdp) + (spike_pre? d_weight_plus:0);
		weight_minus <= weight_minus - (weight_minus>>>tau_stdp) + (spike_post? d_weight_minus:0);
		// update ouput when either spike occurs
		if (spike_pre | spike_post)
		begin
			// increment the weight if the current spike is postsynaptic, by
			// an ammount which decreases with time after the pre spike.
			if (spike_post & (weight_out < max_weight))
				weight_out <= weight_out + weight_plus ;
			// decrement the weight if the current spike is presynaptic, by
			// an ammount which decreases with time after the post spike.	
			else if (spike_pre & (weight_out > -max_weight))
				weight_out <= weight_out + weight_minus ;
		end
	end
end
endmodule


///////////////////////////////////////
////Axon Delay ////////////////////////
///////////////////////////////////////
// delay value 1 to 63 time steps
///////////////////////////////////////
module axon_delay(spike_out, spike_in, delay, clk);
output reg spike_out ;
input spike_in, clk ;
input [5:0] delay ;

reg start_count ;
reg [5:0] counter ;

always @ (posedge clk) 
begin
	if (spike_in) start_count <= 1 ;
	if (start_count == 1) counter <= counter + 1;
	if (counter == delay) 
	begin
		start_count <= 0 ;
		spike_out <= 1;
		counter <= 0 ;
	end
	else spike_out <= 0 ;
end

endmodule

////////////////////////////////////////
//// Single Synapse ////////////////////
////////////////////////////////////////
// Acts to create an exponentially falling current at the output 
// from a spike input and a weight which can be +/-
// One spike input and weight are defined, along with an input value 
// so that synapes can be daisy-chained.
// Tau is 2<tau<8 which sets the decay time constant.
// Tau=2 is approx 0.25 mSec, tau=4 is approx 1.0 mSec, tau=6 is 4 mSec.
////////////////////////////////////////
module single_synapse(out,s1,w1,tau,in,clk,reset);
	output signed[17:0] out; 		//the simulated synaptic current
	input signed [17:0] in	;		// the input current
	input [3:0] tau ;				// the synaptic current decay time const
	input s1 ;     					// the action potential inputs
	input signed [17:0] w1 ;   		// synaptic weight
	input clk, reset;
	
	wire signed	[17:0] out;
	reg  signed	[17:0] v1 ;
	wire signed	[17:0] v1new ;
	
	always @ (posedge clk) 
	begin
		if (reset) v1 <= 18'sh0; // no synaptic input at t=0	
		else v1 <= v1new ;		 
	end
	
	// dt = 1/16 or 2>>4 and tau=1
	// v1(n+1) = v1(n) + dt/tau*(-v1(n)+s1*w1+s2*w2+s3*w3)
	assign v1new = v1 + ((-v1)>>>tau) + (s1?w1:0) ;
	assign out = v1 + in ;  //copy state var to output & add input
	
endmodule

////////////////////////////////////////
//// Synapse ///////////////////////////
////////////////////////////////////////
// Acts to create an exponentially falling current at the output 
// from a spike input and a weight which can be +/-
// up to three spike inputs are defined, each with its own weight
module synapse(out,s1,w1,s2,w2,s3,w3,clk,reset);
	output [17:0] out; 				//the simulated current
	input s1,s2,s3;     			// the action potential inputs
	input signed [17:0] w1,w2,w3;   //weights
	input clk, reset;
	
	wire signed	[17:0] out;
	reg  signed	[17:0] v1 ;
	wire signed	[17:0] v1new ;
	
	assign out = v1;  //copy state var to output
	
	always @ (posedge clk) 
	begin
		if (reset) v1 <= 18'sh0; //
		else v1 <= v1new ;		 
	end
	
	// dt = 1/16 or 2>>4 and tau=1
	// v1(n+1) = v1(n) + dt/tau*(-v1(n)+s1*w1+s2*w2+s3*w3)
	assign v1new = v1 + ((-v1)>>>4) + (s1?w1:0)+(s2?w2:0)+(s3?w3:0) ;
	
endmodule

//////////////////////////////////////////////////
//// Izhikevich neuron ///////////////////////////
//////////////////////////////////////////////////
// Modified to eliminate two of the multiplies
// Since a nd b need not be very precise 
// and because 0.02<a<0.2 and 0.1<b<0.3
// Treat the a and b inputs as an index do determine how much to 
// shift the intermediate results
// treat the a input as value>>>a with a=1 to 7
// treat the b input as value>>>b with b=1 to 3
// NOTE: constants c,d, and I as given in Izhikevich's
// tables and figures have to be multiplied by 0.01

module Iz_neuron(out,spike,a,b,c,d,I,clk,reset);
	output [17:0] out; 				//the simulated membrane voltage
	output spike ;     				// the action potential output
	input signed [17:0] c, d, I;   //a,b,c,d set cell dynamics, I is the input current
	input [3:0] a, b ;
	input clk, reset;
	
	wire signed	[17:0] out;
	reg spike;
	reg  signed	[17:0] v1,u1;
	wire signed	[17:0] u1reset, v1new, u1new, du1;
	wire signed	[17:0] v1xv1, v1xb;
	wire signed	[17:0] p, c14;
	
	assign p =  18'sh0_4CCC ; // 0.30
	assign c14 = 18'sh1_6666; // 1.4
	
	assign out = v1;  //copy state var to output
	
	always @ (posedge clk) 
	begin
		if (reset) 
		begin	
			v1 <= 18'sh3_4CCD ; // -0.7
			u1 <= 18'sh3_CCCD ; // -0.2
			spike <= 0;
		end	
		else 
		begin
			if ((v1 > p)) 
			begin 
				v1 <= c ; 		
				u1 <= u1reset ;
				spike <= 1;
			end
			else
			begin
				v1 <= v1new ;
				u1 <= u1new ; 
				spike <= 0;	
			end
		end 
	end
	
	// dt = 1/16 or 2>>4
	// v1(n+1) = v1(n) + dt*(4*(v1(n)^2) + 5*v1(n) +1.40 - u1(n) + I)
	// but note that what is actually coded is
	// v1(n+1) = v1(n) + (v1(n)^2) + 5/4*v1(n) +1.40/4 - u1(n)/4 + I/4)/4
	signed_mult v1sq(v1xv1, v1, v1);
	assign v1new = v1 + ((v1xv1 + v1+(v1>>>2) + (c14>>>2) - (u1>>>2) + (I>>>2))>>>2);
	
	// u1(n+1) = u1 + dt*a*(b*v1(n) - u1(n))
	assign v1xb = v1>>>b;         //mult (v1xb, v1, b);
	assign du1 = (v1xb-u1)>>>a ;  //mult (du1, (v1xb-u1), a);
	assign u1new = u1 + (du1>>>4) ; 
	assign u1reset = u1 + d ;
endmodule
//////////////////////////////////////////////////


//////////////////////////////////////////////////
//// signed mult of 2.16 format 2'comp////////////
//////////////////////////////////////////////////

module signed_mult (out, a, b);

	output 		[17:0]	out;
	input 	signed	[17:0] 	a;
	input 	signed	[17:0] 	b;
	
	wire	signed	[17:0]	out;
	wire 	signed	[35:0]	mult_out;

	assign mult_out = a * b;
	//assign out = mult_out[33:17];
	assign out = {mult_out[35], mult_out[32:16]};
endmodule

//////////////////////////////////////////////////
/*
%cell parameters from Izhikevich web page
pars=[0.02      0.2     -65      6       14 ;...    % tonic spiking
    0.02      0.25    -65      6       0.5 ;...   % phasic spiking
    0.02      0.2     -50      2       15 ;...    % tonic bursting
    0.02      0.25    -55     0.05     0.6 ;...   % phasic bursting
    0.02      0.2     -55     4        10 ;...    % mixed mode
    0.01      0.2     -65     8        30 ;...    % spike frequency adaptation
    0.02      -0.1    -55     6        0  ;...    % Class 1
    0.2       0.26    -65     0        0  ;...    % Class 2
    0.02      0.2     -65     6        7  ;...    % spike latency
    0.05      0.26    -60     0        0  ;...    % subthreshold oscillations
    0.1       0.26    -60     -1       0  ;...    % resonator
    0.02      -0.1    -55     6        0  ;...    % integrator
    0.03      0.25    -60     4        0;...      % rebound spike
    0.03      0.25    -52     0        0;...      % rebound burst
    0.03      0.25    -60     4        0  ;...    % threshold variability
    1         1.5     -60     0      -65  ;...    % bistability
    1       0.2     -60     -21      0  ;...    % DAP
    0.02      1       -55     4        0  ;...    % accomodation
    -0.02      -1      -60     8        80 ;...    % inhibition-induced spiking
    -0.026     -1      -45     0        80];       % inhibition-induced bursting
*/
//////////////////////////////////////////////////////