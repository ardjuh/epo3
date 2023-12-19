library ieee;
use ieee.std_logic_1164.all;

architecture behavior of memory is
    component hand port (
        clk     : in std_logic;
        rst     : in std_logic;
        mem_rst : in std_logic;
        enable  : in std_logic;
        card    : in std_logic_vector(3 downto 0);

        card1 : out std_logic_vector(3 downto 0);
        card2 : out std_logic_vector(3 downto 0);
        card3 : out std_logic_vector(3 downto 0);
        card4 : out std_logic_vector(3 downto 0);
        card5 : out std_logic_vector(3 downto 0));
    end component;

    component player port (
        clk    : in std_logic;
        rst    : in std_logic;
        memrst : in std_logic;

        profit_enable : in std_logic;
        stake_enable  : in std_logic;
        profit        : in std_logic_vector(6 downto 0);
        stake         : in std_logic_vector(4 downto 0);

        bid_in        : in std_logic_vector(1 downto 0);
        insurance_in  : in std_logic;
        doubledown_in : in std_logic;

        bid_enable        : in std_logic;
        insurance_enable  : in std_logic;
        doubledown_enable : in std_logic;

        bid_out        : out std_logic_vector(1 downto 0);
        money          : out std_logic_vector(9 downto 0);
        insurance_out  : out std_logic;
        doubledown_out : out std_logic);
    end component;

    signal h1, h2, h3, h4, h5, h6                                                                                                 : std_logic                    := '0';
    signal p1_p, p1_s, p1_b, p1_i, p1_d, p2_p, p2_s, p2_b, p2_i, p2_d, p3_p, p3_s, p3_b, p3_i, p3_d, p4_p, p4_s, p4_b, p4_i, p4_d : std_logic                    := '0';
    signal profit                                                                                                                 : std_logic_vector(6 downto 0) := "000000";
    signal stake                                                                                                                  : std_logic_vector(4 downto 0) := "0000";
begin
    h1_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h1, card => card, card1 => card1_1, card2 => card1_2, card3 => card1_3, card4 => card1_4, card5 => card1_5);
    h2_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h2, card => card, card1 => card2_1, card2 => card2_2, card3 => card2_3, card4 => card2_4, card5 => card2_5);
    h3_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h3, card => card, card1 => card3_1, card2 => card3_2, card3 => card3_3, card4 => card3_4, card5 => card3_5);
    h4_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h4, card => card, card1 => card4_1, card2 => card4_2, card3 => card4_3, card4 => card4_4, card5 => card4_5);
    h5_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h5, card => card, card1 => card5_1, card2 => card5_2, card3 => card5_3, card4 => card5_4, card5 => card5_5);
    h6_l : hand port map(clk => clk, rst => rst, mem_rst => mem_rst, enable => h6, card => card, card1 => card6_1, card2 => card6_2, card3 => card6_3, card4 => card6_4, card5 => card6_5);

    p1_l : player port map(clk => clk, rst => rst, mem_rst => mem_rst, profit_enable => p1_p, profit => profit, stake_enable => p1_s, stake => stake, bid_in => bet, insurance_in => insurance, doubledown_in => doubledown, bid_enable => p1_b, insurance_enable => p1_i, doubledown_enable => p1_d, bid_out => bid1, money => money1, insurance_out => insurance1, doubledown_out => doubledown1);
    p1_l : player port map(clk => clk, rst => rst, mem_rst => mem_rst, profit_enable => p2_p, profit => profit, stake_enable => p2_s, stake => stake, bid_in => bet, insurance_in => insurance, doubledown_in => doubledown, bid_enable => p2_b, insurance_enable => p2_i, doubledown_enable => p2_d, bid_out => bid2, money => money2, insurance_out => insurance2, doubledown_out => doubledown2);
    p1_l : player port map(clk => clk, rst => rst, mem_rst => mem_rst, profit_enable => p3_p, profit => profit, stake_enable => p3_s, stake => stake, bid_in => bet, insurance_in => insurance, doubledown_in => doubledown, bid_enable => p3_b, insurance_enable => p3_i, doubledown_enable => p3_d, bid_out => bid3, money => money3, insurance_out => insurance3, doubledown_out => doubledown3);
    p1_l : player port map(clk => clk, rst => rst, mem_rst => mem_rst, profit_enable => p4_p, profit => profit, stake_enable => p4_s, stake => stake, bid_in => bet, insurance_in => insurance, doubledown_in => doubledown, bid_enable => p4_b, insurance_enable => p4_i, doubledown_enable => p4_d, bid_out => bid4, money => money4, insurance_out => insurance4, doubledown_out => doubledown4);

    process (player, card_enable)
    begin
        if (card_enable = '0') then
            h1 <= '0';
            h2 <= '0';
            h3 <= '0';
            h4 <= '0';
            h5 <= '0';
            h6 <= '0';
        else
            case player is
                when "001" =>
                    h1 <= '1';
                    h2 <= '0';
                    h3 <= '0';
                    h4 <= '0';
                    h5 <= '0';
                    h6 <= '0';
                when "010" =>
                    h1 <= '0';
                    h2 <= '1';
                    h3 <= '0';
                    h4 <= '0';
                    h5 <= '0';
                    h6 <= '0';
                when "011" =>
                    h1 <= '0';
                    h2 <= '0';
                    h3 <= '1';
                    h4 <= '0';
                    h5 <= '0';
                    h6 <= '0';
                when "100" =>
                    h1 <= '0';
                    h2 <= '0';
                    h3 <= '0';
                    h4 <= '1';
                    h5 <= '0';
                    h6 <= '0';
                when "101" =>
                    h1 <= '0';
                    h2 <= '0';
                    h3 <= '0';
                    h4 <= '0';
                    h5 <= '1';
                    h6 <= '0';
                when "110" =>
                    h1 <= '0';
                    h2 <= '0';
                    h3 <= '0';
                    h4 <= '0';
                    h5 <= '0';
                    h6 <= '1';
                when others =>
                    h1 <= '0';
                    h2 <= '0';
                    h3 <= '0';
                    h4 <= '0';
                    h5 <= '0';
                    h6 <= '0';
            end case;
        end if;
    end process;
end behavior;