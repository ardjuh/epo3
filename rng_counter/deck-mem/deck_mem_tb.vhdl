library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of deck_mem_tb is
   component deck_mem
      port(clk		: in std_logic;
   	reset       : in  std_logic;
           random_num  : in  std_logic_vector(7 downto 0);
           shuffle     : in  std_logic;
           random_card : out std_logic_vector(3 downto 0));
   end component;
   signal clk		: std_logic;
   signal reset       : std_logic;
   signal random_num  : std_logic_vector(7 downto 0);
   signal shuffle     : std_logic;
   signal random_card : std_logic_vector(3 downto 0);
begin
   test: deck_mem port map (clk, reset, random_num, shuffle, random_card);
   clk <= '0' after 0 ns,
          '1' after 20 ns when clk /= '1' else '0' after 20 ns;
   reset <= '1' after 0 ns,
            '0' after 40 ns;
   random_num <=	"00000000" after 0 ns,
		"00101111" after 100 ns, --47
		"00000000" after 140 ns,
		"00101111" after 190 ns, --47
		"00000000" after 230 ns,
		"00101111" after 280 ns, --47
		"00000000" after 320 ns,
		"10111101" after 360 ns,	--189
		"00000000" after 400 ns;

   shuffle <=		'0' after 0 ns,
		'1' after 500 ns,
		'0' after 550 ns;
end behaviour;
