library ieee;
use ieee.std_logic_1164.all; 

entity zero_to_seven is
    port(
        clk: in std_logic;                     
        an: out std_logic_vector(7 downto 0); 
        sseg: out std_logic_vector(7 downto 0) 
    );
end zero_to_seven;

architecture arch of zero_to_seven is
    constant N : integer := 499; -- 0,0005 segundo de clk (f = 2000Hz)
    signal divide_clk : integer range 0 to N;
    signal enable : std_logic;
 
begin

    seven_sig: entity work.led_mux8
    port map (
        clk => clk, 
        reset => '0',
        enable => enable,
        in0 => "1000000",  
        in1 => "1111001", 
        in2 => "0100100", 
        in3 => "0110000", 
        in4 => "0011001", 
        in5 => "0010010", 
        in6 => "0000010", 
        in7 => "1111000", 
        an => an,                
        sseg => sseg              
    );

    enable <= '1' when divide_clk = N else '0';

    process(clk)
    begin
        if (clk'event and clk='1') then
            divide_clk <= divide_clk + 1;
            if divide_clk = N then
                divide_clk <= 0;
            end if;
        end if;
    end process;
    
end arch;
