library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity game_cont_tb is
end entity game_cont_tb;

architecture behaviour of game_cont_tb is
   component game_cont
   		port(
   			clk	: in  std_logic;
   			reset	: in  std_logic;
   	
   			--Player_Turn	: in std_logic_vector (2 downto 0);
   	
   			button_select	: in  std_logic;  
   			button_left	: in  std_logic;					
   			button_right	: in  std_logic;
   	
   			Player1_Budget	: in  std_logic_vector (9 downto 0);	
   			Player2_Budget	: in  std_logic_vector (9 downto 0);
   			Player3_Budget	: in  std_logic_vector (9 downto 0);  
   			Player4_Budget	: in  std_logic_vector (9 downto 0);
   	
   			Player1_Bid	: in std_logic_vector (1 downto 0);		
   			Player2_Bid	: in std_logic_vector (1 downto 0);		
   			Player3_Bid	: in std_logic_vector (1 downto 0);		
   			Player4_Bid	: in std_logic_vector (1 downto 0);		
   
   			Player1_Insured : in std_logic;
   			Player2_Insured : in std_logic;
   			Player3_Insured : in std_logic;
   			Player4_Insured : in std_logic;
   
   			Player1_Doubled_Down : in std_logic;
   			Player2_Doubled_Down : in std_logic;
   			Player3_Doubled_Down : in std_logic;
   			Player4_Doubled_Down : in std_logic;
   	
   			Player1_Hand_Card_1	: in std_logic_vector (3 downto 0);	
   			Player1_Hand_Card_2	: in std_logic_vector (3 downto 0);
   			Player1_Hand_Card_3	: in std_logic_vector (3 downto 0);
   			Player1_Hand_Card_4	: in std_logic_vector (3 downto 0);
   			Player1_Hand_Card_5	: in std_logic_vector (3 downto 0);
   			Player1_Hand_Score	: in std_logic_vector (4 downto 0);     
   	
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
   	
   			Reserve_Hand_Card_1	: in std_logic_vector (3 downto 0);	
   			Reserve_Hand_Card_2	: in std_logic_vector (3 downto 0);
   			Reserve_Hand_Card_3	: in std_logic_vector (3 downto 0);
   			Reserve_Hand_Card_4	: in std_logic_vector (3 downto 0);
   			Reserve_Hand_Card_5	: in std_logic_vector (3 downto 0);
   			Reserve_Hand_Score	: in std_logic_vector (4 downto 0);
   	
   			random_card	: in  std_logic_vector (3 downto 0);	
   			request_card	: out std_logic;                         
   			new_card	: out std_logic_vector (3 downto 0);	
   	
   			cursor_position	: out std_logic_vector(2 downto 0);
   			current_screen_type : out std_logic_vector(1 downto 0);
   	 
   			hit_option		: out std_logic;
   			double_option		: out std_logic;
   			split_option		: out std_logic;
   			insurance_option	: out std_logic;
   			even_money_option	: out std_logic;
   	
   			Player1_Bid_New	: out std_logic_vector (1 downto 0);  		 
   			Player2_Bid_New	: out std_logic_vector (1 downto 0);
   			Player3_Bid_New	: out std_logic_vector (1 downto 0);
   			Player4_Bid_New	: out std_logic_vector (1 downto 0);
   
   			Player1_win_type : out std_logic_vector (2 downto 0);
   			Player2_win_type : out std_logic_vector (2 downto 0);
   			Player3_win_type : out std_logic_vector (2 downto 0);
   			Player4_win_type : out std_logic_vector (2 downto 0);
   	
   			Player_Turn_New	: out std_logic_vector (2 downto 0);  	 
   			Receiving_Hand	: out std_logic_vector (2 downto 0);  	  
   			
   			enable		: out std_logic;
   			bid_enable      : out std_logic;
   			Player1_Broke   : out std_logic;
   			Player2_Broke   : out std_logic;
   			Player3_Broke   : out std_logic;
   			Player4_Broke   : out std_logic;
   			
   			even_money	: out std_logic;
   			insurance	: out std_logic;
   			split		: out std_logic;
   			double		: out std_logic;
   	
   			round_end	: out std_logic;	     
   			global_reset	: out std_logic
   		);
   end component;
   signal clk	: std_logic;
   signal reset	: std_logic;
   --signal Player_Turn	: std_logic_vector (2 downto 0);
   signal button_select	: std_logic;
   signal button_left	: std_logic;
   signal button_right	: std_logic;
   signal Player1_Budget	: std_logic_vector (9 downto 0);
   signal Player2_Budget	: std_logic_vector (9 downto 0);
   signal Player3_Budget	: std_logic_vector (9 downto 0);
   signal Player4_Budget	: std_logic_vector (9 downto 0);
   signal Player1_Bid	: std_logic_vector (1 downto 0);
   signal Player2_Bid	: std_logic_vector (1 downto 0);
   signal Player3_Bid	: std_logic_vector (1 downto 0);
   signal Player4_Bid	: std_logic_vector (1 downto 0);
   signal Player1_Insured : std_logic;
   signal Player2_Insured : std_logic;
   signal Player3_Insured : std_logic;
   signal Player4_Insured : std_logic;
   signal Player1_Doubled_Down : std_logic;
   signal Player2_Doubled_Down : std_logic;
   signal Player3_Doubled_Down : std_logic;
   signal Player4_Doubled_Down : std_logic;
   signal Player1_Hand_Card_1	: std_logic_vector (3 downto 0);
   signal Player1_Hand_Card_2	: std_logic_vector (3 downto 0);
   signal Player1_Hand_Card_3	: std_logic_vector (3 downto 0);
   signal Player1_Hand_Card_4	: std_logic_vector (3 downto 0);
   signal Player1_Hand_Card_5	: std_logic_vector (3 downto 0);
   signal Player1_Hand_Score	: std_logic_vector (4 downto 0);
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
   signal random_card	: std_logic_vector (3 downto 0);
   signal request_card	: std_logic;
   signal new_card	: std_logic_vector (3 downto 0);
   signal cursor_position	: std_logic_vector(2 downto 0);
   signal current_screen_type : std_logic_vector(1 downto 0);
   signal hit_option		: std_logic;
   signal double_option		: std_logic;
   signal split_option		: std_logic;
   signal insurance_option	: std_logic;
   signal even_money_option	: std_logic;
   signal Player1_Bid_New	: std_logic_vector (1 downto 0);
   signal Player2_Bid_New	: std_logic_vector (1 downto 0);
   signal Player3_Bid_New	: std_logic_vector (1 downto 0);
   signal Player4_Bid_New	: std_logic_vector (1 downto 0);
   signal Player1_win_type : std_logic_vector (2 downto 0);
   signal Player2_win_type : std_logic_vector (2 downto 0);
   signal Player3_win_type : std_logic_vector (2 downto 0);
   signal Player4_win_type : std_logic_vector (2 downto 0);
   signal Player_Turn_New	: std_logic_vector (2 downto 0);
   signal Receiving_Hand	: std_logic_vector (2 downto 0);
   signal enable		: std_logic;
   signal bid_enable      : std_logic;
   signal Player1_Broke   : std_logic;
   signal Player2_Broke   : std_logic;
   signal Player3_Broke   : std_logic;
   signal Player4_Broke   : std_logic;
   signal even_money	: std_logic;
   signal insurance	: std_logic;
   signal split		: std_logic;
   signal double	: std_logic;
   signal round_end	: std_logic;
   signal global_reset	: std_logic;

	begin
   		test: game_cont port map (clk, reset, button_select, button_left, button_right, Player1_Budget, Player2_Budget, Player3_Budget, Player4_Budget, Player1_Bid, Player2_Bid, Player3_Bid, Player4_Bid, Player1_Insured, Player2_Insured, Player3_Insured, Player4_Insured, Player1_Doubled_Down, Player2_Doubled_Down, Player3_Doubled_Down, Player4_Doubled_Down, Player1_Hand_Card_1, Player1_Hand_Card_2, Player1_Hand_Card_3, Player1_Hand_Card_4, Player1_Hand_Card_5, Player1_Hand_Score, Player2_Hand_Card_1, Player2_Hand_Card_2, Player2_Hand_Card_3, Player2_Hand_Card_4, Player2_Hand_Card_5, Player2_Hand_Score, Player3_Hand_Card_1, Player3_Hand_Card_2, Player3_Hand_Card_3, Player3_Hand_Card_4, Player3_Hand_Card_5, Player3_Hand_Score, Player4_Hand_Card_1, Player4_Hand_Card_2, Player4_Hand_Card_3, Player4_Hand_Card_4, Player4_Hand_Card_5, Player4_Hand_Score, Dealer_Hand_Card_1, Dealer_Hand_Card_2, Dealer_Hand_Card_3, Dealer_Hand_Card_4, Dealer_Hand_Card_5, Dealer_Hand_Score, Reserve_Hand_Card_1, Reserve_Hand_Card_2, Reserve_Hand_Card_3, Reserve_Hand_Card_4, Reserve_Hand_Card_5, Reserve_Hand_Score, random_card, request_card, new_card, cursor_position, current_screen_type, hit_option, double_option, split_option, insurance_option, even_money_option, Player1_Bid_New, Player2_Bid_New, Player3_Bid_New, Player4_Bid_New, Player1_win_type, Player2_win_type, Player3_win_type, Player4_win_type, Player_Turn_New, Receiving_Hand, enable, bid_enable, Player1_Broke, Player2_Broke, Player3_Broke, Player4_Broke, even_money, insurance, split, double, round_end, global_reset);
		-- 40 ns = 25 MHz
	clk <=	
		'0' after 0 ns,
		'1' after 20 ns when clk /= '1' else '0' after 20 ns; -- 1 for 20, 60, 100 etc
	
	--   time range 	: action : desired behaviour : graph observation
	-- reset
	--    0	< t <   90	: reset on : everything null except reset : second clock the other components see a global_reset, third clock global_reset goes to zero
	--   90	< t <  230	: reset off : should remain on the start_screen: everything null
	-- button_select on start_screen
	--  230	< t <  430	: button_select on : should remain on the start_screen : only button_select and switch_select changes
	--  430	< t <  830	: button_select off : state moves to game-setup, recognizes player select and ends in game-action
-- removed action up top since start has changed


	--  testing continous menu navigation for 4 options; start 2 players
	-- button_right on choose_action number of players
	--  830	< t < 1230	: button_right on : no change on screen : switch_right on
	-- 1230	< t < 1630	: button_right off : cursor moves to 2 players : current_screen_position=010, switch_right off
	-- 1630	< t < 2030	: button_right on
	-- 2030	< t < 2430	: button_right off : cursor moves to 3 players : current_screen_position=011
	-- 2430	< t < 2830	: button_right on
	-- 2830	< t < 3230	: button_right off : cursor moves to 4 players : current_screen_position=100
	-- 3230	< t < 3630	: button_right on
	-- 3630	< t < 4030	: button_right off : cursor moves to 1 players : current_screen_position=001
	-- 4030	< t < 4430	: button_right on
	-- 4430	< t < 4830	: button_right off : cursor moves to 2 players : current_screen_position=010
	--  button_left on choose_action number of players
	-- 4830	< t < 5230	: button_left on : no change on screen : switch_left on
	-- 5230	< t < 5630	: button_left off : cursor moves to 1 players  : current_screen_position=001, switch_left off
	-- 5630	< t < 6030	: button_left on
	-- 6030	< t < 6430	: button_left off : cursor moves to 4 players  : current_screen_position=100
	-- 6430	< t < 6830	: button_left on
	-- 6830	< t < 7230	: button_left off : cursor moves to 3 players  : current_screen_position=011
	-- 7230	< t < 7630	: button_left on
	-- 7630	< t < 8030	: button_left off : cursor moves to 2 players  : current_screen_position=010
	--  button_select on choose_action number of players
	-- 8030	< t < 8430	: button_select on : no change on screen : switch_select on 
	-- 8430	< t < 8830	: button_select off : select single player game : new_state=game_resolution -> sets N_Players_New=2 , enable=1 , new_state=game_setup -> move to play_action bid screen
	-- 8100 < t < X N_players = 2
	--   bid selection 
	--    player 1 bids 20, higher than allowed by their test budget of 10
	-- button_left on choose_action player bid selection player 1
	--  8830 < t <  9230	: button_left on
	--  9230 < t <  9630	: button_left off : cursor moves to bid 20 : current_screen_position=100
	-- button_select on choose_action player bid selection player 1
	--  9630 < t < 10030	: button_select on
	-- 10030 < t < 10430	: button_select off : nothing should happen
	--    player 1 bids 2
	--  button_right on choose_action player bid selection player 1
	-- 10430 < t < 10830	: button_right on
	-- 10830 < t < 11230	: button_right off : cursor moves to bid 2 : current_screen_position=100
	--  button_select on choose_action player bid selection player 1
	-- 11230 < t < 11630	: button_select on
	-- 11630 < t < 12030	: button_select off : select bid 2 for player 1 : Player1_Bid_New="00", enable=1, bid_successful='1' -> new_state=game_setup -> N_Players_New=1 , enable=1 -> new_state=game_setup
	--    player 2 bids 6
	--  button_right on choose_action player bid selection player 2
	-- 12030 < t < 12430	: button_right on
	-- 12430 < t < 12830	: button_right off : cursor moves to bid 6
	--  button_select on choose_action player bid selection player 2
	-- 12830 < t < 13230	: button_select on
	-- 13230 < t < 13630	: button_select off : select bid 6 for player 2 : Player2_Bid_New="01", enable=1, bid_successful='1' -> new_state=game_setup

	--  drawing cards
	-- should be tested with Deck and memory
	-- drawing cards should fill all hands up to second card & one for dealer, and hand over turn to first player

	--  test without dealing phase
	-- player 1 blackjack, player 2 20, dealer 17.
	-- 13630 < t < 14030 : player 1 card 1, a 10.
	-- 14030 < t < 14430 : player 2 card 1, a K.
	-- 14430 < t < 14830 : dealer card 1, a Q.
	-- 15230 < t < 15630 : player 1 card 2, an A.
	-- 15630 < t < 16030 : player 2 card 2, a J.
	-- test if player 1 can only select hold.
	-- 16430 < t < 16830 : button_right on : no change on screen : switch_right on
	-- 17230	< t < 17630	: button_right off : cursor moves to hit : current_screen_position=010, switch_right off
	-- 17630	< t < 18030	: button_select on : no change on screen : switch_select on 
	-- 18030	< t < 18430	: button_select off : select hit not possible for blackjack, nothing should happen
	-- 18430 < t < 18830	: button_left on
	-- 18830 < t < 19230	: button_left off : cursor moves to hold : current_screen_position=001
	-- 19230	< t < 19630	: button_select on : no change on screen : switch_select on 
	-- 19630	< t < 20030	: button_select off : select hold, turn should go to player 2
	-- hold for player 2
	-- 20030 < t < 20430 : button select on : no change on screen : switch_select on 
	-- 20830	< t < 21230	: button_select off : select hold, turn should go to dealer
	-- 21230 < t < 21630 : dealer card 2, a 7.
	-- round end, select round end button
	-- 21630 < t < 22030 : button select on : no change on screen : switch_select on 
	-- 22430	< t < 22830	: button_select off : select round end, turn should go to bidding phase
	-- player 1 should now have 5 as budget (0000000101) and player 2 should have 12 (0000001100)


	-- interacting with the controller --
	reset <=
		'1' after 0 ns,
		'0' after 90 ns; -- reset two clock cycles: first clock set global reset, second clock the other components see a reset

	button_left <=
		'0' after 0 ns,
		-- player select --
		'1' after 4830 ns,
		'0' after 5230 ns,
		'1' after 5630 ns,
		'0' after 6030 ns,
		'1' after 6430 ns,
		'0' after 6830 ns,
		'1' after 7230 ns,
		'0' after 7630 ns,
		-- bid selection: round 1 player 1 --
		'1' after 8830 ns,
		'0' after 9230 ns,
		-- go from hit to hold p1
		'1' after 18430 ns,
		'0' after 18830 ns;

	button_right <=
		'0' after 0 ns,
		-- player select --
		'1' after 830 ns,
		'0' after 1230 ns,
		'1' after 1630 ns,
		'0' after 2030 ns,
		'1' after 2430 ns,
		'0' after 2830 ns,
		'1' after 3230 ns,
		'0' after 3630 ns,
		'1' after 4030 ns,
		'0' after 4430 ns,
		-- bid selection: round 1 player 1 --
		'1' after 10430 ns,
		'0' after 10830 ns,
		-- bid selection: round 1 player 2 --
		'1' after 12030 ns,
		'0' after 12430 ns,
		-- test if hit doesn work for blackjack
		'1' after 16430 ns,
		'0' after 16830 ns;

	button_select <=
		-- reset --
		'0' after 0 ns,

		-- player select --
		'1' after 8030 ns,
		'0' after 8230 ns,
		'1' after 8430 ns,
		'0' after 8630 ns,
		--'1' after 8600 ns,
		--'0' after 8650 ns,	 --needed for player 2 bid but thats not working rn anyway--
		-- bid selection: round 1 player 1 --
		'1' after 9630 ns,
		'0' after 10030 ns,
		'1' after 11230 ns,
		'0' after 11630 ns,
		-- bid selection: round 1 player 2 --
		'1' after 12830 ns,
		'0' after 13230 ns,
		-- test if hit doesn work for blackjack
		'1' after 17630 ns,
		'0' after 18030 ns,
		-- select hold p1
		'1' after 19230 ns,
		'0' after 19630 ns,
		-- selet hold p2,
		'1' after 20030 ns,
		'0' after 20830 ns,
		-- select round end
		'1' after 21630 ns,
		'0' after 22430 ns;
		

	-- emulate memory --	

	--N_Players <=
		--"000" after 0 ns,
		--"010" after 8100 ns;

	--Player_Turn <= "001" after 0 ns,
		       --"010" after 8100 ns;  --tried 8350 for supposed working version--

	Player1_Bid <=  "00" after 0 ns,
			"01" after 8460 ns;
		

	Player1_Hand_Card_1 <=	"0000" after 0 ns,
				"1010" after 13580 ns;

	Player1_Hand_Card_2 <=	"0000" after 0 ns,
				"0001" after 15180 ns;

	Player1_Hand_Card_3 <=	"0000" after 0 ns;

	Player1_Hand_Card_4 <=	"0000" after 0 ns;

	Player1_Hand_Card_5 <=	"0000" after 0 ns;

	Player1_Budget <=  "0000001010" after 0 ns;

	Player1_Hand_Score <=	"00000" after 0 ns,	
				"01010" after 13580 ns,
				"10011" after 15180 ns;		

	Player2_Hand_Card_1 <=	"0000" after 0 ns,
				"1101" after 13980 ns;

	Player2_Hand_Card_2 <=	"0000" after 0 ns,
				"1011" after 15580 ns;

	Player2_Hand_Card_3 <=	"0000" after 0 ns;

	Player2_Hand_Card_4 <=	"0000" after 0 ns;

	Player2_Hand_Card_5 <=	"0000" after 0 ns;

	Player2_Budget <=	"0000010100" after 0 ns;

	Player2_Hand_Score <= "00000" after 0 ns,
			      "01010" after 13980 ns,
			      "10010" after 15580 ns;

	Player2_Bid <=	"00" after 0 ns;
			
	

	Player3_Hand_Card_1 <=	"0000" after 0 ns;

	Player3_Hand_Card_2 <=	"0000" after 0 ns;

	Player3_Hand_Card_3 <=	"0000" after 0 ns;

	Player3_Hand_Card_4 <=	"0000" after 0 ns;

	Player3_Hand_Card_5 <=	"0000" after 0 ns;

	Player3_Budget <=	"0000000000" after 0 ns;

	Player3_Hand_Score <= "00000" after 0 ns;

	Player3_Bid <=	"00" after 0 ns;
	

	Player4_Hand_Card_1 <=	"0000" after 0 ns;

	Player4_Hand_Card_2 <=	"0000" after 0 ns;

	Player4_Hand_Card_3 <=	"0000" after 0 ns;

	Player4_Hand_Card_4 <=	"0000" after 0 ns;

	Player4_Hand_Card_5 <=	"0000" after 0 ns;

	Player4_Budget <=	"0000000000" after 0 ns;

	Player4_Hand_Score <= "00000" after 0 ns;

	Player4_Bid <=	"00" after 0 ns;
	

	Dealer_Hand_Card_1 <=	"0000" after 0 ns,
				"1100" after 14380 ns;

	Dealer_Hand_Card_2 <=	"0000" after 0 ns;

	Dealer_Hand_Card_3 <=	"0000" after 0 ns;

	Dealer_Hand_Card_4 <=	"0000" after 0 ns;

	Dealer_Hand_Card_5 <=	"0000" after 0 ns;

	Dealer_Hand_Score <= "00000" after 0 ns,
			     "00101" after 14380 ns;

	Reserve_Hand_Card_1 <=	"0000" after 0 ns;

	Reserve_Hand_Card_2 <=	"0000" after 0 ns;

	Reserve_Hand_Card_3 <=	"0000" after 0 ns;

	Reserve_Hand_Card_4 <=	"0000" after 0 ns;

	Reserve_Hand_Card_5 <=	"0000" after 0 ns;

	Reserve_Hand_Score <= "00000" after 0 ns;

	random_card <=	"0000" after 0 ns,
		 "1010" after 13500 ns,
		 "0000" after 13540 ns,
		 "1101" after 13900 ns,
		 "0000" after 13940 ns,
		 "1100" after 14300 ns,
		 "0000" after 14340 ns,
		 "0001" after 15100 ns,
		 "0000" after 15140 ns,
		 "1011" after 15500 ns,
		 "0000" after 15540 ns;

	Player1_Insured <= '0' after 0 ns;
	Player2_Insured <= '0' after 0 ns;
	Player3_Insured <= '0' after 0 ns;
	Player4_Insured <= '0' after 0 ns;

	Player1_Doubled_Down <= '0' after 0 ns;
	Player2_Doubled_Down <= '0' after 0 ns;
	Player3_Doubled_Down <= '0' after 0 ns;
	Player4_Doubled_Down <= '0' after 0 ns;

end behaviour;
   






