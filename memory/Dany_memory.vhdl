library IEEE;
use IEEE.std_logic_1164.all;

entity memory_v2 is
    port (
        clk            : in std_logic;
        rst            : in std_logic;
        enable         : in std_logic;
        bid_enable     : in std_logic;
        player_in      : in std_logic_vector(2 downto 0);
        recieving_hand : in std_logic_vector(2 downto 0);

        insurance  : in std_logic;
        doubledown : in std_logic;
        split      : in std_logic;
        end_round  : in std_logic;
        card_in    : in std_logic_vector(3 downto 0);

        player_a_in  : in std_logic;
        win_type1_in : in std_logic_vector(2 downto 0); -- 0: niet gewonnen, 1: insurance, 2: double down, 3: blackjack, 4 : normal
        bid1_in      : in std_logic_vector(1 downto 0);

        player_b_in  : in std_logic;
        win_type2_in : in std_logic_vector(2 downto 0);
        bid2_in      : in std_logic_vector(1 downto 0);

        player_c_in  : in std_logic;
        win_type3_in : in std_logic_vector(2 downto 0);
        bid3_in      : in std_logic_vector(1 downto 0);

        player_d_in  : in std_logic;
        win_type4_in : in std_logic_vector(2 downto 0);
        bid4_in      : in std_logic_vector(1 downto 0);

        player_out : out std_logic_vector(2 downto 0);

        player_a_out    : out std_logic;
        card1_1_out     : out std_logic_vector(3 downto 0);
        card1_2_out     : out std_logic_vector(3 downto 0);
        card1_3_out     : out std_logic_vector(3 downto 0);
        card1_4_out     : out std_logic_vector(3 downto 0);
        card1_5_out     : out std_logic_vector(3 downto 0);
        score1_out      : out std_logic_vector(4 downto 0);
        money1_out      : out std_logic_vector(9 downto 0);
        bid1_out        : out std_logic_vector(1 downto 0);
        split1_out      : out std_logic;
        insurance1_out  : out std_logic;
        doubledown1_out : out std_logic;

        player_b_out    : out std_logic;
        card2_1_out     : out std_logic_vector(3 downto 0);
        card2_2_out     : out std_logic_vector(3 downto 0);
        card2_3_out     : out std_logic_vector(3 downto 0);
        card2_4_out     : out std_logic_vector(3 downto 0);
        card2_5_out     : out std_logic_vector(3 downto 0);
        score2_out      : out std_logic_vector(4 downto 0);
        money2_out      : out std_logic_vector(9 downto 0);
        bid2_out        : out std_logic_vector(1 downto 0);
        split2_out      : out std_logic;
        insurance2_out  : out std_logic;
        doubledown2_out : out std_logic;

        player_c_out    : out std_logic;
        card3_1_out     : out std_logic_vector(3 downto 0);
        card3_2_out     : out std_logic_vector(3 downto 0);
        card3_3_out     : out std_logic_vector(3 downto 0);
        card3_4_out     : out std_logic_vector(3 downto 0);
        card3_5_out     : out std_logic_vector(3 downto 0);
        score3_out      : out std_logic_vector(4 downto 0);
        money3_out      : out std_logic_vector(9 downto 0);
        bid3_out        : out std_logic_vector(1 downto 0);
        split3_out      : out std_logic;
        insurance3_out  : out std_logic;
        doubledown3_out : out std_logic;

        player_d_out    : out std_logic;
        card4_1_out     : out std_logic_vector(3 downto 0);
        card4_2_out     : out std_logic_vector(3 downto 0);
        card4_3_out     : out std_logic_vector(3 downto 0);
        card4_4_out     : out std_logic_vector(3 downto 0);
        card4_5_out     : out std_logic_vector(3 downto 0);
        score4_out      : out std_logic_vector(4 downto 0);
        money4_out      : out std_logic_vector(9 downto 0);
        bid4_out        : out std_logic_vector(1 downto 0);
        split4_out      : out std_logic;
        insurance4_out  : out std_logic;
        doubledown4_out : out std_logic;

        -- dealer
        card5_1_out : out std_logic_vector(3 downto 0);
        card5_2_out : out std_logic_vector(3 downto 0);
        card5_3_out : out std_logic_vector(3 downto 0);
        card5_4_out : out std_logic_vector(3 downto 0);
        card5_5_out : out std_logic_vector(3 downto 0);
        score5_out  : out std_logic_vector(4 downto 0);

        -- split
        card6_1_out : out std_logic_vector(3 downto 0);
        card6_2_out : out std_logic_vector(3 downto 0);
        card6_3_out : out std_logic_vector(3 downto 0);
        card6_4_out : out std_logic_vector(3 downto 0);
        card6_5_out : out std_logic_vector(3 downto 0);
        score6_out  : out std_logic_vector(4 downto 0)
    );
end entity memory_v2;

architecture behavior of memory_v2 is
    component input_ff port (
        clk : in std_logic;
        D   : in std_logic;
        Q   : out std_logic);
    end component;

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
        clk            : in std_logic;
        rst            : in std_logic;
        mem_rst        : in std_logic;
        enable         : in std_logic;
        bid_enable     : in std_logic;
        profit         : in std_logic_vector(6 downto 0);
        bid            : in std_logic_vector(4 downto 0);
        bid_in         : in std_logic_vector(1 downto 0);
        insurance_in   : in std_logic;
        doubledown_in  : in std_logic;
        player_in      : in std_logic;
        split_in       : in std_logic;
        bid_out        : out std_logic_vector(1 downto 0);
        money          : out std_logic_vector(9 downto 0);
        insurance_out  : out std_logic;
        doubledown_out : out std_logic;
        player_out     : out std_logic;
        split_out      : out std_logic);
    end component;

    signal h1, h2, h3, h4, h5, h6 : std_logic                    := '0';
    signal profit                 : std_logic_vector(6 downto 0) := "0000000";
    signal bid                    : std_logic_vector(4 downto 0) := "00000";
    signal bid_temp               : std_logic_vector(1 downto 0) := "00";
    signal win_type_temp          : std_logic_vector(2 downto 0) := "000";
    signal player_temp            : std_logic_vector(2 downto 0) := "000";
    signal enable_i               : std_logic                    := '0';
begin
    h1_l : hand port map(clk => clk, rst => rst or end_round, enable => h1, card => card_in, card1 => card1_1_out, card2 => card1_2_out, card3 => card1_3_out, card4 => card1_4_out, card5 => card1_5_out, score => score1_out);
    h2_l : hand port map(clk => clk, rst => rst or end_round, enable => h2, card => card_in, card1 => card2_1_out, card2 => card2_2_out, card3 => card2_3_out, card4 => card2_4_out, card5 => card2_5_out, score => score2_out);
    h3_l : hand port map(clk => clk, rst => rst or end_round, enable => h3, card => card_in, card1 => card3_1_out, card2 => card3_2_out, card3 => card3_3_out, card4 => card3_4_out, card5 => card3_5_out, score => score3_out);
    h4_l : hand port map(clk => clk, rst => rst or end_round, enable => h4, card => card_in, card1 => card4_1_out, card2 => card4_2_out, card3 => card4_3_out, card4 => card4_4_out, card5 => card4_5_out, score => score4_out);
    h5_l : hand port map(clk => clk, rst => rst or end_round, enable => h5, card => card_in, card1 => card5_1_out, card2 => card5_2_out, card3 => card5_3_out, card4 => card5_4_out, card5 => card5_5_out, score => score5_out);
    h6_l : hand port map(clk => clk, rst => rst or end_round, enable => h6, card => card_in, card1 => card6_1_out, card2 => card6_2_out, card3 => card6_3_out, card4 => card6_4_out, card5 => card6_5_out, score => score6_out);

    p1_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h1, bid_enable => bid_enable, player_in => player_a_in, split_in => split, profit => profit, bid => bid, bid_in => bid1_in, insurance_in => insurance, doubledown_in => doubledown, player_out => player_a_out, bid_out => bid1_out, money => money1_out, insurance_out => insurance1_out, doubledown_out => doubledown1_out, split_out => split1_out);
    p2_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h2, bid_enable => bid_enable, player_in => player_b_in, split_in => split, profit => profit, bid => bid, bid_in => bid2_in, insurance_in => insurance, doubledown_in => doubledown, player_out => player_b_out, bid_out => bid2_out, money => money2_out, insurance_out => insurance2_out, doubledown_out => doubledown2_out, split_out => split2_out);
    p3_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h3, bid_enable => bid_enable, player_in => player_c_in, split_in => split, profit => profit, bid => bid, bid_in => bid3_in, insurance_in => insurance, doubledown_in => doubledown, player_out => player_c_out, bid_out => bid3_out, money => money3_out, insurance_out => insurance3_out, doubledown_out => doubledown3_out, split_out => split3_out);
    p4_l : player port map(clk => clk, rst => rst, mem_rst => end_round, enable => h4, bid_enable => bid_enable, player_in => player_d_in, split_in => split, profit => profit, bid => bid, bid_in => bid4_in, insurance_in => insurance, doubledown_in => doubledown, player_out => player_d_out, bid_out => bid4_out, money => money4_out, insurance_out => insurance4_out, doubledown_out => doubledown4_out, split_out => split4_out);

    flipflup : input_ff port map(clk => clk, D => enable, Q => enable_i);

    process (recieving_hand, bid1_in, bid2_in, bid3_in, bid4_in, win_type1_in, win_type2_in, win_type3_in, win_type4_in, enable)
    begin
        case recieving_hand is
            when "001" =>
                h1            <= enable;
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid1_in;
                win_type_temp <= win_type1_in;
            when "010" =>
                h1            <= '0';
                h2            <= enable;
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid2_in;
                win_type_temp <= win_type2_in;
            when "011" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= enable;
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid3_in;
                win_type_temp <= win_type3_in;
            when "100" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= enable;
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= bid4_in;
                win_type_temp <= win_type4_in;
            when "101" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= enable;
                h6            <= '0';
                bid_temp      <= "00";
                win_type_temp <= "000";
            when "110" =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= enable;
                bid_temp      <= "00";
                win_type_temp <= "000";
            when others =>
                h1            <= '0';
                h2            <= '0';
                h3            <= '0';
                h4            <= '0';
                h5            <= '0';
                h6            <= '0';
                bid_temp      <= "00";
                win_type_temp <= "000";
        end case;
    end process;

    process (bid_temp, win_type_temp, doubledown)
    begin
        case bid_temp is
            when "00" =>
                case win_type_temp is -- 00 = win, 01 = blackjack_win, 10 = insurance_win, 11 = doubledown_win * /
                    when "001" =>
                        profit <= "0000101";
                    when "010" =>
                        profit <= "0000011";
                    when "011" =>
                        profit <= "0001000";
                    when "100" =>
                        profit <= "0000100";
                    when others =>
                        profit <= "0000000";
                end case;
            when "01" =>
                case win_type_temp is
                    when "001" =>
                        profit <= "0001111";
                    when "010" =>
                        profit <= "0001001";
                    when "011" =>
                        profit <= "0011000";
                    when "100" =>
                        profit <= "0001100";
                    when others =>
                        profit <= "0000000";
                end case;
            when "10" =>
                case win_type_temp is
                    when "001" =>
                        profit <= "0011001";
                    when "010" =>
                        profit <= "0001111";
                    when "011" =>
                        profit <= "0101000";
                    when "100" =>
                        profit <= "0010100";
                    when others =>
                        profit <= "0000000";
                end case;
            when "11" =>
                case win_type_temp is
                    when "001" =>
                        profit <= "0110010";
                    when "010" =>
                        profit <= "0001110";
                    when "011" =>
                        profit <= "1010000";
                    when "100" =>
                        profit <= "0101000";
                    when others =>
                        profit <= "0000000";
                end case;
            when others =>
                profit <= "0000000";
        end case;

        if (doubledown = '1') then
            case bid_temp is
                when "00" =>
                    bid <= "00010";
                when "01" =>
                    bid <= "00110";
                when "10" =>
                    bid <= "01010";
                when "11" =>
                    bid <= "10100";
                when others =>
                    bid <= "00000";
            end case;
        else
            case bid_temp is
                when "00" =>
                    bid <= "00001";
                when "01" =>
                    bid <= "00011";
                when "10" =>
                    bid <= "00101";
                when "11" =>
                    bid <= "01010";
                when others =>
                    bid <= "00000";
            end case;
        end if;
    end process;

    process (clk, rst, enable_i, player_in)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                player_temp <= "001";
            elsif (enable_i = '1') then
                player_temp <= player_in;
            else
                player_temp <= player_temp;
            end if;
        end if;
    end process;

    player_out <= player_temp;
end behavior;
