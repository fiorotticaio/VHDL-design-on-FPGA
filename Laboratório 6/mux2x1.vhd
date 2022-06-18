library ieee;
use ieee.std_logic_1164.all;


entity mux2x1 is 
    port (
        sub: in std_logic;
        B: in std_logic_vector(3 downto 0);
        b_out: out std_logic_vector(3 downto 0)
    );
end mux2x1;


architecture mux2x1_arch of mux2x1 is
    signal B_c2: std_logic_vector(3 downto 0);
begin

    B_c2 <= not B; -- complemento de 2 de B

    b_out <= B when (sub = '0') else 
         B_c2 when (sub = '1');

end mux2x1_arch;