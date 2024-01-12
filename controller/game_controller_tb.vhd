library IEEE;
use IEEE.std_logic_1164.ALL;

entity game_controller_tb is
end entity game_controller_tb;

architecture behaviour of game_controller_tb is
	type controller_state is 
		(	
			reset_state,
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

	component game_controller_tb
		port(
			clk		: in  std_logic;
			reset	: in  std_logic;
	
			Player_Turn_In	: in std_logic_vector (2 downto 0);
			N_Players		: in std_logic_vector (2 downto 0);
	
			button_select	: in  std_logic;  
			button_left		: in  std_logic;						-- player inputs --
			button_right	: in  std_logic;
	
			Player1_Budget	: in  std_logic_vector (10 downto 0);	-- base budget is 100, score limit chosen as 1000 so 11 bits --
			Player2_Budget	: in  std_logic_vector (10 downto 0);
			Player3_Budget	: in  std_logic_vector (10 downto 0);  
			Player4_Budget	: in  std_logic_vector (10 downto 0);
	
			Player1_Bid	: in std_logic_vector (1 downto 0);		-- Bid and Budget required to determine if Insurance/Double are possible --
			Player2_Bid	: in std_logic_vector (1 downto 0);		-- Value of Initial Bid = 2,6,10,20 -> 00,01,10,11 (Internal signal Bid_Value) --
			Player3_Bid	: in std_logic_vector (1 downto 0);		-- Controller never needs the augmented value of Bid as Double/Insurance/Split --
			Player4_Bid	: in std_logic_vector (1 downto 0);		-- are Turn 1 actions (If Mem Controller does end-round calculations) --
	
			Player1_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Each card is a 4-bit vector --
			Player1_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player1_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player1_Hand_Score	: in std_logic_vector (5 downto 0);     -- Player can have 20 and draw a 10, so 30 points total possible --
	
			Player2_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player2_Hand_Card_4	: in std_logic_vector (3 downto 0);   
			Player2_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player2_Hand_Score	: in std_logic_vector (5 downto 0);
	
			Player3_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_3	: in std_logic_vector (3 downto 0);   
			Player3_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player3_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player3_Hand_Score	: in std_logic_vector (5 downto 0);
	
			Player4_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Player4_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Player4_Hand_Score	: in std_logic_vector (5 downto 0);
	
			Dealer_Hand_Card_1	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Dealer_Hand_Score	: in std_logic_vector (5 downto 0);
	
			Reserve_Hand_Card_1	: in std_logic_vector (3 downto 0);	-- Reserve hand for Split. Only one player can split (low chance of multiple splits) --
			Reserve_Hand_Card_2	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_3	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_4	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Card_5	: in std_logic_vector (3 downto 0);
			Reserve_Hand_Score	: in std_logic_vector (5 downto 0);
	
			random_card		: in  std_logic_vector (3 downto 0);	-- Comms with RNG --
			request_card	: out std_logic;                         
			new_card		: out std_logic_vector (3 downto 0);	-- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --
	
			draw_screen		: out std_logic_vector(2 downto 0);  
			cursor_position	: out std_logic_vector(2 downto 0);
	
			hold_option			: out std_logic;     
			hit_option			: out std_logic;
			double_option		: out std_logic;
			split_option		: out std_logic;
			insurance_option	: out std_logic;
			even_money_option	: out std_logic;
	
			Player1_Budget_New	: out  std_logic_vector (10 downto 0);	-- base budget is 100, score limit chosen as 1000 so 11 bits --
			Player2_Budget_New	: out  std_logic_vector (10 downto 0);
			Player3_Budget_New	: out  std_logic_vector (10 downto 0);  
			Player4_Budget_New	: out  std_logic_vector (10 downto 0);
	
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
	
			round_end		: out std_logic;	     
			global_reset	: out std_logic
		);
	end component;

	-- in --
	signal clk		: std_logic;
	signal reset	: std_logic;

	signal Player_Turn_In	: std_logic_vector (2 downto 0);
	signal N_Players		: std_logic_vector (2 downto 0);

	signal button_select	: std_logic;
	signal button_left		: std_logic;
	signal button_right		: std_logic;

	signal Player1_Budget	: std_logic_vector (10 downto 0);	-- base budget is 100, score limit chosen as 1000 --
	signal Player2_Budget	: std_logic_vector (10 downto 0);
	signal Player3_Budget	: std_logic_vector (10 downto 0);  
	signal Player4_Budget	: std_logic_vector (10 downto 0);

	signal Player1_Bid	: std_logic_vector (1 downto 0);		-- Bid and Budget required to determine if Insurance/Double are possible --
	signal Player2_Bid	: std_logic_vector (1 downto 0);		-- Value of Initial Bid = 2,6,10,20 -> 00,01,10,11 (Internal signal Bid_Value) --
	signal Player3_Bid	: std_logic_vector (1 downto 0);		-- Controller never needs the augmented value of Bid as Double/Insurance/Split --
	signal Player4_Bid	: std_logic_vector (1 downto 0);		-- are Turn 1 actions (If Mem Controller does end-round calculations) --

	signal Player1_Hand_Card_1	: std_logic_vector (3 downto 0);	-- Each card is a 4-bit vector --
	signal Player1_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player1_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Player1_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Player1_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player1_Hand_Score	: std_logic_vector (5 downto 0);	-- Player can have 20 and draw a 10, so 30 points total possible --

	signal Player2_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_4	: std_logic_vector (3 downto 0);   
	signal Player2_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Score	: std_logic_vector (5 downto 0);

	signal Player3_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_3	: std_logic_vector (3 downto 0);   
	signal Player3_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Score	: std_logic_vector (5 downto 0);

	signal Player4_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Score	: std_logic_vector (5 downto 0);

	signal Dealer_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Score	: std_logic_vector (5 downto 0);

	signal Reserve_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Score	: std_logic_vector (5 downto 0);

	signal random_card	: std_logic_vector (3 downto 0);	-- Comms with RNG --

	-- out --
	signal request_card	: std_logic;                         
	signal new_card		: std_logic_vector (3 downto 0);	-- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --

	signal draw_screen		: std_logic_vector(2 downto 0);  
	signal cursor_position	: std_logic_vector(2 downto 0);

	signal hold_option			: std_logic;     
	signal hit_option			: std_logic;
	signal double_option		: std_logic;
	signal split_option			: std_logic;
	signal insurance_option		: std_logic;
	signal even_money_option	: std_logic;

	signal Player1_Budget_New	: std_logic_vector (10 downto 0);	-- base budget is 100, score limit chosen as 1000 so 11 bits --
	signal Player2_Budget_New	: std_logic_vector (10 downto 0);
	signal Player3_Budget_New	: std_logic_vector (10 downto 0);  
	signal Player4_Budget_New	: std_logic_vector (10 downto 0);

	signal Player1_Bid_New	: std_logic_vector (1 downto 0);  		 -- 2,6,10,20 = 4 options so 2 bits --
	signal Player2_Bid_New	: std_logic_vector (1 downto 0);
	signal Player3_Bid_New	: std_logic_vector (1 downto 0);
	signal Player4_Bid_New	: std_logic_vector (1 downto 0);

	signal Player_Turn_New	: std_logic_vector (2 downto 0);  	 -- outputs -> mem based on actions --
	signal N_Players_New	: std_logic_vector (2 downto 0);
	signal Receiving_Hand	: std_logic_vector (2 downto 0);  	 -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--

	signal enable		: std_logic;
	signal even_money	: std_logic;
	signal insurance	: std_logic;
	signal split		: std_logic;
	signal double		: std_logic;

	signal round_end	: std_logic;	     
	signal global_reset	: std_logic;

	-- internal --
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

	signal current_screen_position : std_logic_vector(2 downto 0);

begin
   	-- 40 ns = 25 MHz
	clk <=	'0' after 0 ns,
		'1' after 20 ns when clk /= '1' else '0' after 20 ns; -- 1 for 20, 60, 100 etc
	
	-- test bench --
	--   time range 	: action: desired behaviour: graph observation
	-- 0	< t < 120	: turn on with reset held for two clock cycles: everything null
	-- 120	< t < 240	: let loose of reset: should remain on the start screen: everything null except reset
	-- 240	< t < 360	: press button_select: should remain on the start screen: 
	-- 240	< t < 360	: let go of button_select: state moves to game setup
	-- 360	< t < 400	: select a player number: game setup recognizes player select, screen_select=player_select, screen_position=4 move to game setup
	-- 480	< t < 600	: select a player number: move the cursor down to select a two player game: cursor should not yet move current_screen_position
	-- 480	< t < 600	: select a player number: let go of button: cursor moves current_screen_position to 2 within one clock and state changes to user_input
	-- 480	< t < 600	: select a player number: move the cursor up to select a single player game
	-- 480	< t < 600	: select a player number: let go of button: cursor moves current_screen_position to 1 within one clock
	-- 480	< t < 600	: select a player number: press select
	-- 480	< t < 600	: select a player number: let go of button: state changes to game resolution
	-- 480	< t < 600	: select a player number: let go of button: resolution enables memory save to store N-player and moves to game setup
	-- 480	< t < 600	: select a player bid: game setup recognizes player bid menu and selects screen_out bid-selection and moves to user input
	-- 480	< t < 600	: select a player bid: game setup recognizes player bid menu and selects screen_out bid-selection and moves to user input

	-- interactions with the controller --
	reset <=	'1' after 0 ns,
	   		'0' after 80 ns,
	   		'1' after 720 ns, -- test if the reset works
	   		'0' after 780 ns;

	Player_Turn_In <=	'0' after 0 ns;

	N_Players <=	'0' after 0 ns;

	button_select <=	'0' after 0 ns;

	button_left <=	'0' after 0 ns;

	button_right <=	'0' after 0 ns;

	random_card <=	'0' after 0 ns;

	-- emulate memory --
	Player1_Budget <=	'0' after 0 ns;
	Player2_Budget <=	'0' after 0 ns;
	Player3_Budget <=	'0' after 0 ns;
	Player4_Budget <=	'0' after 0 ns;

	Player1_Bid <=	'0' after 0 ns;
	Player2_Bid <=	'0' after 0 ns;
	Player3_Bid <=	'0' after 0 ns;
	Player4_Bid <=	'0' after 0 ns;

	Player1_Hand_Card_1 <=	'0' after 0 ns;
end behaviour;
