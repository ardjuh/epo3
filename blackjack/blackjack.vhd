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
    port( clk  : in std_logic;
          reset: in std_logic;
          Player_Turn_In : in std_logic_vector (2 downto 0);
          N_players      : in std_logic_vector (2 downto 0);
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


         
