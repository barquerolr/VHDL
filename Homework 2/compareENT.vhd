--Programmed by: Luis Baquero
--Purpose: This VHDL Model will take 4 inputs and will determine the maximum value, the minimum value
--	   the index of the maximum value, and the index of the minimum value.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity compareENT is
    Port ( in0     : in   STD_LOGIC_VECTOR (7 downto 0);		--Input 0
           in1     : in   STD_LOGIC_VECTOR (7 downto 0);		--Input 1
           in2     : in   STD_LOGIC_VECTOR (7 downto 0);		--Input 2
           in3     : in   STD_LOGIC_VECTOR (7 downto 0);		--Input 3
	   max_idx : out  STD_LOGIC_VECTOR (1 downto 0); 		--Max Index
           min_idx : out  STD_LOGIC_VECTOR (1 downto 0);		--Min Index
           max_val : out  STD_LOGIC_VECTOR (7 downto 0);		--Max Value
           min_val : out  STD_LOGIC_VECTOR (7 downto 0));		--Min Value
end compareENT;

architecture simple of compareENT is

procedure finding_max (signal input0, input1, input2, input3 : in STD_LOGIC_VECTOR (7 downto 0); --This procedure will take inputs 0-3
    signal max_value : out STD_LOGIC_VECTOR (7 downto 0);    	--Signal to find max value of the inputs
    signal max_index : out STD_LOGIC_VECTOR (1 downto 0)) is 	--Signal to find the index of the max value
    
  begin
    -- Find maximum value
        if (in0 >= in1 and in0 >= in2 and in0 >= in3) then  --This will check to see if input 0 is greater than the rest of the inputs.
         	max_value <= in0;			    --If input 0 is greater than the rest, it outputs the max value and the index.
         	max_index <= b"00";			   
        elsif (in1 >= in0 and in1 >= in2 and in1 >= in3) then  --This will check to see if input 0 is greater than the rest of the inputs.
         	max_value <= in1;			       --If input 1 is greater than the rest, it outputs the max value and the index.
         	max_index <= b"01";
        elsif (in2 >= in0 and in2 >= in1 and in2 >= in3) then  --This will check to see if input 0 is greater than the rest of the inputs.
         	max_value <= in2;			       --If input 2 is greater than the rest, it outputs the max value and the index.
         	max_index <= b"10";
        elsif (in3 >= in0 and in3 >= in1 and in3 >= in2) then  --This will check to see if input 0 is greater than the rest of the inputs.
         	max_value <= in3;			       --If input 3 is greater than the rest, it outputs the max value and the index.
         	max_index <= b"11";
        end if;
  end finding_max;
  
procedure finding_min (signal input0, input1, input2, input3 : in STD_LOGIC_VECTOR (7 downto 0);
  signal min_value : out STD_LOGIC_VECTOR (7 downto 0); 		--Signal to find min value of the inputs
  signal min_index : out STD_LOGIC_VECTOR (1 downto 0)) is		--Signal to find the index of the min value
  
begin 
      -- Find minimum value
      if (in0 <= in1 and in0 <= in2 and in0 <= in3) then   --This will check to see if input 0 is greater than the rest of the inputs.
       	min_value <= in0;				   --If input 0 is greater than the rest, it outputs the max value and the index.
       	min_index <= b"00";
      elsif (in1 <= in0 and in1 <= in2 and in1 <= in3) then  --This will check to see if input 0 is greater than the rest of the inputs.
       	min_value <= in1;				     --If input 1 is greater than the rest, it outputs the max value and the index.
       	min_index <= b"01";
      elsif (in2 <= in0 and in2 <= in1 and in2 <= in3) then  --This will check to see if input 0 is greater than the rest of the inputs.
       	min_value <= in2;				     --If input 2 is greater than the rest, it outputs the max value and the index.
       	min_index <= b"10";
      elsif (in3 <= in0 and in3 <= in1 and in3 <= in2) then  --This will check to see if input 0 is greater than the rest of the inputs.
       	min_value <= in3;				     --If input 3 is greater than the rest, it outputs the max value and the index.
       	min_index <= b"11";
     	end if;
end finding_min;

begin
    process(in0,in1, in2, in3)
      begin
        finding_max(in0, in1, in2, in3,		--Calls the procedure max_finder
                      max_val,max_idx);
        finding_min(in0, in1, in2, in3,		--Calls the procedure min_finder
                      min_val,min_idx);        
    end process;

end simple;