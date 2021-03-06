library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity lab_3 is
  generic(N: integer := 4);
    port( in_4_bit: in bit_vector(N-1 downto 0);
          parity: out bit;
          zero: out bit;
          one: out bit);
end lab_3;

architecture simple of lab_3 is
begin
  process(in_8_bit)
  variable i : integer;
  variable sum: integer;
  begin
  i := 0;
  sum := 0;
  while(i <= N-1) loop
    if(in_8_bit(i) = '1') then
      sum := sum + 1;
    end if;
      i := i + 1; 
    end loop;
    
    if(sum MOD 2 = 1) then
    parity <= '1';
    else
      parity <= '0';
    end if;
    
    if(sum = 0) then
    zero <= '1';
    else 
       zero <= '0';
    end if;
    
    if(sum = N)then
    one <= '1';
    else
       one <= '0';
    end if;
    end process; 
end simple;