library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity controller is
		port(
			clk	: in  std_logic;
			reset	: in  std_logic;
	
			Player_Turn	: in std_logic_vector (2 downto 0);
			N_Players	: in std_logic_vector (2 downto 0);
	
			button_select	: in  std_logic;  
			button_left	: in  std_logic;						-- player inputs --
			button_right	: in  std_logic;
	
			Player1_Budget	: in  std_logic_vector (9 downto 0);	-- base budget is 100, score limit chosen as 1000 so 10 bits --
			Player2_Budget	: in  std_logic_vector (9 downto 0);
			Player3_Budget	: in  std_logic_vector (9 downto 0);  
			Player4_Budget	: in  std_logic_vector (9 downto 0);
	
			Player1_Bid	: in std_logic_vector (1 downto 0);		-- Bid and Budget required to determine if Insurance/Double are possible --
			Player2_Bid	: in std_logic_vector (1 downto 0);		-- Value of Initial Bid = 2,6,10,20 -> 00,01,10,11 (Internal signal Bid_Value) --
			Player3_Bid	: in std_logic_vector (1 downto 0);		-- Controller never needs the augmented value of Bid as Double/Insurance/Split --
			Player4_Bid	: in std_logic_vector (1 downto 0);		-- are Turn 1 actions (If Mem Controller does end-round calculations) --
	
			Player1_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Each card is a 4-bit vector --
			Player1_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player1_Hand_Score	: in std_logic_vector (4 downto 0);     -- Player can have 20 and draw a 10, so 30 points total possible --
	
			Player2_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_4	: in std_logic_vector (3 downto 0);   
			Player2_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player2_Hand_Score	: in std_logic_vector (4 downto 0);
	
			Player3_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_3	: in std_logic_vector (3 downto 0);   
			Player3_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player3_Hand_Score	: in std_logic_vector (4 downto 0);
	
			Player4_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player4_Hand_Score	: in std_logic_vector (4 downto 0);
	
			Dealer_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Score	: in std_logic_vector (4 downto 0);
	
			Reserve_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Reserve hand for Split. Only one player can split (low chance of multiple splits) --
			Reserve_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Score	: in std_logic_vector (4 downto 0);
	
			random_card	: in  std_logic_vector (3 downto 0);	-- Comms with RNG --
			request_card	: out std_logic;                         
			new_card	: out std_logic_vector (3 downto 0);	-- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --
	
			cursor_position	: out std_logic_vector(2 downto 0);
			draw_screen_type : out std_logic_vector(1 downto 0);
	 
			hit_option		: out std_logic;
			double_option		: out std_logic;
			split_option		: out std_logic;
			insurance_option	: out std_logic;
			even_money_option	: out std_logic;
	
			Player1_Budget_New	: out  std_logic_vector (9 downto 0);	-- base budget is 100, score limit chosen as 1000 so 10 bits --
			Player2_Budget_New	: out  std_logic_vector (9 downto 0);
			Player3_Budget_New	: out  std_logic_vector (9 downto 0);  
			Player4_Budget_New	: out  std_logic_vector (9 downto 0);
	
			Player1_Bid_New	: out std_logic_vector (1 downto 0);  		 -- 2,6,10,20 = 4 options so 2 bits --
			Player2_Bid_New	: out std_logic_vector (1 downto 0);
			Player3_Bid_New	: out std_logic_vector (1 downto 0);
			Player4_Bid_New	: out std_logic_vector (1 downto 0);
	
			Player_Turn_New	: out std_logic_vector (2 downto 0);  	 -- outputs -> mem based on actions --
			N_Players_New	: out std_logic_vector (2 downto 0);
			Receiving_Hand	: out std_logic_vector (2 downto 0);  	 -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--
	
			enable		: out std_logic;
			even_money	: out std_logic;
			insurance	: out std_logic;
			split		: out std_logic;
			double		: out std_logic;
	
			round_end	: out std_logic;	     
			global_reset	: out std_logic
		);
end controller;

architecture behaviour of controller is
	type controller_state is ( reset_state,
				   game_setup,
				   player_action,
				   game_resolution,
				   pending_card_a,
				   pending_card_b,
				   sela,
				   selb,
				   lefta,
				   leftb,
				   righta,
				   rightb
				 );

signal state, new_state: controller_state;
signal switch_left, switch_right, switch_select : std_logic;

signal Player1_Bid_Value, Player2_Bid_Value, Player3_Bid_Value, Player4_Bid_Value : std_logic_vector (4 downto 0);
signal bids_placed, bid_successful, require_card, card_received : std_logic;  
signal first_card_deal, dealer_card_deal, second_card_deal : std_logic;

signal even_money_selected, insurance_selected, split_selected, double_selected, hit_selected, hold_selected : std_logic;
signal even_money_selectable, insurance_selectable, split_selectable, double_selectable, hit_selectable, hold_selectable : std_logic;
signal first_turn_over : std_logic;

signal split_player : std_logic_vector (2 downto 0);  
signal split_player_turn : std_logic;

signal start_screen, choose_players, choose_bids, choose_action, score_screen : std_logic;

signal current_screen_position, Player_Turn_In: unsigned(2 downto 0);


begin
	process (clk)
	begin
		if (rising_edge (clk)) then
			if (reset = '1') then
				state <= reset_state;
			else
				state <= new_state;
			end if;
		end if;
	end process;

	process (state, button_left, button_right, button_select, switch_left, switch_right, switch_select, N_Players, bids_placed, 
		Player1_Hand_Card_1, Player1_Hand_Card_2, Player1_Hand_Card_3, Player1_Hand_Card_4, Player1_Hand_Card_5, Player1_Hand_Score,
		Dealer_Hand_Card_1, Dealer_Hand_Card_2, Dealer_Hand_Card_3, Dealer_Hand_Card_4, Dealer_Hand_Card_5, Dealer_Hand_Score,
		Player2_Hand_Card_1, Player2_Hand_Card_2, Player2_Hand_Card_3, Player2_Hand_Card_4, Player2_Hand_Card_5, Player2_Hand_Score,
		Player3_Hand_Card_1, Player3_Hand_Card_2, Player3_Hand_Card_3, Player3_Hand_Card_4, Player3_Hand_Card_5, Player3_Hand_Score,
		Player4_Hand_Card_1, Player4_Hand_Card_2, Player4_Hand_Card_3, Player4_Hand_Card_4, Player4_Hand_Card_5, Player4_Hand_Score,
		Player_Turn_In, split_player_turn, first_turn_over, split_player,
		Player1_Budget, Player2_Budget, Player3_Budget, Player4_Budget,
		Player1_Bid, Player2_Bid, Player3_Bid, Player4_Bid,
		Reserve_Hand_Card_1, Reserve_Hand_Card_2, Reserve_Hand_Card_3, Reserve_Hand_Card_4, Reserve_Hand_Card_5, Reserve_Hand_Score,
		Player1_Bid_Value, Player2_Bid_Value, Player3_Bid_Value, Player4_Bid_Value,
		choose_players, current_screen_position, choose_bids, bid_successful, choose_action, 
		hold_selectable, hit_selectable, double_selectable, split_selectable, insurance_selectable, even_money_selectable,
		score_screen, first_card_deal, random_card, second_card_deal, dealer_card_deal, 
		hold_selected, hit_selected, double_selected, split_selected, insurance_selected, even_money_selected,
		card_received, require_card
		)


	variable button : std_logic_vector (2 downto 0);
	
	begin
		button(0) := button_left;
		button(1) := button_right;
		button(2) := button_select;

		request_card <= '0';
		new_card <= "0000";

		Player1_Bid_New <= Player1_Bid;
		Player2_Bid_New <= Player2_Bid;
		Player3_Bid_New <= Player3_Bid;
		Player4_Bid_New <= Player4_Bid;

		Player_Turn_In <= unsigned(Player_Turn);
		Player_Turn_New <= std_logic_vector(Player_Turn_In);
		N_Players_New <= N_Players;

		enable <= '0';
		win_type <= "000";

		even_money <= '0';
		insurance <= '0';
		split <= '0';
		double <= '0';

		current_screen_position <= "001";                        ------ remember in reset process -----------
		cursor_position <= std_logic_vector(current_screen_position);

		draw_screen_type <= "00";
		hit_option 	  <= hit_selectable; 	 
		double_option  	  <= double_selectable; 	
		split_option	  <= split_selectable; 	 
		insurance_option  <= insurance_selectable;
		even_money_option <= even_money_selectable;

		round_end <= '0';
		global_reset <= '0';

		if ( bids_placed = '1' ) then   
			if ( Player1_Bid = "00" ) then
				Player1_Bid_Value <= "00010";
			elsif ( Player1_Bid = "01" ) then
				Player1_Bid_Value <= "00110";
			elsif ( Player1_Bid = "10" ) then
				Player1_Bid_Value <= "01010";
			elsif ( Player1_Bid = "11" ) then
				Player1_Bid_Value <= "10100";
			else
				Player1_Bid_Value <= "00000";
			end if;

			if ( Player2_Bid = "00" ) then
				Player2_Bid_Value <= "00010";
			elsif ( Player2_Bid = "01" ) then
				Player2_Bid_Value <= "00110";
			elsif ( Player2_Bid = "10" ) then
				Player2_Bid_Value <= "01010";
			elsif ( Player2_Bid = "11" ) then
				Player2_Bid_Value <= "10100";
			else
				Player2_Bid_Value <= "00000";
			end if;

			if ( Player3_Bid = "00" ) then
				Player3_Bid_Value <= "00010";
			elsif ( Player3_Bid = "01" ) then
				Player3_Bid_Value <= "00110";
			elsif ( Player3_Bid = "10" ) then
				Player3_Bid_Value <= "01010";
			elsif ( Player3_Bid = "11" ) then
				Player3_Bid_Value <= "10100";
			else
				Player3_Bid_Value <= "00000";
			end if;

			if ( Player4_Bid = "00" ) then
				Player4_Bid_Value <= "00010";
			elsif ( Player4_Bid = "01" ) then
				Player4_Bid_Value <= "00110";
			end if;
		end if;

		case state is
			when reset_state =>
			
				global_reset <= '1';
				start_screen <= '1';
				draw_screen_type <= "00";  
				new_state <= player_action;
						
			when game_setup =>    
					
				if ( bids_placed = '0' ) and ( N_Players /= "000" ) then	 -- bidding screen condition--
					draw_screen_type <= "01";    ----- 10 tells graphics cursor to track the bidding menu -----
					new_state <= player_action;
				elsif ( choose_action = '1' ) then
					draw_screen_type <= "10";    ----- 10 tells graphics cursor to track the action menu -----
					new_state <= player_action;

				-- Check whether starting cards have been dealt -- 
				-- If yes, check which dealing phase we're in based on player count--
				elsif ( N_Players = "001" ) and ( bids_placed = '1' ) then			    -- if 1 player total, switch phases based on Player 1 cards --
					if ( Player1_Hand_Card_1 = "0000" ) then     -- Dealer receives a card after the last player received their first card --
						first_card_deal <= '1';
						dealer_card_deal <= '0';
						second_card_deal <= '0';
						new_state <= game_resolution; 
			
					elsif ( Player1_Hand_Card_1 /= "0000" ) and ( Dealer_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '0';
						dealer_card_deal <= '1';
						second_card_deal <= '0';
						new_state <= game_resolution; 

					elsif ( Dealer_Hand_Card_1 /= "0000") and ( Player1_Hand_Card_2 = "0000" ) then
						first_card_deal <= '0';
						dealer_card_deal <= '0';
						second_card_deal <= '1';
						new_state <= game_resolution;
					end if;
						
				elsif ( N_Players = "010" ) then		  -- if 2 players, switch phases based on Player 2's hand --
					if ( Player2_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '1';
						dealer_card_deal <= '0';
						second_card_deal <= '0';
						new_state <= game_resolution; 

					elsif ( Player2_Hand_Card_1 /= "0000" ) and ( Dealer_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '0';
						dealer_card_deal <= '1';
						second_card_deal <= '0';
						new_state <= game_resolution; 

					elsif ( Dealer_Hand_Card_1 /= "0000") and ( Player2_Hand_Card_2 = "0000" ) then
						first_card_deal <= '0';
						dealer_card_deal <= '0';
						second_card_deal <= '1';
						new_state <= game_resolution;
					end if; 
						
				elsif ( N_Players = "011" ) then               -- if 3 players, switch phases based on Player 3's hand --
					if ( Player3_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '1';
						dealer_card_deal <= '0';    
						second_card_deal <= '0';
						new_state <= game_resolution;

					elsif ( Player3_Hand_Card_1 /= "0000" ) and ( Dealer_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '0';
						dealer_card_deal <= '1';
						second_card_deal <= '0';
						new_state <= game_resolution; 

					elsif ( Dealer_Hand_Card_1 /= "0000") and ( Player3_Hand_Card_2 = "0000" ) then
						first_card_deal <= '0';
						dealer_card_deal <= '0';      
						second_card_deal <= '1';
						new_state <= game_resolution;
					end if; 
						
				elsif ( N_Players = "100" ) then
					if ( Player4_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '1';
						dealer_card_deal <= '0';
						second_card_deal <= '0';
						new_state <= game_resolution; 

		 	                elsif ( Player4_Hand_Card_1 /= "0000" ) and ( Dealer_Hand_Card_1 = "0000" ) then 
						first_card_deal <= '0';
						dealer_card_deal <= '1';
						second_card_deal <= '0';
						new_state <= game_resolution; 

					elsif ( Dealer_Hand_Card_1 /= "0000") and ( Player4_Hand_Card_2 = "0000" ) then
						first_card_deal <= '0';
						dealer_card_deal <= '0';
						second_card_deal <= '1';
						new_state <= game_resolution;
					end if; 
				end if;
					
			----------------------------- checking actions available: scores of hands may be sent by mem, adjust accordingly -------------------------------------	

				if ( Player_Turn_In = "001" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned(Player1_Hand_Score) > 21) then
							new_state <= player_action;
		
						elsif ( Player1_Hand_Card_2 /= "0000" ) and ( Player1_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Score) < 10 ) and ( unsigned(Player1_Hand_Score) = 21 ) then
								Player1_win_type <= "011";
								new_state <= player_action;
							end if; 
							
							if ( unsigned(Dealer_Hand_Score) > 9 ) and ( unsigned(Player1_Hand_Score) = 21 ) then
								even_money_selectable <= '1';
							end if;
					
							if ( unsigned(Dealer_Hand_Score) = 11 ) and ( unsigned(Player1_Budget) >= ( unsigned(Player1_Bid_Value) /2) )  then 
								insurance_selectable <= '1';
							end if;

							if ( unsigned(Player1_Hand_Card_1) = unsigned(Player1_Hand_Card_2) ) and ( unsigned(Player1_Budget) >= unsigned(Player1_Bid_Value) ) then 
								split_selectable <= '1';
							end if;

							if ( unsigned(Player1_Budget) >= unsigned(Player1_Bid_Value) ) and ( unsigned(Player1_Hand_Score) < 21 ) then  
								double_selectable <= '1';
							end if;
								
							hit_selectable <= '1';
							new_state <= player_action;			

						elsif ( Player1_Hand_Card_3 /= "0000" ) then
							if ( unsigned(Player1_Hand_Score) = 21) then
								new_state <= player_action;
						
							elsif ( unsigned(Player1_Hand_Score) < 22 ) and ( Player1_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
						
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;	
							
					elsif ( first_turn_over = '1' ) then
						if ( unsigned(Player1_Hand_Score) > 21) then
							new_state <= player_action;
						
						elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '0' ) then   
							if ( unsigned(Player1_Hand_Card_1) = 11 ) and ( Player1_Hand_Card_2 /= "0000" ) then    
								new_state <= player_action;
						
							elsif ( unsigned(Player1_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player1_Hand_Score) < 22 ) and ( Player1_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						

				elsif ( Player_Turn_In = "010" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned(Player2_Hand_Score) > 21) then
								new_state <= player_action;
					
						elsif ( Player2_Hand_Card_2 /= "0000" ) and ( Player2_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Score) < 10 ) and ( unsigned(Player2_Hand_Score) = 21 ) then
								Player2_win_type <= "011";
								new_state <= player_action;
							end if; 
								
							if ( unsigned(Dealer_Hand_Score) > 9 ) and ( unsigned(Player2_Hand_Score) = 21 ) then
								even_money_selectable <= '1';
							end if;
					
							if ( unsigned(Dealer_Hand_Score) = 11 ) and ( unsigned(Player2_Budget) >= (unsigned(Player2_Bid_Value)/2) ) then 
								insurance_selectable <= '1';
							end if;

							if ( unsigned(Player2_Hand_Card_1) = unsigned(Player2_Hand_Card_2)) and ( unsigned(Player2_Budget) >= unsigned(Player2_Bid_Value) ) then 
								split_selectable <= '1';
							end if;

							if ( unsigned(Player2_Budget) >= unsigned(Player2_Bid_Value) ) and ( unsigned(Player2_Hand_Score) < 21 ) then  
								double_selectable <= '1';
							end if;
								
							hit_selectable <= '1';
							new_state <= player_action;

						elsif ( Player2_Hand_Card_3 /= "0000" ) then
							if ( unsigned(Player2_Hand_Score) = 21 ) then
								new_state <= player_action;

							elsif ( unsigned(Player2_Hand_Score) < 22 ) and ( Player2_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;

							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned(Player2_Hand_Score) > 21) then
								new_state <= player_action;

						elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player2_Hand_Card_1) = 11 ) and ( Player2_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned(Player2_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player2_Hand_Score) < 22 ) and ( Player2_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						
				elsif ( Player_Turn_In = "011" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned(Player3_Hand_Score) > 21) then
								new_state <= player_action;
					
						elsif ( Player3_Hand_Card_2 /= "0000" ) and ( Player3_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Score) < 10 ) and ( unsigned(Player3_Hand_Score) = 21 ) then
								Player3_win_type <= "011";
								new_state <= player_action;
							end if; 
								
							if ( unsigned(Dealer_Hand_Score) > 9 ) and ( unsigned(Player3_Hand_Score) = 21 ) then
								even_money_selectable <= '1';
							end if;
					
							if ( unsigned(Dealer_Hand_Score) = 11 ) and ( unsigned(Player3_Budget) >= (unsigned(Player3_Bid_Value)/2) ) then 
								insurance_selectable <= '1';
							end if;

							if ( unsigned(Player3_Hand_Card_1) = unsigned(Player3_Hand_Card_2) ) and ( unsigned(Player3_Budget) >= unsigned(Player3_Bid_Value) ) then 
								split_selectable <= '1';
							end if;

							if ( unsigned(Player3_Budget) >= unsigned(Player3_Bid_Value) ) and ( unsigned(Player3_Hand_Score) < 21 ) then  
								double_selectable <= '1';
							end if;

							hit_selectable <= '1';
							new_state <= player_action;

						elsif ( Player3_Hand_Card_3 /= "0000" ) then
							if ( unsigned(Player3_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player3_Hand_Score) < 22 ) and ( Player3_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;

							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned(Player3_Hand_Score) > 21) then
								new_state <= player_action;

						elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player3_Hand_Card_1) = 11 ) and ( Player3_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned(Player3_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player3_Hand_Score) < 22 ) and ( Player3_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						
				elsif ( Player_Turn_In = "100" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned(Player4_Hand_Score) > 21) then
								new_state <= player_action;
					
						elsif ( Player4_Hand_Card_2 /= "0000" ) and ( Player4_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Score) < 10 ) and ( unsigned(Player4_Hand_Score) = 21 ) then
								player4_win_type <= "011";
								new_state <= player_action;
							end if; 
								
							if ( unsigned(Dealer_Hand_Score) > 9 ) and ( unsigned(Player4_Hand_Score) = 21 ) then
								even_money_selectable <= '1';
							end if;
					
							if ( unsigned(Dealer_Hand_Score) = 11 ) and ( unsigned(Player4_Budget) >= ( unsigned(Player4_Bid_Value)/2) ) then 
								insurance_selectable <= '1';
							end if;

							if ( unsigned(Player4_Hand_Card_1) = unsigned(Player4_Hand_Card_2) ) and ( unsigned(Player4_Budget) >= unsigned(Player4_Bid_Value) ) then 
								split_selectable <= '1';
							end if;

							if ( unsigned(Player4_Budget) >= unsigned(Player4_Bid_Value) ) and ( unsigned(Player4_Hand_Score) < 21 ) then  
								double_selectable <= '1';
							end if;
								
							hit_selectable <= '1';
							hold_selectable <= '1';
							new_state <= player_action;

						elsif ( Player4_Hand_Card_3 /= "0000" ) then
							if ( unsigned(Player4_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player4_Hand_Card_1) = 11 ) and ( Reserve_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;

							elsif ( unsigned(Player4_Hand_Score) < 22 ) and ( Player4_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
						
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned(Player4_Hand_Score) > 21) then
								new_state <= player_action;

						elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player4_Hand_Card_1) = 11 ) and ( Player4_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned(Player4_Hand_Score) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Player4_Hand_Score) < 22 ) and ( Player4_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						

				elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '1' ) then
						if ( unsigned(Reserve_Hand_Card_1) = 11 ) and ( Reserve_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
					
						elsif ( unsigned(Reserve_Hand_Score) > 21) then
							new_state <= player_action;
						
						elsif ( unsigned(Reserve_Hand_Score) = 21) then
							new_state <= player_action;

						elsif (unsigned(Reserve_Hand_Score) < 22 ) and ( Reserve_Hand_Card_5 /= "0000" ) then
							new_state <= player_action;
						
						else
							hit_selectable <= '1';
							new_state <= player_action;
						end if;

				elsif ( Player_Turn_In = "101" ) then
					if ( unsigned(Dealer_Hand_Score) < 17) and ( Dealer_Hand_Card_5 = "0000" ) then
							dealer_card_deal <= '1';
							new_state <= game_resolution;
					else
						score_screen <= '1';
						draw_screen_type <= "11";
						choose_action <= '0';
						enable <= '1';

						if ( unsigned(Dealer_Hand_Score) = 21 ) and ( Dealer_Hand_Card_3 = "0000" ) then
							if ( Player1_Insured = '1' ) then
								Player1_win_type <= "001";
								new_state <= game_setup;

							elsif ( Player2_Insured = '1' ) then
								Player2_win_type <= "001";
								new_state <= game_setup;

							elsif ( Player3_Insured = '1' ) then
								Player3_win_type <= "001";
								new_state <= game_setup;
								
							elsif ( Player4_Insured = '1' ) then
								Player4_win_type <= "001";
								new_state <= game_setup;
							end if;

						elsif( unsigned(Player1_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
								Player1_win_type <= "001";
								new_state <= game_setup;

						elsif ( unsigned(Player1_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
								Player2_win_type <= "001";
								new_state <= game_setup;

						elsif ( unsigned(Player3_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
								Player3_win_type <= "001";
								new_state <= game_setup;

						elsif ( unsigned(Player4_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
								Player4_win_type <= "001";
								new_state <= game_setup;

						elsif ( unsigned(Player4_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
								Player4_win_type <= "001";
								new_state <= game_setup;

						elsif ( unsigned(Reserve_Hand_Score) = unsigned(Dealer_Hand_Score) ) then
							if ( split_player = "001" ) then
								Player1_win_type <= "001";
								new_state <= game_setup;

							elsif ( split_player = "010" ) then
								Player2_win_type <= "001";
								new_state <= game_setup;

							elsif ( split_player = "011" ) then
								Player3_win_type <= "001";
								new_state <= game_setup;

							elsif ( split_player = "100" ) then
								Player4_win_type <= "001";
								new_state <= game_setup;
 
						elsif ( unsigned(Player1_Hand_Score) > unsigned(Dealer_Hand_Score) ) then
							if ( Player1_Doubled_Down = '1' ) then
								Player1_win_type <= "010";
								new_state <= game_setup;
							else
								Player1_win_type <= "100";
								new_state <= game_setup;
							end if;

						elsif ( unsigned(Player2_Hand_Score) > unsigned(Dealer_Hand_Score) ) then
							if ( Player2_Doubled_Down = '1' ) then
								Player2_win_type <= "010";
								new_state <= game_setup;
							else
								Player2_win_type <= "100";
								new_state <= game_setup;
							end if;

						elsif ( unsigned(Player3_Hand_Score) > unsigned(Dealer_Hand_Score) ) then
							if ( Player3_Doubled_Down = '1' ) then
								Player3_win_type <= "010";
								new_state <= game_setup;
							else
								Player3_win_type <= "100";
								new_state <= game_setup;
							end if;

						elsif ( unsigned(Player4_Hand_Score) > unsigned(Dealer_Hand_Score) ) then
							if ( Player4_Doubled_Down = '1' ) then
								Player4_win_type <= "010";
								new_state <= game_setup;
							else
								Player4_win_type <= "100";
								new_state <= game_setup;
							end if;

						elsif ( unsigned(Reserve_Hand_Score) > unsigned(Dealer_Hand_Score) ) then
							if ( split_player = "001" ) then
								Player1_win_type <= "100";
								new_state <= game_setup;

							elsif ( split_player = "010" ) then
								Player2_win_type <= "100";
								new_state <= game_setup;

							elsif ( split_player = "011" ) then
								Player3_win_type <= "100";
								new_state <= game_setup;

							elsif ( split_player = "100" ) then
								Player4_win_type <= "100";
								new_state <= game_setup;
							end if;
						end if;
					end if;
				end if;
		
			when player_action =>
					
				if (button = "100") then 
					new_state <= sela;
				elsif (button = "001") then 
					new_state <= lefta;
				elsif (button = "010") then 
					new_state <= righta;
						
				elsif ( start_screen = '1' ) then                              -- menu for choosing players --
					if ( N_Players = "000" ) then
						if ( switch_left = '1' ) then
							if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 4 --
								current_screen_position <= "100"; 
								new_state <= player_action;
							else
								current_screen_position <= current_screen_position - 1;
								new_state <= player_action;
							end if;
		
						elsif ( switch_right = '1' ) then
							if ( current_screen_position = "100" ) then         -- if at option 4, right moves to option 1 --
								current_screen_position <= "001";
								new_state <= player_action;
							else
								current_screen_position <= current_screen_position + 1;
								new_state <= player_action;
							end if;

						elsif ( switch_select = '1' ) then        
							if ( current_screen_position = "001" ) then
								N_Players_New <= "001";
								enable <= '1';
								new_state <= game_setup;

							elsif ( current_screen_position = "010" ) then
								N_Players_New <= "010";
								enable <= '1';
								new_state <= game_setup;

							elsif ( current_screen_position = "011" ) then
								N_Players_New <= "011";
								enable <= '1';
								new_state <= game_setup;
	
							elsif ( current_screen_position = "100" ) then
								N_Players_New <= "100";
								enable <= '1';
								new_state <= game_setup;
						else
							new_state <= player_action;
						end if;
							
					elsif ( N_Players /= "000" ) then
						if ( switch_select = '1' ) then
							choose_action <= '1';
							draw_screen_type <= "10";     --- 10 says draw the bidding box ---
							start_screen <= '0';
							new_state <= game_setup;
						end if;
					end if;

				elsif ( choose_action = '1' ) then 
					if ( bids_placed = '0' ) then
						if ( switch_left = '1' ) then
							if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 4 --
								current_screen_position <= "100"; 
								new_state <= player_action;
							else
								current_screen_position <= current_screen_position - 1;
								new_state <= player_action;
							end if;
		
						elsif ( switch_right = '1' ) then
							if ( current_screen_position = "100" ) then         -- if at option 4, right moves to option 1 --
								current_screen_position <= "001";
								new_state <= player_action;
							else
								current_screen_position <=  current_screen_position + 1;
								new_state <= player_action;
							end if;

						elsif ( switch_select = '1' ) then         
							if ( Player_Turn_In = "001" ) then
								if ( current_screen_position = "001" ) and ( unsigned(Player1_Budget) >= 2 ) then
									Player1_Bid_New <= "00";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "010" ) and ( unsigned(Player1_Budget) >= 6 ) then
									Player1_Bid_New <= "01";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "011" ) and ( unsigned(Player1_Budget) >= 10 ) then
									Player1_Bid_New <= "10";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "100" ) and ( unsigned(Player1_Budget) >= 20 ) then
									Player1_Bid_New <= "11";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;
								else
									new_state <= player_action;
								end if;

								if ( unsigned(N_Players) > Player_Turn_In ) and ( bid_successful = '1' ) then
									Player_Turn_New <= std_logic_vector(Player_Turn_In + 1);
									enable <= '1';
									new_state <= game_setup;
								else
									bids_placed <= '1';
									Player_Turn_New <= "001";
									enable <= '1';
									new_state <= game_setup;
								end if;

							elsif ( Player_Turn_In = "010" ) then
								if ( current_screen_position = "001" ) and ( unsigned(Player2_Budget) >= 2 ) then
									Player2_Bid_New <= "00";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "010" ) and ( unsigned(Player2_Budget) >= 6 ) then
									Player2_Bid_New <= "01";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "011" ) and ( unsigned(Player2_Budget) >= 10 ) then
									Player2_Bid_New <= "10";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "100" ) and ( unsigned(Player2_Budget) >= 20 ) then
									Player2_Bid_New <= "11";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;
								end if;

								if ( unsigned(N_Players) > Player_Turn_In ) and ( bid_successful = '1' ) then
									Player_Turn_New <= std_logic_vector(Player_Turn_In + 1);
									new_state <= game_setup;
									enable <= '1';
								else
									bids_placed <= '1';
									Player_Turn_New <= "001";
									enable <= '1';
									new_state <= game_setup;
								end if;

							elsif ( Player_Turn_In = "011" ) then
								if ( current_screen_position = "001" ) and ( unsigned(Player3_Budget) >= 2 ) then
									Player3_Bid_New <= "00";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "010" ) and ( unsigned(Player3_Budget) >= 6 ) then
									Player3_Bid_New <= "01";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "011" ) and ( unsigned(Player3_Budget) >= 10 ) then
									Player3_Bid_New <= "10";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "100" ) and ( unsigned(Player3_Budget) >= 20 ) then
									Player3_Bid_New <= "11";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;
								end if;

								if ( unsigned(N_Players) > Player_Turn_In) and ( bid_successful = '1' ) then
									Player_Turn_New <= std_logic_vector(Player_Turn_In + 1);
									new_state <= game_setup;
									enable <= '1';
								else
									bids_placed <= '1';
									Player_Turn_New <= "001";
									new_state <= game_setup;
									enable <= '1';
								end if;


							elsif ( Player_Turn_In = "100" ) then
								if ( current_screen_position = "001" ) then
									Player4_Bid_New <= "00";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "010" ) then
									Player4_Bid_New <= "01";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "011" ) then
									Player4_Bid_New <= "10";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;

								elsif ( current_screen_position = "100" ) then
									Player4_Bid_New <= "11";
									bid_successful <= '1';
									enable <= '1';
									new_state <= game_setup;
								end if;

								if ( bid_successful = '1' ) then
									bids_placed <= '1';                 -- sets player turn back to P1, bids placed=1 means the bid wont repeat after --
									Player_Turn_New <= "001";
									enable <= '1';
									new_state <= game_setup;
								end if;
							end if;
						end if;

					elsif ( bids_placed = '1' ) then				
						if ( switch_left = '1' ) then
							if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 6 --
								current_screen_position <= "110";    
							else
								current_screen_position <= current_screen_position - 1;
								new_state <= player_action;
							end if;
		
						elsif ( switch_right = '1' ) then
							if ( current_screen_position = "110" ) then         -- if at option 6, right moves to option 1 --
								current_screen_position <= "001";
							else
								current_screen_position <=  current_screen_position + 1;
								new_state <= player_action;
							end if;

						elsif ( switch_select = '1' ) then  
							if ( current_screen_position = "001" ) and ( hold_selectable = '1' ) then
								hold_selected <= '1';
								new_state <= game_resolution;

							elsif ( current_screen_position = "010" ) and ( hit_selectable = '1' ) then
								hit_selected <= '1';
								new_state <= game_resolution;

							elsif ( current_screen_position = "011" ) and ( double_selectable = '1' ) then
								double_selected <= '1';
								new_state <= game_resolution;

							elsif ( current_screen_position = "100" ) and ( split_selectable = '1' ) then
								split_selected <= '1';
								new_state <= game_resolution;

							elsif ( current_screen_position = "101" ) and ( insurance_selectable = '1' ) then
								insurance_selected <= '1';
								new_state <= game_resolution;

							elsif ( current_screen_position = "110" ) and ( even_money_selectable = '1' ) then
								even_money_selected <= '1';
								new_state <= game_resolution;
							else
								new_state <= player_action;
							end if;
						end if;
					end if;

				elsif ( score_screen = '1' ) then 
					if ( switch_left = '1' ) then
						if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 2 --
							current_screen_position <= "010";    
						else
							current_screen_position <= current_screen_position - 1;
							new_state <= player_action;
						end if;
		
					elsif ( switch_right = '1' ) then
						if ( current_screen_position = "010" ) then         -- if at option 2, right moves to option 1 --
							current_screen_position <= "001";
						else
							current_screen_position <= current_screen_position + 1;
							new_state <= player_action;
						end if;

					elsif ( switch_select = '1' ) then
						if ( current_screen_position = "001" ) then
							round_end <= '1';                            ---- round end executes a pseudo-reset on memory, RCM checks deck ----
							new_state <= game_resolution;

						elsif ( current_screen_position = "010" ) then
							global_reset <= '1';                                ---- reset send to all modules ----
							new_state <= reset_state;
						end if;
					end if;
				end if;
			end if;			
			when game_resolution =>		
				----------------------- dealing phase ------------------------
							
				if (first_card_deal = '1' and random_card = "0000") then	
					require_card <= '1';
					new_state <= pending_card_a;
							
				elsif (second_card_deal = '1' and random_card = "0000") then
					require_card <= '1';
					new_state <= pending_card_a;
							
				elsif (dealer_card_deal = '1' and random_card = "0000") then
					require_card <= '1';
					new_state <= pending_card_a;
							
		           ---------------------------- game phase --------------------------------
				elsif ( hit_selected = '1' ) then
					first_turn_over <= '1';
				        require_card <= '1';
					new_state <= pending_card_a;
							
				elsif ( double_selected = '1' ) then 
					first_turn_over <= '1';
					require_card <= '1';
					new_state <= pending_card_a;

				elsif ( insurance_selected = '1' ) then
					first_turn_over <= '1';
					insurance <= '1';
					enable <= '1';
					new_state <= game_setup;

				elsif ( even_money_selected = '1' ) then
					first_turn_over <= '1';
					even_money <= '1';
					enable <= '1';
					new_state <= game_setup;

				elsif ( split_selected = '1' ) then 
					split_player <= std_logic_vector(Player_Turn_In);   --------------------- inquire ---------------------------
					first_turn_over <= '1';
					split <= '1';
					enable <= '1';
					new_state <= game_setup;
							
				elsif ( hold_selected = '1' ) then
					if (Player_Turn_In = unsigned(N_Players) ) and ( unsigned(split_player) /= Player_Turn_In ) then
						Player_Turn_New <= "101";

					elsif (Player_Turn_In = unsigned(N_Players) ) and ( split_player_turn = '1' ) then
						Player_Turn_New <= "101";
					
					elsif ( unsigned(split_player) = Player_Turn_In ) and ( split_player_turn = '0' ) then
						split_player_turn <= '1';
					else
						Player_Turn_New <= std_logic_vector(Player_Turn_In + 1);
					end if;
					first_turn_over <= '0';
					enable <= '1';
					new_state <= game_setup;
				end if;
							
		----------------------- using the card received after returning from pending_card states ------------------------

				if ( card_received = '1' ) then             -- definitive condition for Receiving Hand to be given values. Removes --
					if ( first_card_deal = '1' ) then         -- requirement for Receiving Hand to have a 0 off state. Saves a bit --   
				        		if ( Player1_Hand_Card_1 = "0000" ) then     
					        	Receiving_Hand <= "001";    -- "000" card goes to Player 1's hand --   				  
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;
							
				       		elsif ( Player1_Hand_Card_1 /= "0000" ) and ( Player2_Hand_Card_1 = "0000" ) and ( unsigned(N_Players) > 1) then 
							Receiving_Hand <= "010";    -- "001" card goes to Player 2's hand --       
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player2_Hand_Card_1 /= "0000" ) and ( Player3_Hand_Card_1 = "0000" ) and ( unsigned(N_Players) > 2) then 
							Receiving_Hand <= "011";    -- "010" card goes to Player 3's hand --
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player3_Hand_Card_1 /= "0000" ) and ( Player4_Hand_Card_1 = "0000" ) and ( unsigned(N_Players) > 3) then 
							Receiving_Hand <= "100";    -- "011" card goes to Player 4's hand --
					        	enable <= '1';
	      						card_received <= '0';
							new_state <= game_setup;
						end if;

					elsif ( dealer_card_deal = '1' ) then   -- may be possible to funnel this in at the end of the above *if* statement as an optimization if needed -- 
						Receiving_Hand <= "101";    -- "100" card goes to Dealer's hand --  
					        enable <= '1';
						card_received <= '0';
						new_state <= game_setup;

					elsif ( second_card_deal = '1' ) then
						if ( Player1_Hand_Card_2 = "0000" ) then     
					        	Receiving_Hand <= "001";    -- "000" card goes to Player 1's hand --   				  
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;
							
				       		elsif ( Player1_Hand_Card_2 /= "0000" ) and ( Player2_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "010";    -- "001" card goes to Player 2's hand --       
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player2_Hand_Card_2 /= "0000" ) and ( Player3_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "011";    -- "010" card goes to Player 3's hand --
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player3_Hand_Card_2 /= "0000" ) and ( Player4_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "100";    -- "000" card goes to Player 4's hand --
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;
						end if;
																  
					elsif ( double_selected = '1' ) then 										  
						Receiving_Hand <= std_logic_vector(Player_Turn_In);
						double <= '1';
						enable <= '1';
						card_received <= '0';
						new_state <= game_setup;

					elsif ( hit_selected = '1' ) then 
						if ( split_player_turn = '1' ) then
							Receiving_Hand <= "110";   
							enable <= '1';
							card_received <= '0';
							new_state <= game_setup;
						else
							Receiving_Hand <= std_logic_vector(Player_Turn_In);
							enable <= '1';
							card_received <= '0';
							new_state <= game_setup;
						end if;
					end if;
				end if;	
					
			when pending_card_a =>
				request_card <= '1';
                                if ( random_card /= "0000" ) then
				        require_card <= '0';
					new_card <= random_card;
					card_received <= '1';
			        else
					require_card <= '1';
				end if;

				if ( require_card = '1' ) then
					new_state <= pending_card_b;
				else
					new_state <= game_resolution;
				end if;

			when pending_card_b =>
				request_card <= '0';
				if ( random_card /= "0000" ) then
				        require_card <= '0';
					new_card <= random_card;
					card_received <= '1';
			        else
					require_card <= '1';
				end if;

				if ( require_card = '1' ) then
					new_state <= pending_card_b;
				else
					new_state <= game_resolution;
				end if;

			when sela => 
				switch_select <= '1' ; 	
				if  (button = "100") then 
					new_state <= selb;
				else 
					new_state <= player_action; 
				end if;
					
			when selb => 
				switch_select <= '0' ; 	
				if  (button = "100") then 
					new_state <= selb; 
				else 
					new_state <= player_action;
				end if;
					
			when lefta => 
				switch_left <= '1' ;	
				if  (button = "001") then 
					new_state <= leftb;
				else 
					new_state <= player_action;
				end if;
					
			when leftb =>
				 switch_left <= '0';
				if (button = "001") then 
					new_state <= leftb;
				else 
					new_state <= player_action;
				end if;
					
			when righta => 
				switch_right <= '1' ;	
				if (button = "010") then
				 	new_state <= rightb;
				else 
					new_state <= player_action;
				end if;
					
			when rightb => 
				switch_right <= '0' ;
				if (button = "010") then 
					new_state <= rightb;
				else 
					new_state <= player_action;
	        		end if;
            end case;
      end process;
end architecture;
