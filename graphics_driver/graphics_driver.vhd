library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- rgb output, 4 bits per color, hsync, vsync
entity graphics_driver is
    port (
        h_pos : in std_logic_vector(9 downto 0);
        v_pos : in std_logic_vector(8 downto 0);
        red   : out integer range 0 to 15;
        green : out integer range 0 to 15;
        blue  : out integer range 0 to 15;
    );
end entity graphics_driver;

-- Begin with displaying half a blue screen in a process
architecture behavior of graphics_driver is

begin
    process (h_pos, v_pos)
    begin
        if (to_integer(unsigned(h_pos)) < 320) then
            red   <= "2";
            green <= "15";
            blue  <= "3";
        else
            red   <= "0";
            green <= "0";
            blue  <= "0";
        end if;
    end process;
end architecture;