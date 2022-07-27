entity counter is 
    port(
        sw : in std_logic_vector(1 downto 0);
    );
end counter;

architecture counter_arch of counter is 
    signal count : unsigned := 0; -- default value 0

begin

    process(sw, count) 
    begin
        if sw(0) = '1' and sw(1) = '0' then
            count <= count + 1;
        elsif sw(0) = '0' and sw(1) = '1' then 
            count <= count - 1;
        end if;
    end process;

end counter_arch;