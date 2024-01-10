library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of input_ff is
begin

	process(clk)
	begin
		if rising_edge(clk) then
		Q <= D;
		end if;
	end process;

end behaviour;
