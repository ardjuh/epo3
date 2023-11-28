library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Begin with displaying half a blue screen in a process
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
        letter : integer range 0 to 26
    ) return std_logic is
    begin
        if (x = 5) then -- Padding right
            return '0';

        elsif (letter = 0) then -- Space
            if (x > 0) then
                return '0';
            end if;
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
            if (x = 0 or x = 4 or (y = 1 and x = 1) or (y = 2 and x = 2) or (y = 3 and x = 3)) then
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
            if (x = 0 or ((y = 0 or y = 4) and x < 4) or (x = 4 and ((y > 0 and y < 3) or y = 4 or y = 5))) then
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
            if (((x = 0 or x = 4) and y < 3) or (x = 2 and (y = 3 or y = 4)) or ((x = 1 or x = 3) and y = 2)) then
                return '1';
            else
                return '0';
            end if;
        else -- Z
            if (y = 0 or y = 6 or (x = 4 and y = 1) or (x = 3 and y = 2) or (x = 2 and y = 3) or (x = 1 and y = 4) or (x = 0 and y = 5)) then
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
            if (y = 0 or (x = 1 and (y = 1 or y > 3)) or ((y = 0 or y = 3) and x > 0 and x < 4) or (x = 4 and y > 0 and y < 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 3) then -- 3
            if ((x = 0 and (y = 1 or y = 5)) or ((y = 0 or y = 6) and (x > 0 and x < 4)) or (x = 4 and (y = 1 or y = 2 or y = 4 or y = 5)) or (y = 3 and x < 1 and y > 6)) then
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
            return small_letter(x, y, 0);
        elsif (char <= 9) then
            return small_number(x, y, char);
        elsif (char = 10) then
            if (x = 0 or x = 2 or x = 4 or ((y = 0 or y = 6) and x = 3)) then
                return '1';
            else
                return '0';
            end if;
        elsif (char = 11) then
            return small_letter(x, y, 9);
        elsif (char = 12) then
            return small_letter(x, y, 16);
        elsif (char = 13) then
            return small_letter(x, y, 10);
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
            if (y = 0) then
                return'1';
            elsif (x = 8 and y < 16) then
                return '1';
            elsif (y = 19 and x > 0 and x < 8) then
                return '1';
            elsif ((x = 0 or x = 7) and y < 19 and y > 15) then
                return'1';
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

    function cards (
        x     : integer range 0 to 99;
        y     : integer range 0 to 86;
        card1 : integer range 0 to 13 := 0;
        card2 : integer range 0 to 13 := 0;
        card3 : integer range 0 to 13 := 0;
        card4 : integer range 0 to 13 := 0;
        card5 : integer range 0 to 13 := 0
    ) return std_logic is
    begin
        if (x >= 44 and x <= 99 and card1 > 0) then
            if (x <= 45 or y <= 1 or x >= 98 or y >= 85) then
                return '0';
            elsif (x >= 70 and x < 80 and y >= 33 and y < 53) then
                return big_number(x - 70, y - 33, card1);
            elsif (x >= 48 and x <= 52 and y >= 4 and y <= 10) then
                return small_card_char(x - 48, y - 4, card1);
            else
                return '1';
            end if;
        elsif (x >= 33 and x <= 43 and card2 > 0) then
            if (x <= 34 or y <= 1 or x >= 42 or y >= 85) then
                return '0';
            elsif (x >= 37 and x <= 41 and y >= 4 and y <= 10) then
                return small_card_char(x - 37, y - 4, card2);
            else
                return '1';
            end if;
        elsif (x >= 22 and x <= 32 and card3 > 0) then
            if (x <= 23 or y <= 1 or x >= 31 or y >= 85) then
                return '0';
            elsif (x >= 26 and x <= 29 and y >= 4 and y <= 10) then
                return small_card_char(x - 26, y - 4, card3);
            else
                return '1';
            end if;
        elsif (x >= 11 and x <= 21 and card4 > 0) then
            if (x <= 12 or y <= 1 or x >= 20 or y >= 85) then
                return '0';
            elsif (x >= 15 and x <= 19 and y >= 4 and y <= 10) then
                return small_card_char(x - 15, y - 4, card4);
            else
                return '1';
            end if;
        elsif (x <= 10 and card5 > 0) then
            if (x <= 1 or y <= 1 or x >= 9 or y >= 85) then
                return '0';
            elsif (x >= 4 and x <= 8 and y >= 4 and y <= 10) then
                return small_card_char(x - 4, y - 4, card5);
            else
                return '1';
            end if;
        else
            return '0';
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
        if (y_pos >= 32 and y_pos <= 38) then
            if (x_pos >= 80 and x_pos < 98) then -- HIT
                if (x_pos < 86) then
                    return small_letter(x_pos - 80, y_pos - 32, 7);
                elsif (x_pos < 92) then
                    return small_letter(x_pos - 86, y_pos - 32, 8);
                else
                    return small_letter(x_pos - 92, y_pos - 32, 19);
                end if;
            elsif (x_pos >= 293 and x_pos < 329 and double = '1') then -- DOUBLE
                if (x_pos < 299) then
                    return small_letter(x_pos - 293, y_pos - 32, 4);
                elsif (x_pos < 305) then
                    return small_letter(x_pos - 299, y_pos - 32, 15);
                elsif (x_pos < 311) then
                    return small_letter(x_pos - 305, y_pos - 32, 21);
                elsif (x_pos < 317) then
                    return small_letter(x_pos - 311, y_pos - 32, 2);
                elsif (x_pos < 323) then
                    return small_letter(x_pos - 317, y_pos - 32, 12);
                else
                    return small_letter(x_pos - 323, y_pos - 32, 5);
                end if;
            elsif (x_pos >= 507 and em = '1') then
                if (x_pos < 514) then
                    return small_letter(x_pos - 507, y_pos - 32, 5);--e
                elsif (x_pos < 520) then
                    return small_letter(x_pos - 513, y_pos - 32, 22);--v
                elsif (x_pos < 526) then
                    return small_letter(x_pos - 519, y_pos - 32, 5);--e
                elsif (x_pos < 532) then
                    return small_letter(x_pos - 525, y_pos - 32, 14);--n
                elsif (x_pos < 538) then
                    return small_letter(x_pos - 531, y_pos - 32, 0);--space
                elsif (x_pos < 544) then
                    return small_letter(x_pos - 537, y_pos - 32, 13); --m
                elsif (x_pos < 550) then
                    return small_letter(x_pos - 543, y_pos - 32, 15);--o
                elsif (x_pos < 556) then
                    return small_letter(x_pos - 549, y_pos - 32, 14); --n
                elsif (x_pos < 562) then
                    return small_letter(x_pos - 555, y_pos - 32, 5);--e
                else
                    return small_letter(x_pos - 561, y_pos - 32, 25);
                end if;
            else
                return '0';
            end if;
        elsif (y_pos >= 82 and y_pos <= 88) then
            if (x_pos >= 80 and x_pos < 104) then -- HOLD
                if (x_pos < 86) then
                    return small_letter(x_pos - 80, y_pos - 82, 8);
                elsif (x_pos < 92) then
                    return small_letter(x_pos - 86, y_pos - 82, 15);
                elsif (x_pos < 98) then
                    return small_letter(x_pos - 92, y_pos - 82, 12);
                else
                    return small_letter(x_pos - 98, y_pos - 82, 4);
                end if;
            elsif (x_pos >= 293 and x_pos < 323 and split = '1') then -- SPLIT
                if (x_pos < 299) then
                    return small_letter(x_pos - 293, y_pos - 82, 19);
                elsif (x_pos < 305) then
                    return small_letter(x_pos - 299, y_pos - 82, 16);
                elsif (x_pos < 311) then
                    return small_letter(x_pos - 305, y_pos - 82, 12);
                elsif (x_pos < 317) then
                    return small_letter(x_pos - 311, y_pos - 82, 9);
                else
                    return small_letter(x_pos - 317, y_pos - 82, 20);
                end if;
            elsif (x_pos >= 507 and x_pos < 561 and insurance = '1') then -- INSURANCE
                if (x_pos < 513) then
                    return small_letter(x_pos - 507, y_pos - 82, 9);
                elsif (x_pos < 519) then
                    return small_letter(x_pos - 513, y_pos - 82, 14);
                elsif (x_pos < 525) then
                    return small_letter(x_pos - 519, y_pos - 82, 19);
                elsif (x_pos < 531) then
                    return small_letter(x_pos - 525, y_pos - 82, 21);
                elsif (x_pos < 537) then
                    return small_letter(x_pos - 531, y_pos - 82, 18);
                elsif (x_pos < 543) then
                    return small_letter(x_pos - 537, y_pos - 82, 1);
                elsif (x_pos < 549) then
                    return small_letter(x_pos - 543, y_pos - 82, 14);
                elsif (x_pos < 555) then
                    return small_letter(x_pos - 549, y_pos - 82, 3);
                else
                    return small_letter(x_pos - 555, y_pos - 82, 5);
                end if;
            else
                return '0';

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
        elsif (y_pos <= 470 and y_pos >= 384 and x_pos >= 10 and x_pos <= 101) then -- Player hand
            if (cards(x_pos - 10, y_pos - 384, 11, 3, 6, 2, 5) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 0;
                g <= 0;
                b <= 0;
            end if;
        elsif (y_pos >= 10 and y_pos < 96 and x_pos < 630 and x_pos >= 531) then -- Dealer hand
            if (cards(630 - x_pos, 96 - y_pos, 12, 4, 7, 3, 1) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 0;
                g <= 0;
                b <= 0;
            end if;
        elsif (y_pos >= 180 and y_pos < 280) then -- Action menu
            if (action_menu(x_pos, y_pos - 180) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 4;
                g <= 4;
                b <= 4;
            end if;
        else
            r <= 2;
            g <= 15;
            b <= 3;
        end if;
    end process;
end architecture;