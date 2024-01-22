library IEEE;
use IEEE.std_logic_1164.all;

entity deck_mem is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        random_num  : in std_logic_vector(7 downto 0);
        shuffle     : in std_logic;
        random_card : out std_logic_vector(3 downto 0));
end deck_mem;