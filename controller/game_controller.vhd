library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity controller is
	port(	clk	: in  std_logic;
		reset	: in  std_logic;

	Player_Turn_In	: in std_logic_vector (2 downto 0);
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

	Player2_Hand_Card_1	: in std_logic_vector (3 downto 0);
	Player2_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Player2_Hand_Card_3	: in std_logic_vector (3 downto 0);
	Player2_Hand_Card_4	: in std_logic_vector (3 downto 0);   
	Player2_Hand_Card_5	: in std_logic_vector (3 downto 0);

	Player3_Hand_Card_1	: in std_logic_vector (3 downto 0);
	Player3_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Player3_Hand_Card_3	: in std_logic_vector (3 downto 0);   
	Player3_Hand_Card_4	: in std_logic_vector (3 downto 0);
	Player3_Hand_Card_5	: in std_logic_vector (3 downto 0);

	Player4_Hand_Card_1	: in std_logic_vector (3 downto 0);
	Player4_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Player4_Hand_Card_3	: in std_logic_vector (3 downto 0);
	Player4_Hand_Card_4	: in std_logic_vector (3 downto 0);
	Player4_Hand_Card_5	: in std_logic_vector (3 downto 0);

	Dealer_Hand_Card_1	: in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_3	: in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_4	: in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_5	: in std_logic_vector (3 downto 0);

	Reserve_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Reserve hand for Split. Only one player can split (low chance of multiple splits) --
	Reserve_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_3	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_4	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_5	: in std_logic_vector (3 downto 0);

	random_card  : in  std_logic_vector (3 downto 0);		-- Comms with RNG --
	request_card : out std_logic;                         
	round_end    : out std_logic;
	new_card     : out std_logic_vector (3 downto 0);   -- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --

	draw_menu    : out std_logic_vector (? downto 0);		-- Comms with Graphics Driver --
	menu_ready   : in std_logic;

	Player1_Budget_New  : out  std_logic_vector (9 downto 0);-- base budget is 100, score limit chosen as 1000 so 10 bits --
	Player2_Budget_New  : out  std_logic_vector (9 downto 0);
	Player3_Budget_New  : out  std_logic_vector (9 downto 0);  
	Player4_Budget_New  : out  std_logic_vector (9 downto 0);

	Player1_Bid_New  : out std_logic_vector (1 downto 0);   -- 2,6,10,20 = 4 options so 2 bits --
	Player2_Bid_New  : out std_logic_vector (1 downto 0);
	Player3_Bid_New  : out std_logic_vector (1 downto 0);
	Player4_Bid_New  : out std_logic_vector (1 downto 0);

	Player_Turn_New	: out std_logic_vector (2 downto 0);   -- outputs -> mem based on actions --
	N_Players_New	: out std_logic_vector (2 downto 0);
	Receiving_Hand	: out std_logic_vector (2 downto 0);   -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--
	enable     : out std_logic;
	even_money : out std_logic;
	insurance  : out std_logic;
	split      : out std_logic;
	double     : out std_logic;
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

signal bids_placed, bid_successful, require_card, card_received : std_logic;  
signal first_card_deal, dealer_card_deal, second_card_deal : std_logic;

signal even_money_selected, insurance_selected, split_selected, double_selected, hit_selected, hold_selected : std_logic;
signal even_money_selectable, insurance_selectable, split_selectable, double_selectable, hit_selectable, hold_selectable : std_logic;
signal first_turn_over : std_logic;

signal split_player : std_logic_vector (2 downto 0);  
signal split_player_turn : std_logic;

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

	process (state, )
	begin
		case state is
			when reset_state =>
				bids_placed <= '0';
				require_card <= '0';
				card_received <= '0';
				split_player <= "000";
				split_player_turn <= '0';
				current_screen_position <= "100";

				start_screen <= '1';
				if ( switch_select = '1' ) then
					start_screen <= '0';
					new_state <= game_setup;
				end if;
					
			when game_setup =>
				insurance <= '0';   ---- may need to move these to reset ----
				split <= '0';
				double <= '0';
				new_card <= "0000";
				enable <= '0';
				Receiving_Hand <= "000";
				request_card <= '0';
				round_end <= '0';
				bid_successful <= '0';     

				if ( N_Players = "000" ) then      -- player select condition --
					choose_players <= '1';
					new_state <= player_action;
				else
					choose_players <= '0';
				end if;

				if ( bids_placed = '0' and N_Players /= "000" ) then	 -- bidding screen condition--
					choose_bids <= '1';
					new_state <= player_action;
				else
					choose_bids <= '0';
				end if;

				-- Check whether starting cards have been dealt -- 
				-- If yes, check which dealing phase we're in based on player count--
				if ( N_Players = "001" ) and ( bids_placed = '1' ) then			    -- if 1 player total, switch phases based on Player 1 cards --
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
					
			----------------------------- checking actions available -------------------------------------	
					
				even_money_selectable <= '0';
				insurance_selectable <= '0';
				split_selectable <= '0';
				double_selectable <= '0';
				hit_selectable <= '0';
				hold_selectable <= '1';

				if ( Player_Turn_In = "001" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) > 21) then
							new_state <= player action;
		
						elsif ( Player1_Hand_Card_2 /= "0000" ) and ( Player1_Hand_Card_3 = "0000" ) and ( split_player /= Player_Turn_In ) then
							if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player1_Hand_Card_1 + Player1_Hand_Card_2) = 21 ) then
								even_money_selectable <= '1';
								-- draw even money pop up --
					
							elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) and ( unsigned(Player1_Budget) >= 0.5 * unsigned(Player1_Bid)* )  then 
								insurance_selectable <= '1';
								-- draw insurance menu --

							elsif ( Player1_Hand_Card_1 = Player1_Hand_Card_2 ) and ( unsigned(Player1_Budget) >= unsigned(Player1_Bid) ) then 
								split_selectable <= '1';

							elsif ( unsigned(Player1_Budget) >= unsigned(Player1_Bid) ) and ( unsigned(Player1_Hand_Card_1 + Player1_Hand_Card_2) < 21 ) then  
								double_selectable <= '1';
								hit_selectable <= '1';
								hold_selectable <= '1';

							else 
								hit_selectable <= '1';
								hold_selectable <= '1';
							end if;
							new_state <= player_action;			

						elsif ( Player1_Hand_Card_3 /= "0000" ) then
							if ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) = 21) then
								new_state <= player_action;
						
							elsif ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) < 22 ) and ( Player1_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
						
							else
								hit_selectable <= '1';
								new_state <= player_actton;
							end if;
						end if;	
							
					elsif ( first_turn_over = '1' ) then
						if ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) > 21) then
							new_state <= player action;
						
						elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player1_Hand_Card_1) = 11 ) and ( Player1_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) < 22 ) and ( Player1_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						

				elsif ( Player_Turn_In = "010" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '1' ) then
						if ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) > 21) then
								new_state <= player action;
					
						elsif ( Player2_Hand_Card_2 /= "0000" ) and ( Player2_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player2_Hand_Card_1 + Player2_Hand_Card_2) = 21 ) then
								even_money_selectable <= '1';
								new_state <= player_action;
								-- draw even money pop up --
					
							elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) and ( unsigned(Player2_Budget) >= 0.5 * unsigned(Player2_Bid)* ) then 
								insurance_selectable <= '1';
								new_state <= player_action;
								-- draw insurance menu --

							elsif ( Player2_Hand_Card_1 = Player2_Hand_Card_2 ) and ( unsigned(Player2_Budget) >= unsigned(Player2_Bid) ) then 
								split_selectable <= '1';

							elsif ( unsigned(Player2_Budget) >= unsigned(Player2_Bid) ) and ( unsigned(Player2_Hand_Card_1 + Player2_Hand_Card_2) < 21 ) then  
								double_selectable <= '1';
								hit_selectable <= '1';
								hold_selectable <= '1';

							else 
								hit_selectable <= '1';
								hold_selectable <= '1';
								new_state <= player_action;
							end if;

						elsif ( Player2_Hand_Card_3 /= "0000" ) then
							if ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) < 22 ) and ( Player2_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;

							else
								hit_selectable <= '1';
								new_state <= player_actton;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) > 21) then
								new_state <= player action;

						elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player2_Hand_Card_1) = 11 ) and ( Player2_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) < 22 ) and ( Player2_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						
				elsif ( Player_Turn_In = "011" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) > 21) then
								new_state <= player action;
					
						elsif ( Player3_Hand_Card_2 /= "0000" ) and ( Player3_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player3_Hand_Card_1 + Player3_Hand_Card_2) = 21 ) then
								even_money_selectable <= '1';
								-- draw even money pop up --
					
							elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) and ( unsigned(Player3_Budget) >= 0.5 * unsigned(Player3_Bid)* ) then 
								insurance_selectable <= '1';
								-- draw insurance menu --

							elsif ( Player3_Hand_Card_1 = Player_Hand3_Card_2 ) and ( unsigned(Player3_Budget) >= unsigned(Player3_Bid) ) then 
								split_selectable <= '1';

							elsif ( unsigned(Player3_Budget) >= unsigned(Player3_Bid) ) and ( unsigned(Player3_Hand_Card_1 + Player3_Hand_Card_2) < 21 ) then  
								double_selectable <= '1';
								hit_selectable <= '1';
								hold_selectable <= '1';

							else 
								hit_selectable <= '1';
								hold_selectable <= '1';
							end if;
							new_state <= player_action;

						elsif ( Player3_Hand_Card_3 /= "0000" ) then
							if ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) < 22 ) and ( Player3_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;

							else
								hit_selectable <= '1';
								new_state <= player_actton;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) > 21) then
								new_state <= player action;

						elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player3_Hand_Card_1) = 11 ) and ( Player3_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) < 22 ) and ( Player3_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						
				elsif ( Player_Turn_In = "100" ) and ( split_player_turn = '0' ) then
					if ( first_turn_over = '0' ) then
						if ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) > 21) then
								new_state <= player action;
					
						elsif ( Player4_Hand_Card_2 /= "0000" ) and ( Player4_Hand_Card_3 = "0000" ) then
							if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player4_Hand_Card_1 + Player4_Hand_Card_2) = 21 ) then
								even_money_selectable <= '1';
								-- draw even money pop up --
					
							elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) and ( unsigned(Player4_Budget) >= 0.5 * unsigned(Player4_Bid)* ) then 
								insurance_selectable <= '1';
								-- draw insurance menu --

							elsif ( Player4_Hand_Card_1 = Player4_Hand_Card_2 ) and ( unsigned(Player4_Budget) >= unsigned(Player4_Bid) ) then 
								split_selectable <= '1';

							elsif ( unsigned(Player4_Budget) >= unsigned(Player4_Bid) ) and ( unsigned(Player4_Hand_Card_1 + Player4_Hand_Card_2) < 21 ) then  
								double_selectable <= '1';
								hit_selectable <= '1';
								hold_selectable <= '1';

							else 
								hit_selectable <= '1';
								hold_selectable <= '1';
							end if;
							new_state <= player_action;

						elsif ( Player4_Hand_Card_3 /= "0000" ) then
							if ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned(Reserve_Hand_Card_1) = 11 ) and ( Reserve_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;

							elsif ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) < 22 ) and ( Player4_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
						
							else
								hit_selectable <= '1';
								new_state <= player_actton;
							end if;
						end if;

					elsif ( first_turn_over = '1' ) then
						if ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) > 21) then
								new_state <= player action;

						elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '0' ) then
							if ( unsigned(Player4_Hand_Card_1) = 11 ) and ( Player4_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
						
							elsif ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) = 21) then
								new_state <= player_action;

							elsif ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) < 22 ) and ( Player4_Hand_Card_5 /= "0000" ) then
								new_state <= player_action;
							else
								hit_selectable <= '1';
								new_state <= player_action;
							end if;
						end if;
					end if;
						

				elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '1' ) then
						if ( unsigned(Reserve_Hand_Card_1) = 11 ) and ( Reserve_Hand_Card_2 /= "0000" ) then
								new_state <= player_action;
					
						elsif ( unsigned( Reserve_Hand_Card_1 + Reserve_Hand_Card_2 + Reserve_Hand_Card_3 + Reserve_Hand_Card_4 + Reserve_Hand_Card_5 ) > 21) then
							new_state <= player action;
						
						elsif ( unsigned( Reserve_Hand_Card_1 + Reserve_Hand_Card_2 + Reserve_Hand_Card_3 + Reserve_Hand_Card_4 + Reserve_Hand_Card_5 ) = 21) then
							new_state <= player_action;

						elsif ( unsigned( Reserve_Hand_Card_1 + Reserve_Hand_Card_2 + Reserve_Hand_Card_3 + Reserve_Hand_Card_4 + Reserve_Hand_Card_5 ) < 22 ) and ( Reserve_Hand_Card_5 /= "0000" ) then
							new_state <= player_action;
						
						else
							hit_selectable <= '1';
							new_state <= player_action;
						end if;

				elsif ( Player_Turn_In = "101" ) then
					if ( unsigned( Dealer_Hand_Card_1 + Dealer_Hand_Card_2 + Dealer_Hand_Card_3 + Dealer_Hand_Card_4 + Dealer_Hand_Card_5 ) < 17) and ( Dealer_Hand_Card_5 = "0000" ) then
							dealer_card_deal <= '1';
							new_state <= game_resolution;
					else
						--- score screen stuff ---
						new_state <= player_action;
				end if;
		
			when player_action =>									
				if ( choose_players = '1' ) then                              -- menu for choosing players --
					if ( switch_left = '1' ) then
						if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 4 --
							current_screen_position <= "100";    
						else
							current_screen_position <= current_screen_position - 1;
							new_state <= player_action;
						end if;
		
					elsif ( switch_right = '1' ) then
						if ( current_screen_position = "100" ) then         -- if at option 4, right moves to option 1 --
							current_screen_position <= "001";
						else
							current_screen_position <= current_screen_position + 1;
							new_state <= player_action;
						end if;

					elsif ( switch_select = '1' ) then        
						if ( current_screen_position = "001" ) then
							N_Players <= "001";
							enable <= '1';
							new_state <= game_setup;

						elsif ( current_screen_position = "010" ) then
							N_Players <= "010";
							enable <= '1';
							new_state <= game_setup;

						elsif ( current_screen_position = "011" ) then
							N_Players <= "011";
							enable <= '1';
							new_state <= game_setup;

						elsif ( current_screen_position = "100" ) then
							N_Players <= "100";
							enable <= '1';
							new_state <= game_setup;
						else
							new_state <= player_action;
						end if;
					end if;

				elsif ( choose_bids = '1' ) then                              -- menu for choosing bids (near identical to choosing players) --
					if ( switch_left = '1' ) then
						if ( current_screen_position = "001" ) then     -- if at option 1, left moves to option 4 --
							current_screen_position <= "100";    
						else
							current_screen_position <= current_screen_position - 1;
							new_state <= player_action;
						end if;
		
					elsif ( switch_right = '1' ) then
						if ( current_screen_position = "100" ) then         -- if at option 4, right moves to option 1 --
							current_screen_position <= "001";
						else
							current_screen_position <= current_screen_position + 1;
							new_state <= player_action;
						end if;

					elsif ( switch_select = '1' ) then         -- N player selection could be done straight away here? --
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

							if ( unsigned(N_Players) > unsigned(Player_Turn_In) ) and ( bid_successful = '1' ) then
								Player_Turn_New <= Player_Turn_In + 1;
							else
								bids_placed <= '1';
								Player_Turn_New <= "001";
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

							if ( unsigned(N_Players) > unsigned(Player_Turn_In) ) and ( bid_successful = '1' ) then
								Player_Turn_New <= Player_Turn_In + 1;
							else
								bids_placed <= '1';
								Player_Turn_New <= "001";
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

							if ( unsigned(N_Players) > unsigned(Player_Turn_In) ) and ( bid_successful = '1' ) then
								Player_Turn_New <= Player_Turn_In + 1;
							else
								bids_placed <= '1';
								Player_Turn_New <= "001";
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
							end if;
	
				elsif ( choose_action = '1' ) then                 -- menu for choosing actions such as hit, hold etc --				
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
							current_screen_position <= current_screen_position + 1;
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
							reset <= '1';                                ---- reset here is akin to the game over option ----
						end if;
					
			when game_resolution =>

			        ------------------ bidding phase ---------------------
				elsif (N_Players /= "000" and bids_placed = '0') then
					if ( Player_Turn_In = "001" ) then            -- Player 1 Bid --
						if (mem_screen_position = "000" ) then
							Player1_Bid_New <= "00";
						elsif (mem_screen_position "001" ) then
							Player1_Bid_New <= "01";
						elsif (mem_screen_position = "010" ) then
							Player1_Bid_New <= "10";
						elsif (mem_screen_position = "011" ) then
							Player1_Bid_New  <= "11";
						end if;  
						if ( unsigned(N_Players) > unsigned(Player_Turn_In) + 1 ) then
							Player_Turn_New <= "01"; 
						else 
							bids_placed <= '1';
						end if;
					elsif ( Player_Turn_In = "010" ) then           -- Player 2 Bid --
						if (mem_screen_position = "000" ) then
							Player2_Bid_New <= "00";
						elsif (mem_screen_position "001" ) then
							Player2_Bid_New <= "01";
						elsif (mem_screen_position = "010" ) then
							Player2_Bid_New <= "10";
						elsif (mem_screen_position = "011" ) then
							Player2_Bid_New  <= "11";
						end if;
						if ( unsigned(N_Players) > "010" ) then
							Player_Turn_New <= "10"; 
						else 
							bids_placed <= '1';
						end if;
					elsif ( Player_Turn_In = "011" ) then           -- Player 3 Bid --
						if (mem_screen_position = "000" ) then
							Player3_Bid_New <= "00";
						elsif (mem_screen_position "001" ) then
							Player3_Bid_New <= "01";
						elsif (mem_screen_position = "010" ) then
							Player3_Bid_New <= "10";
						elsif (mem_screen_position = "011" ) then
							Player3_Bid_New  <= "11";
						end if;  
						if ( unsigned(N_Players) > "011" ) then
							Player_Turn_New <= "11"; 
						else 
							bids_placed <= '1';
						end if;
					elsif ( Player_Turn_In = "100" ) then           -- Player 4 Bid --
						if (mem_screen_position = "000" ) then
							Player4_Bid_New <= "00";
						elsif (mem_screen_position "001" ) then
							Player4_Bid_New <= "01";
						elsif (mem_screen_position = "010" ) then
							Player4_Bid_New <= "10";
						elsif (mem_screen_position = "011" ) then
							Player4_Bid_New  <= "11";
						end if;  
						Player_Turn_New <= "00";
						bids_placed <= '1';
					end if;
					new_state <= game_setup;
				end if;
							
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
					split_player <= Player_Turn_In;
					first_turn_over <= '1';
					split <= '1';
					enable <= '1';
					new_state <= game_setup;
							
				elsif ( hold_selected = '1' ) then
					if ( unsigned(Player_Turn_In) = unsigned(N_Players) ) and ( split_player /= Player_Turn_In )then
						Player_Turn_In <= "101";

					elsif ( unsigned(Player_Turn_In) = unsigned(N_Players) ) and ( split_player_turn = '1' ) then
						Player_Turn_In <= "101";
					
					elsif ( split_player = Player_Turn_In ) and ( split_player_turn = '0' ) then
						split_player_turn <= '1';
					
					else
						Player_Turn_New <= Player_Turn_In + 1;
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
							
				       		elsif ( Player1_Hand_Card_1 /= "0000" ) and ( Player2_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 1) then 
							Receiving_Hand <= "010";    -- "001" card goes to Player 2's hand --       
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player2_Hand_Card_1 /= "0000" ) and ( Player3_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 2) then 
							Receiving_Hand <= "011";    -- "010" card goes to Player 3's hand --
					        	enable <= '1';
							card_received <= '0';
							new_state <= game_setup;

						elsif ( Player3_Hand_Card_1 /= "0000" ) and ( Player4_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 3) then 
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
						unsigned(Receiving_Hand) <= unsigned(Player_Turn_In);
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
							unsigned(Receiving_Hand) <= unsigned(Player_Turn_In);
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
					new_state <= game_resolution; 
				end if;
					
			when selb => 
				switch_select <= '0' ; 	
				if  (button = "100") then 
					new_state <= game_resolution; 
				else 
					new_state <= selb;
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
					new_state <= player_action;
				else 
					new_state <= leftb;
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
					new_state <= player_action;
				else 
					new_state <= rightb;
	        		end if;
            end case;
      end process;
end architecture;
