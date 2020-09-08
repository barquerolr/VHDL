library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity uart_control_sm is
	port(clk                 : in std_logic;
	     reset               : in std_logic;
	     tx_data             : out std_logic_vector(7 downto 0);
		 buffer_write        : out std_logic;
		 buffer_reset        : out std_logic;
		 buffer_data_present : in std_logic;
		 buffer_half_full    : in std_logic;
		 buffer_full         : in std_logic;
		 data_in_lsb         : in std_logic_vector(7 downto 0);
		 data_in_msb         : in std_logic_vector(7 downto 0));
end uart_control_sm;

architecture behavior of uart_control_sm is

  constant NO_CHARACTERS : integer := 15;
  constant BYTE : integer := 8;
  type output_Character_array is array (0 to NO_CHARACTERS-1) of std_logic_vector(Byte-1 downto 0);
  constant out_string : output_Character_array := (x"1b",     --<ESC>
                                                   x"5b",     --"["
                                                   x"30",     --"0"
                                                   x"6a",     --"j"
                                                   x"20",     --" "
                                                   x"20",     --" "
                                                   x"56",     --"V"
                                                   x"69",     --"i"
                                                   x"6e",     --"n"
                                                   x"30",     --"0"
                                                   x"3d",     --"="
                                                   x"38",     --"8"
                                                   x"2e",     --"."
                                                   x"37",     --"7"
                                                   x"56");    --"V"

  type state_type is (START, WRITE, DONE);
  signal present_state, next_state : state_type;
  subtype count_type is integer range 0 to NO_CHARACTERS;
  signal msb_count : count_type := 11;
  signal lsb_count : count_type := 13;
  signal present_count, next_count : count_type;

	begin
    
    clocked : process(clk,reset)
     begin
       if(reset='1') then 
         present_state <= START;
         present_count <= 0;
      elsif(rising_edge(clk)) then
        present_state <= next_state;
        present_count <= next_count;
      end if;     
    end process clocked;

    nextstate : process(present_state)
     begin
       case present_state is
         when START =>
           if(buffer_full = '0') then
             next_state <= WRITE;
             next_count <= present_count;
           else
             next_state <= START;
             next_count <= present_count;
           end if;
         when WRITE =>
           next_state <= DONE;
           next_count <= present_count;
         when DONE =>
           if(present_count < NO_CHARACTERS-1) then
             next_state <= START;
             next_count <= present_count + 1;
           else
             next_state <= DONE;
             next_count <= present_count;
          end if;
       end case;
    end process nextstate;
   
    output : process(present_state)
     begin
       case present_state is
         when START =>
           IF(present_count = lsb_count) THEN
             tx_data <= data_in_lsb;
           ELSIF(present_count = msb_count) THEN
             tx_data <= data_in_msb;
           ELSE
             tx_data <= out_string(present_count);
           END IF;
           buffer_write <= '0';
           buffer_reset <= '0'; 
         when WRITE =>
           IF(present_count = lsb_count) THEN
             tx_data <= data_in_lsb;
           ELSIF(present_count = msb_count) THEN
             tx_data <= data_in_msb;
           ELSE
             tx_data <= out_string(present_count);
           END IF;
           buffer_write <= '1';
           buffer_reset <= '0'; 
         when DONE =>
           IF(present_count = lsb_count) THEN
             tx_data <= data_in_lsb;
           ELSIF(present_count = msb_count) THEN
             tx_data <= data_in_msb;
           ELSE
             tx_data <= out_string(present_count);
           END IF;
           buffer_write <= '0';
           buffer_reset <= '0'; 
       end case;
    end process output;


end behavior;