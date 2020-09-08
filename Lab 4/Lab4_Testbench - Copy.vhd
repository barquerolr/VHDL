	--DOUGLAS PETERSON
	--EGRE 365 - LAB 3 
	
	LIBRARY IEEE;
	USE IEEE.NUMERIC_STD. ALL;
	USE IEEE.STD_LOGIC_1164.ALL;
	
	ENTITY LAB4_TESTBENCH IS 
	END LAB4_TESTBENCH;

	ARCHITECTURE BEHAVIOR OF LAB4_TESTBENCH IS

		CONSTANT MAX_DELAY: TIME := 20 NS;-- DEFINE THE MAXIMUM DELAY FOR THE DUT
		CONSTANT BIT_WIDTH: INTEGER := 16;--INPUT NUMBER OF BITS
		CONSTANT NO_VECTORS: INTEGER := 36;--NUMBER OF VECTORS
		-- DECLARE A CONSTANT TO HOLD AN ARRAY OF INPUT VALUES
		TYPE INPUT_VALUE_ARRAY IS ARRAY(1 TO NO_VECTORS) OF STD_LOGIC_VECTOR(0 TO BIT_WIDTH-1);
		TYPE OUTPUT_VALUE_ARRAY IS ARRAY(1 TO NO_VECTORS) OF STD_LOGIC_VECTOR(0 TO BIT_WIDTH-1);
		TYPE OUTPUT2_VALUE_ARRAY IS ARRAY(1 TO NO_VECTORS) OF STD_LOGIC;
		TYPE MODE_VALUE_ARRAY IS ARRAY(1 TO NO_VECTORS) OF STD_LOGIC_VECTOR(0 TO 2);
		
		CONSTANT A_SIG_VALUES: INPUT_VALUE_ARRAY:= 
		("0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100",
		"0000000000000001",
		"0000000000000110",
		"1111111111111111",
		"0000011111111100");
		
		CONSTANT B_SIG_VALUES: INPUT_VALUE_ARRAY:= 
		("0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110",
		"0111111111000001",
		"0000000000000110",
		"0010000000010111",
		"1100000000111110");
		
		CONSTANT C_SIG_VALUES: OUTPUT_VALUE_ARRAY:= 
		("ZZZZZZZZZZZZZZZZ",
		"ZZZZZZZZZZZZZZZZ",
		"ZZZZZZZZZZZZZZZZ",
		"ZZZZZZZZZZZZZZZZ",
		"0111111111000010",
		"0000000000001100",
		"0010000000010110",
		"1100100000111010",
		"1000000001000000",
		"0000000000000000",
		"1101111111101000",
		"0100011110111110",
		"1111111111111111",
		"1111111111111010",
		"0000000000000001",
		"1111100000000100",
		"0000000000000010",
		"0000000000001100",
		"1111111111111110",
		"1111111111111000",
		"0000000000000001",
		"0000000000000110",
		"0010000000010111",
		"0000000000111100",
		"0111111111000001",
		"0000000000000110",
		"1111111111111111",
		"1100011111111110",
		"0111111111000000",
		"0000000000000000",
		"1101111111101000",
		"1100011111000010",
		"1111111111111110",
		"1111111111111001",
		"0000000000000000",
		"1111100000000011");
		
		CONSTANT MODE_SIG_VALUES: MODE_VALUE_ARRAY:= 
		("000",
		"000",
		"000",
		"000",
		"000",
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
		
		CONSTANT ENABLE_SIG_VALUES: OUTPUT2_VALUE_ARRAY:=
		('0','0','0','0',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1',
		'1','1','1','1');

		CONSTANT C_P_SIG_VALUES: OUTPUT2_VALUE_ARRAY:=
		('0','0','0','0',
		'0','0','0','1',
		'0','0','1','0',
		'0','0','1','0',
		'0','0','1','0',
		'1','0','1','0',
		'0','0','0','0',
		'1','0','1','0',
		'1','0','0','1');

		CONSTANT ZERO_SIG_VALUES: OUTPUT2_VALUE_ARRAY:=
		('0','0','0','0'
		,'0','0','0','0'
		,'0','0','0','0'
		,'0','1','0','0'
		,'0','0','0','0'
		,'0','0','0','0'
		,'0','0','0','0'
		,'0','1','0','0'
		,'0','0','1','0');

		-- DEFINE SIGNALS THAT CONNECT TO DUT
		SIGNAL A_SIG,B_SIG,C_SIG: STD_LOGIC_VECTOR(0 TO BIT_WIDTH-1);
		SIGNAL MODE_SIG: STD_LOGIC_VECTOR(0 TO 2);
		SIGNAL ENABLE_SIG, C_P_SIG, ZERO_SIG: STD_LOGIC;

		BEGIN
			-- THIS IS THE PROCESS THAT WILL GENERATE THE INPUTS
			STIMULUS: PROCESS

		BEGIN

				FOR I IN 1 TO NO_VECTORS LOOP

					ENABLE_SIG <= ENABLE_SIG_VALUES(I);
					MODE_SIG <= MODE_SIG_VALUES(I);
					A_SIG <= A_SIG_VALUES(I);
					B_SIG <= B_SIG_VALUES(I);
					WAIT FOR MAX_DELAY;

				END LOOP;


			WAIT;
			-- STOP THE PROCESS TO AVOID AN INFINITE LOOP
		END PROCESS STIMULUS;

		-- THIS IS THE COMPONENT INSTANTIATION FOR THE
		-- DUT - THE DEVICE WE ARE TESTING
		DUT: ENTITY WORK.LAB4(MODEL)
			PORT MAP(A => A_SIG,B => B_SIG, C => C_SIG, MODE => MODE_SIG, EN => ENABLE_SIG, ZERO => ZERO_SIG, C_P=> C_P_SIG);
			
	 MONITOR: PROCESS
        VARIABLE I: INTEGER;
        BEGIN
            WAIT ON A_SIG ;
            -- WAIT FOR EVENT ON IN_SIG
            WAIT FOR MAX_DELAY/2;
            -- WAIT HALF OF THE "CYCLE TIME"
            I:=1;
            
            WHILE
                (I<=NO_VECTORS) LOOP
                -- LOOK THROUGH INPUT VALUES
            EXIT WHEN
                (A_SIG = A_SIG_VALUES(I) AND B_SIG = B_SIG_VALUES(I));
            
            I:=I+1;
            
            END LOOP;

            ASSERT I <= NO_VECTORS-- CHECK TO SEE THAT I IS IN BOUNDS
                REPORT "NO VALID INPUT VALUE FOUND"
                SEVERITY FAILURE;
            
            ASSERT A_SIG = A_SIG_VALUES(I)-- CHECK TO SEE THAT INPUT IS CORRECT
                REPORT "INCORRECT VALUE ON A_SIG"
                SEVERITY ERROR;
                
            ASSERT B_SIG = B_SIG_VALUES(I)-- CHECK TO SEE THAT INPUT IS CORRECT
                REPORT "INCORRECT VALUE ON B_SIG"
                SEVERITY ERROR;
                
            ASSERT C_SIG = C_SIG_VALUES(I)-- CHECK TO SEE THAT INPUT IS CORRECT
                REPORT "INCORRECT VALUE ON C_SIG"
                SEVERITY ERROR;
                
            
            ASSERT C_P_SIG = C_P_SIG_VALUES(I)-- CHECK TO SEE THAT OUTPUT IS CORRECT
                REPORT "INCORRECT VALUE ON C_P_SIG"
                SEVERITY ERROR;
            
            ASSERT ZERO_SIG = ZERO_SIG_VALUES(I)-- CHECK TO SEE THAT OUTPUT IS CORRECT
                REPORT "INCORRECT VALUE ON ZERO_SIG"
                SEVERITY ERROR;
            
        END PROCESS MONITOR;
END BEHAVIOR;
			
			
			
			
			