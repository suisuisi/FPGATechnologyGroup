library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package qspi_bfm_pkg is
    generic(
        G_CS_POL          : integer := 0; 
        G_CPOL            : integer := 0; 
        G_CPHA            : integer := 0; 
        G_ENDIANESS       : string  := "MSB";
        G_BITS_PER_WORD   : integer := 8;
        G_NUM_SLAVES      : integer := 1;
        G_PERIOD          : time    := 1 us; 
        G_DUMMY           : integer := 4;
        G_START_WAIT      : time    := G_PERIOD * G_BITS_PER_WORD;
        G_INTER_WORD_WAIT : time    := G_PERIOD * 2;
        G_END_WAIT        : time    := G_PERIOD * G_BITS_PER_WORD
    );
		
    ------------------------------------------------------------------------------------
    --Constants - can be used to parameterise test benches
    constant c_cs_pol           : integer := G_CS_POL;       
    constant c_cpol             : integer := G_CPOL;         
    constant c_cpha             : integer := G_CPHA;         
    constant c_endianess        : string  := G_ENDIANESS;    
    constant c_bits_per_word    : integer := G_BITS_PER_WORD;
    constant c_num_slaves       : integer := G_NUM_SLAVES;
    constant c_period           : time    := G_PERIOD;          
    constant c_start_wait       : time    := G_START_WAIT;     
    constant c_inter_word_wait  : time    := G_INTER_WORD_WAIT;
    constant c_end_wait         : time    := G_END_WAIT;   
    constant c_dummy            : integer := G_DUMMY;    

	type t_data_array is array(integer range <>) of unsigned(c_bits_per_word-1 downto 0);

    ------------------------------------------------------------------------------------
    --SPI signal record
	type r_data is record
		s_io0		: std_logic;
        s_io1       : std_logic;
        s_io2       : std_logic;
        s_io3       : std_logic;
	end record r_data;

    type r_cntrl is record
        s_sclk 	    : std_ulogic;
		s_cs		: std_ulogic_vector(c_num_slaves - 1 downto 0);
	end record r_cntrl;
	
    ------------------------------------------------------------------------------------
    --Procedure used to reset the bus to its initial state			
	procedure reset_bus (signal o_qspi_data  : out r_data;
                         signal o_qspi_cntrl : out r_cntrl);

    ------------------------------------------------------------------------------------
    --Procedure to read and write data from a slave
    procedure master_access (       o_data             : out t_data_array;      --Data array of unsigned that were read
                                    i_data 	           : in  t_data_array;      --Data array of unsigned to send
                                    i_cmd              : in t_data_array;
                             signal o_qspi_data        : inout r_data;          --QSPI Data
                             signal o_qspi_cntrl       : out  r_cntrl;          --QSPI Cntrl
                                    i_slave            : in  integer;           --Slave to access
                                    i_rd_lng           : in integer);           --number of bytes to receive

end package qspi_bfm_pkg;

package body qspi_bfm_pkg is 
    
    ------------------------------------------------------------------------------------
    --Procedure used to reset the bus to its initial state
	procedure reset_bus (   signal o_qspi_data  : out r_data;
                            signal o_qspi_cntrl : out r_cntrl) is        

        variable v_cs_pol : std_ulogic;
        variable v_sclk_pol : std_ulogic;

    begin

        v_cs_pol := not std_ulogic(to_unsigned(c_cs_pol, 1)(0));
        v_sclk_pol := std_ulogic(to_unsigned(c_cpol, 1)(0));

        o_qspi_data.s_io0 <= '0';
        o_qspi_data.s_io1 <= '0';
        o_qspi_data.s_io2 <= '0';
        o_qspi_data.s_io3 <= '0';
        o_qspi_cntrl.s_sclk <= v_sclk_pol;
        o_qspi_cntrl.s_cs <= (others => v_cs_pol);
        
	end procedure reset_bus;

    -----------------------------------------------------------------------------------------------	
    --Procedure used to stream data sent by a master				
    procedure master_access (       o_data             : out t_data_array;
                                    i_data 	           : in  t_data_array;
                                    i_cmd              : in t_data_array;
                             signal o_qspi_data        : inout r_data;    
                             signal o_qspi_cntrl       : out r_cntrl;  
                                    i_slave            : in  integer;
                                    i_rd_lng           : in integer) is

        variable v_word_out   : std_ulogic_vector(c_bits_per_word - 1 downto 0);
        variable v_word_in    : std_ulogic_vector(c_bits_per_word - 1 downto 0);
        variable v_bit_select : integer;

        variable v_cs_pol   : std_ulogic;
        variable v_sclk_pol : std_ulogic;
        
        variable o_0 : std_ulogic_vector(1 downto 0);
        variable o_1 : std_ulogic_vector(1 downto 0);
        variable o_2 : std_ulogic_vector(1 downto 0);
        variable o_3 : std_ulogic_vector(1 downto 0);
        variable o_vec : std_ulogic_vector(7 downto 0);

	begin
		
        v_cs_pol := std_ulogic(to_unsigned(c_cs_pol, 1)(0));
        v_sclk_pol := std_ulogic(to_unsigned(c_cpol, 1)(0));

        o_qspi_cntrl.s_cs(i_slave) <= v_cs_pol;
        wait for c_start_wait;
        v_word_out := std_ulogic_vector(i_cmd(0));
        --send io0 command 
        for bit_count in 0 to c_bits_per_word - 1 loop
            if (c_endianess = "MSB") then
                v_bit_select := c_bits_per_word - 1 - bit_count;
            else 
                v_bit_select := bit_count;
            end if;
            
            o_qspi_cntrl.s_sclk <= '0';
            if (c_cpha = 0) then
                o_qspi_data.s_io0 <= v_word_out(v_bit_select);
            end if;
            wait for (c_period/2);

            o_qspi_cntrl.s_sclk <= '1';
            if (c_cpha = 1) then
                o_qspi_data.s_io0 <= v_word_out(v_bit_select);
            end if;
            wait for (c_period/2);
        end loop;

        --send address 
        for word_count in 0 to 3 loop
            v_word_out := std_ulogic_vector(i_data(word_count));
            for bit_count in 0 to ((c_bits_per_word /4) - 1) loop
                if (c_endianess = "MSB") then
                    v_bit_select := bit_count;
                    
                else 
                    v_bit_select := ((c_bits_per_word /4) - 1) - bit_count;
                end if;
                o_qspi_cntrl.s_sclk <= '0';
                if (c_cpha = 0) then
                    o_qspi_data.s_io0 <= v_word_out((v_word_out'high-3) - (v_bit_select *4));
                    o_qspi_data.s_io1 <= v_word_out((v_word_out'high-2) - (v_bit_select *4));
                    o_qspi_data.s_io2 <= v_word_out((v_word_out'high-1) - (v_bit_select *4));
                    o_qspi_data.s_io3 <= v_word_out(v_word_out'high - (v_bit_select *4));
                end if;
                wait for (c_period/2);

                o_qspi_cntrl.s_sclk <= '1';
                if (c_cpha = 1) then
                    o_qspi_data.s_io0 <= v_word_out((v_word_out'high-3) - (v_bit_select *4));
                    o_qspi_data.s_io1 <= v_word_out((v_word_out'high-2) - (v_bit_select *4));
                    o_qspi_data.s_io2 <= v_word_out((v_word_out'high-1) - (v_bit_select *4));
                    o_qspi_data.s_io3 <= v_word_out(v_word_out'high - (v_bit_select *4));
                end if;
                wait for (c_period/2);

            end loop;
        end loop;    
        
        if i_cmd(0) = x"EB" then 
            --send dummy bits 
            for bit_count in 0 to c_dummy - 1 loop 
                o_qspi_cntrl.s_sclk <= '0';
                o_qspi_data.s_io0   <= '0';
                o_qspi_data.s_io1   <= '0';
                o_qspi_data.s_io2   <= '0';
                o_qspi_data.s_io3   <= '0';
                wait for (c_period/2);
                o_qspi_cntrl.s_sclk <= '1';
                wait for (c_period/2);

            end loop;
                o_qspi_data.s_io0   <= 'Z';
                o_qspi_data.s_io1   <= 'Z';
                o_qspi_data.s_io2   <= 'Z';
                o_qspi_data.s_io3   <= 'Z';                

            --generate clocks for the read data
            for word_count in 0 to i_rd_lng - 1 loop
                for bit_count in 0 to ((c_bits_per_word /4) - 1) loop
                    o_qspi_data.s_io0   <= 'Z';
                    o_qspi_data.s_io1   <= 'Z';
                    o_qspi_data.s_io2   <= 'Z';
                    o_qspi_data.s_io3   <= 'Z';
                    o_qspi_cntrl.s_sclk <= '0';
                    wait for (c_period/2);
                    o_qspi_cntrl.s_sclk <= '1';
                    
                    o_0 :=  o_0(o_0'low) & o_qspi_data.s_io0;
                    o_1 :=  o_1(o_1'low) & o_qspi_data.s_io1;
                    o_2 :=  o_2(o_2'low) & o_qspi_data.s_io2;
                    o_3 :=  o_3(o_3'low) & o_qspi_data.s_io3;
                    wait for (c_period/2);
                end loop;
                    if (c_endianess = "MSB") then
                        o_vec (7 downto 4) := o_3(1) & o_2(1) & o_1(1) & o_0(1);
                        o_vec (3 downto 0) := o_3(0) & o_2(0) & o_1(0) & o_0(0); 
                    else
                        o_vec (3 downto 0) := o_3(1) & o_2(1) & o_1(1) & o_0(1);
                        o_vec (7 downto 4) := o_3(0) & o_2(0) & o_1(0) & o_0(0); 
                    end if;
                    o_data(word_count) := unsigned(o_vec);
            end loop;
        end if;
     
        if i_cmd(0) = x"38" then 
            --send data
            for word_count in 4 to i_data'length - 1 loop
                v_word_out := std_ulogic_vector(i_data(word_count));
                for bit_count in 0 to ((c_bits_per_word /4) - 1) loop
                    if (c_endianess = "MSB") then
                        v_bit_select := bit_count;
                    else 
                        v_bit_select := ((c_bits_per_word /4) - 1) - bit_count;
                    end if;
                    
                    o_qspi_cntrl.s_sclk <= '0';
                    if (c_cpha = 0) then
                        o_qspi_data.s_io0 <= v_word_out((v_word_out'high-3) - (v_bit_select *4));
                        o_qspi_data.s_io1 <= v_word_out((v_word_out'high-2) - (v_bit_select *4));
                        o_qspi_data.s_io2 <= v_word_out((v_word_out'high-1) - (v_bit_select *4));
                        o_qspi_data.s_io3 <= v_word_out(v_word_out'high - (v_bit_select *4));
                    end if;
                    wait for (c_period/2);

                    o_qspi_cntrl.s_sclk <= '1';
                    if (c_cpha = 1) then
                        o_qspi_data.s_io0 <= v_word_out((v_word_out'high-3) - (v_bit_select *4));
                        o_qspi_data.s_io1 <= v_word_out((v_word_out'high-2) - (v_bit_select *4));
                        o_qspi_data.s_io2 <= v_word_out((v_word_out'high-1) - (v_bit_select *4));
                        o_qspi_data.s_io3 <= v_word_out(v_word_out'high - (v_bit_select *4));
                    end if;
                    wait for (c_period/2);

                end loop;

                o_data(word_count) := unsigned(v_word_in);        
            end loop;
        end if;
        o_qspi_cntrl.s_sclk <= v_sclk_pol;
        wait for c_end_wait;
        o_qspi_cntrl.s_cs(i_slave) <= not v_cs_pol;
        o_qspi_data.s_io0 <= '0';
        o_qspi_data.s_io1 <= '0';
        o_qspi_data.s_io2 <= '0';
        o_qspi_data.s_io3 <= '0';
        wait for c_inter_word_wait;
	end procedure master_access;

end package body qspi_bfm_pkg;