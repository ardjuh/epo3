library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mini_controller is
	port(		clk:		in std_logic;
			reset:		in std_logic;
			button_select:	in std_logic;
--			button_up:	in std_logic;
--			button_down:	in std_logic;
			button_left:	in std_logic;
			button_right:	in std_logic;
			
			switch_select:	out std_logic;
--			switch_up: 	out std_logic;
--			switch_down:	out std_logic;
			switch_left:	out std_logic;
			switch_right:	out std_logic
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
	rightb,
	reset_state,
	player_action
	);

signal state, new_state, game_resolution: mini_controller_state;

begin
	process (clk)
	begin
		if (clk = '1' and clk'event) then
			if (reset ='1') then
				state	<= reset_state; 
			else
				state	<= new_state;
			end if;
		end if;
	end process;

	process(state, button_left, button_right, button_select)
	begin
		case state is
			when player_action	=> 
				switch_select <= '0' ;	
				if (button_select = '1') then 
					new_state <= sela;
				elsif (button_left = '1') then 
					new_state <= lefta;
				elsif (button_right = '1') then 
					new_state <= righta;
				else  
					new_state <= player_action;
				end if;
					
			when sela	=> 
				switch_select <= '1' ; 	
				if  (button_select = '1') then 
					new_state <= selb;
				else new_state <= game_resolution;
				end if;
					
			when selb	=> 
				switch_select <= '0' ; 	
				if  (button_select = '0') then 
					new_state <= game_resolution;
				else new_state <= selb;
				end if;
					
			when lefta	=> 
				switch_left <= '1' ;	
				if  (button_left = '1') then 
					new_state <= leftb;
				else new_state <= player_action;
				end if;
					
			when leftb	=>
				 switch_left <= '0';
				if (button_left = '0') then 
					new_state <= player_action;
				else new_state <= leftb;
				end if;
					
			when righta => 
				switch_right <= '1' ;	
				if  (button_right = '1') then
					 new_state <= rightb;
				else new_state <= player_action;
				end if;
					
			when rightb => 
				switch_right <= '0' ;
			        if     (button_right = '0') then 
				new_state <= player_action;
				else new_state <= rightb;
			        end if;
		    
			when reset_state =>
				switch_right <= '0' ;
				switch_left <= '0' ;
				switch_select <= '0' ;
				if (reset = '0') then
					new_state <= player_action;
				else new_state <= reset_state;
				end if;
			end case;	
	end process;
end architecture;
