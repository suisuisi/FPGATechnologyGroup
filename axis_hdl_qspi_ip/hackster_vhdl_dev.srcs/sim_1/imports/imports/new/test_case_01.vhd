library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_case_01 is 
end entity;

architecture tc01 of test_case_01 is 

constant clk_period : time := 10 ns;

alias qspi_data  is << signal .test_case_01.tb.s_qspi_data  : work.prot_qspi_bfm_pkg.r_data  >>;
alias qspi_cntrl is << signal .test_case_01.tb.s_qspi_cntrl : work.prot_qspi_bfm_pkg.r_cntrl >>;
alias s_clk is << signal  .test_case_01.tb.s_clk : std_logic >>;
alias s_reset is << signal .test_case_01.tb.s_reset : std_logic >>;


begin

tb : entity work.qspi_test;

clk_gen:process
begin
    loop 
        s_clk <= '0'; 
        wait for clk_period/2;
        s_clk <= '1'; 
        wait for clk_period/2;
    end loop;
end process;

s_reset <= '1', '0' after 1 us;

stim:process 
    variable v_message_rd       :  work.prot_qspi_bfm_pkg.t_data_array(0 to 3);
    variable v_message_wr       :  work.prot_qspi_bfm_pkg.t_data_array(0 to 11);
    variable v_cmd              :  work.prot_qspi_bfm_pkg.t_data_array(0 to 0);
    variable v_do               :  work.prot_qspi_bfm_pkg.t_data_array(0 to 11);
  
  begin


    work.prot_qspi_bfm_pkg.reset_bus(qspi_data, qspi_cntrl);
    wait for  1 us;
    v_message_wr(0) := x"00";
    v_message_wr(1) := x"00";
    v_message_wr(2) := x"00";
    v_message_wr(3) := x"00";
    v_message_wr(4) := x"12";
    v_message_wr(5) := x"34";
    v_message_wr(6) := x"56";
    v_message_wr(7) := x"78";
    v_message_wr(8) := x"9a";
    v_message_wr(9) := x"bc";
    v_message_wr(10) := x"de";
    v_message_wr(11) := x"f1";
    v_cmd(0) := x"38";
    wait for 10 us;

    work.prot_qspi_bfm_pkg.master_access ( v_do, v_message_wr, v_cmd, qspi_data, qspi_cntrl, 0,0); 
    wait for 10 us;
    --read
    v_message_rd(0) := x"00";
    v_message_rd(1) := x"00";
    v_message_rd(2) := x"00";
    v_message_rd(3) := x"00";
    v_cmd(0) := x"eb";
    work.prot_qspi_bfm_pkg.master_access ( v_do, v_message_rd, v_cmd, qspi_data, qspi_cntrl, 0,8);    
 
    wait for  10 us;

    for x in 0 to 7 loop 
        if v_message_wr(x) /= v_do(x+1) then 
            report "expected data incorrect" severity warning;
        else 
            report "read data as expected" severity note;
        end if;
    end loop;

    wait for 1 us;
    
    report "simulation complete" severity failure;
    
end process;
 



end architecture;
