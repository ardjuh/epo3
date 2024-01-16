library IEEE;
use IEEE.std_logic_1164.all;

entity memory is
    port (
        clk       : in std_logic;
        rst       : in std_logic;
        enable    : in std_logic;
        player_in : in std_logic_vector(2 downto 0);

        insurance  : in std_logic;
        doubledown : in std_logic;
        split      : in std_logic;
        end_round  : in std_logic;

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
end entity memory;