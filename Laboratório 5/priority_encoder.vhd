-- ======= Importação de bibliotecas ======== 
library ieee;
use ieee.std_logic_1164.all;


-- ======= Entidade =======
entity encoder4x2 is
	port (
		shr_1, shr_1c, shl_1: in std_logic; -- sinais lógicos de entrada
		c1c0: out std_logic_vector(1 downto 0) -- vetor de 2 bits de saída (codificado)
	);
end encoder4x2;


-- ======= Arquitetura =======
architecture conditional_arch of encoder4x2 is
begin
	c1c0 <= "11" when (shr_1 = '1')  else -- desloc. direira
			"10" when (shr_1c = '1') else -- desloc. circ. direita
			"01" when (shl_1 = '1')  else -- desloc. esquerda
			"00"; 
end conditional_arch;