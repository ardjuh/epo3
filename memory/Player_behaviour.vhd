library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of player is
    signal money_sig : std_logic_vector(9 downto 0);
begin
    money_sig <= money;

    process (clk)
    begin

        if (rising_edge(clk)) then
            if (rst = '1') then
                bid_out        <= "00";
                money          <= "0001100100";
                insurance_out  <= '0';
                doubledown_out <= '0';
                player_out     <= '1';
                split_out      <= '0';
            elsif (mem_rst = '1') then
                bid_out        <= "00";
                insurance_out  <= '0';
                doubledown_out <= '0';
                player_out     <= '1';
                split_out      <= '0';
            elsif (enable = '1') then
                money          <= std_logic_vector(unsigned(money_sig) + unsigned(profit) - unsigned(stake));
                bid_out        <= bid_in;
                player_out     <= player_in and player_out;
                insurance_out  <= insurance_in or insurance_out;
                doubledown_out <= doubledown_in or doubledown_out;
                split_out      <= split_in or split_out;
            end if;
        end if;
    end process;
end behaviour;