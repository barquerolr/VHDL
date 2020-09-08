library ieee;
use ieee.std_logic_1164.all;

entity full_adder_testbench is
end full_adder_testbench;

architecture behavior of full_adder_testbench is

  signal A_sig, B_sig, Cin_sig  : std_ulogic := '0';
  signal Sum_sig, Cout_sig : std_ulogic;
  
  begin
  
  process(A_sig)
    begin
      A_sig <= not A_sig after 10 ns;
  end process;
   process(B_sig)
    begin
      B_sig <= not B_sig after 20 ns;
  end process;

  process(Cin_sig)
    begin
      Cin_sig <= not Cin_sig after 40 ns;
  end process;
  
    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.full_adder(structural2)
      port map(A => A_sig, B => B_sig, Cin => Cin_sig,
	           Sum => Sum_sig, Cout => Cout_sig);

    
end behavior;