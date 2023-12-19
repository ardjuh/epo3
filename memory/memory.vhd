library ieee;
use ieee.std_logic_1164.all;

architecture behavior of memory is
    component hand port (
        clk     : in std_logic;
        rst     : in std_logic;
        mem_rst : in std_logic;
        enable  : in std_logic;
        card    : in std_logic_vector(3 downto 0);

        card1 : out std_logic_vector(3 downto 0);
        card2 : out std_logic_vector(3 downto 0);
        card3 : out std_logic_vector(3 downto 0);
        card4 : out std_logic_vector(3 downto 0);
        card5 : out std_logic_vector(3 downto 0));
    end component;
begin
    h1: hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable);

    process (player,)
    begin

    end process;
end behavior;