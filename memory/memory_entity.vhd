library IEEE;
use IEEE.std_logic_1163.all;

entity memory is
    port (
        rst                : in std_logic;
        card_enable        : in std_logic;
        card               : in std_logic_vector(3 downto 0);
        insurance          : in std_logic;
        insurance_enable   : in std_logic_vector;
        double_down        : in std_logic;
        double_down_enable : in std_logic;
        win_type           : in std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
        win_enable         : in std_logic;
        bet                : in std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
        player             : in std_logic_vector(2 downto 0); -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
        player_enable      : in std_logic;
        card               : in std_logic_vector(3 downto 0);
        card_enable        : in std_logic;
        money              : in std_logic_vector(10 downto 0);
        split              : in std_logic;

        player : out std_logic_vector(2 downto 0);

        player1 : out std_logic;
        card1_1 : out std_logic_vector(3 downto 0);
        card1_2 : out std_logic_vector(3 downto 0);
        card1_3 : out std_logic_vector(3 downto 0);
        card1_4 : out std_logic_vector(3 downto 0);
        card1_5 : out std_logic_vector(3 downto 0);
        money1  : out std_logic_vector(10 downto 0);
        bet1    : out std_logic_vector(1 downto 0);
        split1  : out std_logic;

        player2 : out std_logic;
        card2_1 : out std_logic_vector(3 downto 0);
        card2_2 : out std_logic_vector(3 downto 0);
        card2_3 : out std_logic_vector(3 downto 0);
        card2_4 : out std_logic_vector(3 downto 0);
        card2_5 : out std_logic_vector(3 downto 0);
        money2  : out std_logic_vector(10 downto 0);
        bet2    : out std_logic_vector(1 downto 0);
        split2  : out std_logic;

        player3 : out std_logic;
        card3_1 : out std_logic_vector(3 downto 0);
        card3_2 : out std_logic_vector(3 downto 0);
        card3_3 : out std_logic_vector(3 downto 0);
        card3_4 : out std_logic_vector(3 downto 0);
        card3_5 : out std_logic_vector(3 downto 0);
        money3  : out std_logic_vector(10 downto 0);
        bet3    : out std_logic_vector(1 downto 0);
        split3  : out std_logic;

        player4 : out std_logic;
        card4_1 : out std_logic_vector(3 downto 0);
        card4_2 : out std_logic_vector(3 downto 0);
        card4_3 : out std_logic_vector(3 downto 0);
        card4_4 : out std_logic_vector(3 downto 0);
        card4_5 : out std_logic_vector(3 downto 0);
        money4  : out std_logic_vector(10 downto 0);
        bet4    : out std_logic_vector(1 downto 0);
        split4  : out std_logic;

        -- dealer
        card5_1 : out std_logic_vector(3 downto 0);
        card5_2 : out std_logic_vector(3 downto 0);
        card5_3 : out std_logic_vector(3 downto 0);
        card5_4 : out std_logic_vector(3 downto 0);
        card5_5 : out std_logic_vector(3 downto 0);

        -- split
        card6_1 : out std_logic_vector(3 downto 0);
        card6_2 : out std_logic_vector(3 downto 0);
        card6_3 : out std_logic_vector(3 downto 0);
        card6_4 : out std_logic_vector(3 downto 0);
        card6_5 : out std_logic_vector(3 downto 0)
    )
end entity memory;