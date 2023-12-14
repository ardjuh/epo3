library IEEE;
use IEEE.std_logic_1164.ALL;

entity top_entity_rcm is
    port(clk		    : in std_logic;
	reset       : in  std_logic;
        request_card: in		std_logic;
        round_end   : in  std_logic;
        random_card : out std_logic_vector(3 downto 0));
end top_entity_rcm;
