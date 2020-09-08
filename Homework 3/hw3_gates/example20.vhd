library IEEE;
use IEEE.std_logic_1164.all;
library gate_lib;

entity full_adder is
  port(A    : in std_logic;
       B    : in std_logic;
       Cin  : in std_logic;
       Sum  : out std_logic;
       Cout : out std_logic);
end full_adder;

ARCHITECTURE structural OF full_adder IS

  -- component declarations
  COMPONENT and2 IS
    GENERIC(TpHL : time := 3 ns;
            TpLH : time := 2 ns);
    PORT(in1  : IN std_logic;
         in2  : IN std_logic;
         out1 : OUT std_logic);
  END COMPONENT;

  COMPONENT or2 IS
    GENERIC(TpHL : time := 3 ns;
            TpLH : time := 2 ns);
    PORT(in1  : IN std_logic;
         in2  : IN std_logic;
         out1 : OUT std_logic);
  END COMPONENT;

  COMPONENT xor2 IS
    GENERIC(TpHL : time := 3 ns;
            TpLH : time := 2 ns);
    PORT(in1  : IN std_logic;
         in2  : IN std_logic;
         out1 : OUT std_logic);
  END COMPONENT;

  FOR ALL : and2 USE ENTITY gate_lib.and2_with_rf(simple);
  FOR ALL : or2  USE ENTITY gate_lib.or2_with_rf(simple);
  FOR ALL : xor2  USE ENTITY gate_lib.xor2_with_rf(simple);

  SIGNAL sig_1, sig_2, sig_3 : std_logic;

  BEGIN  
    -- generic maps are optional - as long as
    -- the original included default specifications
    XOR_1 : xor2 PORT MAP(in1 => A, in2 => B,
                          out1 => sig_1);

    -- positional association can be used for port map
    XOR_2 : xor2 GENERIC MAP(TpHL => 2 ns,
                             TpLH => 2 ns)
                 PORT MAP(sig_1, Cin, Sum);

    -- named associations can be out of order
    AND_1 : and2 GENERIC MAP(TpHL => 1 ns,
                             TpLH => 3 ns)
                 PORT MAP(in2 => Cin, out1 => sig_2,
                          in1 => sig_1);

    AND_2 : and2 GENERIC MAP(TpHL => 1 ns,
                             TpLH => 2 ns)
                 PORT MAP(in1 => A, in2 => B,
                          out1 => sig_3);
  
    OR_1 : or2 GENERIC MAP(TpHL => 2 ns,
                           TpLH => 1 ns)
               PORT MAP(in1 => sig_2, in2 => sig_3,
                        out1 => Cout);
  
END structural;
