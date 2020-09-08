entity hw1_B is
   port (A, B, C, D: in bit;
         F3: out bit);
end hw1_B;
architecture simple of hw1_B is
begin 
     F3 <= ((NOT A) AND B AND (NOT C) AND (NOT D)) OR (A AND (NOT B) AND (NOT C) AND (NOT D))
        OR ((NOT A) AND (NOT B) AND (NOT C) AND D) OR (A AND B AND (NOT C) AND D)
        OR ((NOT A) AND B AND C AND D) OR (A AND (NOT B) AND C AND D)
        OR ((NOT A) AND (NOT B) AND C AND (NOT D)) OR (A AND B AND C AND (NOT D));
end simple;