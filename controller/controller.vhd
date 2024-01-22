library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
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

        round_end : out std_logic
    );
end controller;

architecture behaviour of controller is
    type controller_state is (reset_state,
        game_setup,
        player_action,
        game_resolution,
        pending_card_a,
        pending_card_b
    );

    signal state, new_state               : controller_state;
    signal start_screen, new_start_screen : std_logic;
    signal N_Players                      : std_logic_vector (2 downto 0);

    signal Player1_Bid_Value, Player2_Bid_Value, Player3_Bid_Value, Player4_Bid_Value : std_logic_vector (4 downto 0);
    signal Player1_Inactive, Player2_Inactive, Player3_inactive, Player4_Inactive     : std_logic;
    signal bids_placed, bid_successful, require_card, card_received                   : std_logic;
    signal first_card_deal, new_first_card_deal, dealer_card_deal, second_card_deal   : std_logic;

    signal even_money_selected, insurance_selected, split_selected, double_selected, hit_selected, hold_selected             : std_logic;
    signal even_money_selectable, insurance_selectable, split_selectable, double_selectable, hit_selectable, hold_selectable : std_logic;
    signal first_turn_over                                                                                                   : std_logic;

    signal split_player      : std_logic_vector (2 downto 0);
    signal split_player_turn : std_logic;

    signal choose_action, score_screen : std_logic;

    signal draw_screen_type                                                                         : std_logic_vector (1 downto 0);
    signal current_screen_position, new_current_screen_position, Player_Turn_In, new_Player_Turn_In : unsigned(2 downto 0);
begin
    process (clk)
    begin
        if (rising_edge (clk)) then
            if (reset = '1') then
                state                   <= reset_state;
                current_screen_position <= "001";
                Player_Turn_In          <= "001";
                start_screen            <= '1';
                N_Players               <= "000";

            else
                state                   <= new_state;
                current_screen_position <= new_current_screen_position;
                Player_Turn_In          <= new_Player_Turn_In;
                start_screen            <= new_start_screen;
                N_Players               <= N_Players_new;

            end if;
        end if;
    end process;

    process (state, switch_left, switch_right, switch_select, bids_placed,
        Player1_Hand_Card_1, Player1_Hand_Card_2, Player1_Hand_Card_3, Player1_Hand_Card_4, Player1_Hand_Card_5, Player1_Hand_Score,
        Dealer_Hand_Card_1, Dealer_Hand_Card_2, Dealer_Hand_Card_3, Dealer_Hand_Card_4, Dealer_Hand_Card_5, Dealer_Hand_Score,
        Player2_Hand_Card_1, Player2_Hand_Card_2, Player2_Hand_Card_3, Player2_Hand_Card_4, Player2_Hand_Card_5, Player2_Hand_Score,
        Player3_Hand_Card_1, Player3_Hand_Card_2, Player3_Hand_Card_3, Player3_Hand_Card_4, Player3_Hand_Card_5, Player3_Hand_Score,
        Player4_Hand_Card_1, Player4_Hand_Card_2, Player4_Hand_Card_3, Player4_Hand_Card_4, Player4_Hand_Card_5, Player4_Hand_Score,
        Player_Turn_In, split_player_turn, first_turn_over, split_player,
        Player1_Budget, Player2_Budget, Player3_Budget, Player4_Budget,
        Player1_Bid, Player2_Bid, Player3_Bid, Player4_Bid,
        Reserve_Hand_Card_1, Reserve_Hand_Card_2, Reserve_Hand_Card_3, Reserve_Hand_Card_4, Reserve_Hand_Card_5, Reserve_Hand_Score,
        current_screen_position, bid_successful, choose_action, start_screen,
        hold_selectable, hit_selectable, double_selectable, split_selectable, insurance_selectable, even_money_selectable,
        score_screen, new_first_card_deal, random_card, second_card_deal, dealer_card_deal,
        hold_selected, hit_selected, double_selected, split_selected, insurance_selected, even_money_selected,
        card_received, require_card, Player1_Insured, Player2_Insured, Player3_Insured, Player4_Insured, Player1_Doubled_Down,
        Player2_Doubled_Down, Player3_Doubled_Down, Player4_Doubled_Down, Player1_Inactive, Player2_Inactive, Player3_Inactive, Player4_Inactive, draw_screen_type,
        N_Players, Player1_Bid_Value, Player2_Bid_Value, Player3_Bid_Value, Player4_Bid_Value
        )

    begin
        N_Players_new  <= N_Players;
        bids_placed    <= '0';
        bid_successful <= '0';
        require_card   <= '0';
        card_received  <= '0';

        Player1_Bid_Value <= "00000";
        Player2_Bid_Value <= "00000";
        Player3_Bid_Value <= "00000";
        Player4_Bid_Value <= "00000";

        Player1_Inactive <= '0';
        Player2_Inactive <= '0';
        Player3_Inactive <= '0';
        Player4_Inactive <= '0';

        Player1_win_type <= "000";
        Player2_win_type <= "000";
        Player3_win_type <= "000";
        Player4_win_type <= "000";

        first_card_deal  <= '0';
        dealer_card_deal <= '0';
        second_card_deal <= '0';

        even_money_selected <= '0';
        insurance_selected  <= '0';
        double_selected     <= '0';
        split_selected      <= '0';
        hit_selected        <= '0';
        hold_selected       <= '0';

        even_money_selectable <= '0';
        insurance_selectable  <= '0';
        double_selectable     <= '0';
        split_selectable      <= '0';
        hit_selectable        <= '0';
        hold_selectable       <= '1';
        first_turn_over       <= '0';

        split_player      <= "000";
        split_player_turn <= '0';

        choose_action <= '0';
        score_screen  <= '0';

        draw_screen_type <= "10";

        request_card   <= '0';
        new_card       <= "0000";
        Receiving_Hand <= "000";

        Player1_Bid_New <= Player1_Bid;
        Player2_Bid_New <= Player2_Bid;
        Player3_Bid_New <= Player3_Bid;
        Player4_Bid_New <= Player4_Bid;
        enable          <= '0';
        bid_enable      <= '0';
        Player1_Broke   <= Player1_Inactive;
        Player2_Broke   <= Player2_Inactive;
        Player3_Broke   <= Player3_Inactive;
        Player4_Broke   <= Player4_Inactive;

        even_money <= '0';
        insurance  <= '0';
        split      <= '0';
        double     <= '0';

        new_current_screen_position <= current_screen_position;
        cursor_position             <= std_logic_vector(current_screen_position);
        current_screen_type         <= draw_screen_type;

        new_Player_Turn_In <= Player_Turn_In;
        Player_Turn_New    <= std_logic_vector(Player_Turn_In);

        hit_option        <= hit_selectable;
        double_option     <= double_selectable;
        split_option      <= split_selectable;
        insurance_option  <= insurance_selectable;
        even_money_option <= even_money_selectable;

        round_end <= '0';

        new_start_screen <= start_screen;
        case state is
            when reset_state =>
                N_Players_new  <= "000";
                bids_placed    <= '0';
                bid_successful <= '0';
                require_card   <= '0';
                card_received  <= '0';

                Player1_Bid_Value <= "00000";
                Player2_Bid_Value <= "00000";
                Player3_Bid_Value <= "00000";
                Player4_Bid_Value <= "00000";

                Player1_Inactive <= '0';
                Player2_Inactive <= '0';
                Player3_Inactive <= '0';
                Player4_Inactive <= '0';

                Player1_win_type <= "000";
                Player2_win_type <= "000";
                Player3_win_type <= "000";
                Player4_win_type <= "000";

                first_card_deal  <= '0';
                dealer_card_deal <= '0';
                second_card_deal <= '0';

                even_money_selected <= '0';
                insurance_selected  <= '0';
                double_selected     <= '0';
                split_selected      <= '0';
                hit_selected        <= '0';
                hold_selected       <= '0';

                even_money_selectable <= '0';
                insurance_selectable  <= '0';
                double_selectable     <= '0';
                split_selectable      <= '0';
                hit_selectable        <= '0';
                hold_selectable       <= '1';
                first_turn_over       <= '0';

                split_player      <= "000";
                split_player_turn <= '0';

                player_action choose_action <= '0';
                score_screen                <= '0';

                draw_screen_type <= "00";
                new_state        <= game_setup;
            when game_setup =>

                even_money_selected         <= '0';
                insurance_selected          <= '0';
                double_selected             <= '0';
                split_selected              <= '0';
                hit_selected                <= '0';
                player_action hold_selected <= '0';

                bid_successful <= '0';

                if (start_screen = '0') and (score_screen = '0') and (bids_placed = '1') then
                    draw_screen_type <= "10"; ----- 10 tells graphics cursor to track the action menu -----
                    choose_action    <= '1';

                elsif (start_screen = '1') then
                    new_state        <= player_action;
                    draw_screen_type <= "00";

                elsif (bids_placed = '0') and (N_Players /= "000") and (start_screen = '0') then -- bidding screen condition--
                    draw_screen_type <= "01"; ----- 10 tells graphics cursor to track the bidding menu -----
                    choose_action    <= '1';
                    new_state        <= player_action;

                    -- Check whether starting cards have been dealt -- 
                    -- If yes, check which dealing phase we're in based on player count--
                elsif (N_Players = "001") and (bids_placed = '1') then -- if 1 player total, switch phases based on Player 1 cards --
                    new_Player_Turn_In <= "001";
                    if (Player1_Hand_Card_1 = "0000") then -- Dealer receives a card after the last player received their first card --
                        first_card_deal  <= '1';
                        dealer_card_deal <= '0';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    elsif (Player1_Hand_Card_1 /= "0000") and (Dealer_Hand_Card_1 = "0000") then
                        first_card_deal  <= '0';
                        dealer_card_deal <= '1';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                        player_action else
                        first_card_deal  <= '0';
                        dealer_card_deal <= '0';
                        second_card_deal <= '1';
                        new_state        <= game_resolution;
                    end if;

                elsif (N_Players = "010") then -- if 2 players, switch phases based on Player 2's hand --
                    new_Player_Turn_In <= "001";
                    if (Player2_Hand_Card_1 = "0000") then
                        first_card_deal  <= '1';
                        dealer_card_deal <= '0';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    elsif (Player2_Hand_Card_1 /= "0000") and (Dealer_Hand_Card_1 = "0000") then
                        first_card_deal  <= '0';
                        dealer_card_deal <= '1';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    else
                        first_card_deal  <= '0';
                        dealer_card_deal <= '0';
                        second_card_deal <= '1';
                        new_state        <= game_resolution;
                    end if;

                elsif (N_Players = "011") then -- if 3 players, switch phases based on Player 3's hand --
                    new_Player_Turn_In <= "001";
                    if (Player3_Hand_Card_1 = "0000") then
                        first_card_deal  <= '1';
                        dealer_card_deal <= '0';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    elsif (Player3_Hand_Card_1 /= "0000") and (Dealer_Hand_Card_1 = "0000") then
                        first_card_deal  <= '0';
                        dealer_card_deal <= '1';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    else
                        first_card_deal  <= '0';
                        dealer_card_deal <= '0';
                        second_card_deal <= '1';
                        new_state        <= game_resolution;
                    end if;

                else
                    new_Player_Turn_In <= "001";
                    if (Player4_Hand_Card_1 = "0000") then
                        first_card_deal  <= '1';
                        dealer_card_deal <= '0';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    elsif (Player4_Hand_Card_1 /= "0000") and (Dealer_Hand_Card_1 = "0000") then
                        first_card_deal  <= '0';
                        dealer_card_deal <= '1';
                        second_card_deal <= '0';
                        new_state        <= game_resolution;

                    else
                        first_card_deal  <= '0';
                        dealer_card_deal <= '0';
                        second_card_deal <= '1';
                        new_state        <= game_resolution;
                    end if;
                end if;

                ----------------------------- checking actions available: scores of hands may be sent by mem, adjust accordingly -------------------------------------	

                if (Player_Turn_In = "001") and (split_player_turn = '0') then
                    if (first_turn_over = '0') then
                        if (unsigned(Player1_Hand_Score) > 21) then
                            new_state <= player_action;

                        elsif (Player1_Hand_Card_2 /= "0000") and (Player1_Hand_Card_3 = "0000") then
                            if (unsigned(Dealer_Hand_Score) > 9) and (unsigned(Player1_Hand_Score) = 21) then
                                even_money_selectable <= '1';
                            else
                                even_money_selectable <= '0';
                            end if;

                            if (unsigned(Dealer_Hand_Score) = 11) and (unsigned(Player1_Budget) >= (unsigned(Player1_Bid_Value) /2)) then
                                insurance_selectable <= '1';
                            else
                                insurance_selectable <= '0';
                            end if;

                            if (unsigned(Player1_Hand_Card_1) = unsigned(Player1_Hand_Card_2)) and (unsigned(Player1_Budget) >= unsigned(Player1_Bid_Value)) then
                                split_selectable <= '1';
                            else
                                split_selectable <= '0';
                            end if;

                            if (unsigned(Player1_Budget) >= unsigned(Player1_Bid_Value)) and (unsigned(Player1_Hand_Score) < 21) then
                                double_selectable <= '1';
                            else
                                double_selectable <= '0';
                            end if;
                            player_action
                            hit_selectable <= '1';
                            new_state      <= player_action;

                        elsif (Player1_Hand_Card_3 /= "0000") then
                            if (unsigned(Player1_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player1_Hand_Score) < 22) and (Player1_Hand_Card_5 /= "0000") then
                                new_state <= player_action;

                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;

                    else
                        if (unsigned(Player1_Hand_Score) > 21) then
                            new_state <= player_action;

                        else
                            if (unsigned(Player1_Hand_Card_1) = 11) and (Player1_Hand_Card_2 /= "0000") then
                                new_state <= player_action;

                            elsif (unsigned(Player1_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player1_Hand_Score) < 22) and (Player1_Hand_Card_5 /= "0000") then
                                new_state <= player_action;
                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;
                    end if;

                elsif (Player_Turn_In = "010") and (split_player_turn = '0') then
                    if (first_turn_over = '0') then
                        if (unsigned(Player2_Hand_Score) > 21) then
                            new_state <= player_action;

                        elsif (Player2_Hand_Card_2 /= "0000") and (Player2_Hand_Card_3 = "0000") then
                            if (unsigned(Dealer_Hand_Score) > 9) and (unsigned(Player2_Hand_Score) = 21) then
                                even_money_selectable <= '1';
                            else
                                even_money_selectable <= '0';
                            end if;

                            if (unsigned(Dealer_Hand_Score) = 11) and (unsigned(Player2_Budget) >= (unsigned(Player2_Bid_Value)/2)) then
                                insurance_selectable <= '1';
                            else
                                insurance_selectable <= '0';
                            end if;

                            if (unsigned(Player2_Hand_Card_1) = unsigned(Player2_Hand_Card_2)) and (unsigned(Player2_Budget) >= unsigned(Player2_Bid_Value)) then
                                split_selectable <= '1';
                            else
                                split_selectable <= '0';
                            end if;

                            if (unsigned(Player2_Budget) >= unsigned(Player2_Bid_Value)) and (unsigned(Player2_Hand_Score) < 21) then
                                double_selectable <= '1';
                            else
                                double_selectable <= '0';
                            end if;

                            hit_selectable <= '1';
                            new_state      <= player_action;

                        elsif (Player2_Hand_Card_3 /= "0000") then
                            if (unsigned(Player2_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player2_Hand_Score) < 22) and (Player2_Hand_Card_5 /= "0000") then
                                new_state <= player_action;

                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;

                    else
                        if (unsigned(Player2_Hand_Score) > 21) then
                            new_state <= player_action;

                        else
                            if (unsigned(Player2_Hand_Card_1) = 11) and (Player2_Hand_Card_2 /= "0000") then
                                new_state <= player_action;

                            elsif (unsigned(Player2_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player2_Hand_Score) < 22) and (Player2_Hand_Card_5 /= "0000") then
                                new_state <= player_action;
                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;
                    end if;

                elsif (Player_Turn_In = "011") and (split_player_turn = '0') then
                    if (first_turn_over = '0') then
                        if (unsigned(Player3_Hand_Score) > 21) then
                            new_state <= player_action;

                        elsif (Player3_Hand_Card_2 /= "0000") and (Player3_Hand_Card_3 = "0000") then
                            if (unsigned(Dealer_Hand_Score) > 9) and (unsigned(Player3_Hand_Score) = 21) then
                                even_money_selectable <= '1';
                            else
                                even_money_selectable <= '0';
                            end if;

                            if (unsigned(Dealer_Hand_Score) = 11) and (unsigned(Player3_Budget) >= (unsigned(Player3_Bid_Value)/2)) then
                                insurance_selectable <= '1';
                            else
                                insurance_selectable <= '0';
                            end if;

                            if (unsigned(Player3_Hand_Card_1) = unsigned(Player3_Hand_Card_2)) and (unsigned(Player3_Budget) >= unsigned(Player3_Bid_Value)) then
                                split_selectable <= '1';
                            else
                                split_selectable <= '0';
                            end if;

                            if (unsigned(Player3_Budget) >= unsigned(Player3_Bid_Value)) and (unsigned(Player3_Hand_Score) < 21) then
                                double_selectable <= '1';
                            else
                                double_selectable <= '0';
                            end if;

                            hit_selectable <= '1';
                            new_state      <= player_action;

                        elsif (Player3_Hand_Card_3 /= "0000") then
                            if (unsigned(Player3_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player3_Hand_Score) < 22) and (Player3_Hand_Card_5 /= "0000") then
                                new_state <= player_action;

                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;

                    else
                        if (unsigned(Player3_Hand_Score) > 21) then
                            new_state <= player_action;

                        else
                            if (unsigned(Player3_Hand_Card_1) = 11) and (Player3_Hand_Card_2 /= "0000") then
                                new_state <= player_action;

                            elsif (unsigned(Player3_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player3_Hand_Score) < 22) and (Player3_Hand_Card_5 /= "0000") then
                                new_state <= player_action;
                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;
                    end if;

                elsif (Player_Turn_In = "100") and (split_player_turn = '0') then
                    if (first_turn_over = '0') then
                        if (unsigned(Player4_Hand_Score) > 21) then
                            new_state <= player_action;

                        elsif (Player4_Hand_Card_2 /= "0000") and (Player4_Hand_Card_3 = "0000") then
                            if (unsigned(Dealer_Hand_Score) > 9) and (unsigned(Player4_Hand_Score) = 21) then
                                even_money_selectable <= '1';
                            else
                                even_money_selectable <= '0';
                            end if;

                            if (unsigned(Dealer_Hand_Score) = 11) and (unsigned(Player4_Budget) >= (unsigned(Player4_Bid_Value)/2)) then
                                insurance_selectable <= '1';
                            else
                                insurance_selectable <= '0';
                            end if;

                            if (unsigned(Player4_Hand_Card_1) = unsigned(Player4_Hand_Card_2)) and (unsigned(Player4_Budget) >= unsigned(Player4_Bid_Value)) then
                                split_selectable <= '1';
                            else
                                split_selectable <= '0';
                            end if;

                            if (unsigned(Player4_Budget) >= unsigned(Player4_Bid_Value)) and (unsigned(Player4_Hand_Score) < 21) then
                                double_selectable <= '1';
                            else
                                double_selectable <= '0';
                            end if;

                            hit_selectable  <= '1';
                            hold_selectable <= '1';
                            new_state       <= player_action;

                        elsif (Player4_Hand_Card_3 /= "0000") then
                            if (unsigned(Player4_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player4_Hand_Card_1) = 11) and (Reserve_Hand_Card_2 /= "0000") then
                                new_state <= player_action;

                            elsif (unsigned(Player4_Hand_Score) < 22) and (Player4_Hand_Card_5 /= "0000") then
                                new_state <= player_action;

                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;

                    else
                        if (unsigned(Player4_Hand_Score) > 21) then
                            new_state <= player_action;

                        else
                            if (unsigned(Player4_Hand_Card_1) = 11) and (Player4_Hand_Card_2 /= "0000") then
                                new_state <= player_action;

                            elsif (unsigned(Player4_Hand_Score) = 21) then
                                new_state <= player_action;

                            elsif (unsigned(Player4_Hand_Score) < 22) and (Player4_Hand_Card_5 /= "0000") then
                                new_state <= player_action;
                            else
                                hit_selectable <= '1';
                                new_state      <= player_action;
                            end if;
                        end if;
                    end if;
                elsif (unsigned(split_player) = Player_Turn_In) and (split_player_turn = '1') then
                    if (unsigned(Reserve_Hand_Card_1) = 11) and (Reserve_Hand_Card_2 /= "0000") then
                        new_state <= player_action;

                    elsif (unsigned(Reserve_Hand_Score) > 21) then
                        new_state <= player_action;

                    elsif (unsigned(Reserve_Hand_Score) = 21) then
                        new_state <= player_action;

                    elsif (unsigned(Reserve_Hand_Score) < 22) and (Reserve_Hand_Card_5 /= "0000") then
                        new_state <= player_action;

                    else
                        hit_selectable <= '1';
                        new_state      <= player_action;
                    end if;
                elsif (unsigned(Dealer_Hand_Score) < 17) and (Dealer_Hand_Card_5 = "0000") then
                    dealer_card_deal <= '1';
                    new_state        <= game_resolution;
                else
                    score_screen     <= '1';
                    draw_screen_type <= "11";
                    choose_action    <= '0';
                    enable           <= '1';
                    new_state        <= game_setup;

                    if (unsigned(Dealer_Hand_Score) = 21) and (Dealer_Hand_Card_3 = "0000") then
                        if (Player1_Insured = '1') then
                            Player1_win_type <= "001";
                        elsif (Player2_Insured = '1') then
                            Player2_win_type <= "001";
                        elsif (Player3_Insured = '1') then
                            Player3_win_type <= "001";
                        else
                            Player4_win_type <= "001";
                        end if;
                    elsif (unsigned(Player1_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        Player1_win_type <= "001";
                    elsif (unsigned(Player1_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        Player2_win_type <= "001";
                    elsif (unsigned(Player3_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        Player3_win_type <= "001";
                    elsif (player_actionunsigned(Player4_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        Player4_win_type <= "001";
                    elsif (unsigned(Player4_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        Player4_win_type <= "001";
                    elsif (unsigned(Reserve_Hand_Score) = unsigned(Dealer_Hand_Score)) then
                        if (split_player = "001") then
                            Player1_win_type <= "001";
                        elsif (split_player = "010") then
                            Player2_win_type <= "001";
                        elsif (split_player = "011") then
                            Player3_win_type <= "001";
                        else
                            Player4_win_type <= "001";
                        end if;
                    elsif (unsigned(Player1_Hand_Score) > unsigned(Dealer_Hand_Score)) then
                        if (Player1_Doubled_Down = '1') then
                            Player1_win_type <= "010";
                        else
                            Player1_win_type <= "100";
                        end if;
                    elsif (unsigned(Player2_Hand_Score) > unsigned(Dealer_Hand_Score)) then
                        if (Player2_Doubled_Down = '1') then
                            Player2_win_type <= "010";
                        else
                            Player2_win_type <= "100";
                        end if;
                    elsif (unsigned(Player3_Hand_Score) > unsigned(Dealer_Hand_Score)) then
                        if (Player3_Doubled_Down = '1') then
                            Player3_win_type <= "010";
                        else
                            Player3_win_type <= "100";
                        end if;
                    elsif (unsigned(Player4_Hand_Score) > unsigned(Dealer_Hand_Score)) then
                        if (Player4_Doubled_Down = '1') then
                            Player4_win_type <= "010";
                        else
                            Player4_win_type <= "100";
                        end if;
                    elsif (split_player = "001") then
                        Player1_win_type <= "100";
                    elsif (split_player = "010") then
                        Player2_win_type <= "100";
                    elsif player_action(split_player = "011") then
                        Player3_win_type <= "100";
                    else
                        Player4_win_type <= "100";
                    end if;
                end if;
            when player_action =>
                if (switch_select = '1') then
                    new_start_screen <= '0';
                end if;
                if (start_screen = '1') then
                    draw_screen_type <= "00";
                    -- menu for choosing players --
                    if (N_Players = "000") then
                        if (switch_left = '1') then
                            if (current_screen_position = "001") then -- if at option 1, left moves to option 4 --
                                new_current_screen_position <= "100";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position - 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_right = '1') then
                            if (current_screen_position = "100") then -- if at option 4, right moves to option 1 --
                                new_current_screen_position <= "001";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position + 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_select = '1') then
                            if (current_screen_position = "001") then
                                N_Players_new    <= "001";
                                Player2_Inactive <= '1';
                                Player3_Inactive <= '1';
                                Player4_Inactive <= '1';
                                enable           <= '1';

                                new_start_screen <= '0';
                                --new_state <= player_action;
                                new_state <= game_setup;

                            elsif (current_screen_position = "010") then
                                N_Players_new    <= "010";
                                Player3_Inactive <= '1';
                                Player4_Inactive <= '1';
                                enable           <= '1';

                                new_start_screen <= '1';
                                --new_state <= player_action;
                                --choose_action <= '1';
                                --draw_screen_type <= "01";     --- 01 says draw the bidding box ---
                                new_state <= game_setup;

                            elsif (current_screen_position = "011") then
                                N_Players_new    <= "011";
                                Player4_Inactive <= '1';
                                enable           <= '1';
                                --new_state <= player_action;
                                new_state <= game_setup;

                            else
                                N_Players_new <= "100";
                                enable        <= '1';
                                --new_state <= player_action;
                                new_state <= game_setup;
                            end if;
                        else
                            new_state <= player_action;
                        end if;

                    elsif (switch_select = '1') then
                        choose_action    <= '1';
                        new_start_screen <= '0';
                        new_state        <= game_setup;
                    else
                        new_state <= player_action;
                    end if;

                elsif (choose_action = '1') and (draw_screen_type /= "00") then
                    if (bids_placed = '0') then
                        if (unsigned(N_Players) > Player_Turn_In) and (bid_successful = '1') then
                            new_Player_Turn_In <= Player_Turn_In + 1;
                            new_state          <= game_setup;
                            --bid_successful <= '0';
                            enable <= '1';

                        elsif (bid_successful = '1') and (unsigned(N_Players) = Player_Turn_In) then
                            if (N_Players = "001") then
                                if (Player1_Bid_Value /= "00000") then
                                    bids_placed <= '1';
                                    new_state   <= game_setup;
                                    --bid_successful <= '0';
                                    enable <= '1';
                                else
                                    new_state <= player_action;
                                end if;

                            elsif (N_Players = "010") then
                                if (Player2_Bid_Value /= "00000") then
                                    bids_placed <= '1';
                                    new_state   <= game_setup;
                                    enable      <= '1';
                                else
                                    new_state <= player_action;

                                end if;

                            elsif (N_Players = "011") then
                                if (Player1_Bid_Value /= "00000") then
                                    bids_placed <= '1';
                                    new_state   <= game_setup;
                                    enable      <= '1';
                                else
                                    new_state <= player_action;
                                end if;

                            else
                                if (Player1_Bid_Value /= "00000") then
                                    bids_placed <= '1';
                                    new_state   <= game_setup;
                                    enable      <= '1';
                                else
                                    new_state <= player_action;
                                end if;
                            end if;

                        elsif (switch_left = '1') then
                            if (current_screen_position = "001") then -- if at option 1, left moves to option 4 --
                                new_current_screen_position <= "100";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position - 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_right = '1') then
                            if (current_screen_position = "100") then -- if at option 4, right moves to option 1 --
                                new_current_screen_position <= "001";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position + 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_select = '1') then
                            if (Player_Turn_In = "001") then
                                if (current_screen_position = "001") and (unsigned(Player1_Budget) >= 2) and (Player1_Bid_Value = "00000") then
                                    Player1_Bid_New   <= "00";
                                    Player1_Bid_Value <= "00010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "010") and (unsigned(Player1_Budget) >= 6) and (Player1_Bid_Value = "00000") then
                                    Player1_Bid_New   <= "01";
                                    Player1_Bid_Value <= "00110";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "011") and (unsigned(Player1_Budget) >= 10) and (Player1_Bid_Value = "00000") then
                                    Player1_Bid_New   <= "10";
                                    Player1_Bid_Value <= "01010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "100") and (unsigned(Player1_Budget) >= 20) and (Player1_Bid_Value = "00000") then
                                    Player1_Bid_New   <= "11";
                                    Player1_Bid_Value <= "10100";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (unsigned(Player1_Budget) < 2) then
                                    Player1_Inactive <= '1';
                                    bid_successful   <= '1';
                                    new_state        <= game_setup;
                                else
                                    new_state <= player_action;
                                end if;

                            elsif (Player_Turn_In = "010") then
                                if (current_screen_position = "001") and (unsigned(Player2_Budget) >= 2) and (Player2_Bid_Value = "00000") then
                                    Player2_Bid_New   <= "00";
                                    Player2_Bid_Value <= "00010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "010") and (unsigned(Player2_Budget) >= 6) and (Player2_Bid_Value = "00000") then
                                    Player2_Bid_New   <= "01";
                                    Player2_Bid_Value <= "00110";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "011") and (unsigned(Player2_Budget) >= 10) and (Player2_Bid_Value = "00000") then
                                    Player2_Bid_New   <= "10";
                                    Player2_Bid_Value <= "01010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "100") and (unsigned(Player2_Budget) >= 20) and (Player2_Bid_Value = "00000") then
                                    Player2_Bid_New   <= "11";
                                    Player2_Bid_Value <= "10100";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (unsigned(Player2_Budget) < 2) then
                                    Player2_Inactive <= '1';
                                    bid_successful   <= '1';
                                    new_state        <= game_setup;
                                else
                                    new_state <= player_action;
                                end if;

                            elsif (Player_Turn_In = "011") then
                                if (current_screen_position = "001") and (unsigned(Player3_Budget) >= 2) and (Player3_Bid_Value = "00000") then
                                    Player3_Bid_New   <= "00";
                                    Player3_Bid_Value <= "00010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "010") and (unsigned(Player3_Budget) >= 6) and (Player3_Bid_Value = "00000") then
                                    Player3_Bid_New   <= "01";
                                    Player3_Bid_Value <= "00110";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "011") and (unsigned(Player3_Budget) >= 10) and (Player3_Bid_Value = "00000") then
                                    Player3_Bid_New   <= "10";
                                    Player3_Bid_Value <= "01010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "100") and (unsigned(Player3_Budget) >= 20) and (Player3_Bid_Value = "00000") then
                                    Player3_Bid_New   <= "11";
                                    Player3_Bid_Value <= "10100";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (unsigned(Player3_Budget) < 2) then
                                    Player3_Inactive <= '1';
                                    bid_successful   <= '1';
                                    new_state        <= game_setup;
                                else
                                    new_state <= player_action;
                                end if;
                            else
                                if (current_screen_position = "001") and (Player4_Bid_Value = "00000") then
                                    Player4_Bid_New   <= "00";
                                    Player4_Bid_Value <= "00010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "010") and (Player4_Bid_Value = "00000") then
                                    Player4_Bid_New   <= "01";
                                    Player4_Bid_Value <= "00110";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "011") and (Player4_Bid_Value = "00000") then
                                    Player4_Bid_New   <= "10";
                                    Player4_Bid_Value <= "01010";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (current_screen_position = "100") and (Player4_Bid_Value = "00000") then
                                    Player4_Bid_New   <= "11";
                                    Player4_Bid_Value <= "10100";
                                    bid_successful    <= '1';
                                    bid_enable        <= '1';
                                    new_state         <= game_setup;

                                elsif (unsigned(Player4_Budget) < 2) then
                                    Player4_Inactive <= '1';
                                    bid_successful   <= '1';
                                    new_state        <= game_setup;
                                else
                                    new_state <= player_action;
                                end if;
                            end if;
                        end if;

                    elsif (bids_placed = '1') and (draw_screen_type = "10") then
                        if (switch_left = '1') then
                            if (current_screen_position = "001") then -- if at option 1, left moves to option 6 --
                                new_current_screen_position <= "110";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position - 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_right = '1') then
                            if (current_screen_position = "110") then -- if at option 6, right moves to option 1 --
                                new_current_screen_position <= "001";
                                new_state                   <= player_action;
                            else
                                new_current_screen_position <= current_screen_position + 1;
                                new_state                   <= player_action;
                            end if;

                        elsif (switch_select = '1') then
                            if (current_screen_position = "001") and (hold_selectable = '1') then
                                hold_selected <= '1';
                                new_state     <= game_resolution;

                            elsif (current_screen_position = "010") and (hit_selectable = '1') then
                                hit_selected <= '1';
                                new_state    <= game_resolution;

                            elsif (current_screen_position = "011") and (double_selectable = '1') then
                                double_selected <= '1';
                                new_state       <= game_resolution;

                            elsif (current_screen_position = "100") and (split_selectable = '1') then
                                split_selected <= '1';
                                new_state      <= game_resolution;

                            elsif (current_screen_position = "101") and (insurance_selectable = '1') then
                                insurance_selected <= '1';
                                new_state          <= game_resolution;

                            elsif (current_screen_position = "110") and (even_money_selectable = '1') then
                                even_money_selected <= '1';
                                new_state           <= game_resolution;
                            else
                                new_state <= player_action;
                            end if;
                        end if;
                    end if;

                elsif (score_screen = '1') then
                    if (switch_left = '1') then
                        if (current_screen_position = "001") then -- if at option 1, left moves to option 2 --
                            new_current_screen_position <= "010";
                            new_state                   <= player_action;
                        else
                            new_current_screen_position <= current_screen_position - 1;
                            new_state                   <= player_action;
                        end if;

                    elsif (switch_right = '1') then
                        if (current_screen_position = "010") then -- if at option 2, right moves to option 1 --
                            new_current_screen_position <= "001";
                            new_state                   <= player_action;
                        else
                            new_current_screen_position <= current_screen_position + 1;
                            new_state                   <= player_action;
                        end if;

                    elsif (switch_select = '1') then
                        if (current_screen_position = "001") then
                            round_end <= '1'; ---- round end executes a pseudo-reset on memory, RCM checks deck ----
                            new_state <= game_setup;

                        else ---- reset send to all modules ----
                            new_state <= reset_state;
                        end if;
                    else
                        new_state <= player_action;
                    end if;
                end if;

            when game_resolution =>
                ----------------------- dealing phase ------------------------

                if (first_card_deal = '1') and (random_card = "0000") then
                    --require_card <= '1';
                    new_state <= pending_card_a;

                elsif (second_card_deal = '1') and (random_card = "0000") then
                    --require_card <= '1';
                    new_state <= pending_card_a;

                elsif (dealer_card_deal = '1') and (random_card = "0000") then
                    --require_card <= '1';
                    new_state <= pending_card_a;

                    ---------------------------- game phase --------------------------------
                elsif (hit_selected = '1') then
                    first_turn_over <= '1';
                    require_card    <= '1';
                    hit_selectable  <= '0';
                    new_state       <= pending_card_a;

                elsif (double_selected = '1') then
                    first_turn_over   <= '1';
                    require_card      <= '1';
                    double_selectable <= '0';
                    new_state         <= pending_card_a;

                elsif (insurance_selected = '1') then
                    first_turn_over      <= '1';
                    insurance            <= '1';
                    enable               <= '1';
                    insurance_selectable <= '0';
                    new_state            <= game_setup;

                elsif (even_money_selected = '1') then
                    first_turn_over       <= '1';
                    even_money            <= '1';
                    enable                <= '1';
                    even_money_selectable <= '0';
                    new_state             <= game_setup;

                elsif (split_selected = '1') then
                    split_player     <= std_logic_vector(Player_Turn_In); --------------------- inquire ---------------------------
                    first_turn_over  <= '1';
                    split            <= '1';
                    enable           <= '1';
                    split_selectable <= '0';
                    new_state        <= game_setup;

                elsif (hold_selected = '1') then
                    if (Player_Turn_In = unsigned(N_Players)) and (unsigned(split_player) /= Player_Turn_In) then
                        new_Player_Turn_In <= "101";

                    elsif (Player_Turn_In = unsigned(N_Players)) and (split_player_turn = '1') then
                        new_Player_Turn_In <= "101";

                    elsif (unsigned(split_player) = Player_Turn_In) and (split_player_turn = '0') then
                        split_player_turn <= '1';
                    else
                        new_Player_Turn_In <= Player_Turn_In + 1;
                    end if;
                    first_turn_over <= '0';
                    enable          <= '1';
                    hit_selectable  <= '0';
                    new_state       <= game_setup;
                else
                    new_state <= game_resolution;
                end if;

                ----------------------- using the card received after returning from pending_card states ------------------------

                if (card_received = '1') then -- definitive condition for Receiving Hand to be given values. Removes --
                    if (first_card_deal = '1') then -- requirement for Receiving Hand to have a 0 off state. Saves a bit --   
                        if (Player1_Hand_Card_1 = "0000") then
                            Receiving_Hand  <= "001"; -- "000" card goes to Player 1's hand --   				  
                            enable          <= '1';
                            card_received   <= '0';
                            first_card_deal <= '0';
                            new_state       <= game_setup;

                        elsif (Player1_Hand_Card_1 /= "0000") and (Player2_Hand_Card_1 = "0000") and (unsigned(N_Players) > 1) then
                            Receiving_Hand  <= "010"; -- "001" card goes to Player 2's hand --       
                            enable          <= '1';
                            card_received   <= '0';
                            first_card_deal <= '0';
                            new_state       <= game_setup;

                        elsif (Player2_Hand_Card_1 /= "0000") and (Player3_Hand_Card_1 = "0000") and (unsigned(N_Players) > 2) then
                            Receiving_Hand  <= "011"; -- "010" card goes to Player 3's hand --
                            enable          <= '1';
                            card_received   <= '0';
                            first_card_deal <= '0';
                            new_state       <= game_setup;

                        else
                            Receiving_Hand  <= "100"; -- "011" card goes to Player 4's hand --
                            enable          <= '1';
                            card_received   <= '0';
                            first_card_deal <= '0';
                            new_state       <= game_setup;
                        end if;

                    elsif (dealer_card_deal = '1') then -- may be possible to funnel this in at the end of the above *if* statement as an optimization if needed -- 
                        Receiving_Hand   <= "101"; -- "100" card goes to Dealer's hand --  
                        enable           <= '1';
                        card_received    <= '0';
                        dealer_card_deal <= '0';
                        new_state        <= game_setup;

                    elsif (second_card_deal = '1') then
                        if (Player1_Hand_Card_2 = "0000") then
                            Receiving_Hand   <= "001"; -- "000" card goes to Player 1's hand --   				  
                            enable           <= '1';
                            card_received    <= '0';
                            second_card_deal <= '0';
                            new_state        <= game_setup;

                        elsif (Player1_Hand_Card_2 /= "0000") and (Player2_Hand_Card_2 = "0000") and (unsigned(N_Players) > 1) then
                            Receiving_Hand   <= "010"; -- "001" card goes to Player 2's hand --       
                            enable           <= '1';
                            card_received    <= '0';
                            second_card_deal <= '0';
                            new_state        <= game_setup;

                        elsif (Player2_Hand_Card_2 /= "0000") and (Player3_Hand_Card_2 = "0000") and (unsigned(N_Players) > 2) then
                            Receiving_Hand   <= "011"; -- "010" card goes to Player 3's hand --
                            enable           <= '1';
                            card_received    <= '0';
                            second_card_deal <= '0';
                            new_state        <= game_setup;

                        else
                            Receiving_Hand   <= "100"; -- "000" card goes to Player 4's hand --
                            enable           <= '1';
                            card_received    <= '0';
                            second_card_deal <= '0';
                            new_state        <= game_setup;
                        end if;

                    elsif (double_selected = '1') then
                        Receiving_Hand <= std_logic_vector(Player_Turn_In);
                        double         <= '1';
                        enable         <= '1';
                        card_received  <= '0';
                        new_state      <= game_setup;

                    elsif (hit_selected = '1') then
                        if (split_player_turn = '1') then
                            Receiving_Hand <= "110";
                            enable         <= '1';
                            card_received  <= '0';
                            new_state      <= game_setup;
                        else
                            Receiving_Hand <= std_logic_vector(Player_Turn_In);
                            enable         <= '1';
                            card_received  <= '0';
                            new_state      <= game_setup;
                        end if;
                    else
                        new_state <= game_resolution;
                    end if;
                end if;
            when pending_card_a =>
                request_card <= '1';
                if (random_card /= "0000") then
                    require_card  <= '0';
                    new_card      <= random_card;
                    card_received <= '1';
                else
                    require_card <= '1';
                end if;

                if (require_card = '1') then
                    new_state <= pending_card_b;
                else
                    new_state <= game_resolution;
                end if;
            when pending_card_b =>
                request_card <= '0';
                if (random_card /= "0000") then
                    require_card  <= '0';
                    new_card      <= random_card;
                    card_received <= '1';
                else
                    require_card <= '1';
                end if;

                if (require_card = '1') then
                    new_state <= pending_card_b;
                else
                    new_state <= game_resolution;
                end if;
        end case;
    end process;
end architecture;