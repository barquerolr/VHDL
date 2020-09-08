entity homework1 is
  port(A, B, C, D : in bit;
       F1: out bit);

end homework1;
 architecture simple of homework1 is
begin
   F1 <= (A AND B AND C AND D) OR ((NOT A) AND (NOT B) AND (NOT C) AND (NOT D));
end simple; 
