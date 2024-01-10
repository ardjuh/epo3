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
                money         <= "0000000000";
                insurance_out  <= '0';
                doubledown_out <= '0';
            elsif (mem_rst = '1') then
                bid_out        <= "00";
                insurance_out  <= '0';
                doubledown_out <= '0';
            else

                if (profit_enable = '1') then
                    money <= std_logic_vector(unsigned(money_sig) + unsigned(profit));
                end if;
                if (stake_enable = '1') then
                    money <= std_logic_vector(unsigned(money_sig) - unsigned(stake));
                end if;
                if (bid_enable = '1') then
                    bid_out <= bid_in;
                end if;
                if (insurance_enable = '1') then
                    insurance_out <= insurance_in;
                end if;
                if (doubledown_enable = '1') then
                    doubledown_out <= doubledown_in;
                end if;
            end if;
        end if;
    end process;
end behaviour;