library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity controller is
	port(	clk	: in  std_logic;
		reset	: in  std_logic;

	Player_Turn_In	: in std_logic_vector (1 downto 0);
	N_Players	: in std_logic_vector (2 downto 0);

	switch_select	: in  std_logic;  
	switch_left	: in  std_logic;						-- player inputs --
	switch_right	: in  std_logic;

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

	Reserve_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Reserve hand for Split. Only one player can split (low chance) --
	Reserve_Hand_Card_2	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_3	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_4	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_5	: in std_logic_vector (3 downto 0);
	Reserve_Hand_Player	: in std_logic_vector (2 downto 0);	-- Pointer to which player split their hand --

	random_card  : in  std_logic_vector (3 downto 0);		-- Comms with RNG --
	request_card : out std_logic;                         
	round_end    : out std_logic;

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

	Player_Turn_New	: out std_logic_vector (1 downto 0);   -- outputs -> mem based on actions --
	N_Players_New	: out std_logic_vector (2 downto 0);
	Receiving_Hand	: out std_logic_vector (2 downto 0);   -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--
	enable     : out std_logic;
	new_card   : out std_logic_vector (3 downto 0);   -- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --
	);
end controller;

architecture behaviour of controller is
	type controller_state is ( reset_state,
				   game_setup,
				   player_action,
				   game_resolution,
				   pending_card_a,
				   pending_card_b
				 );

signal state, new_state: controller_state;
signal bids_placed, require_card : std_logic;  
signal first_card_deal, dealer_card_deal, second_card_deal : std_logic;
signal even_money_selected, insurance_selected, split_selected, double_selected, hit_selected, hold_selected : std_logic;
signal even_money_selectable, insurance_selectable, split_selectable, double_selectable, hit_selectable, hold_selectable : std_logic;

signal mem_screen_position_max, mem_screen_position : std_logic;
-- draw_menu signal needs to be held continously, thus remembered for all clock cycles --
signal menu : std_logic_vector (? downto 0); 

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

	process (state, mem (t.b.d))
	begin
		case state is
			when reset_state =>
				bids_placed <= '0';
				require_card <= '0';
				enable <= '0';
				-- signal to draw the main menu --
				-- mem_screen_position_max	<= "000" --
				-- mem_screen_position		<= "000" --
				-- mem_switch_select		<= '0' --
				if( mem_switch_select = '1' ) then
					new_state <= game_setup;
				end if;
					
			when game_setup =>
				insurance <= '0'; -- unused signals during game-setup --
				split <= '0';
				double <= '0';
				new_card <= "0000";
				enable <= '0';
				Receiving_Hand <= "000";
				request_card <= '0';
				round_end <= '0';
				N_Players_New <= N_Players; -- preserve unused signals to next state --
				Player_Turn_New <= Player_Turn_In;
				Player1_Bid_New <= Player1_Bid;
				Player2_Bid_New <= Player2_Bid;
				Player3_Bid_New <= Player3_Bid;
				Player4_Bid_New <= Player4_Bid;
				Player1_Budget_New <= Player1_Budget;
				Player2_Budget_New <= Player2_Budget;
				Player3_Budget_New <= Player3_Budget;
				Player4_Budget_New <= Player4_Budget;

				if ( N_Players = "000" ) then      -- player select condition --
					-- draw_menu <= ?? --
					mem_screen_position_max <= "011";
					new_state <= player_action;
				end if;

				if ( bids_placed = '0' and N_Players /= "000" ) then	 -- bidding screen condition--
					-- draw_menu <= ?? --
					mem_screen_position_max	<= "011";
					new_state <= player_action;
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

				if ( Player_Turn_In = "00" ) then
					if ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) > 21) then
							new_state <= player action;
					
					elsif ( Player1_Hand_Card_2 /= "0000" ) and ( Player1_Hand_Card_3 = "0000" ) then
						if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player1_Hand_Card_1 + Player1_Hand_Card_2) = 21 ) then
							even_money_selectable <= '1';
							new_state <= player_action;
							-- draw even money pop up --
					
						elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) then 
							insurance_selectable <= '1';
							new_state <= player_action;
							-- draw insurance menu --

						else 
							double_selectable <= '1';
							hit_selectable <= '1';
							hold_selectable <= '1';
							new_state <= player_action;
						end if;

					elsif ( Player1_Hand_Card_3 /= "0000" ) then
						if ( unsigned( Player1_Hand_Card_1 + Player1_Hand_Card_2 + Player1_Hand_Card_3 + Player1_Hand_Card_4 + Player1_Hand_Card_5 ) = 21) then
							new_state <= player_action;

						else
							hit_selectable <= '1';
							new_state <= player_actton;
						end if;
					end if;
				end if;

				elsif ( Player_Turn_In = "01" ) then
					if ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) > 21) then
							new_state <= player action;
					
					elsif ( Player2_Hand_Card_2 /= "0000" ) and ( Player2_Hand_Card_3 = "0000" ) then
						if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player2_Hand_Card_1 + Player2_Hand_Card_2) = 21 ) then
							even_money_selectable <= '1';
							new_state <= player_action;
							-- draw even money pop up --
					
						elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) then 
							insurance_selectable <= '1';
							new_state <= player_action;
							-- draw insurance menu --

						else 
							double_selectable <= '1';
							hit_selectable <= '1';
							hold_selectable <= '1';
							new_state <= player_action;
						end if;

					elsif ( Player2_Hand_Card_3 /= "0000" ) then
						if ( unsigned( Player2_Hand_Card_1 + Player2_Hand_Card_2 + Player2_Hand_Card_3 + Player2_Hand_Card_4 + Player2_Hand_Card_5 ) = 21) then
							new_state <= player_action;

						else
							hit_selectable <= '1';
							new_state <= player_actton;
						end if;
					end if;
				end if;

				elsif ( Player_Turn_In = "10" ) then
					if ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) > 21) then
							new_state <= player action;
					
					elsif ( Player3_Hand_Card_2 /= "0000" ) and ( Player3_Hand_Card_3 = "0000" ) then
						if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player3_Hand_Card_1 + Player3_Hand_Card_2) = 21 ) then
							even_money_selectable <= '1';
							new_state <= player_action;
							-- draw even money pop up --
					
						elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) then 
							insurance_selectable <= '1';
							new_state <= player_action;
							-- draw insurance menu --

						else 
							double_selectable <= '1';
							hit_selectable <= '1';
							hold_selectable <= '1';
							new_state <= player_action;
						end if;

					elsif ( Player3_Hand_Card_3 /= "0000" ) then
						if ( unsigned( Player3_Hand_Card_1 + Player3_Hand_Card_2 + Player3_Hand_Card_3 + Player3_Hand_Card_4 + Player3_Hand_Card_5 ) = 21) then
							new_state <= player_action;

						else
							hit_selectable <= '1';
							new_state <= player_actton;
						end if;
					end if;
				end if;

				if ( Player_Turn_In = "11" ) then
					if ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) > 21) then
							new_state <= player action;
					
					elsif ( Player4_Hand_Card_2 /= "0000" ) and ( Player4_Hand_Card_3 = "0000" ) then
						if ( unsigned(Dealer_Hand_Card_1) > 9 ) and ( unsigned(Player4_Hand_Card_1 + Player4_Hand_Card_2) = 21 ) then
							even_money_selectable <= '1';
							new_state <= player_action;
							-- draw even money pop up --
					
						elsif ( unsigned(Dealer_Hand_Card_1) = 11 ) then 
							insurance_selectable <= '1';
							new_state <= player_action;
							-- draw insurance menu --

						else 
							double_selectable <= '1';
							hit_selectable <= '1';
							hold_selectable <= '1';
							new_state <= player_action;
						end if;

					elsif ( Player4_Hand_Card_3 /= "0000" ) then
						if ( unsigned( Player4_Hand_Card_1 + Player4_Hand_Card_2 + Player4_Hand_Card_3 + Player4_Hand_Card_4 + Player4_Hand_Card_5 ) = 21) then
							new_state <= player_action;

						else
							hit_selectable <= '1';
							new_state <= player_actton;
						end if;
					end if;
				end if;


			when player_action =>
				mem_screen_position_max <= "011"; 	-- player select screen --
				if ( mem_switch_select = '1' ) then
					mem_switch_select <= '0';
					new_state <= game_resolution;
				end if;
				mem_screen_position_max <= "011";       -- bidding screen --
				if ( mem_switch_select = '1' ) then
					mem_switch_select <= '0';
					new_state <= game_resolution;
				end if;
					
			when game_resolution =>
			------------------- player select menu ------------------------
				if (N_Players = "000")
					if (mem_screen_position = "000") then
						N_Players_New <= "001";
					elsif (mem_screen_position = "001" ) then
						N_Players_New <= "010";
					elsif (mem_screen_position = "010" ) then
						N_Players_New <= "011";
					elsif (mem_screen_position = "011" ) then
						N_Players_New <= "100";
					end if;

			        ------------------ bidding phase ---------------------
				elsif (N_Players /= "000" and bids_placed = '0') then
					if ( Player_Turn_In = "00" ) then            -- Player 1 Bid --
						if (mem_screen_position = "000" ) then
							Player1_Bid_New <= "00";
						elsif (mem_screen_position "001" ) then
							Player1_Bid_New <= "01";
						elsif (mem_screen_position = "010" ) then
							Player1_Bid_New <= "10";
						elsif (mem_screen_position = "011" ) then
							Player1_Bid_New  <= "11";
						end if;  
						if ( unsigned(N_Players) > "001" ) then
							Player_Turn_New <= "01"; 
						else 
							bids_placed <= '1';
						end if;
					elsif ( Player_Turn_In = "01" ) then           -- Player 2 Bid --
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
					elsif ( Player_Turn_In = "10" ) then           -- Player 3 Bid --
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
					elsif ( Player_Turn_In = "11" ) then           -- Player 4 Bid --
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
		-- maybe we can send the card to mem along with player number, and the mem fills the first free card-slot found for that player --
		-- for the dealer it is convenient to take player_turn = 5 which helps during the game itself, --
		-- as in the main game the game setup recognizes dealing out the dealer after fourth player --
							
				if (first_card_deal = '1' and random_card = "0000") then	
					require_card <= '1';
					new_state <= pending_card_a;
				elsif (second_card_deal = '1' and random_card = "0000") then
					require_card <= '1';
					new_state <= pending_card_a;
				elsif (dealer_card_deal = '1' and random_card = "0000") then
					require_card <= '1';
					new_state <= pending_card_a;
				end if;
							
		---------------------------- game phase --------------------------------
					
				elsif (hold_selected = '1') then
					Player_Turn_New <= Player_Turn_In + 1;
					
				elsif (insurance_selected = '1') then
					insurance <= '1';
					
				elsif ( double_selected = '1' ) 
					require_card <= '1';
					new_state <= game_resolution;
					
				elsif hit_selected = '1') then
				        require_card <= '1';
					new_state <= game_resolution;
							
		----------------------- using the card received after returning from pending_card states ------------------------

				if ( random_card /= "0000" ) then             -- definitive condition for Receiving Hand to be given values. Removes --
					if ( first_card_deal = '1' ) then         -- requirement for Receiving Hand to have a 0 off state. Saves a bit --   
				        	if ( Player1_Hand_Card_1 = "0000" ) then     
					        	Receiving_Hand <= "000";    -- "000" card goes to Player 1's hand --   				  
					        	enable <= '1';
							
				       		elsif ( Player1_Hand_Card_1 /= "0000" ) and ( Player2_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 1) then 
							Receiving_Hand <= "001";    -- "001" card goes to Player 2's hand --       
					        	enable <= '1';

						elsif ( Player2_Hand_Card_1 /= "0000" ) and ( Player3_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 2) then 
							Receiving_Hand <= "010";    -- "010" card goes to Player 3's hand --
					        	enable <= '1';

						elsif ( Player3_Hand_Card_1 /= "0000" ) and ( Player4_Hand_Card_1 = "0000" ) and ( unsigned(N_Players > 3) then 
							Receiving_Hand <= "011";    -- "011" card goes to Player 4's hand --
					        	enable <= '1';
						end if;

					elsif ( dealer_card_deal = '1' ) then   -- may be possible to funnel this in at the end of the above *if* statement as an optimization if needed -- 
						Receiving_Hand <= "100";    -- "100" card goes to Dealer's hand --  
					        enable <= '1';

					elsif ( second_card_deal = '1' ) then
						if ( Player1_Hand_Card_2 = "0000" ) then     
					        	Receiving_Hand <= "000";    -- "000" card goes to Player 1's hand --   				  
						 	new_card <= random_card;
					        	enable <= '1';
							
				       		elsif ( Player1_Hand_Card_2 /= "0000" ) and ( Player2_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "001";    -- "001" card goes to Player 2's hand --       
					        	enable <= '1';

						elsif ( Player2_Hand_Card_2 /= "0000" ) and ( Player3_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "010";    -- "010" card goes to Player 3's hand --
					        	enable <= '1';

						elsif ( Player3_Hand_Card_2 /= "0000" ) and ( Player4_Hand_Card_2 = "0000" ) then 
							Receiving_Hand <= "011";    -- "000" card goes to Player 4's hand --
					        	enable <= '1';
						end if;
							
					
			when pending_card_a =>
				request_card <= '1';
                                if ( random_card /= "0000" ) then
				        require_card <= '0';
					new_card <= random_card;
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
			        else
					require_card <= '1';
				end if;
				if ( require_card = '1' ) then
					new_state <= pending_card_b;
				else
					new_state <= game_resolution;
				end if;
            end case;
      end process;
end architecture;
