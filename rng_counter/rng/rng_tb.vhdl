library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of rng_tb is
   component rng
      port(clk          : in  std_logic;
           reset        : in  std_logic;
           request_card : in  std_logic;
           round_end    : in  std_logic;
           shuffle      : out std_logic;
           random_num   : out std_logic_vector(7 downto 0));
   end component;
   signal clk          : std_logic;
   signal reset        : std_logic;
   signal request_card : std_logic;
   signal round_end    : std_logic;
   signal shuffle      : std_logic;
   signal random_num   : std_logic_vector(7 downto 0);
begin
   test: rng port map (clk, reset, request_card, round_end, shuffle, random_num);
   
	clk <= 	'0' after 0 ns,
          		'1' after 20 ns when clk /= '1' else '0' after 20 ns;


   	reset <= '1' after 0 ns,
		'0' after 40 ns;


   	request_card <= '0' after 0 ns,
			'1' after 60 ns,
			'0' after 100 ns,
			'1' after 140 ns,
			'0' after 180 ns;
			
			
		
  	 round_end <= 	'0' after 0 ns,
			'1' after 200 ns, 	
			'0' after 240 ns;
end behaviour;
