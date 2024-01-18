library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of hand is
	signal card1_i, card2_i, card3_i, card4_i, card5_i : std_logic_vector(3 downto 0);
begin
    process (clk, rst, enable, card)
    begin
        if (rising_edge(clk)) then
            card1_i <= card1_i;
            card2_i <= card2_i;
            card3_i <= card3_i;
            card4_i <= card4_i;
            card5_i <= card5_i;
            if (rst = '1') then
                card1_i <= "0000";
                card2_i <= "0000";
                card3_i <= "0000";
                card4_i <= "0000";
                card5_i <= "0000";
            elsif (enable = '1' and card /= "0000") then
                if (card1_i = "0000") then
                    card1_i <= card;
                elsif (card2_i = "0000") then
                    card2_i <= card;
                elsif (card3_i = "0000") then
                    card3_i <= card;
                elsif (card4_i = "0000") then
                    card4_i <= card;
                elsif (card5_i = "0000") then
                    card5_i <= card;
                end if;
            end if;
        end if;
    end process;

    process (card1_i, card2_i, card3_i, card4_i, card5_i)
        variable newScore : integer range 0 to 63;
        variable aces     : integer range 0 to 5;
    begin
        if ((card1_i = "0001" and (card2_i = "1010" or card2_i = "1011" or card2_i = "1100" or card2_i = "1101")) or (card2_i = "0001" and (card1_i = "1010" or card1_i = "1011" or card1_i = "1100" or card1_i = "1101"))) then -- blackjack
            score <= "11111";
        else
            null;
        end if;
        newScore := 0;
        aces     := 0;
        if (card1_i = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card1_i)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card1_i));
        end if;
        if (card2_i = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card2_i)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card2_i));
        end if;
        if (card3_i = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card3_i)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card3_i));
        end if;
        if (card4_i = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card4_i)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card4_i));
        end if;
        if (card5_i = "0001") then
            newScore := newScore + 11;
            aces     := aces + 1;
        elsif (to_integer(unsigned(card5_i)) > 10) then
            newScore := newScore + 10;
        else
            newScore := newScore + to_integer(unsigned(card5_i));
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
        if (newScore < 22 and card5_i /= "0000") then
            score <= "10101"; -- 5 cards charlie
        else
            score <= std_logic_vector(to_unsigned(newScore, 5));
        end if;
    end process;

	 
	card1 <= card1_i;
	card2 <= card2_i;
	card3 <= card3_i;
	card4 <= card4_i;
	card5 <= card5_i;
end behaviour;
