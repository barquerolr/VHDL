	--DOUGLAS PETERSON
	--Luis Barquero
	--EGRE 365 - LAB 4 

	LIBRARY IEEE;
	USE IEEE.NUMERIC_STD. ALL;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY LAB4 IS
	-- Initializes the Inputs and Ouputs used for this lab

		PORT( A,B: IN STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";    
 		      EN: IN STD_LOGIC := '0';					 
		      MODE: IN  STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
		      C_P, ZERO: OUT STD_LOGIC := '0';
		      C: OUT STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000");
	END LAB4;

	ARCHITECTURE MODEL OF LAB4 IS 
		 
	BEGIN
		PROCESS(A,B,MODE,EN) 
		  	VARIABLE I : INTEGER := 0;
		  	VARIABLE TEMP : INTEGER := 0;
		  	VARIABLE RESULT : INTEGER := 0;
	 		VARIABLE CARRY,D,E,C_TEMP: STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
			VARIABLE C_IN,C_OUT,PARITY: STD_LOGIC:= '0';

			
			BEGIN
				I := 0 ;
				TEMP := 0;

				IF (EN = '1') THEN --This is for the cause that enable = 1 and the mode = 0.
					IF MODE = "000" THEN--MODE 0
						C_IN := '0';
							C_TEMP(0) := A(0) XOR B(0) XOR C_IN;   --The XOR function works in a similar way as addition does.
							CARRY(0) := (A(0) AND C_IN) OR (B(0) AND C_IN) OR (A(0) AND B(0)); 
					
							FOR I IN 1  TO 15 LOOP
								C_TEMP(I) := A(I) XOR B(I) XOR CARRY(I-1); --This will calculate addtition for the rest of the bits.
								CARRY(I) := (A(I) AND CARRY(I-1)) OR (B(I) AND CARRY(I-1)) OR (A(I) AND B(I));
							END LOOP;
							
							C_OUT := CARRY(15); -- Finally, we assign C_OUT from carry of last adder.
					
						
					ELSIF MODE = "001" THEN--MODE 1
						C_IN := '1';
							C_TEMP(0) := A(0) XOR NOT (B(0)) XOR C_IN ;    --In order to do subtraction, we have to do 2's complement to the second number, then we add.
							CARRY(0) := (A(0) AND C_IN) OR (NOT(B(0)) AND C_IN) OR (A(0) AND NOT(B(0)));
					
							FOR I IN 1  TO 15 LOOP
								C_TEMP(I) := A(I) XOR NOT(B(I)) XOR CARRY(I-1); --This will calculate subtraction for the rest of the bits.
								CARRY(I) := (A(I) AND CARRY(I-1)) OR (NOT(B(I)) AND CARRY(I-1)) OR (A(I) AND NOT(B(I)));
							END LOOP;
							
							C_OUT := CARRY(15); --We finish by assigning C_OUT from carry of last adder.
						
					ELSIF MODE = "010" THEN--MODE 2
						C_IN := '1';
							D := NOT(A); --Mode 2 will perform -A, which is the equivalent of displaying 2's complement.
						
							C_TEMP(0) := D(0) XOR C_IN;
							CARRY(0) := (D(0) AND C_IN);
					
							FOR I IN 1  TO 15 LOOP --This will calculate two's complement for the rest of the bits.
								C_TEMP(I) := D(I) XOR CARRY(I-1);
								CARRY(I) := (D(I) AND CARRY(I-1));
							END LOOP;
							
							C_OUT := CARRY(15);   --Assign C_OUT from the carry of last adder
						
					ELSIF MODE = "011" THEN--MODE 3
						C_TEMP := A(14 DOWNTO 0) & '0';  --Mode 3 will shift A one unit to the left. 
							IF E(15) = A(15) THEN 
								C_OUT := '0';
							ELSE
								C_OUT := '1';
								END IF;
						
					ELSIF MODE = "100" THEN--MODE 4
						C_TEMP := A AND B;     --Mode 4 is a simple AND operation between A and B
						
					ELSIF MODE = "101" THEN--MODE 5
						C_TEMP := A OR B;      --Mode 5 will perform a simple OR operation between A and B
						
					ELSIF MODE = "110" THEN--MODE 6
						C_TEMP := A XOR B;     --Mode 6 will perform a simple XOR operation between A and B
						
					ELSIF MODE = "111" THEN--MODE 7
						C_TEMP := NOT A;       ---Unlike -A, NOT A will just inverted the input A.
						
					END IF;

					 C <= C_TEMP;
					WHILE( I <= C_TEMP'LENGTH - 1) LOOP
						IF (C_TEMP(I) = '1') THEN
							TEMP := TEMP + 1;
							 
						END IF;
						
						I := I + 1;
					END LOOP;
					
					-- ALL BITS LOW
						IF (TEMP = 0) THEN
							ZERO <= '1'; --Checks to see if Temp - sum of all '1's - is equal to zero, and if so, this means all bits are zero. We then set ZERO <= '1';
						ELSE
							ZERO <= '0'; --If the summation is not 0, the ZERO <= '0';
						END IF;
					
					-- PARITY (EVEN/ODD)			
						RESULT := TEMP MOD 2; --From the previous lab, we take the summation - TEMP - and perform a MOD2 operation

						IF ( RESULT = 0) THEN  --If the MOD2 produces no remainder, then the parity = 0. 
							
							PARITY := '0';--EVEN 
						ELSE 
							PARITY := '1';--ODD
						END IF; 
          
					IF (MODE = ("000" OR "001" OR "010" OR "011")) THEN
						C_P <= C_OUT;
						ELSE
						C_P <= PARITY;
					END IF;
						
				ELSE 
				-- ENABLE OFF
					C_TEMP := "ZZZZZZZZZZZZZZZZ";
				END IF;
				
				C <= C_TEMP;
				END PROCESS;
	END MODEL;


