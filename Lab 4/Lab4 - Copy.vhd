	--DOUGLAS PETERSON
	--EGRE 365 - LAB 4 

	LIBRARY IEEE;
	USE IEEE.NUMERIC_STD. ALL;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY LAB4 IS
		PORT( 	A,B: IN STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
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

				IF (EN = '1') THEN
					IF MODE = "000" THEN--MODE 0
						C_IN := '0';
							C_TEMP(0) := A(0) XOR B(0) XOR C_IN;
							CARRY(0) := (A(0) AND C_IN) OR (B(0) AND C_IN) OR (A(0) AND B(0));
					
							FOR I IN 1  TO 15 LOOP
								C_TEMP(I) := A(I) XOR B(I) XOR CARRY(I-1);
								CARRY(I) := (A(I) AND CARRY(I-1)) OR (B(I) AND CARRY(I-1)) OR (A(I) AND B(I));
							END LOOP;
							
							C_OUT := CARRY(15);
					
						
					ELSIF MODE = "001" THEN--MODE 1
						C_IN := '1';
							C_TEMP(0) := A(0) XOR NOT (B(0)) XOR C_IN ;
							CARRY(0) := (A(0) AND C_IN) OR (NOT(B(0)) AND C_IN) OR (A(0) AND NOT(B(0)));
					
							FOR I IN 1  TO 15 LOOP
								C_TEMP(I) := A(I) XOR NOT(B(I)) XOR CARRY(I-1);
								CARRY(I) := (A(I) AND CARRY(I-1)) OR (NOT(B(I)) AND CARRY(I-1)) OR (A(I) AND NOT(B(I)));
							END LOOP;
							
							C_OUT := CARRY(15);
						
					ELSIF MODE = "010" THEN--MODE 2
						C_IN := '1';
							D := NOT(A);
						
							C_TEMP(0) := D(0) XOR C_IN;
							CARRY(0) := (D(0) AND C_IN);
					
							FOR I IN 1  TO 15 LOOP
								C_TEMP(I) := D(I) XOR CARRY(I-1);
								CARRY(I) := (D(I) AND CARRY(I-1));
							END LOOP;
							
							C_OUT := CARRY(15);
						
					ELSIF MODE = "011" THEN--MODE 3
						C_TEMP := A(14 DOWNTO 0) & '0';
							IF E(15) = A(15) THEN
								C_OUT := '0';
							ELSE
								C_OUT := '1';
								END IF;
						
					ELSIF MODE = "100" THEN--MODE 4
						C_TEMP := A AND B;
						
					ELSIF MODE = "101" THEN--MODE 5
						C_TEMP := A OR B;
						
					ELSIF MODE = "110" THEN--MODE 6
						C_TEMP := A XOR B;
						
					ELSIF MODE = "111" THEN--MODE 7
						C_TEMP := NOT A;
						
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
							ZERO <= '1';
						ELSE
							ZERO <= '0';
						END IF;
					
					-- PARITY (EVEN/ODD)			
						RESULT := TEMP MOD 2;

						IF ( RESULT = 0) THEN
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


