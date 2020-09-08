entity hw1_A is
   port (A, B, C, D: in bit;
         F2: out bit);
end hw1_A;
architecture simple of hw1_A is
begin 
     F2 <= (A AND B AND (NOT C) AND (NOT D)) 
            OR ((NOT A) AND B AND (NOT C) AND D)
            OR (A AND (NOT B) AND (NOT C) AND D)
            OR ((NOT A) AND (NOT B) AND C AND D)
	    OR ((NOT A) AND B AND C AND (NOT D))
	    OR (A AND (NOT B) AND C AND (NOT D));
end simple;