library IEEE;
use IEEE.std_logic_1164.all;

architecture behaviour of graphics_driver_tb is
    component graphics_driver
        port (
            h_pos : in std_logic_vector(9 downto 0);
            v_pos : in std_logic_vector(8 downto 0);
            red   : out integer range 0 to 15;
            green : out integer range 0 to 15;
            blue  : out integer range 0 to 15;
        );
    end component;

    signal h_pos : std_logic_vector(9 downto 0);
    signal v_pos : std_logic_vector(8 downto 0);
    signal red   : integer range 0 to 15;
    signal green : integer range 0 to 15;
    signal blue  : integer range 0 to 15;
begin
    test : graphics_driver port map(h_pos, v_pos, red, green, blue);
end architecture;