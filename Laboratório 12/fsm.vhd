library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is 
    port(
        clk, en: in std_logic;
        a, b : in std_logic;
        car_enter, car_exit: out std_logic
    );
end fsm;

architecture fsm_arch of fsm is 
    type estados is (esperando, entrando1, entrando2, entrando3, entrou, saindo1, saindo2, saindo3, saiu);
    signal estado_atual, proximo_estado: estados;
begin
    -- registrador de estados
    process(clk)
    begin
        if(rising_edge(clk)) then
            if (en = '1') then 
                estado_atual <= proximo_estado;
            end if;
        end if;
    end process;

    -- logica de proximo estado
    process(estado_atual,a, b)
    begin
        case estado_atual is 
            when esperando => 
                if (a = '1') then 
                    proximo_estado <= entrando1;
                 elsif(a = '0' and b = '0') then
                    proximo_estado <= esperando;
                  else 
                    proximo_estado <= saindo1;
                end if;
            
            when entrando1 => 
                if (a = '0') then
                    proximo_estado <= esperando;
                elsif (a = '1' and b = '1') then 
                    proximo_estado <= entrando2;
                else 
                    proximo_estado <= entrando1;                    
                end if;

            when entrando2 => 
                if (b = '0') then
                    proximo_estado <= entrando1;
                elsif (a = '0' and b = '1') then 
                    proximo_estado <= entrando3;
                else
                    proximo_estado <= entrando2;
                end if;

            when entrando3 => 
                if (b = '0') then 
                    proximo_estado <= entrou;
                elsif(a = '0' and b = '1') then
                    proximo_estado <= entrando3;
                else 
                    proximo_estado <= entrando2;
                end if;
                
            when entrou => 
                proximo_estado <= esperando;

            when saindo1 =>
                if (b = '0') then 
                    proximo_estado <= esperando;
                elsif (a = '1' and b = '1') then 
                    proximo_estado <= saindo2;
                else
                    proximo_estado <= saindo1;                    
                end if;

            when saindo2 => 
                if (a = '0') then
                    proximo_estado <= saindo1;
                elsif (a = '1' and b = '0') then 
                    proximo_estado <= saindo3;
                else
                    proximo_estado <= saindo2;
                end if;
            
            when saindo3 => 
                if (a = '0') then 
                    proximo_estado <= saiu;
                elsif(a = '1' and b = '0') then
                    proximo_estado <= saindo3;
                else 
                    proximo_estado <= saindo2;
                end if;

            when saiu => 
                proximo_estado <= esperando;

        end case;
    end process;

    process(estado_atual) 
    begin
        -- default values
        car_enter <= '0';
        car_exit <= '0';
    
        case estado_atual is 
            when entrou => 
                car_enter <= '1';

            when saiu => 
                car_exit <= '1';
                
        end case;
    end process;
end fsm_arch;
