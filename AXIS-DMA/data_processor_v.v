module data_processor(
    input clk,
    input reset,
    input [31:0] s_axis_tdata,
    input [3:0] s_axis_tkeep,
    input s_axis_tlast,
    output reg s_axis_tready,
    input s_axis_tvalid,
    output reg [31:0] m_axis_tdata,
    output reg [3:0] m_axis_tkeep,
    output reg m_axis_tlast,
    input m_axis_tready,
    output reg m_axis_tvalid, 
    output [2:0] state_reg
    );
    
    reg [2:0] state_reg;
    reg [31:0] tdata;
    reg tlast;
    
    parameter init               = 3'd0;
    parameter SetSlaveTready     = 3'd1;
    parameter CheckSlaveTvalid   = 3'd2;
    parameter ProcessTdata       = 3'd3;
    parameter CheckTlast         = 3'd4;
    
    always @ (posedge clk)
        begin
			// Default outputs            
			m_axis_tvalid <= 1'b0;
            
            if (reset == 1'b0)
                begin
                    tlast <= 1'b0;
                    tdata[31:0] <= 32'd0;
                    s_axis_tready <= 1'b0;
                    m_axis_tdata[31:0] <= 32'd0;
                    m_axis_tkeep <= 4'h0;
                    m_axis_tlast <= 1'b0;
                    state_reg <= init;
                end
            else
                begin
                
                    case(state_reg) 
                        init : // 0 
                            begin
                                tlast <= 1'b0;
                                tdata[31:0] <= 32'd0;
                                s_axis_tready <= 1'b0;
                                m_axis_tdata[31:0] <= 32'd0;
                                m_axis_tkeep <= 4'h0;
                                m_axis_tlast <= 1'b0;
                                state_reg <= SetSlaveTready;
                            end 
                            
                        SetSlaveTready : // 1
                            begin
                                s_axis_tready <= 1'b1;
                                state_reg <= CheckSlaveTvalid;
                            end 
                            
                        CheckSlaveTvalid : // 2
                            begin
                                if (s_axis_tkeep == 4'hf && s_axis_tvalid == 1'b1)
                                    begin
                                        s_axis_tready <= 1'b0;
                                        tlast <= s_axis_tlast;
                                        tdata[31:0] <= s_axis_tdata[31:0];
                                        state_reg <= ProcessTdata;
                                    end
                                else
                                    begin 
                                        tdata[31:0] <= 32'd0;
                                        state_reg <= CheckSlaveTvalid;
                                    end 
                            end
                            
                        ProcessTdata : // 3
                            begin 
                                m_axis_tkeep <= 4'hf;
                                m_axis_tlast <= tlast;
                                m_axis_tvalid <= 1'b1;
                                m_axis_tdata[31:0] <= tdata[31:0];
                                
                                if (m_axis_tready == 1'b1)
                                    begin 
                                        state_reg <= CheckTlast;
                                    end 
                                else
                                    begin 
                                        state_reg <= ProcessTdata;
                                    end 
                            end
                            
                        CheckTlast : // 4
                            begin 
                                if (m_axis_tlast == 1'b1)
                                    begin				
                                        state_reg <= init;
                                    end
                                else if (m_axis_tready == 1'b1)
                                    begin
                                        state_reg <= SetSlaveTready;
                                    end
                                else 
                                    begin 
                                        state_reg <= CheckTlast;
                                    end 
                            end 
                            
                    endcase 
                end
        end
    
endmodule
