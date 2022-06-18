library ieee;
use ieee.std_logic_1164.all;


entity somador is 
    port (
        cin: in std_logic;
        a, b: in std_logic_vector(3 downto 0);
        carry_out: out std_logic;
        s: out std_logic_vector(3 downto 0)
    );
end somador;


architecture somador_arch of somador is
    signal co0, co1, co2: std_logic;
begin

    somador_1bit_unity: entity work.somador_1bit
    port map (
        a => a(0),
        b => b(0),
        cin => cin,
        co => co0,
        s => s(0)
    );

    somador_1bit_unity2: entity work.somador_1bit
    port map (
        a => a(1),
        b => b(1),
        cin => co0,
        co => co1,
        s => s(1)
    );

    somador_1bit_unity3: entity work.somador_1bit
    port map (
        a => a(2),
        b => b(2),
        cin => co1,
        co => co2,
        s => s(2)
    );

    somador_1bit_unity4: entity work.somador_1bit
    port map (
        a => a(3),
        b => b(3),
        cin => co2,
        co => carry_out,
        s => s(3)
    );

end somador_arch;