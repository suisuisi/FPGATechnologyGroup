library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

package prot_qspi_bfm_pkg is new work.qspi_bfm_pkg generic map(
    G_CS_POL          => 0, 
    G_CPOL            => 0, 
    G_CPHA            => 0, 
    G_ENDIANESS       => "MSB",
    G_BITS_PER_WORD   => 8,
    G_NUM_SLAVES      => 1,
    G_PERIOD          => 40 ns,
    G_DUMMY           => 4, 
    G_START_WAIT      => 80 ns,
    G_INTER_WORD_WAIT => 40 ns,
    G_END_WAIT        => 80 ns 
);


library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity qspi_test is
end qspi_test;


architecture tb of qspi_test is 



    signal s_clk   : std_logic ;
    signal s_reset : std_logic ;

    signal s_qspi_data  : work.prot_qspi_bfm_pkg.r_data ;
    signal s_qspi_cntrl : work.prot_qspi_bfm_pkg.r_cntrl;

    -- slave axis input
    signal s_slv_axis_tdata  :  std_logic_vector(7 downto 0); 
    signal s_slv_axis_tvalid :  std_logic;                    
    signal s_slv_axis_tready :  std_logic;    
                   
    --master axis op 
    signal s_mstr_axis_tdata  : std_logic_vector(7 downto 0);
    signal s_mstr_axis_tvalid : std_logic;                   
    signal s_mstr_axis_tlast  : std_logic;                  
    signal s_mstr_axis_tready : std_logic;    
    
   component axis_data_fifo_0 is port (
        s_axis_aresetn : in std_logic;
        s_axis_aclk  : in std_logic;
        s_axis_tvalid : in std_logic;
        s_axis_tlast  : in std_logic;
        s_axis_tready : out std_logic;
        s_axis_tdata  : in std_logic_vector(7 downto 0);
        m_axis_tvalid : out std_logic;
        m_axis_tready : in std_logic;
        m_axis_tlast  : out std_logic;
        m_axis_tdata : out std_logic_vector(7 downto 0));
    end component;           
    
begin

    --s_clk <= not s_clk after (clk_period/2);
    --s_reset <= '0' after 1 us;
    
axis_fifo : axis_data_fifo_0 port map (
    s_axis_aresetn => not (s_reset),
    s_axis_aclk    => s_clk,
    s_axis_tvalid  => s_mstr_axis_tvalid,
    s_axis_tready  => s_mstr_axis_tready,
    s_axis_tdata   => s_mstr_axis_tdata,
    s_axis_tlast   => s_mstr_axis_tlast,
    m_axis_tvalid  => s_slv_axis_tvalid,
    m_axis_tready  => s_slv_axis_tready,
    m_axis_tdata   => s_slv_axis_tdata,
    m_axis_tlast   => open
);

uut: entity work.qspi_to_axis  generic map(
    g_reset_level      => '1',
    g_cs_pol           => 0
)
    port map(
    i_clk   => s_clk,
    i_reset => s_reset,

    i_qcs   => s_qspi_cntrl.s_cs(0),
    i_qck   => s_qspi_cntrl.s_sclk,

    io_q0   =>  s_qspi_data.s_io0, 
    io_q1   =>  s_qspi_data.s_io1, 
    io_q2   =>  s_qspi_data.s_io2, 
    io_q3   =>  s_qspi_data.s_io3, 


    i_axis_tdata  => s_slv_axis_tdata  ,
    i_axis_tvalid => s_slv_axis_tvalid ,
    o_axis_tready => s_slv_axis_tready ,

    o_write_length => open,
    
    o_axis_tdata  =>   s_mstr_axis_tdata ,
    o_axis_tvalid =>   s_mstr_axis_tvalid,
    o_axis_tlast  =>   s_mstr_axis_tlast ,
    i_axis_tready =>   s_mstr_axis_tready
);

end architecture;