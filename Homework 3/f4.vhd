library IEEE;
use IEEE.std_logic_1164.all;
library gate_lib;

entity f4 is
  port(A   : in std_logic;
       B   : in std_logic;
       C   : in std_logic;
       D   : in std_logic;
       F  : out std_logic);
end f4;

architecture structural of f4 is
  
  --component declarations
  component and2 is
    generic(Tp : time := 2 ns);
    port(in1  : in std_logic;
         in2  : in std_logic;
         out1 : out std_logic);
  end component;
  
  component or2 is
    generic(Tp : time := 2 ns);
    port(in1  : in std_logic;
         in2  : in std_logic;
         out1 : out std_logic);
  end component;
  
  component inv is
    generic(Tp : time := 1 ns);
    port(in1  : in std_logic;
         out1 : out std_logic);
  end component;

  for all : and2 use entity gate_lib.and2(simple);
  for all : or2 use entity gate_lib.or2(simple);
  for all : inv use entity gate_lib.inv(simple);

  --signal statements
  signal sig_1,  sig_2,  sig_3,  sig_4,  sig_5,
         sig_6 : std_logic;
  begin
    --structural descriptions
    NOT_1 : inv generic map(Tp => 1 ns)
                port map(in1 => A,
                        out1 => sig_1);
                        
    NOT_2 : inv generic map(Tp => 1 ns)
                port map(in1 => C,
                        out1 => sig_2);
                        
    NOT_3 : inv generic map(Tp => 1 ns)
                port map(in1 => D,
                        out1 => sig_3);  
                        
    OR_1 : or2 generic map(Tp => 2 ns)
               port map(in1 => B, in2 => sig_2,
                       out1 => sig_4);                        
                        
    OR_2 : or2 generic map(Tp => 2 ns)
               port map(in1 => sig_2, in2 => sig_3,
                       out1 => sig_5);                     
                        
    OR_3 : or2 generic map(Tp => 2 ns)
               port map(in1 => sig_1, in2 => sig_4,
                       out1 => sig_6);                        
                        
    AND_1 : and2 generic map(Tp => 2 ns)
                 port map(in1 => sig_5, in2 => sig_6,
                         out1 => F);                       
end structural;