library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity qspi_to_axis is generic(
    g_reset_level      : std_logic := '1';
    g_cs_pol           : integer := 0
);
    port(
    i_clk   : in std_logic;
    i_reset : in std_logic;

    i_qcs   : in std_logic;
    i_qck   : in std_logic;

    io_q0   : inout std_logic;
    io_q1   : inout std_logic;
    io_q2   : inout std_logic;
    io_q3   : inout std_logic;


   i_axis_tdata  : in std_logic_vector(7 downto 0);
   i_axis_tvalid : in std_logic;
   o_axis_tready : out std_logic;

   o_write_length : out std_logic_vector(7 downto 0);


    o_axis_tdata  : out std_logic_vector(7 downto 0);
    o_axis_tvalid : out std_logic;
    o_axis_tlast  : out std_logic;
    i_axis_tready : in std_logic
);
end entity;


architecture rtl of qspi_to_axis is 

    constant c_readio4      : std_logic_vector(7 downto 0) := x"EB";
    constant c_ppio4        : std_logic_vector(7 downto 0) := x"38";
    constant c_re_det       : std_logic_vector(1 downto 0) := "01";
    constant c_fe_det       : std_logic_vector(1 downto 0) := "10";
    constant c_cmd_length   : integer := 8;
    constant c_addr_length  : integer := 8;
    constant c_dummy        : integer := 4;

    signal s_cs_det       : std_logic_vector(1 downto 0);
    signal s_ck_det       : std_logic_vector(1 downto 0);
    signal s_io0_enb      : std_logic;
    signal s_io1_3_enb    : std_logic;
    signal s_cs_fe_det    : std_logic;
    signal s_cs_re_det    : std_logic;
    signal s_ck_re_det    : std_logic;
    
    signal s_io0_ip_reg   : std_logic_vector(7 downto 0);
    signal s_io1_ip_reg   : std_logic_vector(1 downto 0);
    signal s_io2_ip_reg   : std_logic_vector(1 downto 0);
    signal s_io3_ip_reg   : std_logic_vector(1 downto 0);

    type t_fsm is (idle, enable_reg0, rd_state,wr_state);
    signal s_current_state  : t_fsm;
    signal s_byte_pos       : std_logic;
    signal s_del_byte_pos   : std_logic;
    signal s_ld_cmd         : std_logic;
    signal s_cmd            : std_logic_vector(7 downto 0);
    signal s_read_cnt       : integer range 0 to 511;
    signal s_write_cnt      : integer range 0 to 511;
    signal s_write_cnt_enb  : std_logic;
    signal s_read_reg       : std_logic;


begin


edge_det: process(i_clk, i_reset)
--edge detect the CS and CK signals 
begin 
    if i_reset = g_reset_level then
        if g_cs_pol = 0 then
            s_cs_det <= (others => '1');
        else
            s_cs_det <= (others => '0');
        end if;
        s_ck_det <= (others => '0');
    elsif rising_edge(i_clk) then 
        s_cs_det <= s_cs_det(s_cs_det'high-1 downto s_cs_det'low) & i_qcs;
        s_ck_det <= s_ck_det(s_ck_det'high-1 downto s_ck_det'low) & i_qck;
    end if;
end process;

--detect risign and falling edges on CS and CLK
s_cs_fe_det <= '1' when s_cs_det = c_fe_det else '0';
s_cs_re_det <= '1' when s_cs_det = c_re_det else '0';
s_ck_re_det <= '1' when s_ck_det = c_re_det else '0';

reg0_ip : process(i_clk, i_reset)
begin
    -- shift registers for capturing the data on IO0 
    -- enabled when re detected on clock and CS is active 
    if i_reset = g_reset_level then
        s_io0_ip_reg <= (others => '0');
    elsif rising_edge(i_clk) then 
        if s_ck_re_det = '1' and s_io0_enb = '1'  then
            s_io0_ip_reg <= s_io0_ip_reg(s_io0_ip_reg'high-1 downto s_io0_ip_reg'low) & io_q0;
        end if;
    end if;
end process;

reg1_3_ip : process(i_clk, i_reset)
begin
    -- shift registers for capturing the data on IO1 to 3
    -- enabled when re detected on clock and CS is active AND command recieved on IO0 reg for read or write
    if i_reset = g_reset_level then
        s_io1_ip_reg <= (others => '0');
        s_io2_ip_reg <= (others => '0');
        s_io3_ip_reg <= (others => '0');
    elsif rising_edge(i_clk) then 
        if s_ck_re_det = '1' and s_io1_3_enb = '1'  then
            s_io1_ip_reg <= s_io1_ip_reg(s_io1_ip_reg'high-1 downto s_io1_ip_reg'low) & io_q1;
            s_io2_ip_reg <= s_io2_ip_reg(s_io2_ip_reg'high-1 downto s_io2_ip_reg'low) & io_q2;
            s_io3_ip_reg <= s_io3_ip_reg(s_io3_ip_reg'high-1 downto s_io3_ip_reg'low) & io_q3;
        end if;
    end if;
end process;

fsm_cntrl: process(i_clk, i_reset)
    --FSM to control enables of the input and output shift registers
begin
    if i_reset = g_reset_level then
        s_current_state <= idle;
        s_io0_enb   <= '0';
        s_io1_3_enb <= '0';
        s_byte_pos  <= '0';
        s_ld_cmd    <= '0';
        s_read_cnt    <= 0;
        s_cmd       <= (others =>'0');
        s_write_cnt_enb <= '0';
    elsif rising_edge(i_clk) then 
        s_ld_cmd        <= '0';
        
        case s_current_state is 

            when idle => 
                s_cmd <= (others =>'0');
                s_io1_3_enb     <= '0';
                s_io0_enb       <= '0';
                if s_cs_fe_det = '1' then
                    s_current_state <= enable_reg0;
                    s_io0_enb       <= '1';
                end if;

            when enable_reg0 =>
                s_io0_enb       <= '1';
                s_io1_3_enb     <= '0';
                if (s_io0_ip_reg = c_readio4) or (s_io0_ip_reg = c_ppio4) then
                    s_current_state <= wr_state;
                    s_write_cnt_enb <= '0';
                    s_read_cnt      <= 0;
                    s_ld_cmd        <= '1';
                    s_io1_3_enb     <= '1';
                    s_byte_pos      <= '0';
                    s_cmd           <= s_io0_ip_reg;
                end if;

            when wr_state => 
                if s_cs_re_det = '1' then
                    s_current_state <= idle;
                    s_io0_enb       <= '0';
                    s_io1_3_enb     <= '0'; 
                    o_write_length  <= std_logic_vector((to_unsigned(s_read_cnt-15,8)));
                elsif s_cmd = c_readio4 and s_read_cnt = (c_addr_length + c_dummy)-1 then -- output data 
                    s_current_state <= rd_state;
                    s_io0_enb       <= '0';
                    s_io1_3_enb     <= '0'; 
                end if;  

                if s_read_cnt <= c_addr_length then
                    s_write_cnt_enb <= '0';
                else
                    s_write_cnt_enb <= '1';
                end if;

                if s_ck_re_det = '1' then 
                    s_read_cnt <= s_read_cnt + 1;
                    s_byte_pos <= not s_byte_pos;
                end if;
            
            when rd_state => 
                if s_cs_re_det = '1' then
                    s_current_state <= idle;
                    s_io0_enb       <= '0';
                    s_io1_3_enb     <= '0'; 
                end if;
                if s_ck_re_det = '1' then 
                    s_byte_pos <= not s_byte_pos;           
                end if;
        end case;
    end if; 
end process;

write_count: process(i_clk, i_reset)
begin
    if i_reset = g_reset_level then
        s_write_cnt <= 0;
    elsif rising_edge(i_clk) then
        if s_write_cnt_enb = '1' then 
            if s_ck_re_det = '1' then 
                s_write_cnt <= s_write_cnt + 1;
            end if;
        else
            s_write_cnt <= 0;
        end if;
    end if;
end process;
     
ip_data: process(i_clk, i_reset)

begin
    if i_reset = g_reset_level then
        io_q0   <= 'Z';
        io_q1   <= 'Z';
        io_q2   <= 'Z';
        io_q3   <= 'Z';
        o_axis_tready   <= '0';
    elsif rising_edge(i_clk) then
        o_axis_tready   <= '0';
        if s_current_state = rd_state then
            if s_del_byte_pos = '0' and s_byte_pos ='1' then -- rising edge
                io_q0   <= i_axis_tdata(0);
                io_q1   <= i_axis_tdata(1);
                io_q2   <= i_axis_tdata(2);
                io_q3   <= i_axis_tdata(3);
                o_axis_tready   <= '1';
            elsif s_del_byte_pos = '1' and s_byte_pos ='0' then -- falling edge
                io_q0   <= i_axis_tdata(4);
                io_q1   <= i_axis_tdata(5);
                io_q2   <= i_axis_tdata(6);
                io_q3   <= i_axis_tdata(7);
                
            end if;
        else
            io_q0   <= 'Z';
            io_q1   <= 'Z';
            io_q2   <= 'Z';
            io_q3   <= 'Z';
        end if;
    end if;
end process;


op_data: process(i_clk, i_reset)
    -- this process latches the bytes as they are recieved by after the command and address 
    -- new bytes are received every two clocks
begin
    if i_reset = g_reset_level then
        s_del_byte_pos  <= '0';
        o_axis_tdata    <= (others =>'0');
        o_axis_tvalid   <= '0';
    elsif rising_edge(i_clk) then
        s_del_byte_pos <= s_byte_pos;
        o_axis_tvalid <= '0';
        o_axis_tlast  <= '0';
        if s_ld_cmd = '1' then -- output command 
            o_axis_tdata  <= s_cmd;
            o_axis_tvalid <= '1';
        elsif s_del_byte_pos = '1' and s_byte_pos ='0' then
            if s_current_state /= rd_state then
                o_axis_tdata (7 downto 4)   <= s_io3_ip_reg(1) & s_io2_ip_reg(1) & s_io1_ip_reg(1) & s_io0_ip_reg(1);
                o_axis_tdata (3 downto 0)   <= s_io3_ip_reg(0) & s_io2_ip_reg(0) & s_io1_ip_reg(0) & s_io0_ip_reg(0);
                o_axis_tvalid <= '1';
            end if;
        elsif s_cs_re_det = '1' then
            o_axis_tdata <= std_logic_vector(shift_right(to_unsigned(s_write_cnt+1,8),3));
            o_axis_tlast  <= '1';
            o_axis_tvalid <= '1';
        end if; 
    end if;
end process;



end architecture; 
