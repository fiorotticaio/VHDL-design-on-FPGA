library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity counter is 
    port(
        up, down : in std_logic;
        count : in integer;
        new_count : out integer;
    );
end counter;

architecture counter_arch of counter is 

begin

    process(up, down, count, new_count) 
    begin
        if up = '1' and down = '0' then
            new_count <= count + 1;
        elsif up = '0' and down = '1' then 
            new_count <= count - 1;
        end if;
    end process;

end counter_arch;