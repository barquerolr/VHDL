library ieee;
use ieee.std_logic_1164.all;

entity uart_sm_testbench is
end uart_sm_testbench;

architecture behavior of uart_sm_testbench is

  signal clk_sig              : std_logic := '0';
  signal reset_sig            : std_logic := '0';
  signal uart_tx_data_in      : std_logic_vector(7 downto 0);
  signal write_to_uart_tx     : std_logic;
  signal uart_tx_reset        : std_logic;
  signal uart_tx_data_present : std_logic := '0';
  signal uart_tx_half_full    : std_logic:= '0';
  signal uart_tx_full         : std_logic:= '0';
  
  constant Tperiod : time := 10 ns;
  
  begin
  
    process(clk_sig)
      begin
        clk_sig <= not clk_sig after Tperiod/2;
    end process;
  
  reset_sig <= '0', '1' after 2 ns, '0' after 4 ns;
  
                    
      
    -- this is the component instantiation for the
    -- DUT - the device we are testing
	DUT : entity work.uart_control_sm(behavior)
	  port map(clk => clk_sig,
	           reset => reset_sig,
			   tx_data => uart_tx_data_in,
			   buffer_write => write_to_uart_tx,
			   buffer_reset => uart_tx_reset,
			   buffer_data_present => uart_tx_data_present,
			   buffer_half_full => uart_tx_half_full,
			   buffer_full => uart_tx_full);
   
end behavior;