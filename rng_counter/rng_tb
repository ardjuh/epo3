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
		'0' after 100 ns;


   	request_card <= '0' after 0 ns,
			'1' after 501 ns,
			'0' after 541 ns,
			'1' after 2000 ns,
			'0' after 2040 ns,
			'1' after 7452 ns,
			'0' after 7492 ns,
			'1' after 10069 ns,
			'0' after 10109 ns,
			'1' after 15340 ns,
			'0' after 15380 ns,
			'1' after 19999 ns,
			'0' after 20039 ns;
			
			
		
  	 round_end <= 	'0' after 0 ns,
			'1' after 4000 ns, 	
			'0' after 4040 ns,
			'1' after 13000 ns,
			'0' after 13040 ns;
end behaviour;
