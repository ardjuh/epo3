library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity blackjack is
	    port(clk    : in std_logic;
	         reset  : in std_logic;
	         sw_select : in std_logic; -- controller
	         sw_left   : in std_logic; -- controller
	         sw_right  : in std_logic; -- controller
	         red    : out std_logic_vector(3 downto 0);
	         green  : out std_logic_vector(3 downto 0);
	         blue   : out std_logic_vector(3 downto 0);
	         H_sync : out std_logic;
	         V_sync : out std_logic;

end blackjack;

architecture behavioral of blackjack is
       
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
		rst               : in std_logic;
	        card_enable       : in std_logic;
	        card              : in std_logic_vector(3 downto 0);
	        insurance         : in std_logic;
	        insurance_enable  : in std_logic_vector;
	        doubledown        : in std_logic;
	        doubledown_enable : in std_logic;
	        win_type          : in std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
	        win_enable        : in std_logic;
	        bid               : in std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
	        player_in         : in std_logic_vector(2 downto 0); -- 0: geen player, 1-4: speler, 5: dealer, 6: split 
	        player_enable     : in std_logic;
	        card              : in std_logic_vector(3 downto 0);
	        card_enable       : in std_logic;
	        money             : in std_logic_vector(10 downto 0);
	        split             : in std_logic;
	
	        player_out : out std_logic_vector(2 downto 0);
	
	        player_a    : out std_logic;
	        card1_1     : out std_logic_vector(3 downto 0);
	        card1_2     : out std_logic_vector(3 downto 0);
	        card1_3     : out std_logic_vector(3 downto 0);
	        card1_4     : out std_logic_vector(3 downto 0);
	        card1_5     : out std_logic_vector(3 downto 0);
	        money1      : out std_logic_vector(10 downto 0);
	        bid1        : out std_logic_vector(1 downto 0);
	        split1      : out std_logic;
	        insurance1  : out std_logic;
	        doubledown1 : out std_logic;
	
	        player_b    : out std_logic;
	        card2_1     : out std_logic_vector(3 downto 0);
	        card2_2     : out std_logic_vector(3 downto 0);
	        card2_3     : out std_logic_vector(3 downto 0);
	        card2_4     : out std_logic_vector(3 downto 0);
	        card2_5     : out std_logic_vector(3 downto 0);
	        money2      : out std_logic_vector(10 downto 0);
	        bid2        : out std_logic_vector(1 downto 0);
	        split2      : out std_logic;
	        insurance2  : out std_logic;
	        doubledown2 : out std_logic;
	
	        player_c    : out std_logic;
	        card3_1     : out std_logic_vector(3 downto 0);
	        card3_2     : out std_logic_vector(3 downto 0);
	        card3_3     : out std_logic_vector(3 downto 0);
	        card3_4     : out std_logic_vector(3 downto 0);
	        card3_5     : out std_logic_vector(3 downto 0);
	        money3      : out std_logic_vector(10 downto 0);
	        bid3        : out std_logic_vector(1 downto 0);
	        split3      : out std_logic;
	        insurance3  : out std_logic;
	        doubledown3 : out std_logic;
	
	        player_d    : out std_logic;
	        card4_1     : out std_logic_vector(3 downto 0);
	        card4_2     : out std_logic_vector(3 downto 0);
	        card4_3     : out std_logic_vector(3 downto 0);
	        card4_4     : out std_logic_vector(3 downto 0);
	        card4_5     : out std_logic_vector(3 downto 0);
	        money4      : out std_logic_vector(10 downto 0);
	        bid4        : out std_logic_vector(1 downto 0);
	        split4      : out std_logic;
	        insurance4  : out std_logic;
	        doubledown4 : out std_logic;
	
	        -- dealer
	        card5_1 : out std_logic_vector(3 downto 0);
	        card5_2 : out std_logic_vector(3 downto 0);
	        card5_3 : out std_logic_vector(3 downto 0);
	        card5_4 : out std_logic_vector(3 downto 0);
	        card5_5 : out std_logic_vector(3 downto 0);
	
	        -- split
	        card6_1 : out std_logic_vector(3 downto 0);
	        card6_2 : out std_logic_vector(3 downto 0);
	        card6_3 : out std_logic_vector(3 downto 0);
	        card6_4 : out std_logic_vector(3 downto 0);
	        card6_5 : out std_logic_vector(3 downto 0)
	    )
	end memory;
	signal bid1_signal, bid2_signal, bid3_signal, bid4_signal : std_logic_vector(1 downto 0);
	signal card1_1_signal, card1_2_signal, card1_3signal, card1_4_sigal, card1_5_signal, card2_1_signal, card2_2_signal, card2_3_signal, card2_4_signal, card2_5_signal, card3_1_signal, card3_2_signal, card3_3_signal, card3_4_signal, card3_5_signal, card4_1_signal, card4_2_signal, card4_3_signal, card4_4_signal, card4_5_signal, card5_1_signal, card5_2_signal, card5_3_signal, card5_4_signal, card5_5_signal : std_logic_vector(3 downto 0);
	signal money1_signal, money2_signal, money3_signal, moneyd4_signal : std_logic_vector(10 downto 0);
	signal player_signal : std_logic_vector(2 downto 0);
	signal select_signal, left_signal, right_signal : std_logic;
		 
begin
	p1: memory 	port map(clk => clk, rst => reset, 
				bid1 => bid1_signal, bid2 => bid2_signal, bid3 => bid3_signal, bid4 => bid4_signal, 
			    	card1_1 => card1_1_signal, card1_2 => card1_2_signal, card1_3 => card1_3_signal, card1_4 => card1_4_signal, card1_5 => card1_5_signal,
			    	card2_1 => card2_1_signal, card2_2 => card2_2_signal, card2_3 => card2_3_signal, card2_4 => card2_4_signal, card2_5 => card2_5_signal,
			    	card3_1 => card3_1_signal, card3_2 => card3_2_signal, card3_3 => card3_3_signal, card3_4 => card3_4_signal, card3_5 => card3_5_signal,
			    	card4_1 => card4_1_signal, card4_2 => card4_2_signal, card4_3 => card4_3_signal, card4_4 => card4_4_signal, card4_5 => card4_5_signal,
			    	card5_1 => card5_1_signal, card5_2 => card5_2_signal, card5_3 => card5_3_signal, card5_4 => card5_4_signal, card5_5 => card5_5_signal,
				money1 => money1_singal, money2 => money2_signal, money3 => money3_signal, money4 => money4_signal,
				player_out => player_signal,

	p2: controller 	port map(clk => clk, reset => reset, 
				Player1_Bid => bid1_signal, Player2_Bid => bid2_signal, Player3_Bid => bid3_signal, Player4_Bid => bid4_signal, 
				Player1_Hand_Card_1 => card1_1_signal, Player1_Hand_Card_2 => card1_2_signal, Player1_Hand_Card_3 => card1_3_signal, Player1_Hand_Card_4 => card1_4_signal, Player1_Hand_Card_5 => card1_5_signal,
				Player2_Hand_Card_1 => card2_1_signal, Player2_Hand_Card_2 => card2_2_signal, Player2_Hand_Card_3 => card2_3_signal, Player2_Hand_Card_4 => card2_4_signal, Player2_Hand_Card_5 => card2_5_signal,
				Player3_Hand_Card_1 => card3_1_signal, Player3_Hand_Card_2 => card3_2_signal, Player3_Hand_Card_3 => card3_3_signal, Player3_Hand_Card_4 => card3_4_signal, Player3_Hand_Card_5 => card3_5_signal,
				Player4_Hand_Card_1 => card4_1_signal, Player4_Hand_Card_2 => card4_2_signal, Player4_Hand_Card_3 => card4_3_signal, Player4_Hand_Card_4 => card4_4_signal, Player4_Hand_Card_5 => card4_5_signal,
				Dealer_Hand_Card_1 => card5_1_signal, Dealer_Hand_Card_2 => card5_2_signal, Dealer_Hand_Card_3 => card5_3_signal, Dealer_Hand_Card_4 => card5_4_signal, Dealer_Hand_Card_5 => card5_5_signal,
				Player1_Budget => money1_signal, Player2_Budget => money2_signal, Player3_Budget => money3_signal, Player4_Budget => money4_signal
				N_Players => player_signal,
				switch_select => select_signal, switch_left => left_signal, switch_right => right_signal

         sw_select <= select_signal;
	 sw_right  <= right_signal;
	 sw_left   <= left_signal;
