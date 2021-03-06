
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port (CLK100MHZ : in STD_LOGIC := '0';
          CPU_RESETN : in STD_LOGIC := '0';
          BTNU : in STD_LOGIC := '0'; --up
          BTND : in STD_LOGIC := '0'; --down
          BTNL : in STD_LOGIC := '0'; --left
          BTNR : in STD_LOGIC := '0'; --right
          BTNC : in STD_LOGIC := '0'; --center
          LED : out  STD_LOGIC_VECTOR(7 downto 0) := (others => '0'));
          
end top_level;

architecture Behavior of top_level is
  
  signal RSET : STD_LOGIC;

  signal clock_sig,  activate,  in1,  in2,  in3,  in4 : STD_LOGIC;
  
  begin  
    
    process(CPU_RESETN)
        begin
            RSET <= NOT CPU_RESETN;
    end process;                                       



  Clock_Divider : entity work.clock_divider(behavior)port map(mclk => CLK100MHZ,
                                                              sclk => clock_sig);
                      
  SwitchDebouncer_C : entity work.SwitchDebouncer(Behavioral)port map(clk       => CLK100MHZ,
                                               reset     => RSET,
                                               switchIn  => BTNC,
                                               switchOut => activate);
                      
  SwitchDebouncer_U : entity work.SwitchDebouncer(Behavioral) port map(clk       => CLK100MHZ,
                                               reset     => RSET,
                                               switchIn  => BTNU,
                                               switchOut => in1);

  SwitchDebouncer_D : entity work.SwitchDebouncer(Behavioral)port map(clk       => CLK100MHZ,
                                               reset     => RSET,
                                               switchIn  => BTND,
                                               switchOut => in2);

  SwitchDebouncer_L : entity work.SwitchDebouncer(Behavioral)port map(clk       => CLK100MHZ,
                                               reset     => RSET,
                                               switchIn  => BTNL,
                                               switchOut => in3);

  SwitchDebouncer_R : entity work.SwitchDebouncer(Behavioral)port map(clk       => CLK100MHZ,
                                               reset     => RSET,
                                               switchIn  => BTNR,
                                               switchOut => in4);
                                               
  LOCK_FSM : entity work.sm1(behavior)
                 port map(clk => clock_sig,
                          rst => RSET,
                          up  => in1,
                          down  => in2,
                          lft  => in3,
                          rght  => in4,
                          center  => activate,
                          z => LED);                                                  

end Behavior;
