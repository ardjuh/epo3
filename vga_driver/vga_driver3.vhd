library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_driver is
    port(clk   	: in std_logic;
        reset 	: in std_logic;
        h_pos   : in std_logic;
        v_pos   : in std_logic;
        H_sync	: out std_logic;
        V_sync	: out std_logic;
        
end vga_driver;

architecture vga_driver of vga_driver is
 
