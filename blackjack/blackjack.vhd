library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity blackjack is
	    port(clk    : in std_logic;
	         reset  : in std_logic;
	         switch_select : in std_logic; -- controller
	         swtich_left   : in std_logic; -- controller
	         switch_right  : in std_logic; -- controller
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

        	Player1_Budget	: in  std_logic_vector (9 downto 0);	
        	Player2_Budget	: in  std_logic_vector (9 downto 0);
        	Player3_Budget	: in  std_logic_vector (9 downto 0);  
        	Player4_Budget	: in  std_logic_vector (9 downto 0);
        
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


         
