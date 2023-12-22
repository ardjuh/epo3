library IEEE;
use IEEE.std_logic_1164.all;

architecture behaviour of hand is
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                card1 <= "0000";
                card2 <= "0000";
                card3 <= "0000";
                card4 <= "0000";
                card5 <= "0000";
            elsif (enable = '1') then
                if (card1 = "0000") then
                    card1 <= card;
                elsif (card2 = "0000") then
                    card2 <= card;
                elsif (card3 = "0000") then
                    card3 <= card;
                elsif (card4 = "0000") then
                    card4 <= card;
                elsif (card5 = "0000") then
                    card5 <= card;
                else
                    null;
                end if;
            end if;
        end if;
    end process;

end behaviour;