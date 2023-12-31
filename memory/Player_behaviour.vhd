library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of player is
    signal budget_sig : std_logic_vector(9 downto 0);
begin
    budget_sig <= budget;

    process (clk)
    begin

        if (rising_edge(clk)) then
            if (rst = '1') then
                bid_out        <= "00";
                budget         <= "0000000000";
                insurance_out  <= '0';
                doubledown_out <= '0';
            elsif (memrst = '1') then
                bid_out        <= "00";
                insurance_out  <= '0';
                doubledown_out <= '0';
            else

                if (profit_enable = '1') then
                    budget <= std_logic_vector(unsigned(budget_sig) + unsigned(profit));
                end if;
                if (stake_enable = '1') then
                    budget <= std_logic_vector(unsigned(budget_sig) - unsigned(stake));
                end if;
                if (bid_in_enable = '1') then
                    bid_out <= bid_in;
                end if;
                if (insurance_in_enable = '1') then
                    insurance_out <= insurance_in;
                end if;
                if (doubledown_in_enable = '1') then
                    doubledown_out <= doubledown_in;
                end if;
            end if;
        end if;
    end process;
end behaviour;