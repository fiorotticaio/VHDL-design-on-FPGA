library ieee;
use ieee.std_logic_1164.all;


entity toplevel is
	port (
		sw: in std_logic_vector(7 downto 0);
		led: out std_logic_vector(2 downto 0)
	);
end toplevel;


architecture displacer of toplevel is
	signal c1c0: std_logic_vector(1 downto 0);

begin
	prio_encoder_unity: entity work.encoder4x2
	port map (
		shr_1 => sw(5),  
		shr_1c => sw(6),
		shl_1 => sw(7),
		c1c0 => c1c0
	);

	mux_s0_unity: entity work.mux4x1
	port map (
		x0 => sw(1),
		x1 => sw(0),
		x2 => sw(2),
		x3 => sw(3),
		output => led(0),
		c1c0 => c1c0
	);

	mux_s1_unity: entity work.mux4x1
	port map (
		x0 => sw(2),
		x1 => sw(1),
		x2 => sw(3),
		x3 => sw(3),
		output => led(1),
		c1c0 => c1c0
	);

	mux_s2_unity: entity work.mux4x1
	port map (
		x0 => sw(3),
		x1 => sw(2),
		x2 => sw(1),
		x3 => sw(4),
		output => led(2),
		c1c0 => c1c0
	);

end displacer;