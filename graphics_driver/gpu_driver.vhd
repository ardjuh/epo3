library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Begin with displaying half a blue screen in a process
architecture behavior of gpu_driver is

begin
    process (h_pos, v_pos)
    begin
        if (to_integer(unsigned(h_pos)) < 145 or to_integer(unsigned(h_pos)) > 784 or to_integer(unsigned(v_pos)) < 32 or to_integer(unsigned(v_pos)) > 511) then
            red   <= 0;
            green <= 0;
            blue  <= 0;
        else
            red   <= 2;
            green <= 15;
            blue  <= 3;
        end if;
    end process;
end architecture;