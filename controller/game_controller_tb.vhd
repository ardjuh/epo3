library IEEE;
use IEEE.std_logic_1164.ALL;

entity game_controller_tb is
end entity game_controller_tb;

architecture behaviour of game_controller_tb is

component game_controller_tb                          --------- portmap placeholder until the compiled code is uploaded ---------
      port(	clk    		: in  std_logic;
           	reset  		: in  std_logic;
           	button_left	: in  std_logic;
   		button_right	: in  std_logic;
   		button_select	: in  std_logic;
   
           	switch_left	: out std_logic;
   		switch_right	: out std_logic;
   		switch_select	: out std_logic);
   end component;
      
signal clk    		: std_logic;           ---------- placeholder for signal list of inputs -----------
signal reset  		: std_logic;
signal button_left	: std_logic;
signal button_right	: std_logic;
signal button_select	: std_logic;
signal switch_left	: std_logic;
signal switch_right	: std_logic;
signal switch_select	: std_logic;
