--Programmed by: Luis Barquero
--Purpose: This program will take the T-Bird's light example, and implement the brakes. 
	 --For example, when the brakes are activated, all six lights are on. 
	 --When the left or turn signal are on, the lights the lights in the direction of the turn 
         -- function as before ? blinking sequentially, the lights opposite the tail lights
	 --are all on continuously.

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY tbird_lc is
  PORT(clk           : IN  std_logic;
       rst           : IN  std_logic;
       left          : IN std_logic; 
       right         : IN std_logic;
       haz           : in std_logic;
       brakes        : in std_logic;
       left_tail_lt  : OUT std_logic_vector(3 downto 1);
       right_tail_lt : OUT std_logic_vector(1 to 3));
END tbird_lc;

ARCHITECTURE behavior OF tbird_lc IS

  TYPE state_type IS (IDLE, LR3, L1, L2, L3, L4, L5, L6, R1, R2, R3, R4, R5, R6);
  SIGNAL present_state, next_state : state_type;
  CONSTANT leftoff : std_logic_vector(3 downto 1) := "000";
  CONSTANT left1on : std_logic_vector(3 downto 1) := "001";
  CONSTANT left2on : std_logic_vector(3 downto 1) := "011";
  CONSTANT left3on : std_logic_vector(3 downto 1) := "111";
  CONSTANT rightoff : std_logic_vector(3 downto 1) := "000";
  CONSTANT right1on : std_logic_vector(3 downto 1) := "100";
  CONSTANT right2on : std_logic_vector(3 downto 1) := "110";
  CONSTANT right3on : std_logic_vector(3 downto 1) := "111";

BEGIN

 clocked : PROCESS(clk,rst)
   BEGIN
     IF(rst='1') THEN 
       present_state <= idle;
    ELSIF(rising_edge(clk)) THEN
      present_state <= next_state;
    END IF;  
 END PROCESS clocked;
 
 nextstate : PROCESS(present_state,left,right,haz, brakes)
  BEGIN
     CASE present_state IS
       WHEN idle => --(000_000). Idle will have all lights turned off.
         IF(haz = '1'OR (left = '1' AND right = '1') OR brakes = '1') THEN 
           next_state <= LR3;
         ELSIF(left = '1') THEN
           next_state <= L1;
         ELSIF(right = '1') THEN
           next_state <= R1;
         ELSE
           next_state <= idle;
         END IF;

       WHEN LR3 => --(111_111). LR3 will have all six lights(all 3 from left side and all 3 from right side).
	 IF(left = '1' AND brakes = '1') THEN
	   next_state <= L4;
	 ELSIF (right = '1' AND brakes = '1') THEN
	    next_state <= R4;
         ELSIF ((left = '0') AND (right = '0') AND (brakes = '1')) THEN
            next_state <= present_state;
	 ELSE 
	    next_state <= idle;
         END IF;

       WHEN L1 => --(001_000). L1 will implement the first left light, with the right lights off because of no brakes.
         IF(haz = '1') THEN
           next_state <= LR3;
         ELSIF (brakes = '1') THEN
	   next_state <= L6;
         ELSIF (haz = '0') THEN
	   next_state <= L2;
         END IF;

       WHEN L2 => --(011_000). L2 will implement the first two left light, with the right lights off because of no brakes.
         IF(haz = '1' OR brakes = '1') THEN
           next_state <= LR3;
         ELSIF (haz = '0' AND brakes = '0') THEN
           next_state <= L3;
         END IF;

       WHEN L3 => --(111_000). L3 will have all 3 lights from left side, with the right side lights off because of no brakes.
         IF(brakes = '1') THEN
            next_state <= L4;
         ELSIF (haz = '1' OR brakes = '1') THEN
            next_state <= LR3;
         ELSE
            next_state <= idle;
       END IF;

       WHEN L4 => -- (000_111) Left and Brakes. L4 will reset the left turn lights after all three have been lit when the brake has been activated.
	 IF (brakes = '0') THEN
	    next_state <= L1;
	 ELSIF (brakes = '1') THEN
	    next_state <= L5;
       END IF;

       WHEN L5 => --(001_111) Left and Brakes. L5 will have the first left light on and all the right lights on, because of the brakes.
	IF (brakes = '0') THEN
    	    next_state <= L2;
        ELSIF (brakes = '1') THEN
	    next_state <= L6;
       END IF;

	WHEN L6 => --(011_111) Left and Brakes. L6 will have the firt two left lights on and all the right lights on, because of the brakes.
	 IF (brakes = '0') THEN
	    next_state <= L3;
	 ELSIF (brakes = '1') THEN
	    next_state <= LR3;
         END IF;

       WHEN R1 => --(000_100). R1 will implement the first right light, with the left lights off because of no brakes.
         IF(haz = '1') THEN
           next_state <= LR3;
         ELSIF (haz = '0' AND brakes = '0') THEN
           next_state <= R2;
	 ELSIF (brakes = '1') THEN
           next_state <= R6;
         END IF;

       WHEN R2 => --(000_110). R2 will implement the first two right lights, with the left lights off because of no brakes.
         IF(haz = '1' or brakes = '1') THEN
           next_state <= LR3;
         ELSIF (haz = '0' AND brakes = '0') THEN
           next_state <= R3;
         END IF;

       WHEN R3 => --(000_111). R3 will have all 3 lights from right side, with the left side lights off because of no brakes.
	 IF (haz = '1' OR brakes = '1') THEN
  	    next_state <= LR3;
	 ELSIF (brakes = '1') THEN
	    next_state <= R4;
	 ELSE
            next_state <= idle;
       END IF; 

	WHEN R4 => -- (111_000) Right and Brakes. R4 will reset the right turn lights after all three have been lit when the brake has been activated.
	 IF (brakes = '0') THEN
	    next_state <= R1;
	 ELSIF (brakes = '1') THEN
	    next_state <= R5;
       END IF;

	WHEN R5 => --(111_100) Right and Brakes. L5 will have the first right light on and all the left lights on, because of the brakes.
	IF (brakes = '0') THEN
    	    next_state <= R2;
        ELSIF (brakes = '1') THEN
	    next_state <= R6;
	END IF;

	WHEN R6 => --(111_110) Right and Brakes. L5 will have the first two right light on and all the left lights on, because of the brakes.
	IF (brakes = '0') THEN
	    next_state <= R3;
	ELSIF (brakes = '1') THEN
	    next_state <= LR3;
	END IF;

    END CASE;
  END PROCESS nextstate;

  output : PROCESS(present_state)
   BEGIN
     CASE present_state IS
       WHEN idle =>  --(000_000)
         left_tail_lt <= leftoff;
         right_tail_lt <= rightoff;

       WHEN LR3 => --(111_111)
         left_tail_lt <= left3on;
         right_tail_lt <= right3on;

       WHEN L1 => --(001_000)
         left_tail_lt <= left1on;
         right_tail_lt <= rightoff;

       WHEN L2 => --(011_000)
         left_tail_lt <= left2on;
         right_tail_lt <= rightoff;

       WHEN L3 => --(111_000)
         left_tail_lt <= left3on;
         right_tail_lt <= rightoff;

      WHEN L4 => --(000_111)
	 left_tail_lt <= leftoff;
	 right_tail_lt <= right3on;

      WHEN L5 => --(001_111)
	 left_tail_lt <= left1on;
	 right_tail_lt <= right3on;

      WHEN L6 => --(011_111)
	 left_tail_lt <= left2on;
         right_tail_lt <= right3on;

       WHEN R1 => --(000_100)
         left_tail_lt <= leftoff;
         right_tail_lt <= right1on;

       WHEN R2 => --(000_110)
         left_tail_lt <= leftoff;
         right_tail_lt <= right2on;

       WHEN R3 => --(000_111)
         left_tail_lt <= leftoff;
         right_tail_lt <= right3on;

       WHEN R4 => --(111_000)
	 left_tail_lt <= left3on;
	 right_tail_lt <= rightoff;

      WHEN R5 => --(111_100)
	 left_tail_lt <= left3on;
	 right_tail_lt <= right1on;

      WHEN R6 => --(111_110)
	 left_tail_lt <= left3on;
         right_tail_lt <= right2on;
	 
	 
     END CASE;
 END PROCESS output;
 
END ARCHITECTURE behavior;