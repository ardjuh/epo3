library ieee;
use ieee.std_logic_1164.all;

architecture behavior of memory is
    component hand port (
        clk    : in std_logic;
        rst    : in std_logic;
        enable : in std_logic;
        card   : in std_logic_vector(3 downto 0);

        card1 : out std_logic_vector(3 downto 0);
        card2 : out std_logic_vector(3 downto 0);
        card3 : out std_logic_vector(3 downto 0);
        card4 : out std_logic_vector(3 downto 0);
        card5 : out std_logic_vector(3 downto 0);
        score : out std_logic_vector(4 downto 0));
    end component;

    component player port (
        clk     : in std_logic;
        rst     : in std_logic;
        mem_rst : in std_logic;
        enable  : in std_logic;

        profit : in std_logic_vector(6 downto 0);
        stake  : in std_logic_vector(4 downto 0);

        bid_in        : in std_logic_vector(1 downto 0);
        insurance_in  : in std_logic;
        doubledown_in : in std_logic;

        bid_out        : out std_logic_vector(1 downto 0);
        money          : out std_logic_vector(9 downto 0);
        insurance_out  : out std_logic;
        doubledown_out : out std_logic);
    end component;

    signal h1, h2, h3, h4, h5, h6 : std_logic                    := '0';
    signal profit                 : std_logic_vector(6 downto 0) := "0000000";
    signal stake                  : std_logic_vector(4 downto 0) := "00000";
    signal bid_temp               : std_logic_vector(1 downto 0) := "000";
    signal win_type_temp          : std_logic_vector(1 downto 0) := "000";
begin
    h1_l : hand port map(clk => clk, rst => rst or end_round, enable => h1, card => card_in, card1 => card1_1_out, card2 => card1_2_out, card3 => card1_3_out, card4 => card1_4_out, card5 => card1_5_out, score => score1_out);
    h2_l : hand port map(clk => clk, rst => rst or end_round, enable => h2, card => card_in, card1 => card2_1_out, card2 => card2_2_out, card3 => card2_3_out, card4 => card2_4_out, card5 => card2_5_out, score => score2_out);
    h3_l : hand port map(clk => clk, rst => rst or end_round, enable => h3, card => card_in, card1 => card3_1_out, card2 => card3_2_out, card3 => card3_3_out, card4 => card3_4_out, card5 => card3_5_out, score => score3_out);
    h4_l : hand port map(clk => clk, rst => rst or end_round, enable => h4, card => card_in, card1 => card4_1_out, card2 => card4_2_out, card3 => card4_3_out, card4 => card4_4_out, card5 => card4_5_out, score => score4_out);
    h5_l : hand port map(clk => clk, rst => rst or end_round, enable => h5, card => card_in, card1 => card5_1_out, card2 => card5_2_out, card3 => card5_3_out, card4 => card5_4_out, card5 => card5_5_out, score => score5_out);
    h6_l : hand port map(clk => clk, rst => rst or end_round, enable => h6, card => card_in, card1 => card6_1_out, card2 => card6_2_out, card3 => card6_3_out, card4 => card6_4_out, card5 => card6_5_out, score => score6_out);

    p1_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h1, profit => profit, stake => stake, bid_in => bid1_in, insurance_in => insurance, doubledown_in => doubledown, bid_out => bid1_out, money => money1_out, insurance_out => insurance1_out, doubledown_out => doubledown1_out);
    p2_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h2, profit => profit, stake => stake, bid_in => bid2_in, insurance_in => insurance, doubledown_in => doubledown, bid_out => bid2_out, money => money2_out, insurance_out => insurance2_out, doubledown_out => doubledown2_out);
    p3_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h3, profit => profit, stake => stake, bid_in => bid3_in, insurance_in => insurance, doubledown_in => doubledown, bid_out => bid3_out, money => money3_out, insurance_out => insurance3_out, doubledown_out => doubledown3_out);
    p4_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h4, profit => profit, stake => stake, bid_in => bid4_in, insurance_in => insurance, doubledown_in => doubledown, bid_out => bid4_out, money => money4_out, insurance_out => insurance4_out, doubledown_out => doubledown4_out);

    process (player_in, bid1_in, bid2_in, bid3_in, bid4_in, win_type1_in, win_type2_in, win_type3_in, win_type4_in)
    begin
        case player_in is
            when "001" =>
                h1            <= '1';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid1_in;
                win_type_temp <= win_type1_in;
            when "010" =>
                h1            <= '0';
                h2            <= '1';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid2_in;
                win_type_temp <= win_type2_in;
            when "011" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '1';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid3_in;
                win_type_temp <= win_type3_in;
            when "100" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '1';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid4_in;
                win_type_temp <= win_type4_in;
            when "101" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '1';
                h6            <= '0';
                bid_temp      <= "000";
                win_type_temp <= "000";
            when "110" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '1';
                bid_temp      <= "000";
                win_type_temp <= "000";
            when others =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= "000";
                win_type_temp <= "000";
        end case;
    end process;

    process (win_type, bid_temp, win_type_temp, doubledown_in)
    begin
        case bid_temp is
            when "00" =>
                case win_type_temp is -- 00 = win, 01 = blackjack_win, 10 = insurance_win, 11 = doubledown_win * /
                    when "00" =>
                        profit <= "0000100";
                    when "01" =>
                        profit <= "0000101";
                    when "10" =>
                        profit <= "0000011";
                    when "11" =>
                        profit <= "0001000";
                    when others =>
                        profit <= "0000000";
                end case;
            when "01" =>
                case win_type_temp is
                    when "00" =>
                        profit <= "0001100";
                    when "01" =>
                        profit <= "0001111";
                    when "10" =>
                        profit <= "0001001";
                    when "11" =>
                        profit <= "0011000";
                    when others =>
                        profit <= "0000000";
                end case;
            when "10" =>
                case win_type_temp is
                    when "00" =>
                        profit <= "0010100";
                    when "01" =>
                        profit <= "0011001";
                    when "10" =>
                        profit <= "0001111";
                    when "11" =>
                        profit <= "0101000";
                    when others =>
                        profit <= "0000000";
                end case;
            when "11" =>
                case win_type_temp is
                    when "00" =>
                        profit <= "0101000";
                    when "01" =>
                        profit <= "0110010";
                    when "10" =>
                        profit <= "0001110";
                    when "11" =>
                        profit <= "1010000";
                    when others =>
                        profit <= "0000000";
                end case;
            when others =>
                profit <= "0000000";
        end case;

        if (doubledown_in = '1') then
            case bid_temp is
                when "00" =>
                    stake <= "00010";
                when "01" =>
                    stake <= "00110";
                when "10" =>
                    stake <= "01010";
                when "11" =>
                    stake <= "10100";
                when others =>
                    stake <= "00000";
            end case;
        else
            case bid_temp is
                when "00" =>
                    stake <= "00001";
                when "01" =>
                    stake <= "00011";
                when "10" =>
                    stake <= "00101";
                when "11" =>
                    stake <= "01010";
                when others =>
                    stake <= "00000";
            end case;
        end if;
    end process;
end behavior;