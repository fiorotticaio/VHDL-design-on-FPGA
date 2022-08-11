library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk  : in std_logic;  
        sw   : in std_logic_vector(7 downto 0);
        led  : out std_logic_vector(3 downto 0)
    );
end top;

architecture top_arch of top is 
    -- entries
    signal SHR_in, cLD, cINC, CSHR : std_logic;

    -- variables for divide clock
    signal en : std_logic;

    -- variables for priority encoder
    signal pcode : std_logic_vector(1 downto 0);

    -- variables for 4 bit incrementer
    signal inc_out : std_logic_vector(3 downto 0);

    -- variables for multiplexer
    signal s0, s1, s2, s3 : std_logic;

    -- variables for flip-flop D
    signal Q0, Q1, Q2, Q3 : std_logic;
    
begin

    -- initializing variables
    SHR_in <= sw(4);
    cLD <= sw(5);
    cINC <= sw(6);
    CSHR <= sw(7);

    -- instantiate divide clock
    div_clk_unity: entity work.div_clk(Behavioral)
    port map (
        clk => clk,
        en => en
    );

    -- instantiate priority encoder
    cod_prio_unity: entity work.cod_prio(cond_arch)
    port map (
        r(2) => cLD,
        r(1) => cINC,
        r(0) => CSHR,
        pcode => pcode
    );

    -- instantiate 4 bit incrementer
    inc_4bits_unity: entity work.inc_4bits(Behavioral)
    port map (
        inc_in(0) => Q0,
        inc_in(1) => Q1,
        inc_in(2) => Q2,
        inc_in(3) => Q3,
        inc_out => inc_out
    );

    -- instantiate multiplexer 0
    mux_4x1_unity0: entity work.mux_4x1(cond_arch)
    port map (
        i(0) => Q0,
        i(1) => Q1,
        i(2) => inc_out(0),
        i(3) => sw(0),
        c => pcode,
        s => s0
    );

    -- instantiate multiplexer 1
    mux_4x1_unity1: entity work.mux_4x1(cond_arch)
    port map (
        i(0) => Q1,
        i(1) => Q2,
        i(2) => inc_out(1),
        i(3) => sw(1),
        c => pcode,
        s => s1
    );

    -- instantiate multiplexer 2
    mux_4x1_unity2: entity work.mux_4x1(cond_arch)
    port map (
        i(0) => Q2,
        i(1) => Q3,
        i(2) => inc_out(2),
        i(3) => sw(2),
        c => pcode,
        s => s2
    );

    -- instantiate multiplexer 3
    mux_4x1_unity3: entity work.mux_4x1(cond_arch)
    port map (
        i(0) => Q3,
        i(1) => SHR_in,
        i(2) => inc_out(3),
        i(3) => sw(3),
        c => pcode,
        s => s3
    );

    -- instantiate flip-flop D 0
    ff_d_unity0: entity work.FF_D(Behavioral)
    port map (
        D => s0,
        e => en,
        Q => Q0,
        clk => clk
    );

    -- instantiate flip-flop D 1
    ff_d_unity1: entity work.FF_D(Behavioral)
    port map (
        D => s1,
        e => en,
        Q => Q1,
        clk => clk
    );

    -- instantiate flip-flop D 2
    ff_d_unity2: entity work.FF_D(Behavioral)
    port map (
        D => s2,
        e => en,
        Q => Q2,
        clk => clk
    );

    -- instantiate flip-flop D 3
    ff_d_unity3: entity work.FF_D(Behavioral)
    port map (
        D => s3,
        e => en,
        Q => Q3,
        clk => clk
    );

    -- lighting LEDs
    led(0) <= Q0;
    led(1) <= Q1;
    led(2) <= Q2;
    led(3) <= Q3;

end top_arch;