library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of hand is
begin
    process (clk, rst, enable, card)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                card1 <= "0000";
                card2 <= "0000";
                card3 <= "0000";
                card4 <= "0000";
                card5 <= "0000";
            elsif (enable = '1' and card /= "0000") then
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

    process (card1, card2, card3, card4, card5)
        variable newScore : integer range 0 to 63;
        variable aces     : integer range 0 to 5;
    begin
        if ((card1 = "0001" and (card2 = "1010" or card2 = "1011" or card2 = "1100" or card2 = "1101")) or (card2 = "0001" and (card1 = "1010" or card1 = "1011" or card1 = "1100" or card1 = "1101"))) then -- blackjack
            score <= "11111";
        else
            null;
        end if;
        newScore := 0;
        aces     := 0;
        if (card1 = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card1)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card1));
        end if;
        if (card2 = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card2)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card2));
        end if;
        if (card3 = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card3)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card3));
        end if;
        if (card4 = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card4)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card4));
        end if;
        if (card5 = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card5)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card5));
        end if;
        if (newScore > 21 and aces > 0) then
            newScore := newScore - 10;
            aces     := aces - 1;
        else
            null;
        end if;
        if (newScore > 21 and aces > 0) then
            newScore := newScore - 10;
            aces     := aces - 1;
        else
            null;
        end if;
        if (newScore > 21 and aces > 0) then
            newScore := newScore - 10;
            aces     := aces - 1;
        else
            null;
        end if;
        if (newScore > 21 and aces > 0) then
            newScore := newScore - 10;
            aces     := aces - 1;
        else
            null;
        end if;
        if (newScore < 22 and card5 /= "0000") then
            score <= "10101"; -- 5 cards charlie
        else
            score <= std_logic_vector(to_unsigned(newScore, 5));
        end if;
    end process;

end behaviour;