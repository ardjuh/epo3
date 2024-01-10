library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture hand_tb_arc of hand_tb is

    component hand is
        port (
            clk    : in std_logic;
            rst    : in std_logic;
            enable : in std_logic;

            card : in std_logic_vector(3 downto 0);

            card1 : out std_logic_vector(3 downto 0);
            card2 : out std_logic_vector(3 downto 0);
            card3 : out std_logic_vector(3 downto 0);
            card4 : out std_logic_vector(3 downto 0);
            card5 : out std_logic_vector(3 downto 0);
            score : out std_logic_vector(4 downto 0)
        );
    end component;

    signal clk, rst, enable                        : std_logic                    := '0';
    signal card, card1, card2, card3, card4, card5 : std_logic_vector(3 downto 0) := "0000";
    signal score                                   : std_logic_vector(4 downto 0) := "00000";
begin
    test : hand port map(clk, rst, enable, card, card1, card2, card3, card4, card5, score);

    clk <= not clk after 10 ns;

    card <= "0000" after 0 ns,
        "0100" after 50 ns,
        "0110" after 70 ns,
        "0101" after 85 ns,
        "0110" after 125 ns,
        "0101" after 165 ns;

    enable <= '0' after 25 ns,
        '1' after 50 ns,
        '0' after 70 ns;

    rst <= '0' after 0 ns,
        '1' after 5 ns,
        '0' after 25 ns;
end architecture;