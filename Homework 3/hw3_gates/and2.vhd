library IEEE;
use IEEE.std_logic_1164.all;

entity and2 is
  generic(Tp : time := 2 ns);
  port(in1  : in std_logic;
       in2  : in std_logic;
       out1 : out std_logic);
end and2;

architecture simple of and2 is

begin
  
  process(in1, in2)
  begin
    if(in1 = '1' and in2 = '1') then
      out1 <= transport '1' after Tp;
    elsif(in1 = '0' or in2 = '0') then
      out1 <= transport '0' after Tp;
    else
      out1 <= 'X'; -- handle all other input values
    end if;
  end process;
  
end simple;
