-- ======= Importação de bibliotecas ======== 
library ieee;
use ieee.std_logic_1164.all; 


-- ======= Entidade =======
-- Especifica as portas de entrada e saída de um sistema
entity hex_to_sseg_test is
    port(
        sw: in std_logic_vector(15 downto 0);  -- os 15 switches da placa
        clk: in std_logic;                     -- o clock da placa
        an: out std_logic_vector(7 downto 0);  -- saída que fala qual dos displays da placa vai acender
        sseg: out std_logic_vector(7 downto 0) -- os 7 segmenos da placa
    );
end hex_to_sseg_test;


-- ======= Arquitetura =======
-- Descreve a operação interna de um sistema
architecture arch of hex_to_sseg_test is
    -- "signal" -> utilizado para declarar qualquer variável
    signal led0, led1, led2, led3: std_logic_vector(7 downto 0);
begin

    seven_sig_0: entity work.hex_to_sseg
        port map (
            hex  => sw(3 downto 0), -- o valor de hex vai vir dos 3 primeiros switchs
            dp   => '1', -- "1" vai deixar desligado a bolinha
            sseg => led0 -- o resultado sseg vai ser inserido em led0
        );
    
    seven_sig_1: entity work.hex_to_sseg
        port map (
            hex  => sw(7 downto 4),
            dp   => '1',
            sseg => led1
        );
        
    seven_sig_2: entity work.hex_to_sseg
        port map (
            hex  => sw(11 downto 8),
            dp   => '1',
            sseg => led2
        );
            
    seven_sig_3: entity work.hex_to_sseg
        port map (
            hex  => sw(15 downto 12),
            dp   => '1',
            sseg => led3
        );
    
    seven_sig: entity work.led_mux8
        port map (
          clk => clk, -- padrão
          reset => '0', -- padrão
          in0 => led0, -- "in0" recebe o sinal gerado "led0"    
          in1 => led1, 
          in2 => led2, 
          in3 => led3, 
          in4 => led0, 
          in5 => led1, 
          in6 => led2, 
          in7 => led3, 
          an => an,                
          sseg => sseg              
        );
    
end arch;