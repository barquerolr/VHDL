library IEEE;
use IEEE.std_logic_1164.all;

ENTITY sm1 is
  PORT(clk : IN  std_logic;
       rst : IN  std_logic;
       up,down,lft,rght,center   : IN std_logic;
       z   : OUT std_logic_vector(7 downto 0));
END sm1;

ARCHITECTURE behavior OF sm1 IS

  TYPE state_type IS (A, B, C, D, Locked, Unlocked);
  SIGNAL present_state, next_state : state_type;


BEGIN

 clocked : PROCESS(clk,rst)
   BEGIN
     IF(rst='1') THEN 
       present_state <= A;
    ELSIF(rising_edge(clk)) THEN
      present_state <= next_state;
    END IF;  
 END PROCESS clocked;

 nextstate : PROCESS(present_state, up, down, lft, rght, center) -- Mealy Machine
  BEGIN
     CASE present_state IS
       WHEN Locked =>
         IF (up = '1') THEN
           next_state <= A;
         ELSIF((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;
	 ElSE 
	   next_state <= Locked;
         END IF;


       WHEN A =>
         IF (down = '1') THEN
           next_state <= B;
         ELSIF ((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

          ELSIF((up = '1') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

         ELSE
           next_state <= Locked;
         END IF;


       WHEN B =>
         IF (lft = '1') THEN
           next_state <= C;
         ELSIF ((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

 	 ELSIF((up = '0') AND (down = '1') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

         ELSE
           next_state <= Locked;
         END IF;


	WHEN C =>
         IF (rght = '1') THEN
           next_state <= D;
         ELSIF ((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

 	 ELSIF((up = '0') AND (down = '0') AND (lft = '1') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

         ELSE
           next_state <= Locked;
         END IF;


	WHEN D =>
         IF (center = '1') THEN
           next_state <= Unlocked;

         ELSIF ((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '0') AND (center = '0')) THEN
           next_state <= present_state;

	 ELSIF((up = '0') AND (down = '0') AND (lft = '0') AND (rght = '1') AND (center = '0')) THEN
           next_state <= present_state;

         ELSE
           next_state <= Locked;
         END IF;


	WHEN Unlocked =>
         IF ((up = '1') OR (down = '1') OR (lft = '1') OR (rght = '1')) THEN
           next_state <= Locked;

         ELSIF (center = '1') THEN
           next_state <= present_state;

         ELSE
           next_state <= Locked;

         END IF;

     END CASE;
END PROCESS nextstate;
 
  output : PROCESS(present_state)
   BEGIN
     CASE present_state IS
       WHEN Locked =>
          z <= "00000100";
      
       WHEN A =>
          z <= "00001000";

       WHEN B =>
          z <= "00010000";

       WHEN C =>
          z <= "00100000";

       WHEN D =>
          z <= "01000000";

      WHEN Unlocked =>
          z <= "10000001";
     END CASE;

 END PROCESS output;
END ARCHITECTURE behavior;