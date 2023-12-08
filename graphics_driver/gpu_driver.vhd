library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
architecture behavior of gpu_driver is
    signal x_pos : integer range -145 to 878;
    signal y_pos : integer range -32 to 991;
    signal r     : integer range 0 to 15;
    signal g     : integer range 0 to 15;
    signal b     : integer range 0 to 15;

    -- Display a small letter 5x7
    function small_letter (
        x      : integer range 0 to 5;
        y      : integer range 0 to 6;
        letter : integer range 0 to 27
    ) return std_logic is
    begin
        if (x = 5) then -- Padding right
            return '0';
        elsif (letter = 0) then -- Space
            return '0';
        elsif (letter = 1) then -- A
            if (((x = 0 or x = 4) and y > 0) or y = 4 or (y = 0 and x > 0 and x < 4)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 2) then -- B
            if (x = 0 or ((y = 0 or y = 3 or y = 6) and x < 4) or (x = 4 and (y = 1 or y = 2 or y = 4 or y = 5))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 3) then -- C
            if ((x = 0 and (y > 0 and y < 6)) or ((y = 0 or y = 6) and x > 0 and x < 4) or (x = 4 and (y = 1 or y = 5))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 4) then -- D
            if (x = 0 or ((y = 0 or y = 6) and x < 4) or (x = 4 and y > 0 and y < 6)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 5) then -- E
            if (x = 0 or y = 0 or y = 6 or (y = 3 and x < 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 6) then -- F
            if (x = 0 or y = 0 or (y = 3 and x < 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 7) then -- G
            if ((x = 0 and (y > 0 and y < 6)) or ((y = 0 or y = 6) and x > 0 and x < 4) or (x = 4 and (y = 1 or y = 5 or y = 6)) or (y = 3 and x > 2)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 8) then -- H
            if (x = 0 or x = 4 or y = 3) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 9) then -- I
            if (x = 2 or y = 0 or y = 6) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 10) then -- J
            if (y = 0 or (x = 3 and y < 6) or (x = 0 and y > 3 and y < 6) or (y = 6 and x > 0 and x < 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 11) then -- K
            if (x = 0 or (y = 3 and x < 3) or (x = 3 and (y = 2 or y = 4)) or (x = 4 and (y = 0 or y = 1 or y = 5 or y = 6))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 12) then -- L
            if (x = 0 or y = 6) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 13) then -- M
            if (x = 0 or x = 4 or (y = 1 and (x = 1 or x = 3)) or ((y = 2 or y = 3) and x = 2)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 14) then -- N
            if (x = 0 or x = 4 or (y = 2 and x = 1) or (y = 3 and x = 2) or (y = 4 and x = 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 15) then -- O
            if (((x = 0 or x = 4) and (y > 0 and y < 6)) or ((y = 0 or y = 6) and x > 0 and x < 4)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 16) then -- P
            if (x = 0 or ((y = 0 or y = 3) and x < 4) or (x = 4 and (y = 1 or y = 2))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 17) then -- Q
            if ((x = 0 and (y > 0 and y < 6)) or (y = 0 and x > 0 and x < 4) or (x = 2 and y = 4) or (x = 3 and y = 5) or (x = 4 and y = 6) or (x = 4 and y > 0 and y < 5) or (y = 6 and x > 0 and x < 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 18) then -- R
            if (x = 0 or ((y = 0 or y = 4) and x < 4) or (x = 4 and ((y > 0 and y < 4) or y = 5 or y = 6))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 19) then -- S
            if ((x = 0 and (y = 1 or y = 2 or y = 6)) or ((y = 0 or y = 3 or y = 6) and x > 0 and x < 4) or (x = 4 and (y = 0 or y = 4 or y = 5))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 20) then -- T
            if (x = 2 or y = 0) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 21) then -- U
            if (((x = 0 or x = 4) and y < 6) or (y = 6 and x > 0 and x < 4)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 22) then -- V
            if (((x = 0 or x = 4) and y < 4) or (y = 4 and (x = 1 or x = 3)) or ((y = 5 or y = 6) and x = 2)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 23) then -- W
            if (x = 0 or x = 4 or (y = 5 and (x = 1 or x = 3)) or (x = 2 and (y = 3 or y = 4))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 24) then -- X
            if (((x = 0 or x = 4) and (y < 3 or y > 5)) or ((x = 1 or x = 3) and (y = 2 or y = 4)) or (x = 2 and y = 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 25) then -- Y
            if (((x = 0 or x = 4) and y < 3) or (x = 2 and (y >= 4 and y < 7)) or ((x = 1 or x = 3) and (y = 3))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 26) then -- Z
            if (y = 0 or y = 6 or (x = 4 and y = 1) or (x = 3 and y = 2) or (x = 2 and y = 3) or (x = 1 and y = 4) or (x = 0 and y = 5)) then
                return '1';
            else
                return '0';
            end if;
        else -- :
            if (x = 2 and (y = 2 or y = 4)) then
                return '1';
            else
                return '0';
            end if;
        end if;
    end function;

    -- Display a small number 5x7
    function small_number (
        x      : integer range 0 to 5;
        y      : integer range 0 to 6;
        number : integer range 0 to 9
    ) return std_logic is
    begin
        if (x = 5) then -- Padding right
            return '0';
        elsif (number = 0) then -- 0
            if (((y = 0 or y = 6) and x > 0 and x < 4) or ((x = 0 or x = 4) and y > 0 and y < 6) or (x = 1 and y = 4) or (x = 2 and y = 3) or (x = 3 and y = 2)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 1) then -- 1
            if (x = 2 or y = 6 or (x = 1 and y = 1) or (x = 0 and y = 2)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 2) then -- 2
            if (y = 6 or (y = 0 and x > 0 and x < 4) or (x = 0 and y = 1) or (x = 1 and y = 5) or (x = 2 and y = 4) or (x = 3 and y = 3) or (x = 4 and (y = 1 or y = 2))) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 3) then -- 3
            if ((x = 0 and (y = 1 or y = 5)) or ((y = 0 or y = 6) and (x > 0 and x < 4)) or (x = 4 and (y = 1 or y = 2 or y = 4 or y = 5)) or (y = 3 and x > 1 and x < 4)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 4) then -- 4
            if ((x = 0 and y < 4) or y = 3 or x = 3) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 5) then -- 5
            if (y = 0 or ((y = 3 or y = 6) and x < 4) or (x = 0 and y < 4) or (x = 4 and y < 6 and y > 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 6) then -- 6
            if ((x = 0 and y > 0 and y < 6) or ((y = 0 or y = 3 or y = 6) and x > 0 and x < 4) or (x = 4 and ((y > 3 and y < 6) or y = 0))) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 7) then -- 7
            if (y = 0 or (x = 4 and y < 3) or (y = 3 and x < 4 and x > 1) or (x = 1 and y > 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 8) then -- 8
            if (((x = 0 or x = 4) and (y = 1 or y = 2 or y = 4 or y = 5)) or ((y = 0 or y = 3 or y = 6) and x > 0 and x < 4)) then
                return '1';
            else
                return '0';
            end if;
        else -- 9
            if ((x = 4 and y > 0 and y < 6) or ((y = 0 or y = 3 or y = 6) and x > 0 and x < 4) or (x = 0 and ((y > 0 and y < 3) or y = 5))) then
                return '1';
            else
                return '0';
            end if;
        end if;
    end function;

    -- Display a small number or letter of a card
    function small_card_char (
        x    : integer range 0 to 5;
        y    : integer range 0 to 6;
        char : integer range 0 to 13
    ) return std_logic is
    begin
        if (char = 0) then
            return '0';
        elsif (char = 1) then
            return small_letter(x, y, 1);
        elsif (char <= 9) then
            return small_number(x, y, char);
        elsif (char = 10) then
            if (x = 0 or x = 2 or x = 4 or ((y = 0 or y = 6) and x = 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (char = 11) then
            return small_letter(x, y, 10);
        elsif (char = 12) then
            return small_letter(x, y, 17);
        elsif (char = 13) then
            return small_letter(x, y, 11);
        else
            return '0';
        end if;
    end function;

    function big_number(
        x      : integer range 0 to 9;
        y      : integer range 0 to 19;
        number : integer range 0 to 13
    ) return std_logic is
    begin
        if (number = 0) then --no card
            return '0';
        elsif (number = 1) then --A 
            if (x > 4 and x < 7 and y = 0) then
                return '1';
            elsif ((x = 3 or x = 6) and y >= 0 and y < 3) then
                return '1';
            elsif ((x = 2 or x = 7) and y > 2 and y < 5) then
                return '1';
            elsif ((x = 1 or x = 8) and y > 4 and y < 9) then
                return '1';
            elsif ((x = 0 or x = 11) and y > 8) then
                return '1';
            elsif (y = 13) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 2) then --2
            if (x > 2 and x < 7 and y = 0) then
                return '1';
            elsif (((x > 0 and x < 3) or (x > 6 and x < 9)) and y = 1) then
                return '1';
            elsif ((x = 0 or x = 8) and y = 1) then
                return '1';
            elsif ((x = 0 or x = 9) and y = 2) then
                return '1';
            elsif (x = 9 and y > 3 and y < 10) then
                return '1';
            elsif (x = 8 and y = 10) then
                return '1';
            elsif (x = 7 and y > 10 and y < 13) then
                return '1';
            elsif (x > 4 and x < 7 and y = 13) then
                return '1';
            elsif (x = 4 and y > 13 and y < 16) then
                return '1';
            elsif (x > 1 and x < 4 and y = 16) then
                return '1';
            elsif (x = 1 and y > 16) then
                return '1';
            elsif (y = 19) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 3) then --3
            if ((x = 0 or x = 9) and ((y < 16 and y > 11) or (y < 8 and y > 3))) then
                return'1';
            elsif ((x = 1 or x = 8) and ((y < 18 and y > 15) or (y < 4 and y > 1))) then
                return '1';
            elsif (x > 1 and (x < 3 or x > 5) and x < 8 and (y = 1 or y = 18)) then
                return '1';
            elsif ((y = 0 or Y = 19) and x > 2 and x < 7) then
                return'1';
            elsif (x = 8 and (y = 11 or y = 8)) then
                return '1';
            elsif (x = 7 and y > 8 and y < 11) then
                return'1';
            else
                return '0';
            end if;
        elsif (number = 4) then --4
            if (x = 0 and y >= 0 and y < 10) then
                return '1';
            elsif (x = 9 and y >= 0) then
                return '1';
            elsif (x < 10 and y = 9) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 5) then --5
            if (y = 0) then
                return '1';
            elsif (x = 0 and (y < 7 or y = 18)) then
                return'1';
            elsif (x > 0 and x < 7 and y = 19) then
                return '1';
            elsif (x > 0 and x < 3 and y = 7) then
                return '1';
            elsif (x > 2 and x < 8 and y = 8) then
                return '1';
            elsif (x > 7 and y = 9) then
                return '1';
            elsif (x = 9 and y > 9 and y < 17) then
                return'1';
            elsif (x = 8 and y = 17) then
                return '1';
            elsif (x > 6 and x < 9 and y = 18) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 6) then --6
            if (x > 3 and y = 0) then
                return '1';
            elsif (x > 1 and x < 4 and y = 1) then
                return '1';
            elsif (x = 1 and y = 2) then
                return '1';
            elsif (x = 0 and y > 2 and y < 17) then
                return '1';
            elsif (x = 1 and y = 11) then
                return '1';
            elsif (x = 1 and y < 19 and y > 16) then
                return '1';
            elsif (x > 1 and x < 7 and (y = 10 or y = 19)) then
                return'1';
            elsif (x = 2 and y = 18) then
                return '1';
            elsif (x = 7 and (y = 18 or (y < 13 and y > 10))) then
                return'1';
            elsif (x = 8 and y < 18 and y > 12) then
                return'1';
            else
                return '0';
            end if;
        elsif (number = 7) then --7
            if (y = 0) then
                return '1';
            elsif (y > 0 and y < 3 and x = 8) then
                return '1';
            elsif (y > 2 and x = 7) then
                return '1';
            elsif (y = 10 and x > 3) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 8) then --8
            if ((y = 0 or y = 19) and x > 1 and x < 8) then
                return'1';
            elsif ((x = 1 or x = 8) and y > 0 and (y < 3 or y > 5) and (y < 8 or y > 10) and (y < 13 or y > 15) and y < 19) then
                return '1';
            elsif ((x = 0 or x = 9) and y > 2 and y < 6) then
                return '1';
            elsif (x > 1 and (x < 4 or x > 5) and x > 8 and (y = 8 or y = 10)) then
                return '1';
            elsif (y = 9 and x > 3 and x < 6) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 9) then --9
            if ((y = 0 or y = 19) and x > 1 and x < 8) then
                return '1';
            elsif ((x = 1 or x = 8) and y > 0 and y < 3) then
                return '1';
            elsif (x = 0 and y > 2 and y < 8) then
                return '1';
            elsif (x = 1 and y > 6 and y < 10) then
                return '1';
            elsif (x = 8 and y = 9) then
                return '1';
            elsif (x = 9 and y > 2 and y < 19) then
                return '1';
            elsif (x > 1 and x < 8 and y = 10) then
                return '1';
            elsif (x > 6 and y = 18) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 10) then --10
            if (x = 0) then
                return'1';
            elsif ((y = 0 or y = 19) and x > 3 and x < 8) then
                return'1';
            elsif ((x = 9 or x = 3) and y > 0 and y < 19) then
                return '1';
            else
                return '0';
            end if;
elsif (number = 11) then --J
            if (y = 0 and x > 1 and x < 10) then
                return'1';
            elsif (x = 7 and y < 18) then
                return '1';
	    elsif (x = 6 and y > 16 and y < 19) then
                return '1';
            elsif (x = 5 and y > 17) then
                return '1';
            elsif (x = 2 and y > 17) then
                return '1';
            elsif ((x = 3 or x = 4) and y = 19) then
                return '1';
            elsif (x = 1 and y > 16 and y  19) then
                return '1';
            elsif (x = 0 and y > 15 and y < 18) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 12) then --Q
            if ((y = 0 or y = 19)and x > 1 and x < 8) then
                return '1';
            elsif ((x = 0 or x = 9) and y > 2 and y < 18) then
                return '1';
            elsif ((x = 1 or x = 8) and (y = 2 or y = 18)) then
                return '1';
            elsif (x = 6 and y = 16) then
                return '1';
            elsif (x = 7 and y = 17) then
                return '1';
            elsif (x = 9 and y = 19) then
                return '1';
            else
                return '0';
            end if;
        else --K
            if (x = 0) then
                return '1';
            elsif (x = 1 and y > 7 and y < 12) then
                return'1';
            elsif (x = 2 and (y = 7 or y = 12)) then
                return '1';
            elsif (x = 3 and (y = 6 or y = 13)) then
                return'1';
            elsif (x = 4 and (y = 5 or y = 14)) then
                return'1';
            elsif (x = 5 and (y = 4 or y = 15)) then
                return '1';
            elsif (x = 6 and (y = 3 or y = 16)) then
                return '1';
            elsif (x = 7 and (y = 2 or y = 17)) then
                return '1';
            elsif (x = 8 and (y = 1 or y = 18)) then
                return '1';
            elsif (x = 9 and (y = 0 or y = 19)) then
                return'1';
            else
                return '0';
            end if;
        end if;
    end function;

    function table (
        x       : integer range 0 to 115;
        y       : integer range 0 to 38;
        player1 : std_logic;
        card1_1 : integer range 0 to 13  := 0;
        card1_2 : integer range 0 to 13  := 0;
        card1_3 : integer range 0 to 13  := 0;
        card1_4 : integer range 0 to 13  := 0;
        card1_5 : integer range 0 to 13  := 0;
        money1  : integer range 0 to 999 := 0;

        player2 : std_logic;
        card2_1 : integer range 0 to 13  := 0;
        card2_2 : integer range 0 to 13  := 0;
        card2_3 : integer range 0 to 13  := 0;
        card2_4 : integer range 0 to 13  := 0;
        card2_5 : integer range 0 to 13  := 0;
        money2  : integer range 0 to 999 := 0;

        player3 : std_logic;
        card3_1 : integer range 0 to 13  := 0;
        card3_2 : integer range 0 to 13  := 0;
        card3_3 : integer range 0 to 13  := 0;
        card3_4 : integer range 0 to 13  := 0;
        card3_5 : integer range 0 to 13  := 0;
        money3  : integer range 0 to 999 := 0;

        player4 : std_logic;
        card4_1 : integer range 0 to 13  := 0;
        card4_2 : integer range 0 to 13  := 0;
        card4_3 : integer range 0 to 13  := 0;
        card4_4 : integer range 0 to 13  := 0;
        card4_5 : integer range 0 to 13  := 0;
        money4  : integer range 0 to 999 := 0
    ) return std_logic is
    begin
        if (y < 7) then
            if (x < 6) then
                return small_letter(x, y, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y, 18); --R
            elsif (x < 42) then
                return small_letter(x - 36, y, 0); --Space
            elsif (x < 48) then
                return small_letter(x - 42, y, 13); --M
            elsif (x < 54) then
                return small_letter(x - 48, y, 15); --O
            elsif (x < 60) then
                return small_letter(x - 54, y, 14); --N
            elsif (x < 66) then
                return small_letter(x - 60, y, 5); --E
            elsif (x < 72) then
                return small_letter(x - 66, y, 25); --Y
            elsif (x < 78) then
                return small_letter(x - 72, y, 0); --Space
            elsif (x < 84) then
                return small_letter(x - 78, y, 3); --C
            elsif (x < 90) then
                return small_letter(x - 84, y, 1); --A
            elsif (x < 96) then
                return small_letter(x - 90, y, 18); --R
            elsif (x < 102) then
                return small_letter(x - 96, y, 4); --D
            elsif (x<108) then
                return small_letter(x - 102, y, 19); --S
				else
				return '0';
            end if;
        elsif (y >= 11 and y < 18) then
            if (x < 6) then
                return small_letter(x, y - 11, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 11, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 11, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 11, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 11, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 11, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 11, 1); --1
            elsif (x < 48) then
                return small_letter(x - 42, y - 11, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 11, money1/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 11, (money1/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 11, money1 mod 10);
            elsif (x < 72) then
                return small_letter(x - 66, y - 11, 0); --Space
            elsif (x < 78 and card1_1 > 0) then
                return small_card_char(x - 72, y - 11, card1_1); --Player1 card 1
            elsif (x < 84 and card1_2 > 0) then
                return small_card_char(x - 78, y - 11, card1_2); --Player1 card 2
            elsif (x < 90 and card1_3 > 0) then
                return small_card_char(x - 84, y - 11, card1_3); --Player1 card 3
            elsif (x < 96 and card1_4 > 0) then
                return small_card_char(x - 90, y - 11, card1_4); --Player1 card 4
            elsif (x < 102 and card1_5 > 0) then
                return small_card_char(x - 96, y - 11, card1_5); --Player1 card 5
            else
                return '0';
            end if;
        elsif (y >= 19 and y < 26) then
            if (x < 6) then
                return small_letter(x, y - 19, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 19, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 19, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 19, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 19, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 19, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 19, 2); --2
            elsif (x < 48) then
                return small_letter(x - 42, y - 19, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 19, money2/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 19, (money2/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 19, money2 mod 10);
            elsif (x < 72) then
                return small_letter(x - 66, y - 19, 0); --Space
            elsif (x < 78 and card2_1 > 0) then
                return small_card_char(x - 72, y - 19, card2_1); --Player2 card 1
            elsif (x < 84 and card2_2 > 0) then
                return small_card_char(x - 78, y - 19, card2_2); --Player2 card 2
            elsif (x < 90 and card2_3 > 0) then
                return small_card_char(x - 84, y - 19, card2_3); --Player2 card 3
            elsif (x < 96 and card2_4 > 0) then
                return small_card_char(x - 90, y - 19, card2_4); --Player2 card 4
            elsif (x < 102 and card2_5 > 0) then
                return small_card_char(x - 96, y - 19, card2_5); --Player2 card 5
            else
                return '0';
            end if;
        elsif (y >= 27 and y < 34) then
            if (x < 6) then
                return small_letter(x, y - 27, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 27, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 27, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 27, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 27, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 27, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 27, 3); --3
            elsif (x < 48) then
                return small_letter(x - 42, y - 27, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 27, money3/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 27, (money3/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 27, money3 mod 10);
            elsif (x < 72) then
                return small_letter(x - 66, y - 27, 0); --Space
            elsif (x < 78 and card3_1 > 0) then
                return small_card_char(x - 72, y - 27, card3_1); --Player3 card 1
            elsif (x < 84 and card3_2 > 0) then
                return small_card_char(x - 78, y - 27, card3_2); --Player3 card 2
            elsif (x < 90 and card3_3 > 0) then
                return small_card_char(x - 84, y - 27, card3_3); --Player3 card 3
            elsif (x < 96 and card3_4 > 0) then
                return small_card_char(x - 90, y - 27, card3_4); --Player3 card 4
            elsif (x < 102 and card3_5 > 0) then
                return small_card_char(x - 96, y - 27, card3_5); --Player3 card 5
            else
                return '0';
            end if;
        elsif (y >= 35) then
            if (x < 6) then
                return small_letter(x, y - 35, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 35, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 35, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 35, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 35, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 35, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 35, 4); --4
            elsif (x < 48) then
                return small_letter(x - 42, y - 35, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 35, money4/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 35, (money4/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 35, money4 mod 10);
            elsif (x < 72) then
                return small_letter(x - 66, y - 35, 0); --Space
            elsif (x < 78 and card4_1 > 0) then
                return small_card_char(x - 72, y - 35, card4_1); --Player4 card 1
            elsif (x < 84 and card4_2 > 0) then
                return small_card_char(x - 78, y - 35, card4_2); --Player4 card 2
            elsif (x < 90 and card4_3 > 0) then
                return small_card_char(x - 84, y - 35, card4_3); --Player4 card 3
            elsif (x < 96 and card4_4 > 0) then
                return small_card_char(x - 90, y - 35, card4_4); --Player4 card 4
            elsif (x < 102 and card4_5 > 0) then
                return small_card_char(x - 96, y - 35, card4_5); --Player4 card 5
            else
                return '0';
            end if;
        else
            return '0';
        end if;
    end function;

    function cards (
        x     : integer range 0 to 100;
        y     : integer range 0 to 86;
        card1 : integer range 0 to 13 := 0;
        card2 : integer range 0 to 13 := 0;
        card3 : integer range 0 to 13 := 0;
        card4 : integer range 0 to 13 := 0;
        card5 : integer range 0 to 13 := 0
    ) return std_logic is
    begin
        if (x >= 44 and card1 > 0) then
            if (x <= 45 or y <= 1 or x >= 98 or y >= 85) then
                return '1';
            elsif (x >= 70 and x < 80 and y >= 33 and y < 53) then
                return big_number(x - 70, y - 33, card1);
            elsif (x >= 48 and x <= 52 and y >= 4 and y <= 10) then
                return small_card_char(x - 48, y - 4, card1);
            else
                return '0';
            end if;
        elsif (x >= 33 and x <= 43 and card2 > 0) then
            if (x <= 34 or y <= 1 or y >= 85) then
                return '1';
            elsif (x >= 37 and x < 42 and y >= 4 and y <= 10) then
                return small_card_char(x - 37, y - 4, card2);
            else
                return '0';
            end if;
        elsif (x >= 22 and x <= 32 and card3 > 0) then
            if (x <= 23 or y <= 1 or y >= 85) then
                return '1';
            elsif (x >= 26 and x <= 30 and y >= 4 and y <= 10) then
                return small_card_char(x - 26, y - 4, card3);
            else
                return '0';
            end if;
        elsif (x >= 11 and x <= 21 and card4 > 0) then
            if (x <= 12 or y <= 1 or y >= 85) then
                return '1';
            elsif (x >= 15 and x <= 19 and y >= 4 and y <= 10) then
                return small_card_char(x - 15, y - 4, card4);
            else
                return '0';
            end if;
        elsif (x <= 10 and card5 > 0) then
            if (x <= 1 or y <= 1 or y >= 85) then
                return '1';
            elsif (x >= 4 and x <= 8 and y >= 4 and y <= 10) then
                return small_card_char(x - 4, y - 4, card5);
            else
                return '0';
            end if;
        else
            return '1';
        end if;
    end function;

    function action_menu (
        x_pos     : integer range 0 to 639;
        y_pos     : integer range 0 to 99;
        em        : std_logic := '0';
        double    : std_logic := '0';
        insurance : std_logic := '0';
        split     : std_logic := '0'
    ) return std_logic is
    begin --hit
        if (y_pos >= 22 and y_pos <= 28) then
            if (x_pos >= 80 and x_pos < 98) then -- HIT
                if (x_pos < 86) then
                    return small_letter(x_pos - 80, y_pos - 22, 8);
                elsif (x_pos < 92) then
                    return small_letter(x_pos - 86, y_pos - 22, 9);
                else
                    return small_letter(x_pos - 92, y_pos - 22, 20);
                end if;
            elsif (x_pos >= 293 and x_pos < 329 and double = '1') then -- DOUBLE
                if (x_pos < 299) then
                    return small_letter(x_pos - 293, y_pos - 22, 4);
                elsif (x_pos < 305) then
                    return small_letter(x_pos - 299, y_pos - 22, 15);
                elsif (x_pos < 311) then
                    return small_letter(x_pos - 305, y_pos - 22, 21);
                elsif (x_pos < 317) then
                    return small_letter(x_pos - 311, y_pos - 22, 2);
                elsif (x_pos < 323) then
                    return small_letter(x_pos - 317, y_pos - 22, 12);
                else
                    return small_letter(x_pos - 323, y_pos - 22, 5);
                end if;
            elsif (x_pos >= 507 and x_pos < 567 and em = '1') then -- EVEN MONEY
                if (x_pos < 513) then
                    return small_letter(x_pos - 507, y_pos - 22, 5);
                elsif (x_pos < 519) then
                    return small_letter(x_pos - 513, y_pos - 22, 22);
                elsif (x_pos < 525) then
                    return small_letter(x_pos - 519, y_pos - 22, 5);
                elsif (x_pos < 531) then
                    return small_letter(x_pos - 525, y_pos - 22, 14);
                elsif (x_pos < 537) then
                    return '0';
                elsif (x_pos < 543) then
                    return small_letter(x_pos - 537, y_pos - 22, 13);
                elsif (x_pos < 549) then
                    return small_letter(x_pos - 543, y_pos - 22, 15);
                elsif (x_pos < 555) then
                    return small_letter(x_pos - 549, y_pos - 22, 14);
                elsif (x_pos < 561) then
                    return small_letter(x_pos - 555, y_pos - 22, 5);
                else
                    return small_letter(x_pos - 561, y_pos - 22, 25);
                end if;
            else
                return '0';
            end if;
        elsif (y_pos >= 72 and y_pos <= 78) then
            if (x_pos >= 80 and x_pos < 104) then -- HOLD
                if (x_pos < 86) then
                    return small_letter(x_pos - 80, y_pos - 72, 8);
                elsif (x_pos < 92) then
                    return small_letter(x_pos - 86, y_pos - 72, 15);
                elsif (x_pos < 98) then
                    return small_letter(x_pos - 92, y_pos - 72, 12);
                else
                    return small_letter(x_pos - 98, y_pos - 72, 4);
                end if;
            elsif (x_pos >= 293 and x_pos < 323 and split = '1') then -- SPLIT
                if (x_pos < 299) then
                    return small_letter(x_pos - 293, y_pos - 72, 19);
                elsif (x_pos < 305) then
                    return small_letter(x_pos - 299, y_pos - 72, 16);
                elsif (x_pos < 311) then
                    return small_letter(x_pos - 305, y_pos - 72, 12);
                elsif (x_pos < 317) then
                    return small_letter(x_pos - 311, y_pos - 72, 9);
                else
                    return small_letter(x_pos - 317, y_pos - 72, 20);
                end if;
            elsif (x_pos >= 507 and x_pos < 561 and insurance = '1') then -- INSURANCE
                if (x_pos < 513) then
                    return small_letter(x_pos - 507, y_pos - 72, 9);
                elsif (x_pos < 519) then
                    return small_letter(x_pos - 513, y_pos - 72, 14);
                elsif (x_pos < 525) then
                    return small_letter(x_pos - 519, y_pos - 72, 19);
                elsif (x_pos < 531) then
                    return small_letter(x_pos - 525, y_pos - 72, 21);
                elsif (x_pos < 537) then
                    return small_letter(x_pos - 531, y_pos - 72, 18);
                elsif (x_pos < 543) then
                    return small_letter(x_pos - 537, y_pos - 72, 1);
                elsif (x_pos < 549) then
                    return small_letter(x_pos - 543, y_pos - 72, 14);
                elsif (x_pos < 555) then
                    return small_letter(x_pos - 549, y_pos - 72, 3);
                else
                    return small_letter(x_pos - 555, y_pos - 72, 5);
                end if;
            else
                return '0';

            end if;
        else
            return '0';
        end if;
    end function;

    function details(
        x            : integer range 0 to 84;
        y            : integer range 0 to 36;
        player       : integer range 1 to 4;
        money        : integer range 0 to 999;
        bet          : integer range 2 to 40;
        insurance    : std_logic            := '0'
    ) return std_logic is
    begin
        if (x >= 3 and x < 51 and y >= 3 and y < 10) then -- Player {{player}}
            if (x < 9) then
                return small_letter(x - 3, y - 3, 16);
            elsif (x < 15) then
                return small_letter(x - 9, y - 3, 12);
            elsif (x < 21) then
                return small_letter(x - 15, y - 3, 1);
            elsif (x < 27) then
                return small_letter(x - 21, y - 3, 25);
            elsif (x < 33) then
                return small_letter(x - 27, y - 3, 5);
            elsif (x < 39) then
                return small_letter(x - 33, y - 3, 18);
            elsif (x < 45) then
                return '0';
            else
                return small_number(x - 45, y - 3, player);
            end if;
        elsif (x >= 3 and x < 63 and y >= 12 and y < 19) then -- Money: {{money}}
            if (x < 9) then
                return small_letter(x - 3, y - 12, 13);
            elsif (x < 15) then
                return small_letter(x - 9, y - 12, 15);
            elsif (x < 21) then
                return small_letter(x - 15, y - 12, 14);
            elsif (x < 27) then
                return small_letter(x - 21, y - 12, 5);
            elsif (x < 33) then
                return small_letter(x - 27, y - 12, 25);
            elsif (x < 39) then
                return small_letter(x - 33, y - 12, 27);
            elsif (x < 45) then
                return '0';
            elsif (x < 51) then
                return small_number(x - 45, y - 12, money / 100);
            elsif (x < 57) then
                return small_number(x - 51, y - 12, (money / 10) mod 10);
            else
                return small_number(x - 57, y - 12, money mod 10);
            end if;
        elsif (x >= 3 and x < 45 and y >= 21 and y < 28) then -- Bet: {{bet}}
            if (x < 9) then
                return small_letter(x - 3, y - 21, 2);
            elsif (x < 15) then
                return small_letter(x - 9, y - 21, 5);
            elsif (x < 21) then
                return small_letter(x - 15, y - 21, 20);
            elsif (x < 27) then
                return small_letter(x - 21, y - 21, 27);
            elsif (x < 33) then
                return '0';
            elsif (x < 39) then
                return small_number(x - 33, y - 21, bet / 10);
            else
                return small_number(x - 39, y - 21, bet mod 10);
            end if;
        elsif (x >= 3 and x < 87 and y >= 30) then -- Insurance: {{insurance}}
            if (x < 9) then
                return small_letter(x - 3, y - 30, 9);
            elsif (x < 15) then
                return small_letter(x - 9, y - 30, 14);
            elsif (x < 21) then
                return small_letter(x - 15, y - 30, 19);
            elsif (x < 27) then
                return small_letter(x - 21, y - 30, 21);
            elsif (x < 33) then
                return small_letter(x - 27, y - 30, 18);
            elsif (x < 39) then
                return small_letter(x - 33, y - 30, 1);
            elsif (x < 45) then
                return small_letter(x - 39, y - 30, 14);
            elsif (x < 51) then
                return small_letter(x - 45, y - 30, 3);
            elsif (x < 57) then
                return small_letter(x - 51, y - 30, 5);
            elsif (x < 63) then
                return small_letter(x - 57, y - 30, 27);
            elsif (x < 69) then
                return '0';
            elsif (insurance = '1') then -- Yes
                if (x < 75) then
                    return small_letter(x - 69, y - 30, 25);
                elsif (x < 81) then
                    return small_letter(x - 75, y - 30, 5);
                else
                    return small_letter(x - 81, y - 30, 19);
                end if;
            else -- No
                if (x < 75) then
                    return small_letter(x - 69, y - 30, 14);
                elsif (x < 81) then
                    return small_letter(x - 75, y - 30, 15);
                else
                    return '0';
                end if;
            end if;
        else
            return '0';
        end if;
    end function;

begin
    -- Convert the position signals to unsigned and subtract the offset
    x_pos <= to_integer(unsigned(h_pos)) - 145;
    y_pos <= to_integer(unsigned(v_pos)) - 32;
    -- Convert the color signals to unsigned
    red   <= std_logic_vector(to_unsigned(r, 4));
    green <= std_logic_vector(to_unsigned(g, 4));
    blue  <= std_logic_vector(to_unsigned(b, 4));
    -- The process that splits the screen in sections
    process (x_pos, y_pos)
    begin
        if (x_pos < 0 or x_pos > 639 or y_pos < 0 or y_pos > 479) then
            r <= 0;
            g <= 0;
            b <= 0;
        elsif (y_pos <= 470 and y_pos >= 384 and x_pos >= 10 and x_pos <= 110) then -- Player hand
            if (cards(x_pos - 10, y_pos - 384, 11, 3, 6, 2, 5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            else
                r <= 15;
                g <= 15;
                b <= 15;
            end if;
        elsif (y_pos >= 10 and y_pos < 96 and x_pos < 630 and x_pos >= 529) then -- Dealer hand
            if (cards(x_pos - 529, y_pos - 10, 12, 4, 7) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            else
                r <= 15;
                g <= 15;
                b <= 15;
            end if;
        elsif (y_pos >= 180 and y_pos < 280) then -- Action menu
            if (action_menu(x_pos, y_pos - 180, '1', '1', '1', '1') = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 4;
                g <= 4;
                b <= 4;
            end if;
        elsif (x_pos < 630 and x_pos >= 544 and y_pos < 470 and y_pos >= 430) then -- Details
            if (x_pos = 544 or x_pos = 629 or y_pos = 430 or y_pos = 469) then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (details(x_pos - 545, y_pos - 431, 1, 100, 10) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 2;
                g <= 11;
                b <= 2;
            end if;
        elsif (x_pos >= 10 and y_pos >= 10 and x_pos < 121 and y_pos < 62) then -- Table
            if (x_pos = 10 or x_pos = 120 or y_pos = 10 or y_pos = 61) then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (x_pos <= 12 or x_pos >= 138 or y_pos <= 12 or y_pos >= 59) then
                r <= 2;
                g <= 11;
                b <= 2;
            elsif ( y_pos <= 54 and table(x_pos - 13, y_pos - 13, '1', 1, 2, 3, 4, 5, 123, '1', 6, 7, 8, 9, 10, 456, '1', 11, 12, 13, 1, 2, 789, '1', 3, 4, 5, 6, 7, 5) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 2;
                g <= 11;
                b <= 2;
            end if;
        else
            r <= 2;
            g <= 11;
            b <= 2;
        end if;
    end process;
end architecture;
