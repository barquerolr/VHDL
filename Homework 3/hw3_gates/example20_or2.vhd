library IEEE;
use IEEE.std_logic_1164.all;

entity or2_with_rf is
  generic(TpHL : time := 3 ns;
          TpLH : time := 2 ns);
  port(in1  : in std_logic;
       in2  : in std_logic;
       out1 : out std_logic);
end or2_with_rf;

architecture simple of or2_with_rf is

begin
  
  process(in1, in2)
  begin
    if(in1 = '0' and in2 = '0') then
      out1 <= '0' after TpHL;
    elsif(in1 = '1' or in2 = '1') then
      out1 <= '1' after TpLH;
    else
      out1 <= 'X'; -- handle all other input values
    end if;
  end process;
  
end simple;
