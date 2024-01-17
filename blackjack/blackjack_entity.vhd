library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity blackjack is
	    port(clk    : in std_logic;
	         reset  : in std_logic;
	         switch_select : in std_logic; -- controller
	         switch_left   : in std_logic; -- controller
	         switch_right  : in std_logic; -- controller
	         red    : out std_logic_vector(3 downto 0);
	         green  : out std_logic_vector(3 downto 0);
	         blue   : out std_logic_vector(3 downto 0);
	         H_sync : out std_logic;
	         V_sync : out std_logic;

end blackjack;
