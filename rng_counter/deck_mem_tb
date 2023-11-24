library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of deck_mem_tb is
   component deck_mem
      port(reset : in std_logic;
   	random_num  : in  std_logic_vector(7 downto 0);
           shuffle     : in  std_logic;
           random_card : out std_logic_vector(3 downto 0));
   end component;
   signal reset : std_logic;
   signal random_num  : std_logic_vector(7 downto 0);
   signal shuffle     : std_logic;
   signal random_card : std_logic_vector(3 downto 0);
begin
   test: deck_mem port map (reset, random_num, shuffle, random_card);
   reset <= '1' after 0 ns,
            '0' after 10 ns;
   random_num <= "00000000" after 0 ns,
		"00101111" after 100 ns, --47
		"00000000" after 110 ns,
		"10111101" after 200 ns; --189
		--"00000000" after 300 ns,
		--"00000000" after 400 ns,
		--"00000000" after 500 ns,
		--"00000000" after 600 ns,
		--"00000000" after 700 ns,
		--"00000000" after 800 ns,
		--"00000000" after 900 ns,
		--"00000000" after 1000 ns,
   shuffle <= '0' after 0 ns;
end behaviour;
