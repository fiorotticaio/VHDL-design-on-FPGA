library ieee;
use ieee.std_logic_1164.all;

entity pattern_top is 
  port(
    sw: in std_logic_vector(1 downto 0);
    clk: in std_logic;
    an, sseg: out std_logic_vector(7 downto 0)
  );
end pattern_top;

architecture pattern_top_arch of pattern_top is 
  constant N : integer := 49999999; -- half second
  signal enable: std_logic;
  signal divide_clk: integer range 0 to N;
begin 

  pattern_unity : entity work.pattern(pattern_arch)
  port map (
    clk => clk,
    en => enable,
    cw => sw(0),
    an => an,
    sseg => sseg
  );

  -- when the time of the clock comes and we enable de signal
  enable <= '1' when (divide_clk = N  and sw(1) = '1') else '0';

  process(clk) 
  begin
    if(rising_edge(clk)) then 
      divide_clk <= divide_clk + 1;
      if (divide_clk = N) then 
        divide_clk <= 0;
      end if;
    end if;
  end process;

end pattern_top_arch;