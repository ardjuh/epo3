library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- rgb output, 4 bits per color, hsync, vsync
entity graphics_driver is
    port (
        h_pos : in std_logic_vector(9 downto 0);
        v_pos : in std_logic_vector(8 downto 0);
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0)
    );
end entity graphics_driver;

-- Begin with displaying half a blue screen in a process
architecture behavior of graphics_driver is

begin
    process (h_pos, v_pos)
    begin
        if (to_integer(unsigned(h_pos)) < 320) then
            red   <= "0000";
            green <= "0000";
            blue  <= "1111";
        else
            red   <= "0000";
            green <= "0000";
            blue  <= "0000";
        end if;
    end process;
end architecture;