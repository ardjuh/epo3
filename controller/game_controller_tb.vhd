library IEEE;
use IEEE.std_logic_1164.ALL;

entity game_controller_tb is
end entity game_controller_tb;

architecture behaviour of game_controller_tb is

	component game_controller is
		port(
			clk	: in  std_logic;
			reset	: in  std_logic;
	
			Player_Turn	: in std_logic_vector (2 downto 0);
			N_Players	: in std_logic_vector (2 downto 0);
	
			button_select	: in  std_logic;  
			button_left	: in  std_logic;						-- player inputs --
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
	
			draw_screen	: out std_logic_vector(2 downto 0);  
			cursor_position	: out std_logic_vector(2 downto 0);
	
			hold_option		: out std_logic;     
			hit_option		: out std_logic;
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
	
			round_end	: out std_logic;	     
			global_reset	: out std_logic
		);
	end component;

	-- in --
	signal clk	: std_logic;
	signal reset	: std_logic;

	signal Player_Turn	: std_logic_vector (2 downto 0);
	signal N_Players	: std_logic_vector (2 downto 0);

	signal button_select	: std_logic;
	signal button_left	: std_logic;
	signal button_right	: std_logic;

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
	signal Player1_Hand_Score	: std_logic_vector (4 downto 0);	-- Player can have 20 and draw a 10, so 30 points total possible --

	signal Player2_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Card_4	: std_logic_vector (3 downto 0);   
	signal Player2_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player2_Hand_Score	: std_logic_vector (4 downto 0);

	signal Player3_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_3	: std_logic_vector (3 downto 0);   
	signal Player3_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player3_Hand_Score	: std_logic_vector (4 downto 0);

	signal Player4_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Player4_Hand_Score	: std_logic_vector (4 downto 0);

	signal Dealer_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Dealer_Hand_Score	: std_logic_vector (4 downto 0);

	signal Reserve_Hand_Card_1	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_2	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_3	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_4	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Card_5	: std_logic_vector (3 downto 0);
	signal Reserve_Hand_Score	: std_logic_vector (4 downto 0);

	signal random_card	: std_logic_vector (3 downto 0);	-- Comms with RNG --

	-- out (test bench assigns to input because of missing components) --
	signal new_card		: std_logic_vector (3 downto 0);	-- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --

	signal Player1_Budget_New	: std_logic_vector (10 downto 0);	-- base budget is 100, score limit chosen as 1000 so 11 bits --
	signal Player2_Budget_New	: std_logic_vector (10 downto 0);
	signal Player3_Budget_New	: std_logic_vector (10 downto 0);  
	signal Player4_Budget_New	: std_logic_vector (10 downto 0);

	signal Player1_Bid_New	: std_logic_vector (1 downto 0);	-- 2,6,10,20 = 4 options so 2 bits --
	signal Player2_Bid_New	: std_logic_vector (1 downto 0);
	signal Player3_Bid_New	: std_logic_vector (1 downto 0);
	signal Player4_Bid_New	: std_logic_vector (1 downto 0);

	signal Player_Turn_New	: std_logic_vector (2 downto 0);  	 -- outputs -> mem based on actions --
	signal N_Players_New	: std_logic_vector (2 downto 0);

	signal global_reset	: std_logic;

	-- out (only to inspect)
	signal draw_screen		: std_logic_vector(2 downto 0);  
	signal cursor_position	: std_logic_vector(2 downto 0);

	signal request_card	: std_logic;

	signal hold_option			: std_logic;     
	signal hit_option			: std_logic;
	signal double_option		: std_logic;
	signal split_option			: std_logic;
	signal insurance_option		: std_logic;
	signal even_money_option	: std_logic;

	signal enable		: std_logic;
	signal even_money	: std_logic;
	signal insurance	: std_logic;
	signal split		: std_logic;
	signal double		: std_logic;

	signal Receiving_Hand	: std_logic_vector (2 downto 0);  	 -- pointer to which hand the new card is added to (3 bits for 1, 2, 3, 4, dealer, reserve--

	signal round_end	: std_logic;

	-- internal (only to inspects) --
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
	clk <=	
		'0' after 0 ns,
		'1' after 20 ns when clk /= '1' else '0' after 20 ns; -- 1 for 20, 60, 100 etc
	
	--   time range 	: action : desired behaviour : graph observation
	-- reset
	--   0	< t <   90	: reset on : everything null except reset : second clock the other components see a global_reset, third clock global_reset goes to zero
	--  90	< t <  230	: reset off : should remain on the start_screen: everything null
	-- button_select on start_screen
	--  230	< t <  430	: button_select on : should remain on the start_screen : only button_select and switch_select changes
	--  430	< t <  630	: button_select off : state moves to game-setup, recognizes player select and ends in game-action

	--  testing continous menu navigation for 4 options 
	-- button_right on choose_action number of players
	--  630	< t <  830	: button_right on : no change on screen : switch_right on
	--  830	< t < 1030	: button_right off : cursor moves to 2 players  : current_screen_position changes, switch_right off, new_state player-action
	-- 1030	< t < 1230	: button_right on : no change on screen : switch_right on
	-- 1230	< t < 1430	: button_right off : cursor moves to 3 players  : current_screen_position changes, switch_right off, new_state player-action
	-- 1430	< t < 1630	: button_right on : no change on screen : switch_right on
	-- 1630	< t < 1830	: button_right off : cursor moves to 4 players  : current_screen_position changes, switch_right off, new_state player-action
	-- 1830	< t < 2030	: button_right on : no change on screen : switch_right on
	-- 2030	< t < 2230	: button_right off : cursor moves to 1 players  : current_screen_position changes, switch_right off, new_state player-action
	-- 2230	< t < 2430	: button_right on : no change on screen : switch_right on
	-- 2430	< t < 2630	: button_right off : cursor moves to 2 players  : current_screen_position changes, switch_right off, new_state player-action
	--  button_left on choose_action number of players
	-- 2630	< t < 2830	: button_left on : no change on screen : switch_left on
	-- 2830	< t < 3030	: button_left off : cursor moves to 1 players  : current_screen_position changes, switch_left off, new_state player-action
	-- 3030	< t < 3230	: button_left on : no change on screen : switch_left on
	-- 3230	< t < 3430	: button_left off : cursor moves to 4 players  : current_screen_position changes, switch_left off, new_state player-action
	-- 3430	< t < 3630	: button_left on : no change on screen : switch_left on
	-- 3630	< t < 3830	: button_left off : cursor moves to 3 players  : current_screen_position changes, switch_left off, new_state player-action
	-- 3830	< t < 4030	: button_left on : no change on screen : switch_left on
	-- 4030	< t < 4230	: button_left off : cursor moves to 2 players  : current_screen_position changes, switch_left off, new_state player-action
	-- 4230	< t < 4430	: button_left on : no change on screen : switch_left on
	-- 4430	< t < 4630	: button_left off : cursor moves to 1 players  : current_screen_position changes, switch_left off, new_state player_action
	--  button_select on choose_action number of players
	-- 4630	< t < 4830	: button_select on : no change on screen : switch_select on 
	-- 4830	< t < 5030	: button_select off : select single player game : new_state=game_resolution -> sets N_Players_New=1 , enable=1 , new_state=game_setup -> move to play_action bid screen
	
	--  button_left on choose_action player bid selection
	-- 5030	< t < 5230	: button_left on : no change on screen : switch_left on
	-- 5230	< t < 5430	: button_left off : cursor moves to 1 players
	--  button_select on choose_action player bid selection
	-- 5430	< t < 5630	: button_select on : no change on screen : switch_select on 
	-- 5630	< t < 5830	: button_select off : select single player game : new_state=game_resolution -> sets N_Players_New=1 , enable=1 , new_state=game_setup -> move drawing cards

	--  drawing cards
	-- should be tested with Deck



	-- interacting with the controller --
	reset <=
		'1' after 0 ns,
		'0' after 90 ns; -- reset two clock cycles: first clock set global reset, second clock the other components see a reset

	button_select <=
		-- reset --
		'0' after 0 ns,
		'1' after 230 ns,
		'0' after 430 ns,
		-- player select --
		'1' after 4630 ns,
		'0' after 4830 ns,
		-- bid selection --
		'1' after 5430 ns,
		'0' after 5630 ns;

	button_right <=
		'0' after 0 ns,
		-- player select --
		'1' after 630 ns,
		'0' after 830 ns,
		'1' after 1030 ns,
		'0' after 1230 ns,
		'1' after 1430 ns,
		'0' after 1630 ns,
		'1' after 1830 ns,
		'0' after 2030 ns,
		'1' after 2230 ns,
		'0' after 2430 ns;

	button_left <=
		'0' after 0 ns,
		-- player select --
		'1' after 2630 ns,
		'0' after 2830 ns,
		'1' after 3030 ns,
		'0' after 3230 ns,
		'1' after 3430 ns,
		'0' after 3630 ns,
		'1' after 3830 ns,
		'0' after 4030 ns,
		'1' after 4230 ns,
		'0' after 4430 ns,
		-- bid selection --
		'1' after 5030 ns,
		'0' after 5230 ns;



	random_card <=	"0000" after 0 ns;

	-- emulate memory --
	Player_Turn_In <=
		"000" after 0 ns,
		Player_Turn_New after 230 ns;

	N_Players <=
		"000" after 0 ns,
		N_Players_New after 230 ns;

	Player1_Hand_Card_1 <=	"0000" after 0 ns;
	Player1_Hand_Card_2 <=	"0000" after 0 ns;
	Player1_Hand_Card_3 <=	"0000" after 0 ns;
	Player1_Hand_Card_4 <=	"0000" after 0 ns;
	Player1_Hand_Card_5 <=	"0000" after 0 ns;
	Player1_Budget <=	"00000000000" after 0 ns;
	Player1_Hand_Score <= "000000" after 0 ns;
	Player1_Bid <=	"00" after 0 ns;

	Player2_Hand_Card_1 <=	"0000" after 0 ns;
	Player2_Hand_Card_2 <=	"0000" after 0 ns;
	Player2_Hand_Card_3 <=	"0000" after 0 ns;
	Player2_Hand_Card_4 <=	"0000" after 0 ns;
	Player2_Hand_Card_5 <=	"0000" after 0 ns;
	Player2_Budget <=	"00000000000" after 0 ns;
	Player2_Hand_Score <= "000000" after 0 ns;
	Player2_Bid <=	"00" after 0 ns;

	Player3_Hand_Card_1 <=	"0000" after 0 ns;
	Player3_Hand_Card_2 <=	"0000" after 0 ns;
	Player3_Hand_Card_3 <=	"0000" after 0 ns;
	Player3_Hand_Card_4 <=	"0000" after 0 ns;
	Player3_Hand_Card_5 <=	"0000" after 0 ns;
	Player3_Budget <=	"00000000000" after 0 ns;
	Player3_Hand_Score <= "000000" after 0 ns;
	Player3_Bid <=	"00" after 0 ns;

	Player4_Hand_Card_1 <=	"0000" after 0 ns;
	Player4_Hand_Card_2 <=	"0000" after 0 ns;
	Player4_Hand_Card_3 <=	"0000" after 0 ns;
	Player4_Hand_Card_4 <=	"0000" after 0 ns;
	Player4_Hand_Card_5 <=	"0000" after 0 ns;
	Player4_Budget <=	"00000000000" after 0 ns;
	Player4_Hand_Score <= "000000" after 0 ns;
	Player4_Bid <=	"00" after 0 ns;

	Dealer_Hand_Card_1 <=	"0000" after 0 ns;
	Dealer_Hand_Card_2 <=	"0000" after 0 ns;
	Dealer_Hand_Card_3 <=	"0000" after 0 ns;
	Dealer_Hand_Card_4 <=	"0000" after 0 ns;
	Dealer_Hand_Card_5 <=	"0000" after 0 ns;
	Dealer_Hand_Score <= "000000" after 0 ns;

	Reserve_Hand_Card_1 <=	"0000" after 0 ns;
	Reserve_Hand_Card_2 <=	"0000" after 0 ns;
	Reserve_Hand_Card_3 <=	"0000" after 0 ns;
	Reserve_Hand_Card_4 <=	"0000" after 0 ns;
	Reserve_Hand_Card_5 <=	"0000" after 0 ns;
	Reserve_Hand_Score <= "000000" after 0 ns;


end behaviour;
