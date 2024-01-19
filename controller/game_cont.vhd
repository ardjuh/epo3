architecture behaviour of game_cont is
    component controller
        port (
            clk   : in std_logic;
            reset : in std_logic;

            --Player_Turn	: in std_logic_vector (2 downto 0);

            switch_select : in std_logic;
            switch_left   : in std_logic; -- player inputs --
            switch_right  : in std_logic;

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
    end component;

    component mini_cont
        port (
            clk           : in std_logic;
            reset         : in std_logic;
            button_left   : in std_logic;
            button_right  : in std_logic;
            button_select : in std_logic;

            switch_left   : out std_logic;
            switch_right  : out std_logic;
            switch_select : out std_logic
        );
    end component;

    signal sig_select, sig_left, sig_right, reset_global : std_logic;

begin
    lbl1 : controller port map(
        clk   => clk,
        reset => reset,
        --Player_Turn	=> Player_Turn,

        switch_select => sig_select,
        switch_left   => sig_left,
        switch_right  => sig_right,

        Player1_Budget => Player1_Budget,
        Player2_Budget => Player2_Budget,
        Player3_Budget => Player3_Budget,
        Player4_Budget => Player4_Budget,

        Player1_Bid => Player1_Bid,
        Player2_Bid => Player2_Bid,
        Player3_Bid => Player3_Bid,
        Player4_Bid => Player4_Bid,

        Player1_Insured => Player1_Insured,
        Player2_Insured => Player2_Insured,
        Player3_Insured => Player3_Insured,
        Player4_Insured => Player4_Insured,

        Player1_Doubled_Down => Player1_Doubled_Down,
        Player2_Doubled_Down => Player2_Doubled_Down,
        Player3_Doubled_Down => Player3_Doubled_Down,
        Player4_Doubled_Down => Player4_Doubled_Down,

        Player1_Hand_Card_1 => Player1_Hand_Card_1,
        Player1_Hand_Card_2 => Player1_Hand_Card_2,
        Player1_Hand_Card_3 => Player1_Hand_Card_3,
        Player1_Hand_Card_4 => Player1_Hand_Card_4,
        Player1_Hand_Card_5 => Player1_Hand_Card_5,
        Player1_Hand_Score  => Player1_Hand_Score,

        Player2_Hand_Card_1 => Player2_Hand_Card_1,
        Player2_Hand_Card_2 => Player2_Hand_Card_2,
        Player2_Hand_Card_3 => Player2_Hand_Card_3,
        Player2_Hand_Card_4 => Player2_Hand_Card_4,
        Player2_Hand_Card_5 => Player2_Hand_Card_5,
        Player2_Hand_Score  => Player2_Hand_Score,

        Player3_Hand_Card_1 => Player3_Hand_Card_1,
        Player3_Hand_Card_2 => Player3_Hand_Card_2,
        Player3_Hand_Card_3 => Player3_Hand_Card_3,
        Player3_Hand_Card_4 => Player3_Hand_Card_4,
        Player3_Hand_Card_5 => Player3_Hand_Card_5,
        Player3_Hand_Score  => Player3_Hand_Score,

        Player4_Hand_Card_1 => Player4_Hand_Card_1,
        Player4_Hand_Card_2 => Player4_Hand_Card_2,
        Player4_Hand_Card_3 => Player4_Hand_Card_3,
        Player4_Hand_Card_4 => Player4_Hand_Card_4,
        Player4_Hand_Card_5 => Player4_Hand_Card_5,
        Player4_Hand_Score  => Player4_Hand_Score,

        Dealer_Hand_Card_1 => Dealer_Hand_Card_1,
        Dealer_Hand_Card_2 => Dealer_Hand_Card_2,
        Dealer_Hand_Card_3 => Dealer_Hand_Card_3,
        Dealer_Hand_Card_4 => Dealer_Hand_Card_4,
        Dealer_Hand_Card_5 => Dealer_Hand_Card_5,
        Dealer_Hand_Score  => Dealer_Hand_Score,

        Reserve_Hand_Card_1 => Reserve_Hand_Card_1,
        Reserve_Hand_Card_2 => Reserve_Hand_Card_2,
        Reserve_Hand_Card_3 => Reserve_Hand_Card_3,
        Reserve_Hand_Card_4 => Reserve_Hand_Card_4,
        Reserve_Hand_Card_5 => Reserve_Hand_Card_5,
        Reserve_Hand_Score  => Reserve_Hand_Score,

        random_card  => random_card,
        request_card => request_card,
        new_card     => new_card, -- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --

        cursor_position     => cursor_position,
        current_screen_type => current_screen_type,

        hit_option        => hit_option,
        double_option     => double_option,
        split_option      => split_option,
        insurance_option  => insurance_option,
        even_money_option => even_money_option,

        Player1_Bid_New => Player1_Bid_New,
        Player2_Bid_New => Player2_Bid_New,
        Player3_Bid_New => Player3_Bid_New,
        Player4_Bid_New => Player4_Bid_New,

        Player1_win_type => Player1_win_type,
        Player2_win_type => Player2_win_type,
        Player3_win_type => Player3_win_type,
        Player4_win_type => Player4_win_type,

        Player_Turn_New => Player_Turn_New,
        Receiving_Hand  => Receiving_Hand, -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--

        enable        => enable,
        bid_enable    => bid_enable,
        Player1_Broke => Player1_Broke,
        Player2_Broke => Player2_Broke,
        Player3_Broke => Player3_Broke,
        Player4_Broke => Player4_Broke,

        even_money => even_money,
        insurance  => insurance,
        split      => split,
        double     => double,

        round_end    => round_end,
        global_reset => reset_global
    );

    lbl2 : mini_cont port map(
        clk           => clk,
        reset         => reset_global,
        button_left   => button_left,
        button_right  => button_right,
        button_select => button_select,

        switch_left   => sig_left,
        switch_right  => sig_right,
        switch_select => sig_select
    );
end behaviour;