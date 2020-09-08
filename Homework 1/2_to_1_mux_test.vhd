entity two_to_one_mux_test is
end two_to_one_mux_test;

architecture behavior of two_to_one_mux_test is

signal input : bit_vector (0 to 2);
signal output: bit;
begin

stimulus : process
   begin
	input <= "000" after 100 ns,
		 "001" after 200 ns,
           	 "010" after 300 ns,
		 "011" after 400 ns,
		 "100" after 500 ns,
           	 "101" after 600 ns,
		 "110" after 700 ns,
		 "111" after 800 ns;

	wait;
      end process stimulus;

	DUT: entity work.two_to_one_mux(simple)
	     port map(a => input(0),
		      b => input(1),
		      sel => input(2),
		      y => output);

	
end behavior;