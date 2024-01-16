library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity blackjack is
	    port(clk    : in std_logic;
	         reset  : in std_logic;
	         switch_select : in std_logic; -- controller
	         switch_left   : in std_logic; -- controller
	         switch_right  : in std_logic; -- controller
	         red    : out std_logic_vector(3 downto 0);
	         green  : out std_logic_vector(3 downto 0);
	         blue   : out std_logic_vector(3 downto 0);
	         H_sync : out std_logic;
	         V_sync : out std_logic;

end blackjack;

architecture behavioral of blackjack is

component vga_driver_combined
    port(       clk : in std_logic;
	        reset: in std_logic;
	        x_pos: out std_logic_vector (9 downto 0);
	        y_pos: out std_logic_vector (9 downto 0);
	        H_sync: out std_logic;
	        V_sync: out std_logic);
end component;

component top_entity_rcm
    port(	clk : in std_logic;
	 	reset : in std_logic;
	 	request_card : in std_logic;
	 	round_end : in std_logic;
	 	random_card : out std_logic_vector(3 downto 0));

component gpu_driver
    port(	h_pos : in std_logic_vector(9 downto 0);
	        v_pos : in std_logic_vector(9 downto 0);
	        red   : out std_logic_vector(3 downto 0);
	        green : out std_logic_vector(3 downto 0);
	        blue  : out std_logic_vector(3 downto 0);
	
	        player : in std_logic_vector (1 downto 0);
	
	        player_a : in std_logic;
	        card1_1  : in std_logic_vector (3 downto 0);
	        card1_2  : in std_logic_vector (3 downto 0);
	        card1_3  : in std_logic_vector (3 downto 0);
	        card1_4  : in std_logic_vector (3 downto 0);
	        card1_5  : in std_logic_vector (3 downto 0);
	        money1   : in std_logic_vector (10 downto 0);
	        split1   : in std_logic;
	
	        player_b : in std_logic;
	        card2_1  : in std_logic_vector (3 downto 0);
	        card2_2  : in std_logic_vector (3 downto 0);
	        card2_3  : in std_logic_vector (3 downto 0);
	        card2_4  : in std_logic_vector (3 downto 0);
	        card2_5  : in std_logic_vector (3 downto 0);
	        money2   : in std_logic_vector (10 downto 0);
	        split2   : in std_logic;
	
	        player_c : in std_logic;
	        card3_1  : in std_logic_vector (3 downto 0);
	        card3_2  : in std_logic_vector (3 downto 0);
	        card3_3  : in std_logic_vector (3 downto 0);
	        card3_4  : in std_logic_vector (3 downto 0);
	        card3_5  : in std_logic_vector (3 downto 0);
	        money3   : in std_logic_vector (10 downto 0);
	        split3   : in std_logic;
	
	        player_d : in std_logic;
	        card4_1  : in std_logic_vector (3 downto 0);
	        card4_2  : in std_logic_vector (3 downto 0);
	        card4_3  : in std_logic_vector (3 downto 0);
	        card4_4  : in std_logic_vector (3 downto 0);
	        card4_5  : in std_logic_vector (3 downto 0);
	        money4   : in std_logic_vector (10 downto 0);
	        split4   : in std_logic
	    );     
       
component controller
    port( 	clk  : in std_logic;
          	reset: in std_logic;
                Player_Turn_In  : in std_logic_vector (2 downto 0);
         	N_players       : in std_logic_vector (2 downto 0);
          	switch_select	: in  std_logic;  
	        switch_left	: in  std_logic;					
	        switch_right	: in  std_logic;

        	Player1_Budget	: in  std_logic_vector (10 downto 0);	
        	Player2_Budget	: in  std_logic_vector (10 downto 0);
        	Player3_Budget	: in  std_logic_vector (10 downto 0);  
        	Player4_Budget	: in  std_logic_vector (10 downto 0);
        
        	Player1_Bid	: in std_logic_vector (1 downto 0);		
        	Player2_Bid	: in std_logic_vector (1 downto 0);		
        	Player3_Bid	: in std_logic_vector (1 downto 0);		
        	Player4_Bid	: in std_logic_vector (1 downto 0);		
        
        	Player1_Hand_Card_1	: in std_logic_vector (3 downto 0);	
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
        
        	random_card  : in  std_logic_vector (3 downto 0);		-- Comms with RNG --
        	request_card : out std_logic;                         
        	round_end    : out std_logic;
        	new_card     : out std_logic_vector (3 downto 0);   -- Mem Controller determines where the new card goes from Receiving Hand and Hand Cards --
        
        	draw_menu    : out std_logic_vector (? downto 0);		-- Comms with Graphics Driver --
        	menu_ready   : in std_logic;
        
        	Player1_Budget_New  : out  std_logic_vector (10 downto 0);-- base budget is 100, score limit chosen as 1000 so 10 bits --
        	Player2_Budget_New  : out  std_logic_vector (10 downto 0);
        	Player3_Budget_New  : out  std_logic_vector (10 downto 0);  
        	Player4_Budget_New  : out  std_logic_vector (10 downto 0);
        
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
        	hit 	   : out std_logic;
        	hold 	   : out std_logic;
        	);
end component;
		 
         
component memory 
  port   (
		clk       : in std_logic;
	        rst       : in std_logic;
	        enable    : in std_logic;
	        player_in : in std_logic_vector(2 downto 0);
	
	        insurance  : in std_logic;
	        doubledown : in std_logic;
	        win_type   : in std_logic_vector(2 downto 0); -- 0: niet gewonnen, 1: insurance, 2: double down, 3: blackjack, 4 : normal
	        split      : in std_logic;
	
	        player_a_in : in std_logic;
	        money1_in   : in std_logic_vector(9 downto 0);
	        bid1_in     : in std_logic_vector(1 downto 0);
	
	        player_b_in : in std_logic;
	        money2_in   : in std_logic_vector(9 downto 0);
	        bid2_in     : in std_logic_vector(1 downto 0);
	
	        player_c_in : in std_logic;
	        money3_in   : in std_logic_vector(9 downto 0);
	        bid3_in     : in std_logic_vector(1 downto 0);
	
	        player_d_in : in std_logic;
	        money4_in   : in std_logic_vector(9 downto 0);
	        bid4_in     : in std_logic_vector(1 downto 0);
	
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
	    
end component;
		 
	signal bid1_signal, bid1_signal_new, bid2_signal, bid2_signal_new, bid3_signal, bid3_signal_new, bid4_signal, bid4_signal_new : std_logic_vector(1 downto 0); --bids per player
	signal card1_1_signal, card1_2_signal, card1_3signal, card1_4_sigal, card1_5_signal, card2_1_signal, card2_2_signal, card2_3_signal, card2_4_signal, card2_5_signal, card3_1_signal, card3_2_signal, card3_3_signal, card3_4_signal, card3_5_signal, card4_1_signal, card4_2_signal, card4_3_signal, card4_4_signal, card4_5_signal, card5_1_signal, card5_2_signal, card5_3_signal, card5_4_signal, card5_5_signal, card6_1_signal, card6_2_signal, card6_3_signal, card6_4_signal, card6_5_signal : std_logic_vector(3 downto 0); -- hand cards of players including dealers hand
	signal money1_signal, money1_signal_new, money2_signal, money2_signal_new money3_signal, money3_signal_new, moneyd4_signal, money4_signal_new : std_logic_vector(10 downto 0); -- money of all 4 players
	signal split1_signal, split2_signal, split3_signal, split4_signal : std_logic;	 -- high if a player splits, low if a player does not split
	signal insurance1_signal, insurance2_signal, insurance3_signal, insurance4_signal- : std_logic; -- if a players chooses insurance
	signal double1, double2, double3, double4 : std_logic;
	signal player_current_signal, player_signal_new : std_logic_vector(2 downto 0); -- number of players
	signal player_turn_in_signal, player_turn_new_signal : std_logic_vector(2 downto 0); -- which player is at turn
	signal player_a_in_signal, player_b_in_signal, player_c_in_signal, player_d_in_signal : std_logic;-- the different players
	signal player_a_out_signal, player_b_out_signal, player_c_out_signal, player_d_out_signal : std_logic;
	signal select_signal, left_signal, right_signal,  H_sync_signal, V_sync_signal : std_logic;  -- gamepad inputs controller and sync signals vga driver
	signal x_pos_signal, y_pos_signal : std_logic_vector(9 downto 0); -- current horizontal and vertical pixel position
	signal red_signal, green_signal, blue_signal : std_logic_vector(3 downto 0); -- rgb signals
	signal random_card_signal, new_card_signal : std_logic_vector (3 downto 0); -- rcm and new card
	signal request_card_signal, round_end_signal : std_logic; 
	signal hit_option_signal, double_option_signal, split_option_signal, insurance_option_signal, even_money_option_signal : std_logic; -- if option should be selectable
	signal enable_signal : std_logic;
	signal double_signal, split_signal, insurance_signal, even_money_signal : std_logic; 
	signal draw_screen_signal : std_logic_vector(1 downto 0);
	signal cursor_position_signal: std_logic_vector(2 downto 0);
	signal win_type_signal : std_logic_vector(2 downto 0);  -- 0: niet gewonnen, 1: insurance, 2: double down, 3: blackjack, 4 : normal
	signal player1_score, player2_score, player3_score, player4_score, dealer_score, split_score : std_logic_vector (4 downto 0);
begin
	p1: memory 	port map(clk => clk, rst => reset, 
				enable => enable_signal, -- from controller
				player_in => player_signal_new, -- comes from controller, number of players
				insurance => insurance_signal, -- from controller
				doubledown => double_signal, -- from controller
				win_type => win_type_signal, -- mem ontvangt van controller
				split => split_signal, -- from controller
				player_a_in => player_a_in_signal, player_b_in=> player_b_in_signal, player_c_in => player_c_in_signal, player_d_in => player_d_in_signal, -- van waar komt dit?
				money1_in => money1_singal_new, money2_in => money2_signal_new, money3_in => money3_signal_new, money4_in => money4_signal_new,  -- from controller to mem
				bid1_in => bid1_signal_new, bid2_in => bid2_signal_new, bid3_in => bid3_signal_new, bid4_in => bid4_signal_new, -- from controller to mem

				player_out => player_current_signal, -- goes to controller, number of players 
				 
				player_a_out => player_a_out_signal, player_b_out=> player_b_out_signal, player_c_out => player_c_out_signal, player_d_out => player_d_out_signal, -- to gpu
				money1_out => money1_signal, money2_out => money2_signal, money3_out => money3_signal, money4_out => money4_signal, -- goes to controller and gpu
				bid1_out => bid1_signal, bid2_out => bid2_signal, bid3_out => bid3_signal, bid4_out => bid4_signal, -- goes to controller and gpu
				split1_out => split1_signal, split2_out => split2_signal, split3_out => split3_signal, split4_out => split4_signal, -- only goes to gpu
				insurance1_out => insurance1_signal, insurance2_out => insurance2_signal, insurance3_out => insurance3_signal, insurance4_out => insurance4_signal, -- only goes to gpu
				doubledown1_out => double1, doubledown2_out => double2 => doubledown3_out => double3, doubledown4_out => double4, -- only goes to gpu
				score1_out => player1_score, score2_out => player2_score, score3_out => player3_score, score4_out => player4_score, score5_out => dealer_score, score6_out => split_score, -- goes to controller

			    	card1_1_out => card1_1_signal, card1_2_out => card1_2_signal, card1_3_out => card1_3_signal, card1_4_out => card1_4_signal, card1_5_out => card1_5_signal,
			    	card2_1_out => card2_1_signal, card2_2_out => card2_2_signal, card2_3_out => card2_3_signal, card2_4_out => card2_4_signal, card2_5_out => card2_5_signal,
			    	card3_1_out => card3_1_signal, card3_2_out => card3_2_signal, card3_3_out => card3_3_signal, card3_4_out => card3_4_signal, card3_5_out => card3_5_signal,
			    	card4_1_out => card4_1_signal, card4_2_out => card4_2_signal, card4_3_out => card4_3_signal, card4_4_out => card4_4_signal, card4_5_out => card4_5_signal,
			    	card5_1_out => card5_1_signal, card5_2_out => card5_2_signal, card5_3_out => card5_3_signal, card5_4_out => card5_4_signal, card5_5_out => card5_5_signal,
				card6_1_out => card6_1_signal, card6_2_out => card6_2_signal, card6_3_out => card6_3_signal, card6_4_out => card6_4_signal, card6_5_out => card6_5_signal,
				

	p2: controller 	port map(clk => clk, reset => reset, 
				 
				Player_Turn_In => player_turn_in_signal, 
				N_Players => player_signal,
				 
				switch_select => select_signal, switch_left => left_signal, switch_right => right_signal,

				Player1_Budget => money1_signal, Player2_Budget => money2_signal, Player3_Budget => money3_signal, Player4_Budget => money4_signal,
				Player1_Bid => bid1_signal, Player2_Bid => bid2_signal, Player3_Bid => bid3_signal, Player4_Bid => bid4_signal, 
				
				Player1_Hand_Card_1 => card1_1_signal, Player1_Hand_Card_2 => card1_2_signal, Player1_Hand_Card_3 => card1_3_signal, Player1_Hand_Card_4 => card1_4_signal, Player1_Hand_Card_5 => card1_5_signal,
				Player2_Hand_Card_1 => card2_1_signal, Player2_Hand_Card_2 => card2_2_signal, Player2_Hand_Card_3 => card2_3_signal, Player2_Hand_Card_4 => card2_4_signal, Player2_Hand_Card_5 => card2_5_signal,
				Player3_Hand_Card_1 => card3_1_signal, Player3_Hand_Card_2 => card3_2_signal, Player3_Hand_Card_3 => card3_3_signal, Player3_Hand_Card_4 => card3_4_signal, Player3_Hand_Card_5 => card3_5_signal,
				Player4_Hand_Card_1 => card4_1_signal, Player4_Hand_Card_2 => card4_2_signal, Player4_Hand_Card_3 => card4_3_signal, Player4_Hand_Card_4 => card4_4_signal, Player4_Hand_Card_5 => card4_5_signal,
				 
				Dealer_Hand_Card_1 => card5_1_signal, Dealer_Hand_Card_2 => card5_2_signal, Dealer_Hand_Card_3 => card5_3_signal, Dealer_Hand_Card_4 => card5_4_signal, Dealer_Hand_Card_5 => card5_5_signal,

				Reserve_Hand_Card_1 => card6_1_signal, Reserve_Hand_Card_2 => card6_2_signal, Reserve_Hand_Card_3 => card6_3_signal, Reserve_Hand_Card_4 => card6_4_signal, Reserve_Hand_Card_5 => card6_5_signal,
				
				random_card => random_card_signal, request_card => request_card_signal, round_end => round_end_signal,
				new_card => new_card_signal,
				draw_screen_type => draw_screen_signal, cursor_position => cursor_position_signal,
				 
				hit_option => hit_option_signal, double_option => double_option_signal, split_option => split_option_signal, insurance_option => insurance_option_signal, even_money_option => even_money_option_signal,
				 
				Player1_Budget_New => money1_signal_new, Player2_Budget_New => money2_signal_new, Player3_Budget_New => money3_signal_new, Player4_Budget_New => money4_signal_new,
				Player1_Bid_New => bid1_signal_new, Player2_Bid_New => bid2_signal_new, Player3_Bid_New => bid3_signal_new, Player4_Bid_New => bid4_signal_new,

				Player_Turn_New => player_turn_new_signal,
				N_Players_New => player_signal_new,
				-- receiving hand?
				enable => enable_signal,
				even_money => even_money_signal, insurance => insurance_signal, split => split_signal, double => double_signal,
				round_end => round_end_signal,
				-- global reset?
							
				 
	p3: vga_driver_combined port map(clk => clk, reset => reset, x_pos => x_pos_signal, y_pos => y_pos_signal, H_sync => H_sync_signal, V_sync => V_sync_signal);

	p4: gpu_driver port map(h_pos => x_pos_signal, v_pos => y_pos_sinal,
				red => red_signal, green => green_signal, blue => blue_signal,
				card1_1 => card1_1_signal, card1_2 => card1_2_signal, card1_3 => card1_3_signal, card1_4 => card1_4_signal, card1_5 => card1_5_signal,
			    	card2_1 => card2_1_signal, card2_2 => card2_2_signal, card2_3 => card2_3_signal, card2_4 => card2_4_signal, card2_5 => card2_5_signal,
			    	card3_1 => card3_1_signal, card3_2 => card3_2_signal, card3_3 => card3_3_signal, card3_4 => card3_4_signal, card3_5 => card3_5_signal,
			    	card4_1 => card4_1_signal, card4_2 => card4_2_signal, card4_3 => card4_3_signal, card4_4 => card4_4_signal, card4_5 => card4_5_signal,
				player_a => player_a_signal, player_b => player_b_signal, player_c => player_c_signal, player_d => player_d_signal,
				money1 => money1_singal, money2 => money2_signal, money3 => money3_signal, money4 => money4_signal,
				bet1 => bid1_signal, bet2 => bid2_signal, bet3 => bid3_signal, bet4 => bid4_signal,
				split1 => split1_signal, split2 => split2_signal, split3 => split3_signal, split4 => split4_signal,
				insurance1 => insurance1_signal, insurance2 => insurance2_signal, insurance3 => insurance3_signal, insurance4 => insurance4_signal,
				doubledown1 => double1, doubledown2 => double2, doubledown3 => double3, doubledown4 => double4,
				player => player_signal,
				hit => hit_option_signal, double => double_option_signal, split => split_option_signal, insurance => insurance_option_signal, em => even_money_option_signal,
				screentype => draw_screen_signal, cursor_position => cursor_position_signal);

	p5: top_entity_rcm port map(clk => clk, reset => reset, request_card => request_card_signal, round_end => round_end_signal, random_card => random_card_signal);

        switch_select <= select_signal;
	switch_right  <= right_signal;
	switch_left   <= left_signal;
	
	H_sync <= H_sync_signal;
	V_sync <= V_sync_signal;

	red <= red_signal;
	green <= green_signal;
	blue <= blue_signal;
