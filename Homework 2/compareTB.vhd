--Programmed by: Luis Baquero
--Purpose: This VHDL Testbench will take 4 inputs and will determine the maximum value, the minimum value
--	   the index of the maximum value, and the index of the minimum value.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY compareTB IS
END compareTB;
 
ARCHITECTURE behavior OF compareTB IS 
 
   -- define the maximum delay for the DUT
   constant MAX_DELAY : time := 100 ns;
   constant BIT_WIDTH : integer := 8;
   constant NO_OF_VALUES : integer := 10;

 -- define signals that connect to DUT
   signal in0_sig  : std_logic_vector((BIT_WIDTH-1) downto 0);  --Input 0
   signal in1_sig  : std_logic_vector((BIT_WIDTH-1) downto 0);  --Input 1
   signal in2_sig  : std_logic_vector((BIT_WIDTH-1) downto 0);  --Input 2
   signal in3_sig  : std_logic_vector((BIT_WIDTH-1) downto 0);	--Input 3
   signal max_index_sig : std_logic_vector(1 downto 0);	    --Max Index
   signal min_index_sig : std_logic_vector(1 downto 0);	    --Min Index
   signal max_value_sig : std_logic_vector((BIT_WIDTH-1) downto 0);	--Max Value
   signal min_value_sig : std_logic_vector((BIT_WIDTH-1) downto 0);	--Min Value
 
 
   --declare a constant to hold arrays of input values for each input signal
   type input_value_array is array (0 to (NO_OF_VALUES-1)) of std_logic_vector ((BIT_WIDTH-1) downto 0);
   constant in0_sig_values : input_value_array := ("00100010","00000000",   --Test Cases 1 and 2 for Input 0
                                                   "00000001","00100100",   --Test Cases 3 and 4 for Input 0	
                                                   "00000011","01111010",   --Test Cases 5 and 6 for Input 0	
                                                   "10010010","10001000",   --Test Cases 7 and 8 for Input 0
                                                   "00100100","00000010");  --Test Cases 9 and 10 for Input 0

   constant in1_sig_values : input_value_array := ("00110011","00000000",	--Test Cases 1 and 2 for Input 1
                                                   "00011001","00100100",	--Test Cases 3 and 4 for Input 1
                                                   "00001100","01111000",	--Test Cases 5 and 6 for Input 1
                                                   "10010010","10001000",	--Test Cases 7 and 8 for Input 1
                                                   "00100100","00000101");	--Test Cases 9 and 10 for Input 1

   constant in2_sig_values : input_value_array := ("00000000","11111111",	--Test Cases 1 and 2 for Input 2
                                                   "01000000","01000000",	--Test Cases 3 and 4 for Input 2
                                                   "00000110","01111011",	--Test Cases 5 and 6 for Input 2
                                                   "10010010","10001000",	--Test Cases 7 and 8 for Input 2
                                                   "01001000","00000001");	--Test Cases 9 and 10 for Input 2

   constant in3_sig_values : input_value_array := ("11111111","11111111",	--Test Cases 1 and 2 for Input 3
                                                   "01000000","01100101",	--Test Cases 3 and 4 for Input 3
                                                   "00001001","01111001",	--Test Cases 5 and 6 for Input 3
                                                   "10010010","10001000",	--Test Cases 7 and 8 for Input 3
                                                   "01001000","00000111");      --Test Cases 9 and 10 for Input 3                                                                                            
 
   begin
  
	 -- this is the process that will generate the inputs
    stimulus : process
      begin
        for i in 0 to (NO_OF_VALUES-1) loop
          in0_sig <= in0_sig_values(i);
          in1_sig <= in1_sig_values(i);
          in2_sig <= in2_sig_values(i);
          in3_sig <= in3_sig_values(i);
          wait for MAX_DELAY;
        end loop;
        wait; -- stop the process to avoid an infinite loop
    end process stimulus;
 
    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.compareENT(simple)
        port map(  in0     => in0_sig,		
                   in1     => in1_sig,
                   in2     => in2_sig,
                   in3     => in3_sig,
                   max_idx => max_index_sig,
                   min_idx => min_index_sig,
                   max_val => max_value_sig,
                   min_val => min_value_sig);
end behavior;
 
