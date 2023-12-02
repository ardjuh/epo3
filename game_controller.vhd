library IEEE;
use IEEE.std_logic_1164.ALL;

entity controller is
   port(clk          : in  std_logic;
        reset        : in  std_logic;

        Player_Turn_In  : in std_logic_vector (2 downto 0);

	switch_select  : in  std_logic;  
	switch_left    : in  std_logic;    -- player inputs --
	switch_right   : in  std_logic;

	Player1_Budget  : in  std_logic_vector (9 downto 0);   -- base budget is 100, score limit chosen as 1000 so 10 bits --
        Player2_Budget  : in  std_logic_vector (9 downto 0);
	Player3_Budget  : in  std_logic_vector (9 downto 0);  
	Player4_Budget  : in  std_logic_vector (9 downto 0);

        Player1_Bid  : in std_logic_vector (1 downto 0);   -- Bid and Budget required to determine if Insurance/Double are possible --
        Player2_Bid  : in std_logic_vector (1 downto 0);   -- Value of Initial Bid = 2,6,10,20 -> 00,01,10,00 (Internal signal Bid_Value) --
        Player3_Bid  : in std_logic_vector (1 downto 0);   -- Controller never needs the augmented value of Bid as Double/Insurance/Split --
        Player4_Bid  : in std_logic_vector (1 downto 0);   -- are Turn 1 actions (If Mem Controller does end-round calculations) --

        Player1_Hand_Card_1  : in std_logic_vector (3 downto 0);   -- Each card is a 4-bit vector --
        Player1_Hand_Card_2  : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_3  : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_4  : in std_logic_vector (3 downto 0);
        Player1_Hand_Card_5  : in std_logic_vector (3 downto 0);

        Player2_Hand_Card_1  : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_2  : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_3  : in std_logic_vector (3 downto 0);
        Player2_Hand_Card_4  : in std_logic_vector (3 downto 0);   
        Player2_Hand_Card_5  : in std_logic_vector (3 downto 0);

        Player3_Hand_Card_1  : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_2  : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_3  : in std_logic_vector (3 downto 0);   
        Player3_Hand_Card_4  : in std_logic_vector (3 downto 0);
        Player3_Hand_Card_5  : in std_logic_vector (3 downto 0);

        Player4_Hand_Card_1  : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_2  : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_3  : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_4  : in std_logic_vector (3 downto 0);
        Player4_Hand_Card_5  : in std_logic_vector (3 downto 0);

	Dealer_Hand_Card_1   : in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_2   : in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_3   : in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_4   : in std_logic_vector (3 downto 0);
	Dealer_Hand_Card_5   : in std_logic_vector (3 downto 0);

	Reserve_Hand_Card_1  : in std_logic_vector (3 downto 0);   -- Reserve hand for Split. Only one player can split (low chance) --
	Reserve_Hand_Card_2  : in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_3  : in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_4  : in std_logic_vector (3 downto 0);
	Reserve_Hand_Card_5  : in std_logic_vector (3 downto 0);
  	Reserve_Hand_Player  : in std_logic_vector (2 downto 0);   -- Pointer to which player split their hand --

	random_card  : in  std_logic_vector (3 downto 0);   -- Comms with RCM --
        request_card : out std_logic;                         
        round_end    : out std_logic;

        draw_menu    : out std_logic_vector (? downto 0);   -- Comms with Graphics Driver --
	menu_ready   : in std_logic;

	Player1_Budget_New  : out  std_logic_vector (9 downto 0);   -- base budget is 100, score limit chosen as 1000 so 10 bits --
        Player2_Budget_New  : out  std_logic_vector (9 downto 0);
	Player3_Budget_New  : out  std_logic_vector (9 downto 0);  
	Player4_Budget_New  : out  std_logic_vector (9 downto 0);

        Player1_Bid_New  : out std_logic_vector (1 downto 0);   -- 2,6,10,20 = 4 options so 2 bits --
        Player2_Bid_New  : out std_logic_vector (1 downto 0);
        Player3_Bid_New  : out std_logic_vector (1 downto 0);
        Player4_Bid_New  : out std_logic_vector (1 downto 0);

	Player_Turn_New  : out std_logic_vector (2 downto 0);   -- outputs -> mem based on actions --
	new_card   : out std_logic_vector (3 downto 0);   -- Mem Controller determines where the new card goes from Player Turn and Hand Cards --
	double     : out std_logic;   
	split      : out std_logic;   -- Mem Controller determines what happens with each function --
	insurance  : out std_logic;
        );
end controller;

architecture behaviour of controller is

type controller_state is ( reset,
			   start_screen,
			   game_setup,
                           player_action,	
                           game_resolution );

signal state, new_state: controller state;

begin
      process (clk)
      begin
             if (rising_edge (clk)) then
                   if (reset = '1') then
                       state <= reset;
                   else
                       state <= new_state;
                   end if;
	     end if;
      end process;

      process (state, mem (t.b.d))
      begin
             case state is
                      when reset =>

		      when start_screen => 
         
                      when game_setup =>
 
                      when player_action =>

                      when game_resolution =>

             end case;
      end process;
end architecture;