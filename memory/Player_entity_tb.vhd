
library IEEE;
use IEEE.std_logic_1164.all;

architecture behaviour of player_tb is
    component player
        port (
            clk                  : in std_logic;
            rst                  : in std_logic;
            memrst               : in std_logic;
            profit_enable        : in std_logic;
            stake_enable         : in std_logic;
            profit               : in std_logic_vector(6 downto 0);
            stake                : in std_logic_vector(4 downto 0);
            bid_in               : in std_logic_vector(1 downto 0);
            insurance_in         : in std_logic;
            doubledown_in        : in std_logic;
            bid_in_enable        : in std_logic;
            insurance_in_enable  : in std_logic;
            doubledown_in_enable : in std_logic;
            bid_out              : out std_logic_vector(1 downto 0);
            money                : out std_logic_vector(9 downto 0);
            insurance_out        : out std_logic;
            doubledown_out       : out std_logic);
    end component;
    signal clk                  : std_logic                    := '0';
    signal rst                  : std_logic                    := '0';
    signal memrst               : std_logic                    := '0';
    signal profit_enable        : std_logic                    := '0';
    signal stake_enable         : std_logic                    := '0';
    signal profit               : std_logic_vector(6 downto 0) := "0000000";
    signal stake                : std_logic_vector(4 downto 0) := "00000";
    signal bid_in               : std_logic_vector(1 downto 0) := "00";
    signal insurance_in         : std_logic                    := '0';
    signal doubledown_in        : std_logic                    := '0';
    signal bid_in_enable        : std_logic                    := '0';
    signal insurance_in_enable  : std_logic                    := '0';
    signal doubledown_in_enable : std_logic                    := '0';
    signal bid_out              : std_logic_vector(1 downto 0) := "00";
    signal money                : std_logic_vector(9 downto 0) := "0000000000";
    signal insurance_out        : std_logic                    := '0';
    signal doubledown_out       : std_logic                    := '0';
begin
    test : player port map(clk, rst, memrst, profit_enable, stake_enable, profit, stake, bid_in, insurance_in, doubledown_in, bid_in_enable, insurance_in_enable, doubledown_in_enable, bid_out, money, insurance_out, doubledown_out);

    clk <= not clk after 10 ns;
    rst <= '0' after 0 ns,
        '1' after 5 ns,
        '0' after 25 ns;
    profit_enable <= '1' after 100 ns,
        '0' after 140 ns;
    profit <= "0101010" after 100 ns,
        "0000000" after 140 ns;
    insurance_in <= '1' after 100 ns,
        '0' after 140 ns;
    insurance_in_enable <= '1' after 120 ns,
        '0' after 140 ns;
end behaviour;