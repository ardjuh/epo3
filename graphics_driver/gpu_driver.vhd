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

    function cards (
        x     : integer range 0 to 91;
        y     : integer range 0 to 86;
        card1 : integer range 0 to 13 := 0;
        card2 : integer range 0 to 13 := 0;
        card3 : integer range 0 to 13 := 0;
        card4 : integer range 0 to 13 := 0;
        card5 : integer range 0 to 13 := 0;
    ) return std_logic is
    begin
        if (x >= 36 and x <= 91 and card1 > 0) then
            if (x <= 37 or y <= 1 or x >= 90 or y >= 85) then
                return '0';
            elsif (x >= 62 and x <= 72 and y >= 33 and y <= 56) then
                -- TODO add number of card1
                return '0';
            else 
                return '1';
            end if;
            return '1';
        else
            return '0';
        end if;
    end function;

    -- The process that splits the screen in sections
    process (x_pos, y_pos)
    begin
        if (x_pos < 0 or x_pos > 640 or y_pos < 0 or y_pos > 480) then
            r <= 0;
            g <= 0;
            b <= 0;
        elsif (y_pos <= 470 and y_pos >= 383 and x_pos >= 10 and x_pos <= 101) then
            if (cards(y_pos - 383, x_pos - 10) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 0;
                g <= 0;
                b <= 0;
            end if;
        else
            r <= 2;
            g <= 15;
            b <= 3;
        end if;
    end process;
end architecture;