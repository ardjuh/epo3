library IEEE;
use IEEE.std_logic_1164.ALL;

architecture structural of top_entity_rcm is

	
component rng is --dit is de rng counter
   port(clk          : in  std_logic;
        reset        : in  std_logic;
        request_card : in  std_logic;
        round_end    : in  std_logic;
        shuffle      : out std_logic;
        random_num   : out std_logic_vector(7 downto 0));
end component rng;

component deck_mem is --dit is de deck memory
   port(clk		: in std_logic;
	reset       : in  std_logic;
        random_num  : in  std_logic_vector(7 downto 0);
        shuffle     : in  std_logic;
        random_card : out std_logic_vector(3 downto 0));
end component deck_mem;	

	signal shuffle_intermediate : std_logic;
	signal random_num_intermediate : std_logic_vector(7 downto 0);

begin

RNGLB: rng port map(	clk         => clk,
       		 reset         => reset,
       		 request_card  => request_card,
       		 round_end     => round_end,
       		 shuffle       => shuffle_intermediate,
       		 random_num    => random_num_intermediate);

DECKMEMLB: deck_mem port map(clk					=> clk,
		        	reset   		=> reset,
       			 random_num  		=> random_num_intermediate,
       			 shuffle        => shuffle_intermediate,
       			 random_card 		=> random_card);
		


end structural;

