library ieee;
use ieee.std_logic_1164.all;


entity somador_1bit is 
    port (
        a, b, cin: in std_logic;
        co, s: out std_logic
    );
end somador_1bit;


architecture somador_1bit_arch of somador_1bit is
begin

--    s <= '1' when ((a = '0' and b = '0' and cin = '1') or 
--                   (a = '0' and b = '1' and cin = '0') or
--                   (a = '1' and b = '0' and cin = '0') or
--                   (a = '1' and b = '1' and cin = '1')) else
--         '0' when others;
    s <= a xor b xor cin;
    
--    co <= '1' when ((a = '0' and b = '1' and cin = '1') or 
--                    (a = '1' and b = '0' and cin = '1') or
--                    (a = '1' and b = '1' and cin = '0') or
--                    (a = '1' and b = '1' and cin = '1')) else
--          '0' when others;
    co <= (b and cin) or (a and cin) or (a and b);

end somador_1bit_arch;