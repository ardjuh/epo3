library IEEE;
use IEEE.std_logic_1164.all;

architecture memory_tb_arc of memory_tb is
    component memory is
        port (
            clk               : in std_logic;
            rst               : in std_logic;
            end_round         : in std_logic;
            card_enable       : in std_logic;
            card              : in std_logic_vector(3 downto 0);
            insurance         : in std_logic;
            insurance_enable  : in std_logic;
            doubledown        : in std_logic;
            doubledown_enable : in std_logic;
            win_type          : in std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
            win_enable        : in std_logic;
            bid               : in std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
            bid_enable        : in std_logic;
            player_in         : in std_logic_vector(2 downto 0); -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
            player_enable     : in std_logic;
            money             : in std_logic_vector(9 downto 0);
            split             : in std_logic;

            player_out : out std_logic_vector(2 downto 0);

            player_a    : out std_logic;
            card1_1     : out std_logic_vector(3 downto 0);
            card1_2     : out std_logic_vector(3 downto 0);
            card1_3     : out std_logic_vector(3 downto 0);
            card1_4     : out std_logic_vector(3 downto 0);
            card1_5     : out std_logic_vector(3 downto 0);
            money1      : out std_logic_vector(9 downto 0);
            bid1        : out std_logic_vector(1 downto 0);
            split1      : out std_logic;
            insurance1  : out std_logic;
            doubledown1 : out std_logic;
            score1      : out std_logic_vector(4 downto 0);

            player_b    : out std_logic;
            card2_1     : out std_logic_vector(3 downto 0);
            card2_2     : out std_logic_vector(3 downto 0);
            card2_3     : out std_logic_vector(3 downto 0);
            card2_4     : out std_logic_vector(3 downto 0);
            card2_5     : out std_logic_vector(3 downto 0);
            money2      : out std_logic_vector(9 downto 0);
            bid2        : out std_logic_vector(1 downto 0);
            split2      : out std_logic;
            insurance2  : out std_logic;
            doubledown2 : out std_logic;
            score2      : out std_logic_vector(4 downto 0);

            player_c    : out std_logic;
            card3_1     : out std_logic_vector(3 downto 0);
            card3_2     : out std_logic_vector(3 downto 0);
            card3_3     : out std_logic_vector(3 downto 0);
            card3_4     : out std_logic_vector(3 downto 0);
            card3_5     : out std_logic_vector(3 downto 0);
            money3      : out std_logic_vector(9 downto 0);
            bid3        : out std_logic_vector(1 downto 0);
            split3      : out std_logic;
            insurance3  : out std_logic;
            doubledown3 : out std_logic;
            score3      : out std_logic_vector(4 downto 0);

            player_d    : out std_logic;
            card4_1     : out std_logic_vector(3 downto 0);
            card4_2     : out std_logic_vector(3 downto 0);
            card4_3     : out std_logic_vector(3 downto 0);
            card4_4     : out std_logic_vector(3 downto 0);
            card4_5     : out std_logic_vector(3 downto 0);
            money4      : out std_logic_vector(9 downto 0);
            bid4        : out std_logic_vector(1 downto 0);
            split4      : out std_logic;
            insurance4  : out std_logic;
            doubledown4 : out std_logic;
            score4      : out std_logic_vector(4 downto 0);

            -- dealer
            card5_1 : out std_logic_vector(3 downto 0);
            card5_2 : out std_logic_vector(3 downto 0);
            card5_3 : out std_logic_vector(3 downto 0);
            card5_4 : out std_logic_vector(3 downto 0);
            card5_5 : out std_logic_vector(3 downto 0);
            score5  : out std_logic_vector(4 downto 0);

            -- split
            card6_1 : out std_logic_vector(3 downto 0);
            card6_2 : out std_logic_vector(3 downto 0);
            card6_3 : out std_logic_vector(3 downto 0);
            card6_4 : out std_logic_vector(3 downto 0);
            card6_5 : out std_logic_vector(3 downto 0);
            score6  : out std_logic_vector(4 downto 0)
        );
    end component;
    signal rst, clk, end_round : std_logic                    := '0';
    signal card_enable         : std_logic                    := '0';
    signal card                : std_logic_vector(3 downto 0) := "0000";
    signal insurance           : std_logic                    := '0';
    signal insurance_enable    : std_logic                    := '0';
    signal doubledown          : std_logic                    := '0';
    signal doubledown_enable   : std_logic                    := '0';
    signal win_type            : std_logic_vector(1 downto 0) := "00"; -- 0: normal, 1: insurance, 2: double down: 3: blackjack
    signal win_enable          : std_logic                    := '0';
    signal bid                 : std_logic_vector(1 downto 0) := "00"; -- 0: 2, 1: 6, 2: 10, 3: 20
    signal bid_enable          : std_logic                    := '0';
    signal player_in           : std_logic_vector(2 downto 0) := "000"; -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
    signal player_enable       : std_logic                    := '0';
    signal money               : std_logic_vector(9 downto 0) := "0000000000";
    signal split               : std_logic                    := '0';

    signal player_out : std_logic_vector(2 downto 0);

    signal player1     : std_logic;
    signal card1_1     : std_logic_vector(3 downto 0);
    signal card1_2     : std_logic_vector(3 downto 0);
    signal card1_3     : std_logic_vector(3 downto 0);
    signal card1_4     : std_logic_vector(3 downto 0);
    signal card1_5     : std_logic_vector(3 downto 0);
    signal money1      : std_logic_vector(9 downto 0);
    signal bid1        : std_logic_vector(1 downto 0);
    signal split1      : std_logic;
    signal insurance1  : std_logic;
    signal doubledown1 : std_logic;
    signal score1      : std_logic_vector(4 downto 0);

    signal player2     : std_logic;
    signal card2_1     : std_logic_vector(3 downto 0);
    signal card2_2     : std_logic_vector(3 downto 0);
    signal card2_3     : std_logic_vector(3 downto 0);
    signal card2_4     : std_logic_vector(3 downto 0);
    signal card2_5     : std_logic_vector(3 downto 0);
    signal money2      : std_logic_vector(9 downto 0);
    signal bid2        : std_logic_vector(1 downto 0);
    signal split2      : std_logic;
    signal insurance2  : std_logic;
    signal doubledown2 : std_logic;
    signal score2      : std_logic_vector(4 downto 0);

    signal player3     : std_logic;
    signal card3_1     : std_logic_vector(3 downto 0);
    signal card3_2     : std_logic_vector(3 downto 0);
    signal card3_3     : std_logic_vector(3 downto 0);
    signal card3_4     : std_logic_vector(3 downto 0);
    signal card3_5     : std_logic_vector(3 downto 0);
    signal money3      : std_logic_vector(9 downto 0);
    signal bid3        : std_logic_vector(1 downto 0);
    signal split3      : std_logic;
    signal insurance3  : std_logic;
    signal doubledown3 : std_logic;
    signal score3      : std_logic_vector(4 downto 0);

    signal player4     : std_logic;
    signal card4_1     : std_logic_vector(3 downto 0);
    signal card4_2     : std_logic_vector(3 downto 0);
    signal card4_3     : std_logic_vector(3 downto 0);
    signal card4_4     : std_logic_vector(3 downto 0);
    signal card4_5     : std_logic_vector(3 downto 0);
    signal money4      : std_logic_vector(9 downto 0);
    signal bid4        : std_logic_vector(1 downto 0);
    signal split4      : std_logic;
    signal insurance4  : std_logic;
    signal doubledown4 : std_logic;
    signal score4      : std_logic_vector(4 downto 0);

    -- dealer
    signal card5_1 : std_logic_vector(3 downto 0);
    signal card5_2 : std_logic_vector(3 downto 0);
    signal card5_3 : std_logic_vector(3 downto 0);
    signal card5_4 : std_logic_vector(3 downto 0);
    signal card5_5 : std_logic_vector(3 downto 0);
    signal score5  : std_logic_vector(4 downto 0);

    -- split
    signal card6_1 : std_logic_vector(3 downto 0);
    signal card6_2 : std_logic_vector(3 downto 0);
    signal card6_3 : std_logic_vector(3 downto 0);
    signal card6_4 : std_logic_vector(3 downto 0);
    signal card6_5 : std_logic_vector(3 downto 0);
    signal score6  : std_logic_vector(4 downto 0);
begin

    test : memory port map(
        clk,
        rst,
        end_round,
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
        player_in,
        player_enable,
        money,
        split,

        player_out,

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
        score1,

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
        score2,

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
        score3,

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
        score4,

        -- dealer
        card5_1,
        card5_2,
        card5_3,
        card5_4,
        card5_5,
        score5,

        -- split
        card6_1,
        card6_2,
        card6_3,
        card6_4,
        card6_5,
        score6
    );
    clk <= not clk after 10 ns;

    card <= "0000" after 0 ns,
        "0100" after 30 ns,
        "0110" after 50 ns,
        "0101" after 70 ns,
        "0110" after 90 ns,
        "0101" after 110 ns,
        "0100" after 130 ns,
        "0110" after 150 ns,
        "0101" after 170 ns,
        "0110" after 190 ns,
        "0101" after 210 ns;

    card_enable <= '0' after 0 ns,
        '1' after 30 ns,
        '0' after 90 ns,
        '1' after 110 ns,
        '0' after 190 ns,
        '1' after 210 ns,
        '0' after 230 ns;

    player_in <= "000" after 0 ns,
        "010" after 90 ns,
        "001" after 110 ns,
        "000" after 190 ns,
        "010" after 210 ns;

    rst <= '0' after 0 ns,
        '1' after 5 ns,
        '0' after 25 ns;

end architecture;