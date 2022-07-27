library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_to_sseg is
   port(
      count  : in  unsigned;
      dp   : in  std_logic;
      sseg : out std_logic_vector(7 downto 0)
   );
end hex_to_sseg;

architecture arch of hex_to_sseg is
begin
   with hex select
      sseg(6 downto 0) <=
         "1000000" when "0000", -- 0
         "1111001" when "0001", -- 1
         "0100100" when "0010", -- 2
         "0110000" when "0011", -- 3
         "0011001" when "0100", -- 4
         "0010010" when "0101", -- 5
         "0000010" when "0110", -- 6
         "1111000" when "0111", -- 7
         "0000000" when "1000", -- 8
         "0010000" when "1001", -- 9
   sseg(7) <= dp;
end arch;