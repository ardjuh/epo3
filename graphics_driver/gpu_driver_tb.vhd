library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
architecture behaviour of gpu_driver_tb is
    component gpu_driver
        port (
            h_pos : in std_logic_vector(8 downto 0);
            v_pos : in std_logic_vector(9 downto 0);
            red   : out integer range 0 to 15;
            green : out integer range 0 to 15;
            blue  : out integer range 0 to 15
        );
    end component;

    signal h_pos : std_logic_vector(8 downto 0);
    signal v_pos : std_logic_vector(9 downto 0);
    signal red   : integer range 0 to 15;
    signal green : integer range 0 to 15;
    signal blue  : integer range 0 to 15;

begin
    test : graphics_driver port map(h_pos, v_pos, red, green, blue);

    simulation : process
    begin
        for i in 32 to 511 loop
            h_pos <= std_logic_vector(to_unsigned(i, 9));
            for j in 145 to 784 loop
                v_pos <= std_logic_vector(to_unsigned(j, 10));
                wait for 40 ns;
            end loop;
        end loop;
    end process;
end architecture;
