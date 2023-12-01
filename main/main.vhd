library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

architecture behaviour of main is
 component vga_driver_combined port(
		clk: in std_logic;
		reset: in std_logic;
		V_sync: out std_logic;
		H_sync: out std_logic;
		x_pos: out std_logic_vector (9 downto 0);
		y_pos: out std_logic_vector (9 downto 0));
end component;

component gpu_driver port(
	h_pos: in std_logic_vector(9 downto 0);
	v_pos: in std_logic_vector(9 downto 0);
	red: out std_logic_vector(3 downto 0);
	green: out std_logic_vector(3 downto 0);
	blue: out std_logic_vector(3 downto 0));
end component;

signal V_sync_i, H_sync_i: std_logic;
signal x_pos, y_pos: std_logic_vector (9 downto 0);
signal red, green, blue: std_logic_vector ( 3 downto 0);

begin
	vga: vga_driver_combined port map(clk => clk, reset => reset, x_pos => x_pos, y_pos => y_pos, H_sync => H_sync_i, V_sync => V_sync_i);

	gpu: gpu_driver port map(h_pos => x_pos, v_pos => y_pos, red => red, green => green, blue => blue);

vga_vsync <= V_sync_i;
vga_hsync <= H_sync_i;
r <= red;
g <= green;
b <= blue;

end behaviour;
