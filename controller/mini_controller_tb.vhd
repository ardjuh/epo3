library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mini_controller_tb is
end entity mini_controller_tb;

architecture structural of mini_controller_tb is

	
	component mini_controller is
		port (	clk			: in std_logic;
				reset		: in std_logic;
				
				button_select	: in std_logic;
				button_left	: in std_logic;
				button_right	: in std_logic;
				
				switch_select	: out std_logic;
				switch_left	: out std_logic;
				switch_right	: out std_logic
			);
	end component mini_controller;
	
	signal clk, reset : std_logic;
	signal button_right, button_left, button_select	: std_logic;
	

begin
	-- 40 ns = 25 MHz
	clk			<=	'0' after 0 ns,
					'1' after 20 ns when clk /= '1' else '0' after 20 ns; -- 1 for 20, 60, 100 etc
					
	reset		<=  '1' after 0 ns,
					'0' after 80 ns,
					'1' after 140 ns, -- test if the reset works
					'0' after 160 ns;
	
	button_select 	<=	'0' after 0 ns, -- all buttons 0
						'1' after 60 ns, -- test if reset works, since that is high
						'0' after 80 ns,
						'1' after 100 ns, -- test if select works, left & right 0
						'0' after 120 ns,
						'1' after 140 ns, -- test if it chooses reset over select
						'0' after 160 ns,
						'1' after 260 ns, -- test what happens if select & left 1
						'0' after 280 ns,
						'1' after 300 ns, -- test what happens if select & right 1
						'0' after 320 ns,
						'1' after 380 ns, -- test if all 1
						'0' after 400 ns;
	
	button_left		<= 	'0' after 0 ns, -- all buttons 0
						'1' after 180 ns, -- test if left works, select & right 0
						'0' after 200 ns,
						'1' after 260 ns, -- test what happens if select & left 1
						'0' after 280 ns,
						'1' after 340 ns, -- test for left & right 1
						'0' after 360 ns,
						'1' after 380 ns, -- test if all 1
						'0' after 400 ns;
	
	button_right	<= 	'0' after 0 ns,	-- all buttons 0
						'1' after 220 ns, -- test if right works, select & left 0
						'0' after 240 ns,
						'1' after 300 ns, -- test what happens if select & right 1
						'0' after 320 ns,
						'1' after 340 ns, -- test for left & right 1
						'0' after 360 ns,
						'1' after 380 ns, -- test if all 1
						'0' after 400 ns;
						
end architecture structural;
