library IEEE;
use IEEE.std_logic_1163.all;

entity memory_tb is
end entity;

architecture memory_tb_arc of memory_tb is

    component memory is
        port (
            clk               : in std_logic;
            rst               : in std_logic;
            card_enable       : in std_logic;
            card              : in std_logic_vector(3 downto 0);
            insurance         : in std_logic;
            insurance_enable  : in std_logic_vector;
            doubledown        : in std_logic;
            doubledown_enable : in std_logic;
            win_type          : in std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
            win_enable        : in std_logic;
            bid               : in std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
            bid_enable        : in std_logic;
            player            : in std_logic_vector(2 downto 0); -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
            player_enable     : in std_logic;
            money             : in std_logic_vector(10 downto 0);
            split             : in std_logic;

            player : out std_logic_vector(2 downto 0);

            player1     : out std_logic;
            card1_1     : out std_logic_vector(3 downto 0);
            card1_2     : out std_logic_vector(3 downto 0);
            card1_3     : out std_logic_vector(3 downto 0);
            card1_4     : out std_logic_vector(3 downto 0);
            card1_5     : out std_logic_vector(3 downto 0);
            money1      : out std_logic_vector(10 downto 0);
            bid1        : out std_logic_vector(1 downto 0);
            split1      : out std_logic;
            insurance1  : out std_logic;
            doubledown1 : out std_logic;

            player2     : out std_logic;
            card2_1     : out std_logic_vector(3 downto 0);
            card2_2     : out std_logic_vector(3 downto 0);
            card2_3     : out std_logic_vector(3 downto 0);
            card2_4     : out std_logic_vector(3 downto 0);
            card2_5     : out std_logic_vector(3 downto 0);
            money2      : out std_logic_vector(10 downto 0);
            bid2        : out std_logic_vector(1 downto 0);
            split2      : out std_logic;
            insurance2  : out std_logic;
            doubledown2 : out std_logic;

            player3     : out std_logic;
            card3_1     : out std_logic_vector(3 downto 0);
            card3_2     : out std_logic_vector(3 downto 0);
            card3_3     : out std_logic_vector(3 downto 0);
            card3_4     : out std_logic_vector(3 downto 0);
            card3_5     : out std_logic_vector(3 downto 0);
            money3      : out std_logic_vector(10 downto 0);
            bid3        : out std_logic_vector(1 downto 0);
            split3      : out std_logic;
            insurance3  : out std_logic;
            doubledown3 : out std_logic;

            player4     : out std_logic;
            card4_1     : out std_logic_vector(3 downto 0);
            card4_2     : out std_logic_vector(3 downto 0);
            card4_3     : out std_logic_vector(3 downto 0);
            card4_4     : out std_logic_vector(3 downto 0);
            card4_5     : out std_logic_vector(3 downto 0);
            money4      : out std_logic_vector(10 downto 0);
            bid4        : out std_logic_vector(1 downto 0);
            split4      : out std_logic;
            insurance4  : out std_logic;
            doubledown4 : out std_logic;

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
        );
    end component;
    signal rst               : std_logic;
    signal card_enable       : std_logic;
    signal card              : std_logic_vector(3 downto 0);
    signal insurance         : std_logic;
    signal insurance_enable  : std_logic_vector;
    signal doubledown        : std_logic;
    signal doubledown_enable : std_logic;
    signal win_type          : std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
    signal win_enable        : std_logic;
    signal bid               : std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
    signal bid_enable        : std_logic;
    signal player            : std_logic_vector(2 downto 0); -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
    signal player_enable     : std_logic;
    signal money             : std_logic_vector(10 downto 0);
    signal split             : std_logic;

    signal player : std_logic_vector(2 downto 0);

    signal player1     : std_logic;
    signal card1_1     : std_logic_vector(3 downto 0);
    signal card1_2     : std_logic_vector(3 downto 0);
    signal card1_3     : std_logic_vector(3 downto 0);
    signal card1_4     : std_logic_vector(3 downto 0);
    signal card1_5     : std_logic_vector(3 downto 0);
    signal money1      : std_logic_vector(10 downto 0);
    signal bid1        : std_logic_vector(1 downto 0);
    signal split1      : std_logic;
    signal insurance1  : std_logic;
    signal doubledown1 : std_logic;

    signal player2     : std_logic;
    signal card2_1     : std_logic_vector(3 downto 0);
    signal card2_2     : std_logic_vector(3 downto 0);
    signal card2_3     : std_logic_vector(3 downto 0);
    signal card2_4     : std_logic_vector(3 downto 0);
    signal card2_5     : std_logic_vector(3 downto 0);
    signal money2      : std_logic_vector(10 downto 0);
    signal bid2        : std_logic_vector(1 downto 0);
    signal split2      : std_logic;
    signal insurance2  : std_logic;
    signal doubledown2 : std_logic;

    signal player3     : std_logic;
    signal card3_1     : std_logic_vector(3 downto 0);
    signal card3_2     : std_logic_vector(3 downto 0);
    signal card3_3     : std_logic_vector(3 downto 0);
    signal card3_4     : std_logic_vector(3 downto 0);
    signal card3_5     : std_logic_vector(3 downto 0);
    signal money3      : std_logic_vector(10 downto 0);
    signal bid3        : std_logic_vector(1 downto 0);
    signal split3      : std_logic;
    signal insurance3  : std_logic;
    signal doubledown3 : std_logic;

    signal player4     : std_logic;
    signal card4_1     : std_logic_vector(3 downto 0);
    signal card4_2     : std_logic_vector(3 downto 0);
    signal card4_3     : std_logic_vector(3 downto 0);
    signal card4_4     : std_logic_vector(3 downto 0);
    signal card4_5     : std_logic_vector(3 downto 0);
    signal money4      : std_logic_vector(10 downto 0);
    signal bid4        : std_logic_vector(1 downto 0);
    signal split4      : std_logic;
    signal insurance4  : std_logic;
    signal doubledown4 : std_logic;

    -- dealer
    signal card5_1 : std_logic_vector(3 downto 0);
    signal card5_2 : std_logic_vector(3 downto 0);
    signal card5_3 : std_logic_vector(3 downto 0);
    signal card5_4 : std_logic_vector(3 downto 0);
    signal card5_5 : std_logic_vector(3 downto 0);

    -- split
    signal card6_1 : std_logic_vector(3 downto 0);
    signal card6_2 : std_logic_vector(3 downto 0);
    signal card6_3 : std_logic_vector(3 downto 0);
    signal card6_4 : std_logic_vector(3 downto 0);
    signal card6_5 : std_logic_vector(3 downto 0);
begin

    test : hand port map(
        rst,
        card_enable,
        card,
        insurance,
        insurance_enable,
        doubledown,
        doubledown_enable,
        win_type,
        win_enable,
        bid,
        bid_enable,
        player,
        player_enable,
        money,
        split,

        player,

        player1,
        card1_1,
        card1_2,
        card1_3,
        card1_4,
        card1_5,
        money1,
        bid1,
        split1,
        insurance1,
        doubledown1,

        player2,
        card2_1,
        card2_2,
        card2_3,
        card2_4,
        card2_5,
        money2,
        bid2,
        split2,
        insurance2,
        doubledown2,

        player3,
        card3_1,
        card3_2,
        card3_3,
        card3_4,
        card3_5,
        money3,
        bid3,
        split3,
        insurance3,
        doubledown3,

        player4,
        card4_1,
        card4_2,
        card4_3,
        card4_4,
        card4_5,
        money4,
        bid4,
        split4,
        insurance4,
        doubledown4,

        -- dealer
        card5_1,
        card5_2,
        card5_3,
        card5_4,
        card5_5,

        -- split
        card6_1,
        card6_2,
        card6_3,
        card6_4,
        card6_5);

    clk <= not clk after 10 ns;

    card <= "0000" after 0 ns,
        "0100" after 50 ns,
        "0110" after 70 ns,
        "0101" after 85 ns,
        "0110" after 125 ns,
        "0101" after 165 ns;

    enable <= '0' after 25 ns,
        '1' after 50 ns,
        '0' after 70 ns,
        '1' after 85 ns,
        '0' after 125 ns,
        '1' after 165 ns,
        '0' after 185 ns;

    rst <= '0' after 0 ns,
        '1' after 5 ns,
        '0' after 25 ns;
end architecture;