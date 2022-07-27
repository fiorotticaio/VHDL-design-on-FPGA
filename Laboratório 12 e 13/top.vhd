entity parking is 
    port(
        
    );
end parking;

architecture parking_arch of parking is 
    constant N : integer := 49999999; -- half second
    signal enable: std_logic;
    signal divide_clk: integer range 0 to N;

begin 

  

    ---------- divide clock -----------
    -- when the time of the clock comes and we enable de signal
    enable <= '1' when (divide_clk = N) else '0';
    process(clk) 
    begin
        if (rising_edge(clk)) then 
            divide_clk <= divide_clk + 1;
            if (divide_clk = N) then 
                divide_clk <= 0;
            end if;
        end if;
    end process;

end parking_arch;