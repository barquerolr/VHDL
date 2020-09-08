library IEEE;
use IEEE.std_logic_1164.all;

entity inv is
  generic(Tp : time := 1 ns);
  port(in1  : in std_logic;
       out1 : out std_logic);
end inv;

architecture simple of inv is

begin
  
  process(in1)
  begin
    if(in1 = '1') then
      out1 <= transport '0' after Tp;
    elsif(in1 = '0') then
      out1 <= transport '1' after Tp;
    else
      out1 <= 'X'; -- handle all other input values
    end if;
  end process;
  
end simple;
