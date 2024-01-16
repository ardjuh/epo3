library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of player_tb is
   component player
       port (
           clk            : in std_logic;
           rst            : in std_logic;
           mem_rst        : in std_logic;
           enable         : in std_logic;
           profit         : in std_logic_vector(6 downto 0);
           stake          : in std_logic_vector(4 downto 0);
           bid_in         : in std_logic_vector(1 downto 0);
           insurance_in   : in std_logic;
           doubledown_in  : in std_logic;
           bid_out        : out std_logic_vector(1 downto 0);
           money          : out std_logic_vector(9 downto 0);
           insurance_out  : out std_logic;
           doubledown_out : out std_logic);
   end component;


signal clk                  : std_logic                    := '0';
    signal rst                  : std_logic                    := '0';
    signal mem_rst               : std_logic                    := '0';
  
    signal profit               : std_logic_vector(6 downto 0) := "0000000";
    signal stake                : std_logic_vector(4 downto 0) := "00000";
    signal bid_in               : std_logic_vector(1 downto 0) := "00";
    signal insurance_in         : std_logic                    := '0';
    signal doubledown_in        : std_logic                    := '0';
    signal 	enable        : std_logic                    := '0';
    signal bid_out              : std_logic_vector(1 downto 0) := "00";
    signal money                : std_logic_vector(9 downto 0) := "0000000000";
    signal insurance_out        : std_logic                    := '0';
    signal doubledown_out       : std_logic                    := '0';

begin
   test: player port map (clk, rst, mem_rst, enable, profit, stake, bid_in, insurance_in, doubledown_in, bid_out, money, insurance_out, doubledown_out);
   
	clk <= not clk after 20 ns;
  	rst <= 	'0' after 0 ns,
        		'1' after 5 ns,
        		'0' after 25 ns;

    	enable <= '1' after 100 ns,
        		'0' after 140 ns;
    	profit <= "0101010" after 100 ns,
        		"0000000" after 140 ns;


    	insurance_in <= '1' after 100 ns,
        			'0' after 140 ns;

	mem_rst	<= 	'0' after 0 ns;
	stake 	<= 	"00000" after 0 ns;

end behaviour;