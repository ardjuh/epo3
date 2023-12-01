library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mini_controller is
	port(	clk:			in std_logic;
			button_select:	in std_logic;
--			button_up:	in std_logic;
--			button_down:	in std_logic;
			button_left:	in std_logic;
			button_right:	in std_logic;
			
			switch_select:	out std_logic;
--			switch_up: 	out std_logic;
--			switch_down:	out std_logic;
			switch_left:	out std_logic;
			switch_right:	out std_logic;
		);
end mini_controller;

architecture behaviour of mini_controller is

type mini_controller_state is (
	sela,
	selb,
--	upa,
--	upb,
--	downa,
--	downb,
	lefta,
	leftb,
	righta,
	rightb);

signal state, player_action;

begin
	process (clk)
	begin
		if (rising_edge (clk)) then
			if (button_select = '1') then
				state <= sela;
			else
				state <= player_action;
			end if;
		end if;
	end process;
process;

--begin
--	process (clk)
--	begin
--		if (rising_edge (clk)) then
--			if (button_up = '1') then
--				state <= upa;
--			else
--				state <= player_action;
--			end if;
--		end if;
--	end process;
--process;

--begin
--	process (clk)
--	begin
--		if (rising_edge (clk)) then
--			if (button_down = '1') then
--				state <= downa;
--			else
--				state <= player_action;
--			end if;
--		end if;
--	end process;
--process;

begin
	process (clk)
	begin
		if (rising_edge (clk)) then
			if (button_left = '1') then
				state <= lefta;
			else
				state <= player_action;
			end if;
		end if;
	end process;
process;

begin
	process (clk)
	begin
		if (rising_edge (clk)) then
			if (button_right = '1') then
				state <= righta;
			else
				state <= player_action;
			end if;
		end if;
	end process;
	process;
	
	process(button_down, button_left, button_right, button_select, button_up)
	begin
		case state is
			when player_action	=> switch_select <= '0' ;	new_state <= player_action;
				if     (button_select = '1') then new_state <= sela;
					else     (button_select = '0') then new_state <= player_action;
					
			when sela	=> switch_select <= '1' ; 	new_state <= sela;
				if     (button_select = '1') then new_state <= selb;
					else new_state <= game_resolution;
					
			when selb	=> switch_select <= '0' ; 	new_state <= selb;
				if     (button_select = '0') then new_state <= game_resolution;
					else then new_state <= selb;
					
--			when downa	=> switch_down <= '1' ;	new_state <= downa;
--				if     (button_down = '1') then new_state <= downb;
--					else new_state <= player_action;
					
--			when downb	=> switch_down <= '0' ;	new_state <= downb;
--				if     (button_down = '0') then new_state <= player_action;
--					else then new_state <= downb;
					
			when lefta	=> switch_left <= '1' ;	new_state <= lefta;
				if     (button_left = '1') then new_state <= leftb;
					else new_state <= player_action;
					
			when leftb	=> switch_left <= '0' ;	new_state <= leftb;
				if     (button_left = '0') then new_state <= player_action;
					else then new_state <= leftb;
					
			when righta => switch_right <= '1' ;	new_state <= righta;
				if     (button_right = '1') then new_state <= rightb;
					else new_state <= player_action;
					
			when rightb => switch_right <= '0' ;	new_state <= rightb;
			if     (button_right = '0') then new_state <= player_action;
					else then new_state <= rightb;
					
--			when upa 	=> switch_up <= '1' ;		new_state <= upa;
--				if     (button_up = '1') then new_state <= upb;
--					else new_state <= player_action;
					
--			when upb	=> switch_up <= '0' ;		new_state <= upb;
--				if     (button_up = '0') then new_state <= player_action;
--					else then new_state <= upb;
			end case;	
		
	end process;
end architecture behavioural;
