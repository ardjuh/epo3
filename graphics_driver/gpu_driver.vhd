library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Begin with displaying half a blue screen in a process
architecture behavior of gpu_driver is
    signal x_pos : integer range -145 to 878;
    signal y_pos : integer range -32 to 991;
    signal r     : integer range 0 to 15;
    signal g     : integer range 0 to 15;
    signal b     : integer range 0 to 15;
begin
    -- Convert the position signals to unsigned and subtract the offset
    x_pos <= to_integer(unsigned(h_pos)) - 145;
    y_pos <= to_integer(unsigned(v_pos)) - 32;
    -- Convert the color signals to unsigned
    red   <= std_logic_vector(to_unsigned(r, 4));
    green <= std_logic_vector(to_unsigned(g, 4));
    blue  <= std_logic_vector(to_unsigned(b, 4));

    -- The process that splits the screen in sections
    process (x_pos, y_pos)
    begin
        if (x_pos < 0 or x_pos > 640 or y_pos < 0 or y_pos > 480) then
            r <= 0;
            g <= 0;
            b <= 0;
        elsif (y_pos < 470 and y_pos > 383 and x_pos > 10 and x_pos < 66) then
            r <= 15;
            g <= 15;
            b <= 15;
        else
            r <= 2;
            g <= 15;
            b <= 3;
        end if;
    end process;
end architecture;