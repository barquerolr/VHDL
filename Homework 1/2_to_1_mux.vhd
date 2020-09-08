entity two_to_one_mux is
  port(a, b, sel: in bit;
       y: out bit);

end two_to_one_mux;
 architecture simple of two_to_one_mux
 is
begin	
   process(a,b, sel)
begin
   if (sel <= '0') then
	y <= a; 
   else
	y <= b;
   end if;
 end process;
end simple; 