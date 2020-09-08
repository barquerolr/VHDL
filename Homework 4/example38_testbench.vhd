--Programmed by: Luis Barquero
--Purpose: Testbench will simulate the T-Bird light example, except there is the inclusion of the brakes
   --The different states will be: Idle, Left Turn(no brakes), Right Turn(no brakes), Hazards, Left Turn(with brakes), 
   --				   Right Turn(with brakes).

library ieee;
use ieee.std_logic_1164.all;

entity tbird_testbench is
end tbird_testbench;

architecture behavior of tbird_testbench is

  signal clk_sig : std_logic := '0';
  signal rst_sig : std_logic := '0';
  signal left_sig,right_sig,haz_sig,brakes_sig : std_logic;
  constant Tperiod : time := 10 ns;
  
  begin
  
    process(clk_sig)
      begin
        clk_sig <= not clk_sig after Tperiod/2;
    end process;
  
  rst_sig <= '0', '1' after 2 ns, '0' after 4 ns;        --Reset Signal
  
--Left will be on from 20 to 60 ns(no brake), then it will be on from 140-240 (with brakes from 160-220).

  left_sig <= '0', '1' after 20 ns, '0' after 60 ns, '1' after 140 ns, '0' after 240 ns; 


--Right will be on from 60 to 100 ns(no brake), then it will be on from 240-340 (with brakes from 260-320).
  
  right_sig <= '0', '1' after 60 ns, '0' after 100 ns, '1' after 240 ns, '0' after 340 ns ;


--Hazard will be on from 100 to 140 ns.
  
  haz_sig <= '0', '1' after 100 ns, '0' after 140 ns;


--Brakes will be on from 160 to 220 ns(for left turn with brakes), then it will be on from 260-320 (for right turn with brakes).

  brakes_sig <= '0', '1' after 160 ns, '0' after 220 ns, '1' after 260 ns, '0' after 320 ns;
                    
      
    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.tbird_lc(behavior)
      port map(clk => clk_sig, rst => rst_sig,
               left => left_sig, right => right_sig,
               haz => haz_sig, brakes => brakes_sig);

    
end behavior;