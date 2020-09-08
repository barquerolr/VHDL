library IEEE;
use IEEE.std_logic_1164.all;

entity hmwk2_f3_tb is
end hmwk2_f3_tb;

architecture behavior of hmwk2_f3_tb is

  -- define the maximum delay for the DUT
  constant MAX_DELAY : time := 50 ns;
  constant NO_OF_VALUES : integer := 16;

  --declare a constant to hold an array of input values
  type input_value_array is array (0 to (NO_OF_VALUES-1)) of std_logic;
  constant in1_sig_values : input_value_array := ('0','1','0','1',
                                                  '0','1','0','1',
                                                  '0','1','0','1',
                                                  '0','1','0','1');
  constant in2_sig_values : input_value_array := ('0','0','1','1',
                                                  '0','0','1','1',
                                                  '0','0','1','1',
                                                  '0','0','1','1');
  constant in3_sig_values : input_value_array := ('0','0','0','0',
                                                  '1','1','1','1',
                                                  '0','0','0','0',
                                                  '1','1','1','1');
  constant in4_sig_values : input_value_array := ('0','0','0','0',
                                                  '0','0','0','0',
                                                  '1','1','1','1',
                                                  '1','1','1','1');
  -- define signals that connect to DUT
  signal in1_sig : std_logic;
  signal in2_sig : std_logic;
  signal in3_sig : std_logic;
  signal in4_sig : std_logic;
  signal out1 : std_logic; 
  
  begin
  
	-- this is the process that will generate the inputs
    stimulus : process
     begin
        for i in 0 to (NO_OF_VALUES-1) loop
          in1_sig <= in1_sig_values(i);
          in2_sig <= in2_sig_values(i);
          in3_sig <= in3_sig_values(i);
          in4_sig <= in4_sig_values(i);
          wait for MAX_DELAY;
        end loop;
      wait; -- stop the process to avoid an infinite loop
    end process stimulus;

    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.f3(structural)
        port map(  D => in1_sig,
                   C => in2_sig,
                   B => in3_sig,
                   A => in4_sig,
                   F => out1);
end behavior;


