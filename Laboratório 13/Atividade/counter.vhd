library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
   port(
      clk, reset : in  std_logic;
      up, down   : in std_logic;  
      q          : out std_logic_vector(3 downto 0)
   );
end counter;

architecture counter_arch of counter is
   signal r_reg  : unsigned(3 downto 0);
   signal r_next : unsigned(3 downto 0);
   
begin

   -- register
   process(clk,reset)
   begin
      if (reset='1') then
         r_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         r_reg <= r_next;
      end if;
   end process;

   -- next-state logic
   process(clk, up, down)
   begin
      if (up = '1' and down = '0') then 
         r_next <= r_reg + 1;
      elsif (down = '1' and up = '0') then
         r_next <= r_reg - 1;
      else 
         r_next <= r_reg; 
      end if;
   end process;

   -- output logic
   q <= std_logic_vector(r_reg);

end counter_arch;