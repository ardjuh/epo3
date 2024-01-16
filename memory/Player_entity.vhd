library IEEE;
use IEEE.std_logic_1164.all;

entity player is
    port (
        clk            : in std_logic;
        rst            : in std_logic;
        mem_rst        : in std_logic;
        enable         : in std_logic;
        profit         : in std_logic_vector(6 downto 0);
        stake          : in std_logic_vector(4 downto 0);
        bid_in         : in std_logic_vector(1 downto 0);
        insurance_in   : in std_logic;
        doubledown_in  : in std_logic;
        bid_out        : out std_logic_vector(1 downto 0);
        money          : out std_logic_vector(9 downto 0);
        insurance_out  : out std_logic;
        doubledown_out : out std_logic);
end player;