-- ======= Importação de bibliotecas ======== 
library ieee;
use ieee.std_logic_1164.all;


-- ======= Entidade =======
entity mux4x1 is
	port (
		x0, x1, x2, x3: in std_logic; -- inputs
		c1c0: in std_logic_vector(1 downto 0); -- comando
		output: out std_logic -- output
	);
end mux4x1;


-- ======= Arquitetura =======
architecture mux4x1_arch of mux4x1 is
begin 
	output <= x3 when (c1c0 = "11") else
		  	  x2 when (c1c0 = "10") else
		  	  x1 when (c1c0 = "01") else
		  	  x0;
end mux4x1_arch;