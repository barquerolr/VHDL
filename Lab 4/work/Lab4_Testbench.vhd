LIBRARY IEEE;
USE IEEE.NUMERIC_STD. ALL;
USE IEEE.STD_LOGIC_1164.ALL;

entity Lab4_Testbench is
end Lab4_Testbench;

architecture behavior of Lab4_Testbench is
--define the maximum delay for the DUT
constant MAX_DELAY : time := 100 ns;
constant BIT_WIDTH : integer := 16;
constant BIT_WIDTH_2 : integer := 3;
constant NO_VECTORS : integer := 32;
constant NO_VECTORS2: integer := 20;

signal A_sig, B_sig : STD_LOGIC_VECTOR(0 to BIT_WIDTH -1);
signal EN_sig: STD_LOGIC:= '0';
signal MODE_sig: STD_LOGIC_VECTOR(0 to BIT_WIDTH_2 -1);
signal C_OUT_sig: STD_LOGIC:= '0';
signal PARITY_sig: STD_LOGIC := '0';
signal ZERO_sig: STD_LOGIC := '0';
signal C_sig : STD_LOGIC_VECTOR(0 to BIT_WIDTH -1);

--declare a constant to hold an array of input values
type input_value_array is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH -1);
type input_value_array2 is array(1 to NO_VECTORS2) of std_logic_vector(0 to BIT_WIDTH -1);
type input_value_array3 is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH_2 -1);
type output_value_array is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH -1);

constant A : input_value_array := ("0000000000001001",
                                   "0000000000001111",     --Mode 0
				   "0000000000000000",
                                   "0000000000001111",

				   "0000000000001001",
                                   "0000000000001111",	   --Mode 1
				   "0000000000000000",
                                   "0000000000001111",

				   "0000000000001001",
                                   "0000000000001111",     --Mode 2
				   "0000000000000000",
                                   "0000000000001000",
				
				   "0000000000001001",
                                   "0000000000001101",     --Mode 3
				   "0000000000000100",
                                   "0000000000001000",

				   "0000000000001111",
                                   "0000000000001001",	   --Mode 4
				   "0000000000000100",
                                   "0000000000001100",

				   "0000000000001111",
                                   "0000000000000000",     --Mode 5
				   "0000000000000000",
                                   "0000000000001100",

				   "0000000000001111",
                                   "0000000000000000",     --Mode 6
				   "0000000000000000",
                                   "0000000000001111",

				   "0000000000001111",
                                   "0000000000000111",     --Mode 7
				   "0000000000000000",
                                   "0000000000001110");


constant B : input_value_array2 := ("0000000000000110",
				   "0000000000001111",     --Mode 0
				   "0000000000000000",
				   "0000000000001101",
                                      
				   "0000000000000110",
                                   "0000000000001111",     --Mode 1
				   "0000000000000000",
                                   "0000000000001101",

				   "0000000000000000",
                                   "0000000000000110",	   --Mode 4
				   "0000000000001101",
                                   "0000000000000100",

				   "0000000000000000",
                                   "0000000000000001",	   --Mode 5
				   "0000000000000000",
                                   "0000000000000100",

				   "0000000000000000",
                                   "0000000000000001",	   --Mode 6
				   "0000000000000000",
                                   "0000000000001111");

				  
constant MODE : input_value_array3 :=  ("000",
                                        "000",
					"000",
					"000",
					"001",
					"001",
					"001",
					"001",
					"010",
					"010",
					"010",
					"010",
					"011",
					"011",
					"011",
					"011",
					"100",
					"100",
					"100",
					"100",
					"101",
					"101",
					"101",
					"101",
					"110",
					"110",
					"110",
					"110",
					"111",
					"111",
					"111",
					"111");

constant C : output_value_array := ("0000000000001111",
                                    "0000000000011110",		--Mode 0
                                    "0000000000000000",
				    "0000000000011110",

				    "0000000000010111",
                                    "0000000000010000", 	--Mode 1
                                    "0000000000010000",
				    "0000000000010010",

				    "1111111111110111",
                                    "1111111111110001",		--Mode 2
                                    "1111111111110000",
				    "1111111111111000",

				    "0000000000010010",
                                    "0000000000011010",		--Mode 3
                                    "0000000000001000",
				    "0000000000010000",

				    "0000000000000000",
                                    "0000000000000000",		--Mode 4
                                    "0000000000000101",
				    "0000000000000100",

				    "0000000000001111",
                                    "0000000000000001",		--Mode 5
                                    "0000000000000000",
				    "0000000000001100",

				    "0000000000001111",	
                                    "0000000000000001",		--Mode 6
                                    "0000000000000000",
				    "0000000000000000",

				    "1111111111110000",
                                    "1111111111111000",
                                    "1111111111111111",
				    "1111111111110001");

constant EN : std_logic_vector(1 to NO_VECTORS) :=
('1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1');

constant PARITY : std_logic_vector(1 to NO_VECTORS) :=
('0','1','0','0','0','0','0','1','1','1','0','1','0','1','1','1','0','0','0','1','0','1','0','0','0','1','0','0','0','1','0','1');

constant ZERO : std_logic_vector(1 to NO_VECTORS) :=
('0','0','1','0','0','1','1','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','1','0','0','0','1','1','1','0','0','0');

constant C_OUT: std_logic_vector(1 to NO_VECTORS) :=
('0','1','0','1','1','1','1','1','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');

-- define signals that connect to DUT

begin
  
-- this is the process that will generate the inputs

stimulus: process

  begin
    for i in 1 to NO_VECTORS loop
      A_sig <= A(i);
      B_sig <= B(i);
      EN_sig <= EN(i);
      MODE_sig <= MODE(i);

      wait for MAX_DELAY;
    end loop;
    wait; -- stops the process to avoid an infinite loop
  end process stimulus;
  
  -- this is the component instantiation for the 
  -- DUT - the device we are testing 
  DUT : entity work.LAB4(simple)
        generic map(N => BIT_WIDTH)
        port map(A => A_sig, B => B_sig, EN => EN_sig, MODE => MODE_sig, PARITY => PARITY_sig, ZERO => ZERO_sig,
                 C_OUT => C_OUT_sig, C => C_sig);  
                    
end behavior;  
                                   