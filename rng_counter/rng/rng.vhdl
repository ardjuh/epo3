library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

architecture behaviour of rng is

signal new_count, new_deck_count,deck_count, count: unsigned(7 downto 0);

type state_machine is (reset_state,count_state,request_state);
signal state, new_state: state_machine;

begin
	

	process(clk)
	begin
		if(rising_edge (clk)) then
			if(reset = '1') then
				state<= reset_state;
				count <= to_unsigned(1,8);
				deck_count <= to_unsigned(208,8);
			else
				state <= new_state;
				count <= new_count;
				deck_count <= new_deck_count;
			end if;
		end if;
	end process;


	process(state, count, request_card, round_end, deck_count)
	begin
	
		case state is
		
		when reset_state =>			shuffle <= '1';
					random_num <= "00000000";

			new_count <= to_unsigned(1,8);

			new_deck_count <= to_unsigned(208,8);

			new_state	<= count_state;
			


		when count_state =>			shuffle <= '0';
					random_num <= "00000000";

			new_deck_count <= deck_count;	--volgende deck_count beslissen

			if(count = deck_count) then		--New count beslissen
				new_count <= to_unsigned(1,8);
			else
				new_count <= count + 1;
			end if;
		

			if(request_card = '1') then -- Volgende state beslissen
				new_state <= request_state;
			elsif round_end = '1' AND deck_count <= to_unsigned(52,8) then -- VERANDER NAAR 52
				new_state <= reset_state;
			else	
				new_state <= count_state;
			end if;


		when request_state =>			shuffle <= '0';
					random_num <= std_logic_vector(count);

			new_count <= unsigned(count);
			--new_count <= to_unsigned(1,8);

			new_deck_count <= deck_count - 1;

			new_state <= count_state;


		end case;
	end process;
end architecture;


