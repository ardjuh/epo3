library IEEE;
use IEEE.std_logic_1164.all;

architecture memory_tb_arc of memory_v2_tb is
    component memory_v2 is
        port (
            clk        : in std_logic;
            rst        : in std_logic;
            enable     : in std_logic;
            bid_enable : in std_logic;
            player_in  : in std_logic_vector(2 downto 0);

            insurance  : in std_logic;
            doubledown : in std_logic;
            split      : in std_logic;
            end_round  : in std_logic;
            card_in    : in std_logic_vector(3 downto 0);

            player_a_in  : in std_logic;
            win_type1_in : in std_logic_vector(2 downto 0); -- 0: niet gewonnen, 1: insurance, 2: double down, 3: blackjack, 4 : normal
            money1_in    : in std_logic_vector(9 downto 0);
            bid1_in      : in std_logic_vector(1 downto 0);

            player_b_in  : in std_logic;
            win_type2_in : in std_logic_vector(2 downto 0);
            money2_in    : in std_logic_vector(9 downto 0);
            bid2_in      : in std_logic_vector(1 downto 0);

            player_c_in  : in std_logic;
            win_type3_in : in std_logic_vector(2 downto 0);
            money3_in    : in std_logic_vector(9 downto 0);
            bid3_in      : in std_logic_vector(1 downto 0);

            player_d_in  : in std_logic;
            win_type4_in : in std_logic_vector(2 downto 0);
            money4_in    : in std_logic_vector(9 downto 0);
            bid4_in      : in std_logic_vector(1 downto 0);

            player_out : out std_logic_vector(2 downto 0);

            player_a_out    : out std_logic;
            card1_1_out     : out std_logic_vector(3 downto 0);
            card1_2_out     : out std_logic_vector(3 downto 0);
            card1_3_out     : out std_logic_vector(3 downto 0);
            card1_4_out     : out std_logic_vector(3 downto 0);
            card1_5_out     : out std_logic_vector(3 downto 0);
            score1_out      : out std_logic_vector(4 downto 0);
            money1_out      : out std_logic_vector(9 downto 0);
            bid1_out        : out std_logic_vector(1 downto 0);
            split1_out      : out std_logic;
            insurance1_out  : out std_logic;
            doubledown1_out : out std_logic;

            player_b_out    : out std_logic;
            card2_1_out     : out std_logic_vector(3 downto 0);
            card2_2_out     : out std_logic_vector(3 downto 0);
            card2_3_out     : out std_logic_vector(3 downto 0);
            card2_4_out     : out std_logic_vector(3 downto 0);
            card2_5_out     : out std_logic_vector(3 downto 0);
            score2_out      : out std_logic_vector(4 downto 0);
            money2_out      : out std_logic_vector(9 downto 0);
            bid2_out        : out std_logic_vector(1 downto 0);
            split2_out      : out std_logic;
            insurance2_out  : out std_logic;
            doubledown2_out : out std_logic;

            player_c_out    : out std_logic;
            card3_1_out     : out std_logic_vector(3 downto 0);
            card3_2_out     : out std_logic_vector(3 downto 0);
            card3_3_out     : out std_logic_vector(3 downto 0);
            card3_4_out     : out std_logic_vector(3 downto 0);
            card3_5_out     : out std_logic_vector(3 downto 0);
            score3_out      : out std_logic_vector(4 downto 0);
            money3_out      : out std_logic_vector(9 downto 0);
            bid3_out        : out std_logic_vector(1 downto 0);
            split3_out      : out std_logic;
            insurance3_out  : out std_logic;
            doubledown3_out : out std_logic;

            player_d_out    : out std_logic;
            card4_1_out     : out std_logic_vector(3 downto 0);
            card4_2_out     : out std_logic_vector(3 downto 0);
            card4_3_out     : out std_logic_vector(3 downto 0);
            card4_4_out     : out std_logic_vector(3 downto 0);
            card4_5_out     : out std_logic_vector(3 downto 0);
            score4_out      : out std_logic_vector(4 downto 0);
            money4_out      : out std_logic_vector(9 downto 0);
            bid4_out        : out std_logic_vector(1 downto 0);
            split4_out      : out std_logic;
            insurance4_out  : out std_logic;
            doubledown4_out : out std_logic;

            -- dealer
            card5_1_out : out std_logic_vector(3 downto 0);
            card5_2_out : out std_logic_vector(3 downto 0);
            card5_3_out : out std_logic_vector(3 downto 0);
            card5_4_out : out std_logic_vector(3 downto 0);
            card5_5_out : out std_logic_vector(3 downto 0);
            score5_out  : out std_logic_vector(4 downto 0);

            -- split
            card6_1_out : out std_logic_vector(3 downto 0);
            card6_2_out : out std_logic_vector(3 downto 0);
            card6_3_out : out std_logic_vector(3 downto 0);
            card6_4_out : out std_logic_vector(3 downto 0);
            card6_5_out : out std_logic_vector(3 downto 0);
            score6_out  : out std_logic_vector(4 downto 0)
        );
    end component;
    signal clk        : std_logic                    := '0';
    signal rst        : std_logic                    := '0';
    signal enable     : std_logic                    := '0';
    signal bid_enable : std_logic                    := '0';
    signal player_in  : std_logic_vector(2 downto 0) := "000";

    signal insurance  : std_logic                    := '0';
    signal doubledown : std_logic                    := '0';
    signal split      : std_logic                    := '0';
    signal end_round  : std_logic                    := '0';
    signal card_in    : std_logic_vector(3 downto 0) := "0000";

    signal player_a_in  : std_logic                    := '0';
    signal win_type1_in : std_logic_vector(2 downto 0) := "000";
    signal money1_in    : std_logic_vector(9 downto 0) := "0000000000";
    signal bid1_in      : std_logic_vector(1 downto 0) := "00";

    signal player_b_in  : std_logic                    := '0';
    signal win_type2_in : std_logic_vector(2 downto 0) := "000";
    signal money2_in    : std_logic_vector(9 downto 0) := "0000000000";
    signal bid2_in      : std_logic_vector(1 downto 0) := "00";

    signal player_c_in  : std_logic                    := '0';
    signal win_type3_in : std_logic_vector(2 downto 0) := "000";
    signal money3_in    : std_logic_vector(9 downto 0) := "0000000000";
    signal bid3_in      : std_logic_vector(1 downto 0) := "00";

    signal player_d_in  : std_logic                    := '0';
    signal win_type4_in : std_logic_vector(2 downto 0) := "000";
    signal money4_in    : std_logic_vector(9 downto 0) := "0000000000";
    signal bid4_in      : std_logic_vector(1 downto 0) := "00";
    signal player_out   : std_logic_vector(2 downto 0);

    signal player1_out     : std_logic;
    signal card1_1_out     : std_logic_vector(3 downto 0);
    signal card1_2_out     : std_logic_vector(3 downto 0);
    signal card1_3_out     : std_logic_vector(3 downto 0);
    signal card1_4_out     : std_logic_vector(3 downto 0);
    signal card1_5_out     : std_logic_vector(3 downto 0);
    signal money1_out      : std_logic_vector(9 downto 0);
    signal bid1_out        : std_logic_vector(1 downto 0);
    signal split1_out      : std_logic;
    signal insurance1_out  : std_logic;
    signal doubledown1_out : std_logic;
    signal score1_out      : std_logic_vector(4 downto 0);

    signal player2_out     : std_logic;
    signal card2_1_out     : std_logic_vector(3 downto 0);
    signal card2_2_out     : std_logic_vector(3 downto 0);
    signal card2_3_out     : std_logic_vector(3 downto 0);
    signal card2_4_out     : std_logic_vector(3 downto 0);
    signal card2_5_out     : std_logic_vector(3 downto 0);
    signal money2_out      : std_logic_vector(9 downto 0);
    signal bid2_out        : std_logic_vector(1 downto 0);
    signal split2_out      : std_logic;
    signal insurance2_out  : std_logic;
    signal doubledown2_out : std_logic;
    signal score2_out      : std_logic_vector(4 downto 0);

    signal player3_out     : std_logic;
    signal card3_1_out     : std_logic_vector(3 downto 0);
    signal card3_2_out     : std_logic_vector(3 downto 0);
    signal card3_3_out     : std_logic_vector(3 downto 0);
    signal card3_4_out     : std_logic_vector(3 downto 0);
    signal card3_5_out     : std_logic_vector(3 downto 0);
    signal money3_out      : std_logic_vector(9 downto 0);
    signal bid3_out        : std_logic_vector(1 downto 0);
    signal split3_out      : std_logic;
    signal insurance3_out  : std_logic;
    signal doubledown3_out : std_logic;
    signal score3_out      : std_logic_vector(4 downto 0);

    signal player4_out     : std_logic;
    signal card4_1_out     : std_logic_vector(3 downto 0);
    signal card4_2_out     : std_logic_vector(3 downto 0);
    signal card4_3_out     : std_logic_vector(3 downto 0);
    signal card4_4_out     : std_logic_vector(3 downto 0);
    signal card4_5_out     : std_logic_vector(3 downto 0);
    signal money4_out      : std_logic_vector(9 downto 0);
    signal bid4_out        : std_logic_vector(1 downto 0);
    signal split4_out      : std_logic;
    signal insurance4_out  : std_logic;
    signal doubledown4_out : std_logic;
    signal score4_out      : std_logic_vector(4 downto 0);

    -- dealer
    signal card5_1_out : std_logic_vector(3 downto 0);
    signal card5_2_out : std_logic_vector(3 downto 0);
    signal card5_3_out : std_logic_vector(3 downto 0);
    signal card5_4_out : std_logic_vector(3 downto 0);
    signal card5_5_out : std_logic_vector(3 downto 0);
    signal score5_out  : std_logic_vector(4 downto 0);

    -- split
    signal card6_1_out : std_logic_vector(3 downto 0);
    signal card6_2_out : std_logic_vector(3 downto 0);
    signal card6_3_out : std_logic_vector(3 downto 0);
    signal card6_4_out : std_logic_vector(3 downto 0);
    signal card6_5_out : std_logic_vector(3 downto 0);
    signal score6_out  : std_logic_vector(4 downto 0);
begin

    test : memory_v2 port map(
        clk,
        rst,
        enable,
        bid_enable,
        player_in,

        insurance,
        doubledown,
        split,
        end_round,
        card_in,

        player_a_in,
        win_type1_in,
        money1_in,
        bid1_in,

        player_b_in,
        win_type2_in,
        money2_in,
        bid2_in,

        player_c_in,
        win_type3_in,
        money3_in,
        bid3_in,

        player_d_in,
        win_type4_in,
        money4_in,
        bid4_in,

        player_out,

        player1_out,
        card1_1_out,
        card1_2_out,
        card1_3_out,
        card1_4_out,
        card1_5_out,
        score1_out,
        money1_out,
        bid1_out,
        split1_out,
        insurance1_out,
        doubledown1_out,

        player2_out,
        card2_1_out,
        card2_2_out,
        card2_3_out,
        card2_4_out,
        card2_5_out,
        score2_out,
        money2_out,
        bid2_out,
        split2_out,
        insurance2_out,
        doubledown2_out,

        player3_out,
        card3_1_out,
        card3_2_out,
        card3_3_out,
        card3_4_out,
        card3_5_out,
        score3_out,
        money3_out,
        bid3_out,
        split3_out,
        insurance3_out,
        doubledown3_out,

        player4_out,
        card4_1_out,
        card4_2_out,
        card4_3_out,
        card4_4_out,
        card4_5_out,
        score4_out,
        money4_out,
        bid4_out,
        split4_out,
        insurance4_out,
        doubledown4_out,

        -- dealer
        card5_1_out,
        card5_2_out,
        card5_3_out,
        card5_4_out,
        card5_5_out,
        score5_out,

        -- split
        card6_1_out,
        card6_2_out,
        card6_3_out,
        card6_4_out,
        card6_5_out,
        score6_out
    );
    clk <= not clk after 10 ns;

    card_in <= "0000" after 0 ns,
        "0100" after 70 ns,
        "0110" after 130 ns,
        "0101" after 190 ns,
        "0110" after 250 ns,
        "0101" after 310 ns,
        "0100" after 370 ns,
        "0110" after 430 ns,
        "0101" after 490 ns,
        "0110" after 550 ns,
        "0101" after 610 ns;

    enable <= '0' after 0 ns,
        '1' after 30 ns,
        '0' after 40 ns,
        '1' after 60 ns,
        '0' after 70 ns,
        '1' after 90 ns,
        '0' after 100 ns,

        '1' after 120 ns,
        '0' after 130 ns,
        '1' after 150 ns,
        '0' after 160 ns,
        '1' after 180 ns,
        '0' after 190 ns,
        '1' after 210 ns,
        '0' after 220 ns,

        '1' after 240 ns,
        '0' after 250 ns,
        '1' after 270 ns,
        '0' after 280 ns,
        '1' after 300 ns,
        '0' after 310 ns,
        '1' after 330 ns,
        '0' after 340 ns,
        '1' after 420 ns,
        '0' after 430 ns;
      

    player_in <= "000" after 0 ns,
        "010" after 90 ns,
        "001" after 110 ns,
        "000" after 190 ns,
        "010" after 210 ns;

    rst <= '0' after 0 ns,
        '1' after 5 ns,
        '0' after 25 ns;

    bid2_in <= "00" after 0 ns,
        "01" after 30 ns,
        "10" after 50 ns,
        "01" after 70 ns,
        "10" after 90 ns,
        "01" after 210 ns;

    win_type2_in <= "000" after 0 ns,
        "001" after 30 ns,
        "010" after 50 ns,
        "001" after 70 ns,
        "010" after 90 ns,
        "001" after 210 ns;

    insurance <= '0' after 0 ns,
        '1' after 50 ns,
        '0' after 130 ns,
        '1' after 150 ns,
        '0' after 190 ns,
        '1' after 250 ns,
        '0' after 300 ns;


        doubledown <= '0' after 0 ns,
        '1' after 250 ns,
        '0' after 330 ns,
        '1' after 350 ns,
        '0' after 390 ns,
        '1' after 450 ns,
        '0' after 500 ns;
end architecture;