`timescale 1ns / 1ps

module sin_sm(
    input clk,
    input rst,
    input [31:0] tdata_slave,
    output reg [31:0] tdata_master,
    output reg tx_pkt_done
    );
    
    parameter T0_period       = 3'd2;
    parameter T1_period       = 3'd1;
    parameter unit_circle_deg = 9'd360;
    
    reg [31:0] tdata;
    reg [2:0]  period;
    reg [2:0]  period_cntr;
    reg [8:0]  degree_cntr;
    reg [4:0]  tdata_sel_cntr;
    
    wire [15:0] DAC_code;
    
    sin_lut sin_lut_i(
        .clk(clk),
        .rst(rst),
        .sel(degree_cntr),
        .DAC_code(DAC_code)
    );
    
    always @ (posedge clk)
        begin
            if (rst == 1'b0)
                begin
                    tdata_master[31:0] <= 32'd0;
                end
            else
                begin
                    tdata_master[31:16] <= DAC_code[15:0];
                    tdata_master[15:0]  <= DAC_code[15:0];
                end
        end 
        
    always @ (posedge clk)
        begin
            if (rst == 1'b0)
                begin
                    tdata[31:0] <= 32'd0;
                end
            else
                begin
                    tdata[31:0] <= tdata_slave[31:0];
                end
        end

    reg current_tx_bit;
    reg tx_pkt_done;
    always @ (tdata_sel_cntr)
        begin 
            case (tdata_sel_cntr) 
                32'd0   : 
                    begin
                        current_tx_bit <= tdata[0];
                        tx_pkt_done <= 1'b0;
                    end 
                32'd1   : 
                    begin
                         current_tx_bit <= tdata[1];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd2   : 
                    begin
                         current_tx_bit <= tdata[2];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd3   : 
                    begin
                         current_tx_bit <= tdata[3];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd4   : 
                    begin
                         current_tx_bit <= tdata[4];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd5   : 
                    begin
                         current_tx_bit <= tdata[5];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd6   : 
                    begin
                         current_tx_bit <= tdata[6];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd7   : 
                    begin
                         current_tx_bit <= tdata[7];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd8   : 
                    begin
                         current_tx_bit <= tdata[8];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd9   : 
                    begin
                         current_tx_bit <= tdata[9];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd10  : 
                    begin
                         current_tx_bit <= tdata[10];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd11  : 
                    begin
                         current_tx_bit <= tdata[11];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd12  : 
                    begin
                         current_tx_bit <= tdata[12];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd13  : 
                    begin
                         current_tx_bit <= tdata[13];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd14  : 
                    begin
                         current_tx_bit <= tdata[14];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd15  : 
                    begin
                         current_tx_bit <= tdata[15];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd16  : 
                    begin
                         current_tx_bit <= tdata[16];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd17  : 
                    begin
                         current_tx_bit <= tdata[17];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd18  : 
                    begin
                         current_tx_bit <= tdata[18];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd19  : 
                    begin
                         current_tx_bit <= tdata[19];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd20  : 
                    begin
                         current_tx_bit <= tdata[20];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd21  : 
                    begin
                         current_tx_bit <= tdata[21];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd22  : 
                    begin
                         current_tx_bit <= tdata[22];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd23  : 
                    begin
                         current_tx_bit <= tdata[23];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd24  : 
                    begin
                         current_tx_bit <= tdata[24];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd25  : 
                    begin
                         current_tx_bit <= tdata[25];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd26  : 
                    begin
                         current_tx_bit <= tdata[26];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd27  : 
                    begin
                         current_tx_bit <= tdata[27];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd28  : 
                    begin
                         current_tx_bit <= tdata[28];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd29  : 
                    begin
                         current_tx_bit <= tdata[29];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd30  : 
                    begin
                         current_tx_bit <= tdata[30];
                         tx_pkt_done <= 1'b0;
                    end 
                32'd31  : 
                    begin
                         current_tx_bit <= tdata[31];
                         tx_pkt_done <= 1'b1;
                    end 
                default : 
                    begin
                        current_tx_bit <= 1'b0;
                        tx_pkt_done <= 1'b0;
                    end
            endcase 
        end
        
    always @ (posedge clk)
        begin 
            if (current_tx_bit == 1'b1)
                period <= T1_period;
            else
                period <= T0_period;
        end
        
    reg incr_degree_cntr;
    reg degree_cntr_done;
    always @ (posedge clk)
        begin 
            if (rst == 1'b0)
                begin
                    degree_cntr <= 9'd0;
                    degree_cntr_done <= 1'b0; 
                end
            else if (incr_degree_cntr == 1'b1)
                begin
                    if (degree_cntr < unit_circle_deg)
                        begin
                            degree_cntr <= degree_cntr + 1;
                            degree_cntr_done <= 1'b0;
                        end
                    else
                        begin
                            degree_cntr <= 9'd0;
                            degree_cntr_done <= 1'b1;
                        end
                end
            else
                begin
                    degree_cntr <= degree_cntr;
                end
        end 
    
    always @ (posedge clk)
        begin 
            if (rst == 1'b0)
                begin
                    incr_degree_cntr = 1'b0;
                    period_cntr <= 3'd0;
                end
            else
                begin
                    if (period_cntr == period)
                        begin
                            incr_degree_cntr = 1'b1;
                            period_cntr <= 3'd0;
                        end
                    else
                        begin 
                            incr_degree_cntr = 1'b0;
                            period_cntr <= period_cntr + 1;
                        end 
                end
        end 
 
    always @ (posedge clk)
        begin 
            if (rst == 1'b0)
                begin
                    tdata_sel_cntr <= 5'd0;
                end 
            else 
                begin
                    if (degree_cntr_done == 1'b1)
                        begin
                            tdata_sel_cntr <= tdata_sel_cntr + 1;
                        end
                    else
                        begin
                            tdata_sel_cntr <= tdata_sel_cntr;
                        end
                end 
        end  
    
endmodule
