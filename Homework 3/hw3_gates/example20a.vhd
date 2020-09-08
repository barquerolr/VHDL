library IEEE;
use IEEE.std_logic_1164.all;
library gate_lib;

ARCHITECTURE structural2 OF full_adder IS

  SIGNAL sig_1, sig_2, sig_3 : std_logic;
  
  BEGIN
  -- generic maps are optional - as long as
  -- the original included default specifications
  XOR_1 : ENTITY gate_lib.xor2_with_rf(simple) 
                 PORT MAP(in1 => A, in2 => B, out1 => sig_1);

  -- positional association can be used for port map
  XOR_2 : ENTITY gate_lib.xor2_with_rf(simple)
                 GENERIC MAP(TpHL => 2 ns, TpLH => 2 ns)
                 PORT MAP(sig_1, Cin, Sum);

  -- named associations can be out of order
  AND_1 : ENTITY gate_lib.and2_with_rf(simple)
                 GENERIC MAP(TpHL => 1 ns, TpLH => 3 ns)
                 PORT MAP(in2 => Cin, out1 => sig_2, in1 => sig_1);

  AND_2 : ENTITY gate_lib.and2_with_rf(simple) 
                 GENERIC MAP(TpHL => 1 ns, TpLH => 2 ns)
                 PORT MAP(in1 => A, in2 => B, out1 => sig_3);
  
  OR_1 : ENTITY gate_lib.or2_with_rf(simple) 
                GENERIC MAP(TpHL => 2 ns, TpLH => 1 ns)
                PORT MAP(in1 => sig_2, in2 => sig_3, out1 => Cout);

  
END structural2;
