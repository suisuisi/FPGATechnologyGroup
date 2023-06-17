// Verilog Test Fixture Template

  `timescale 1 ns / 1 ps

module mult59x59_tb;
          reg en,rst,iclk,iclk_b,delclk;
	  wire [117:0] multout1,multout2;
	  reg [58:0] R, S;
 	  reg pass,rstpipe1,rstpipe2,rstpipe3,rstpipe4,rstpipe5,rstpipe6,rstpipe7,rstpipe8;
			 
mult59x59fabric reference (.clk(iclk), .en(en), .rst(rst), .R(R),.S(S),.multout(multout1));
mult59x59 DUT (.clk(iclk), .en(en), .rst(rst), .R(R),.S(S),.multout(multout2));

   /*********************************************/
   /* Parameters                                */
   /*********************************************/
   parameter    PERIOD = 1000;
   parameter    HALF_PERIOD = PERIOD/2;
   parameter    STROBE_WAIT = PERIOD/2 - 10;

   integer out_file;
   event   strobe_pins;

   /*******************************************************/
   /* If VIRSIM_ON flag is on, then dump vcd+ files       */
   /*******************************************************/
   //`ifdef VIRSIM_ON
       initial $vcdpluson;
   //`endif

    /*******************************************************/
   /* Generate Free Running Clock                         */
   /* Same frequency for now.                             */
   /*******************************************************/
   initial begin
      iclk = 0; iclk_b = 1;
   end
   
   always begin
        delclk = #100 iclk;
   end
   
   always begin
      #(HALF_PERIOD);
                    iclk = 1; iclk_b = 0;
      #(HALF_PERIOD); iclk = 0; iclk_b = 1;
   end

   initial begin
        #10
        rst = 1;
	en = 1;
        #10000
        rst = 0;
        #(10000*PERIOD);
        #PERIOD $finish;
   end


  always @ (posedge delclk) begin
	rstpipe1 <= rst;
	rstpipe2 <= rstpipe1;
	rstpipe3 <= rstpipe2;
	rstpipe4 <= rstpipe3;
	rstpipe5 <= rstpipe4;
	rstpipe6 <= rstpipe5;
	rstpipe7 <= rstpipe6;
	rstpipe8 <= rstpipe7;

	if (rstpipe5 == 1'b1) begin
	R <= 59'b00000000000000000000000000000000000000000000000000000000000;
	S <= 59'b01111111111111111111111111111111111111111111111111111111111;
	end else begin
	R <= R + 54'b011001010100110010000011110000011000011001000111100001;
	S <= S - 54'b011010110011101010101101110110100101010110101010110010;
	end

	if ((rstpipe8 == 1'b1)||(rst ==1'b1)) begin
	       	pass <= 1'b1;
       	end else begin
		if (multout1 == multout2) begin
			pass <= 1'b1;
		end else begin
			pass <= 1'b0;
		end 
	end
  end


 /*******************************************************/
  /* Open output file                                    */
  /*                                                     */
  /* Holistic Mode - output is named "design.dat"        */
  /* SVG Mode      - output is named "design_ver.dat"    */
  /*******************************************************/
  initial begin
     out_file = $fopen("mult59x59.dat");
     if (out_file == 0) $finish;
  end

  /*******************************************************/
  /* Store input(s)/output(s) into a file at the end     */
  /* of each clock edge.                                 */
  /*******************************************************/
  always #HALF_PERIOD -> strobe_pins;
  always @(strobe_pins) begin          #(STROBE_WAIT);

  $fstrobe(out_file,"%T%b%b%b%b%b%b%b", $time, iclk, en, rst, R,S, multout1,multout2);

  end // always @ (strobe_pins)

  endmodule
  
`timescale 1ns / 1ps

module mult59x59fabric(clk, en, rst, R,S,multout);
    input clk;
    input en;
    input rst;
    input [58:0] R;
    input [58:0] S;
    output [117:0] multout;

wire one = 1'b1;
wire zero = 1'b0;
reg [58:0] R1,S1,R2,S2,R3,S3,R4,S4,R5,S5,R6,S6,R7,S7,R8,S8; 
reg [117:0] multout, multout3, multout2, multout1;


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
//multout3 <= {59'b00000000000000000000000000000000000000000000000000000000000,R8} * {59'b00000000000000000000000000000000000000000000000000000000000, S8};

multout3 <= {R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58],R8[58:0]} * {S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58],S8[58:0]};

multout2 <= multout3;
multout1 <= multout2;
multout <= multout1;

end

endmodule
