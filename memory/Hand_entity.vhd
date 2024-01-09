library IEEE;
use IEEE.std_logic_1164.all;

entity hand is
    port (
        clk    : in std_logic;
        rst    : in std_logic;
        enable : in std_logic;
        card   : in std_logic_vector(3 downto 0);
        card1  : out std_logic_vector(3 downto 0);
        card2  : out std_logic_vector(3 downto 0);
        card3  : out std_logic_vector(3 downto 0);
        card4  : out std_logic_vector(3 downto 0);
        card5  : out std_logic_vector(3 downto 0);
        score  : out std_logic_vector(4 downto 0) -- "11111" is BlackJack
    );
end hand;