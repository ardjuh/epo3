library IEEE;
use IEEE.std_logic_1164.all;

-- rgb output, 4 bits per color, hsync, vsync
entity gpu_driver is
    port (
        h_pos : in std_logic_vector(9 downto 0);
        v_pos : in std_logic_vector(9 downto 0);
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0);

        player : in std_logic_vector (2 downto 0);

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
        split4   : in std_logic
    );
end entity gpu_driver;
