library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of player is
    signal money_sig : std_logic_vector(9 downto 0);
	 signal money_i : std_logic_vector(9 downto 0);
	 signal insurance_i, doubledown_i, split_i, player_i : std_logic;
	 signal bid_i : std_logic_vector(1 downto 0);
begin
    money_sig <= money_i;

    process (clk)
    begin
        if (rising_edge(clk)) then
            bid_i        <= bid_i;
            money_i          <= money_i;
            insurance_i  <= insurance_i;
            doubledown_i <= doubledown_i;
            player_i     <= player_i;
            split_i      <= split_i;
            if (rst = '1') then
                bid_i        <= "00";
                money_i          <= "0001100100";
                insurance_i  <= '0';
                doubledown_i <= '0';
                player_i     <= '1';
                split_i      <= '0';
            elsif (mem_rst = '1') then
                bid_i        <= "00";
                insurance_i  <= '0';
                doubledown_i <= '0';
                player_i     <= '1';
                split_i      <= '0';
            elsif (bid_enable = '1') then
                bid_i <= bid_in;
                money_i   <= std_logic_vector(unsigned(money_sig) - unsigned(bid));
            elsif (enable = '1') then
                money_i          <= std_logic_vector(unsigned(money_sig) + unsigned(profit));
                player_i     <= player_in and player_i;
                insurance_i  <= insurance_in or insurance_i;
                doubledown_i <= doubledown_in or doubledown_i;
                split_i      <= split_in or split_i;
            end if;
        end if;
    end process;
	 
            bid_out        <= bid_i;
            money          <= money_i;
            insurance_out  <= insurance_i;
            doubledown_out <= doubledown_i;
            player_out     <= player_i;
            split_out      <= split_i;
end behaviour;
