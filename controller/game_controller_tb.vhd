library IEEE;
use IEEE.std_logic_1164.ALL;

entity game_controller_tb is
end entity game_controller_tb;

architecture behaviour of game_controller_tb is

entity mini_con is
   port(clk    			: in  std_logic;
        reset  			: in  std_logic;
        button_left			: in  std_logic;
	button_right		: in  std_logic;
	button_select		: in  std_logic;

        switch_left			: out std_logic;
	switch_right		: out std_logic;
	switch_select		: out std_logic);
end mini_con;
