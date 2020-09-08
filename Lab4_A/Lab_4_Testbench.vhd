LIBRARY IEEE;
USE IEEE.NUMERIC_STD. ALL;
USE IEEE.STD_LOGIC_1164.ALL;

entity lab4_testbench is
end lab4_testbench;

architecture behavior of lab4_testbench is
--define the maximum delay for the DUT
constant MAX_DELAY : time := 100 ns;
constant BIT_WIDTH : integer := 16;
constant BIT_WIDTH_2 : integer := 3;
constant NO_VECTORS : integer := 2;
signal A_sig, B_sig : STD_LOGIC_VECTOR(0 to BIT_WIDTH -1);
signal EN_sig: STD_LOGIC:= '0';
signal MODE_sig: STD_LOGIC_VECTOR(0 to BIT_WIDTH_2 -1);
signal C_OUT_sig: STD_LOGIC:= '0';
signal PARITY_sig: STD_LOGIC := '0';
signal ZERO_sig: STD_LOGIC := '0';
signal C_sig : STD_LOGIC_VECTOR(0 to BIT_WIDTH -1);

--declare a constant to hold an array of input values
type input_value_array is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH -1);
type input_value_array_2 is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH_2 -1);
type output_value_array is array(1 to NO_VECTORS) of std_logic_vector(0 to BIT_WIDTH -1);
constant A : input_value_array := ("0000000000001001",
                                   "0000000000001111");

constant B : input_value_array := ("0000000000000110",
				   "0000000000001111");
constant MODE : input_value_array_2 := ("000",
                                       "000");

constant C : output_value_array := ("0000000000001111",
                                    "0000000000011110");

constant EN : std_logic_vector(1 to NO_VECTORS) :=
('1','1');


constant PARITY : std_logic_vector(1 to NO_VECTORS) :=
('0','1');

constant ZERO : std_logic_vector(1 to NO_VECTORS) :=
('0','0');

constant C_OUT: std_logic_vector(1 to NO_VECTORS) :=
('0','1');

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
                                   