library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

architecture behaviour of main is
 component vga_driver_combined port(clk : in std_logic;
       reset: in std_logic;
       x_pos: out std_logic_vector (9 downto 0);
       y_pos: out std_logic_vector (9 downto 0);
       H_sync: out std_logic;
       V_sync: out std_logic);
end component;

component gpu_driver port(
	h_pos: in std_logic_vector(9 downto 0);
	v_pos: in std_logic_vector(9 downto 0);
	red: out std_logic_vector(3 downto 0);
	green: out std_logic_vector(3 downto 0);
	blue: out std_logic_vector(3 downto 0);
	player	: in std_logic_vector (1 downto 0);

	player1 : in std_logic;
        card1_1 : in std_logic_vector (4 downto 0);
        card1_2 : in std_logic_vector (4 downto 0);
        card1_3 : in std_logic_vector (4 downto 0);
        card1_4 : in std_logic_vector (4 downto 0);
        card1_5 : in std_logic_vector (4 downto 0);
        money1  : in std_logic_vector (10 downto 0);
	split1 	: in std_logic;

        player2 : in std_logic;
        card2_1 : in std_logic_vector (4 downto 0);
        card2_2 : in std_logic_vector (4 downto 0);
        card2_3 : in std_logic_vector (4 downto 0);
        card2_4 : in std_logic_vector (4 downto 0);
        card2_5 : in std_logic_vector (4 downto 0);
        money2  : in std_logic_vector (10 downto 0);
	split2	: in std_logic;

        player3 : in std_logic;
        card3_1 : in std_logic_vector (4 downto 0);
        card3_2 : in std_logic_vector (4 downto 0);
        card3_3 : in std_logic_vector (4 downto 0);
        card3_4 : in std_logic_vector (4 downto 0);
        card3_5 : in std_logic_vector (4 downto 0);
        money3  : in std_logic_vector (10 downto 0);
	split3	: in std_logic;

        player4 : in std_logic;
        card4_1 : in std_logic_vector (4 downto 0);
        card4_2 : in std_logic_vector (4 downto 0);
        card4_3 : in std_logic_vector (4 downto 0);
        card4_4 : in std_logic_vector (4 downto 0);
        card4_5 : in std_logic_vector (4 downto 0);
        money4  : in std_logic_vector (10 downto 0);
	split4	: in std_logic
	);
end component;

signal V_sync_i, H_sync_i: std_logic;
signal x_pos_i, y_pos_i: std_logic_vector (9 downto 0);
signal red, green, blue: std_logic_vector (3 downto 0);
signal player_i : std_logic_vector (1 downto 0);
signal player1_i, player2_i, player3_i, player4_i, split1_i, split2_i, split3_i, split4_i : std_logic;
signal card1_1_i, card1_2_i, card1_3_i, card1_4_i, card1_5_i, card2_1_i, card2_2_i, card2_3_i, card2_4_i, card2_5_i, card3_1_i, card3_2_i, card3_3_i, card3_4_i, card3_5_i, card4_1_i, card4_2_i, card4_3_i, card4_4_i, card4_5_i, card5_1_i, card5_2_i, card5_3_i, card5_4_i, card5_5_i : std_logic_vector (4 downto 0);
signal money1_i, money2_i, money3_i, money4_i, money5_i : std_logic_vector (10 downto 0);

begin
	vga: vga_driver_combined port map(clk => clk, reset => reset, x_pos => x_pos_i, y_pos => y_pos_i, H_sync => H_sync_i, V_sync => V_sync_i);

	gpu: gpu_driver port map(h_pos => x_pos_i, v_pos => y_pos_i, red => red, green => green, blue => blue, player => player_i, player1 => player1_i, card1_1 => card1_1_i, card1_2 => card1_2_i, card1_3 => card1_3_i, card1_4 => card1_4_i, card1_5 => card1_5_i, money1 => money1_i, split1 => split1_i, player2 => player2_i, card2_1 => card2_1_i, card2_2 => card2_2_i, card2_3 => card2_3_i, card2_4 => card2_4_i, card2_5 => card2_5_i, money2 => money2_i, split2 => split2_i, player3 => player3_i, card3_1 => card3_1_i, card3_2 => card3_2_i, card3_3 => card3_3_i, card3_4 => card3_4_i, card3_5 => card3_5_i, money3 => money3_i, split3 => split3_i, player4 => player4_i, card4_1 => card4_1_i, card4_2 => card4_2_i, card4_3 => card4_3_i, card4_4 => card4_4_i, card4_5 => card4_5_i, money4 => money4_i, split4 => split4_i);

vga_vsync <= V_sync_i;
vga_hsync <= H_sync_i;


r <= red;
g <= green;
b <= blue;

end behaviour;
