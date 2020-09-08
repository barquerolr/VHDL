library ieee;
use ieee.std_logic_1164.all;

entity sm1_testbench is
end sm1_testbench;

architecture behavior of sm1_testbench is

  signal clk_sig : std_logic := '0';
  signal rst_sig : std_logic := '0';
  signal x_sig,z_sig : std_logic;
  constant Tperiod : time := 10 ns;
  
  begin
  
    process(clk_sig)
      begin
        clk_sig <= not clk_sig after Tperiod/2;
    end process;
  
  rst_sig <= '0', '1' after 2 ns, '0' after 4 ns;
  
  x_sig <= '0', '1' after 20 ns, '0' after 50 ns,
           '1' after 80 ns, '0' after 90 ns, '1' after 98 ns,
           '0' after 101 ns;
                    
      
    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.sm1(behavior)
      port map(clk => clk_sig, rst => rst_sig,
               x => x_sig, z => z_sig);

    
end behavior;