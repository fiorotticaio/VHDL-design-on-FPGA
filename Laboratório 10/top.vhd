library ieee;
use ieee.std_logic_1164.all; 

entity top is
    port(
        clk: in std_logic;                     
        sw: in std_logic_vector(1 downto 0);
        an: out std_logic(3 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );
end top;

architecture arch of zero_to_seven is
    -- constant N : integer := 99999999; -- 1 segundo de clk
    -- signal divide_clk : integer range 0 to N;
    -- signal enable : std_logic;
 
begin

    debounce_btn: entity work.debounce_btn
        port map(
            clk => clk,
            btn => sw,
            an => an,
            sseg => sseg
        );

    -- enable <= '1' when divide_clk = N else '0';

    -- process(clk)
    -- begin
    --     if (clk'event and clk='1') then
    --         divide_clk <= divide_clk + 1;
    --         if divide_clk = N then
    --             divide_clk <= 0;
    --         end if;
    --     end if;
    -- end process;
    
end arch;