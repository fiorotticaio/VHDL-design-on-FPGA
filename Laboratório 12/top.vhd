library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is  
  port(
      sw: in std_logic_vector(1 downto 0);
      led: out std_logic_vector(1 downto 0);
      clk: in std_logic
  );
end top;

architecture top_arch of top is 
    signal enable,exited: std_logic;
    constant N : integer := 49999999; -- half second
    signal divide_clk: integer range 0 to N;

begin
    
  fsm_unit: entity work.fsm(fsm_arch)
  port map(
    clk => clk,
    a => sw(0),
    b => sw(1),
    en => enable,
    car_enter => led(0),
    car_exit => led(1)
  );


  -- divisor de clock
  enable <= '1' when (divide_clk = N) else '0';
  process(clk) 
  begin
    if(rising_edge(clk)) then 
      divide_clk <= divide_clk + 1;
      if (divide_clk = N) then 
        divide_clk <= 0;
      end if;
    end if;
  end process;

end top_arch;