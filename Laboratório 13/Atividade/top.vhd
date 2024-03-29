library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parking is
    port(
        clk  : in std_logic;                    
        btn  : in std_logic_vector(1 downto 0);
        an   : out std_logic_vector(7 downto 0);  
        sseg : out std_logic_vector(7 downto 0) 
    );
end parking;

architecture parking_arch of parking is 
    -- variables to clock divider
    constant N        : integer := 49999999; -- half second
    signal enable     : std_logic;
    signal divide_clk : integer range 0 to N;

    -- variables to debounce teste
    signal q1_reg, q1_next    : unsigned(7 downto 0);
    signal q0_reg, q0_next    : unsigned(7 downto 0);
    signal b_count, d_count   : std_logic_vector(7 downto 0);
    signal db_reg1, db_reg2   : std_logic;
    signal db_level, db_level2, db_tick1, db_tick2 : std_logic;

    -- variables to enter/exit circuit
    signal up, down : std_logic;

    -- variables to counter
    signal q : std_logic_vector(3 downto 0);
    
begin

    -- instantiate debouncing circuit for the first button
    db_unit1 : entity work.db_fsm(arch)
    port map(
        clk   => clk,
        reset => '0',
        sw    => btn(0),
        db    => db_level1
    );


    -- instantiate debouncing circuit for the second button
    db_unit2 : entity work.db_fsm(arch)
    port map(
        clk   => clk,
        reset => '0',
        sw    => btn(1),
        db    => db_level2
    );


    -- instantiate the enter/exit circuit
    enter_exit_unity : entity work.enter_exit_unity(enter_exit_arch)
    port map (
        clk       => clk,
        a         => db_level1,
        b         => db_level2,
        car_enter => up,
        car_exit  => down
    );


    -- instantiate the counter circuit
    counter_unity : entity work.counter(counter_arch)
    port map(
        clk    => clk,
        reset  => '0',
        up     => up,
        down   => down,
        q      => q
    );


    -- instantiate hex display time-multiplexing circuit
    disp_unit : entity work.hex_to_sseg(hex_to_sseg_arch)
    port map(
        q     => q,
        dp    => '0',
        an    => an,
        sseg  => sseg
    );
  

    -- clock divider
    -- enable <= '1' when (divide_clk = N) else '0';
    -- process(clk) 
    -- begin
    --     if (clk'event and clk = '1') then 
    --         divide_clk <= divide_clk + 1;
    --         if (divide_clk = N) then 
    --             divide_clk <= 0;
    --         end if;
    --     end if;
    -- end process;

end parking_arch;