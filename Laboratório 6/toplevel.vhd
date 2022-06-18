library ieee;
use ieee.std_logic_1164.all;


entity toplevel is
	port (
		sw: in std_logic_vector(8 downto 0);
		led: out std_logic_vector(4 downto 0)
	);
end toplevel;


architecture soma_sub of toplevel is
    signal b, s: std_logic_vector(3 downto 0);
    signal carry_out, overflow, sub: std_logic;
begin
    sub <= sw(8);

    mux2x1_unity: entity work.mux2x1
    port map (
        sub => sub,
        B => sw(7 downto 4),
        b_out => b
    );

    somador_unity: entity work.somador
    port map (
        cin => sub,
        a => sw (3 downto 0),
        b => b,
        carry_out => carry_out,
        s => s
    );

    led(3 downto 0) <= s;

--    process(sub, carry_out. b, sw(3))
--    begin
--      if (b = '1' and sw(3) = '1' and carry_out = '0') then
--         led(4) <= '1';
--      elsif (b = '0' and sw(3) = '0' and carry_out = '1') then
--         led(4) <= '1';
--      else 
--      else 
--         led(4) <= '0';
--      end if;
--    end;
    
     led(4) <= ((not s(3)) and sw(3) and b(3)) or ((not b(3)) and s(3) and (not sw(3)));

end soma_sub;