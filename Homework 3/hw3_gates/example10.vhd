entity adder is
  port(x      : in bit;
       y      : in bit;
       enable : in bit;
       result : out bit;
       carry  : out bit);
end adder;

architecture behavior of adder is

	function add_bits (a, b : in BIT) return bit is
	begin  -- functions cannot return multiple values
		return (a XOR b);
	end add_bits;

  begin
  
 	process (enable, x, y)
	begin	
		if (enable = '1') then
			result <= add_bits(x, y);
			carry  <= x AND y;
		else
			carry  <= '0';
			result <= '0';
		end if;
	end process;
    
end behavior;