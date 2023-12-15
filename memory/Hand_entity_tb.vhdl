library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hand_tb is
end entity;

architecture hand_tb_arc of hand_tb is

    component hand is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            mem_rst : in std_logic;
            enable  : in std_logic;

            card : in std_logic_vector(3 downto 0);

            card1         : out std_logic_vector(3 downto 0);
            card2         : out std_logic_vector(3 downto 0);
            card3         : out std_logic_vector(3 downto 0);
            card4         : out std_logic_vector(3 downto 0);
            card5         : out std_logic_vector(3 downto 0);
            numberofcards : out std_logic_vector(2 downto 0)

        );
    end component;

    signal clk, rst, mem_rst, enable               : std_logic                    := '0';
    signal card, card1, card2, card3, card4, card5 : std_logic_vector(3 downto 0) := "0000";
    signal numberofcards                           : std_logic_vector(2 downto 0) := "000";

begin
    L1 : hand port map(clk, rst, mem_rst, enable, card, card1, card2, card3, card4, card5, numberofcards);

    clk <= not clk after 10 ns;

    card    <= "0100" after 50 ns, "0110" after 70 ns, "0101" after 90 ns, "0110" after 130 ns, "0101" after 170 ns;
    enable  <= '1' after 70 ns;
    mem_rst <= '1' after 110 ns, '0' after 130 ns;
end architecture;