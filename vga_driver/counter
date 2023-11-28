library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


architecture behaviour of counter is

signal h_pos: unsigned (9 downto 0);
signal v_pos: unsigned (9 downto 0);

begin
process (clk, reset)
	begin
		if reset = '1' then
			h_pos <= "0000000000";
			v_pos <= "0000000000";
		elsif (rising_edge(clk)) then
			if (h_pos < 799) then
				h_pos <= h_pos + 1;
			else
				h_pos <= "0000000000";
				if (v_pos < 520) then
					v_pos <= v_pos + 1;
				else
					v_pos <= "0000000000";
				end if;
			end if;
		end if;
end process;

x_pos <= std_logic_vector(h_pos);
y_pos <= std_logic_vector(v_pos);

end behaviour;
