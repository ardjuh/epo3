library IEEE;
use IEEE.std_logic_1164.all;

entity main is
    port (
        clk       : in std_logic;
        reset     : in std_logic;
        vga_hsync : out std_logic;
        vga_vsync : out std_logic;
        r         : out std_logic_vector(3 downto 0);
        g         : out std_logic_vector(3 downto 0);
        b         : out std_logic_vector(3 downto 0);

        player : in std_logic_vector (1 downto 0);

        player_a : in std_logic;
        card1_1  : in std_logic_vector (3 downto 0);
        card1_2  : in std_logic_vector (3 downto 0);
        card1_3  : in std_logic_vector (3 downto 0);
        card1_4  : in std_logic_vector (3 downto 0);
        card1_5  : in std_logic_vector (3 downto 0);
        money1   : in std_logic_vector (10 downto 0);
        split1   : in std_logic;

        player_b : in std_logic;
        card2_1  : in std_logic_vector (3 downto 0);
        card2_2  : in std_logic_vector (3 downto 0);
        card2_3  : in std_logic_vector (3 downto 0);
        card2_4  : in std_logic_vector (3 downto 0);
        card2_5  : in std_logic_vector (3 downto 0);
        money2   : in std_logic_vector (10 downto 0);
        split2   : in std_logic;

        player_c : in std_logic;
        card3_1  : in std_logic_vector (3 downto 0);
        card3_2  : in std_logic_vector (3 downto 0);
        card3_3  : in std_logic_vector (3 downto 0);
        card3_4  : in std_logic_vector (3 downto 0);
        card3_5  : in std_logic_vector (3 downto 0);
        money3   : in std_logic_vector (10 downto 0);
        split3   : in std_logic;

        player_d : in std_logic;
        card4_1  : in std_logic_vector (3 downto 0);
        card4_2  : in std_logic_vector (3 downto 0);
        card4_3  : in std_logic_vector (3 downto 0);
        card4_4  : in std_logic_vector (3 downto 0);
        card4_5  : in std_logic_vector (3 downto 0);
        money4   : in std_logic_vector (10 downto 0);
        split4   : in std_logic);
end main;
