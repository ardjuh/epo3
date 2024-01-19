library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_cont is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        --Player_Turn	: in std_logic_vector (2 downto 0);

        button_select : in std_logic;
        button_left   : in std_logic; -- player inputs --
        button_right  : in std_logic;

        Player1_Budget : in std_logic_vector (9 downto 0); -- base budget is 100, score limit chosen as 1000 so 10 bits --
        Player2_Budget : in std_logic_vector (9 downto 0);
        Player3_Budget : in std_logic_vector (9 downto 0);
        Player4_Budget : in std_logic_vector (9 downto 0);

        Player1_Bid : in std_logic_vector (1 downto 0); -- Bid and Budget required to determine if Insurance/Double are possible --
        Player2_Bid : in std_logic_vector (1 downto 0); -- Value of Initial Bid = 2,6,10,20 -> 00,01,10,11 (Internal signal Bid_Value) --
        Player3_Bid : in std_logic_vector (1 downto 0); -- Controller never needs the augmented value of Bid as Double/Insurance/Split --
        Player4_Bid : in std_logic_vector (1 downto 0); -- are Turn 1 actions (If Mem Controller does end-round calculations) --

        Player1_Insured : in std_logic;
        Player2_Insured : in std_logic;
        Player3_Insured : in std_logic;
        Player4_Insured : in std_logic;

        Player1_Doubled_Down : in std_logic;
        Player2_Doubled_Down : in std_logic;
        Player3_Doubled_Down : in std_logic;
        Player4_Doubled_Down : in std_logic;

        Player1_Hand_Card_1 : in std_logic_vector (3 downto 0); -- Each card is a 4-bit vector --
        Player1_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Player1_Hand_Score  : in std_logic_vector (4 downto 0); -- Player can have 20 and draw a 10, so 30 points total possible --

        Player2_Hand_Card_1 : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Player2_Hand_Score  : in std_logic_vector (4 downto 0);

        Player3_Hand_Card_1 : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Player3_Hand_Score  : in std_logic_vector (4 downto 0);

        Player4_Hand_Card_1 : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Player4_Hand_Score  : in std_logic_vector (4 downto 0);

        Dealer_Hand_Card_1 : in std_logic_vector (3 downto 0);
        Dealer_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Dealer_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Dealer_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Dealer_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Dealer_Hand_Score  : in std_logic_vector (4 downto 0);

        Reserve_Hand_Card_1 : in std_logic_vector (3 downto 0); -- Reserve hand for Split. Only one player can split (low chance of multiple splits) --
        Reserve_Hand_Card_2 : in std_logic_vector (3 downto 0);
        Reserve_Hand_Card_3 : in std_logic_vector (3 downto 0);
        Reserve_Hand_Card_4 : in std_logic_vector (3 downto 0);
        Reserve_Hand_Card_5 : in std_logic_vector (3 downto 0);
        Reserve_Hand_Score  : in std_logic_vector (4 downto 0);

        random_card  : in std_logic_vector (3 downto 0); -- Comms with RNG --
        request_card : out std_logic;
        new_card     : out std_logic_vector (3 downto 0); -- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --

        cursor_position     : out std_logic_vector(2 downto 0);
        current_screen_type : out std_logic_vector(1 downto 0);

        hit_option        : out std_logic;
        double_option     : out std_logic;
        split_option      : out std_logic;
        insurance_option  : out std_logic;
        even_money_option : out std_logic;

        Player1_Bid_New : out std_logic_vector (1 downto 0); -- 2,6,10,20 = 4 options so 2 bits --
        Player2_Bid_New : out std_logic_vector (1 downto 0);
        Player3_Bid_New : out std_logic_vector (1 downto 0);
        Player4_Bid_New : out std_logic_vector (1 downto 0);

        Player1_win_type : out std_logic_vector (2 downto 0);
        Player2_win_type : out std_logic_vector (2 downto 0);
        Player3_win_type : out std_logic_vector (2 downto 0);
        Player4_win_type : out std_logic_vector (2 downto 0);

        Player_Turn_New : out std_logic_vector (2 downto 0); -- outputs -> mem based on actions --
        Receiving_Hand  : out std_logic_vector (2 downto 0); -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--

        enable        : out std_logic;
        bid_enable    : out std_logic;
        Player1_Broke : out std_logic;
        Player2_Broke : out std_logic;
        Player3_Broke : out std_logic;
        Player4_Broke : out std_logic;

        even_money : out std_logic;
        insurance  : out std_logic;
        split      : out std_logic;
        double     : out std_logic;

        round_end    : out std_logic;
        global_reset : out std_logic
    );
end game_cont;