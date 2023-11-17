library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behaviour of gpu_driver is

begin
    process (h_pos, v_pos)
    begin
        if (to_integer(unsigned(h_pos)) < 640) then
            red   <= 2;
            green <= 15;
            blue  <= 3;
        else
            red   <= 0;
            green <= 0;
            blue  <= 0;
        end if;
    end process;

end behaviour;
