library ieee;
use ieee.std_logic_1164.all;

entity graphics_driver is
    port(clk   	: in std_logic;
        reset 	: in std_logic;
        H_sync	: out std_logic;
        V_sync	: out std_logic;
        R	: out std_logic;
	G	: out std_logic;
	B	: out std_logic);
end graphics_driver;
