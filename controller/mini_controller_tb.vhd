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
signal switch_right, switch_left, switch_select	: std_logic;
	

begin
	-- 40 ns = 25 MHz
	clk			<=	'0' after 0 ns,
					'1' after 20 ns when clk /= '1' else '0' after 20 ns; -- 1 for 20, 60, 100 etc
					
	reset		<=  		'1' after 0 ns,
					'0' after 80 ns,
					'1' after 740 ns, -- test if the reset works
					'0' after 780 ns;
	
	button_select 	<=	'0' after 0 ns, -- all buttons 0
						'1' after 60 ns, -- test if reset works, since that is high
						'0' after 80 ns,
						'1' after 100 ns, -- test if select works, left & right 0
						'0' after 220 ns,
						'1' after 700 ns, -- test if it chooses reset over select
						'0' after 820 ns,
						'1' after 900 ns, -- test what happens if select & left 1
						'0' after 1020 ns,
						'1' after 1100 ns, -- test what happens if select & right 1
						'0' after 1220 ns,
						'1' after 1500 ns, -- test if all 1
						'0' after 1620 ns;
	
	button_left		<= 	'0' after 0 ns, -- all buttons 0
						'1' after 300 ns, -- test if left works, select & right 0
						'0' after 420 ns,
						'1' after 900 ns, -- test what happens if select & left 1
						'0' after 1020 ns,
						'1' after 1300 ns, -- test for left & right 1
						'0' after 1420 ns,
						'1' after 1500 ns, -- test if all 1
						'0' after 1620 ns;
	
	button_right	<= 	'0' after 0 ns,	-- all buttons 0
						'1' after 500 ns, -- test if right works, select & left 0
						'0' after 620 ns,
						'1' after 1100 ns, -- test what happens if select & right 1
						'0' after 1220 ns,
						'1' after 1300 ns, -- test for left & right 1
						'0' after 1420 ns,
						'1' after 1500 ns, -- test if all 1
						'0' after 1620 ns;

lbl1: mini_controller  port map( clk        =>  clk,
                            reset      =>  reset,
                            button_select  =>  button_select,
                            button_left =>  button_left,
			    button_right => button_right,
			    switch_select  =>  switch_select,
                            switch_left =>  switch_left,
			    switch_right => switch_right
                           );
						
end architecture structural;
