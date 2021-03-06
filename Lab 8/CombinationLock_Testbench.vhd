library ieee;
use ieee.std_logic_1164.all;

entity ComboLock_testbench is
end ComboLock_testbench;

architecture behavior of ComboLock_testbench is

	signal clk_sig : std_logic := '0';
	signal rst_sig : std_logic := '0';
	signal up_sig,down_sig,left_sig,right_sig,center_sig: std_logic;
	signal out_sig : std_logic_vector(7 downto 0) := "00000000";
	constant Tperiod : time := 10 ns;

	begin

		process(clk_sig)
		begin
		clk_sig <= not clk_sig after Tperiod/2;
		end process;

		rst_sig <= '0', '1' after 2 ns, '0' after 4 ns, '1' after 238 ns;

		up_sig <= '0', '1' after 42 ns, '0' after 47 ns, '1' after 92 ns, '0' after 97 ns, '1' after 132 ns, '0' after 137 ns, '1' after 162 ns, '0' after 167 ns;

		down_sig <= '0', '1' after 32 ns, '0' after 37 ns, '1' after 62 ns, '0' after 67 ns, '1' after 122 ns, '0' after 127 ns, '1' after 172 ns, '0' after 177 ns;

		left_sig <= '0', '1' after 22 ns, '0' after 27 ns, '1' after 72 ns, '0' after 77 ns, '1' after 112 ns, '0' after 117 ns, '1' after 182 ns, '0' after 187 ns, '1' after 222 ns;

		right_sig <= '0', '1' after 12 ns, '0' after 17 ns, '1' after 82 ns, '0' after 87 ns, '1' after 142 ns, '0' after 147 ns, '1' after 192 ns, '0' after 197 ns;

		center_sig <= '0', '1' after 52 ns, '0' after 57 ns, '1' after 102 ns, '0' after 107 ns, '1' after 152 ns, '0' after 157 ns, '1' after 202 ns, '0' after 207 ns, '1' after 212 ns, '0' after 217 ns;


		-- this is the component instantiation for the
		-- DUT - the device we are testing
		DUT : entity work.sm1(behavior)
			port map(clk => clk_sig, rst => rst_sig,
					up => up_sig,down => down_sig,lft => left_sig,rght => right_sig,center => center_sig,z => out_sig);


end behavior;