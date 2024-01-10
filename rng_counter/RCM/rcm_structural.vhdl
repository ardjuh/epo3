library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

architecture structural of top_entity_rcm is

component input_ff is
	port ( 	clk : in  std_logic;
        		D   : in  std_logic;
        		Q   : out std_logic);
end component input_ff;
	
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
	signal ff1_2, ff2_rng : std_logic;

begin

FF1: 	input_ff port map(			clk	=> clk,
				D	=> request_card,
				Q	=> ff1_2);
				
				
FF2:	input_ff port map(			clk	=> clk,
				D	=> ff1_2,
				Q	=> ff2_rng);		
			

RNGLB: rng port map(	clk         => clk,
       		 reset         => reset,
       		 request_card  => ff2_rng,  -- vanuit ff2
       		 round_end     => round_end,
       		 shuffle       => shuffle_intermediate,
       		 random_num    => random_num_intermediate);

DECKMEMLB: deck_mem port map(clk					=> clk,
		        	reset   		=> reset,
       			 random_num  		=> random_num_intermediate,
       			 shuffle        => shuffle_intermediate,
       			 random_card 		=> random_card);
		


end structural;
