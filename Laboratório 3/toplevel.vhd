library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
    port(
        sw  : in  std_logic_vector(15 downto 0); 
        led : out std_logic_vector(15 downto 0) 
    );
    -- Pra cada função instanciado vamos pular um sw e um led
        -- OBS.: só os leds das últimas duas funções que vão ficar colados

end toplevel;

architecture arch of toplevel is
begin

    -- Decodificador 2x4 utilizando a estrutura de roteamento WHEN
    decod_2x4_w: entity work.decoder_2_4(cond_arch)
        port map(
            a => sw(1 downto 0),
            en => '1', -- não tem enable nesse caso
            y => led(3 downto 0)
        );

    -- Decodificador 2x4 com ENABLE utilizando a estrutura de roteamento WITH... SELECT
    decod_2x4_ws: entity work.decoder_2_4(sel_arch)
        port map (
            a => sw(4 downto 3),
            en => sw(5),
            y => led(8 downto 5)
        );

    -- Codificador de Prioridade utilizando um PROCESS e a estrutura IF
    prio_encoder_if: entity work.prio_encoder(if_arch)
        port map (
            r => sw(9 downto 6),
            pcode => led(12 downto 10)
        );

    -- Codificador de Prioridade utilizando um PROCESS e a estrutura CASE
    prio_encoder_case: entity work.prio_encoder(case_arch)
        port map (
            r => sw(14 downto 11),
            pcode => led(15 downto 13)
        );

end arch;