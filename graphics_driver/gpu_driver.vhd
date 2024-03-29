
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
architecture behavior of gpu_driver is
    signal x_pos   : integer range -145 to 878;
    signal y_pos   : integer range -32 to 991;
    signal r       : integer range 0 to 15;
    signal g       : integer range 0 to 15;
    signal b       : integer range 0 to 15;
    signal money_a : integer range 0 to 999;
    signal money_b : integer range 0 to 999;
    signal money_c : integer range 0 to 999;
    signal money_d : integer range 0 to 999;
    signal carda_1 : integer range 0 to 13;
    signal carda_2 : integer range 0 to 13;
    signal carda_3 : integer range 0 to 13;
    signal carda_4 : integer range 0 to 13;
    signal carda_5 : integer range 0 to 13;

    signal cardb_1 : integer range 0 to 13;
    signal cardb_2 : integer range 0 to 13;
    signal cardb_3 : integer range 0 to 13;
    signal cardb_4 : integer range 0 to 13;
    signal cardb_5 : integer range 0 to 13;

    signal cardc_1 : integer range 0 to 13;
    signal cardc_2 : integer range 0 to 13;
    signal cardc_3 : integer range 0 to 13;
    signal cardc_4 : integer range 0 to 13;
    signal cardc_5 : integer range 0 to 13;

    signal cardd_1 : integer range 0 to 13;
    signal cardd_2 : integer range 0 to 13;
    signal cardd_3 : integer range 0 to 13;
    signal cardd_4 : integer range 0 to 13;
    signal cardd_5 : integer range 0 to 13;

    signal carde_1 : integer range 0 to 13;
    signal carde_2 : integer range 0 to 13;
    signal carde_3 : integer range 0 to 13;
    signal carde_4 : integer range 0 to 13;
    signal carde_5 : integer range 0 to 13;

    signal cardf_1 : integer range 0 to 13;
    signal cardf_2 : integer range 0 to 13;
    signal cardf_3 : integer range 0 to 13;
    signal cardf_4 : integer range 0 to 13;
    signal cardf_5 : integer range 0 to 13;

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
            return '0';
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
            -- if (x = 0 or x = 4 or (y = 5 and (x = 1 or x = 3)) or (x = 2 and (y = 3 or y = 4))) then
            --     return '1';
            -- else
            --     return '0';
            -- end if;
            return '0';
        elsif (letter = 24) then -- X
            -- if (((x = 0 or x = 4) and (y < 3 or y > 5)) or ((x = 1 or x = 3) and (y = 2 or y = 4)) or (x = 2 and y = 3)) then
            --     return '1';
            -- else
            --     return '0';
            -- end if;
            return '0';
        elsif (letter = 25) then -- Y
            if (((x = 0 or x = 4) and y < 3) or (x = 2 and (y >= 4 and y < 7)) or ((x = 1 or x = 3) and (y = 3))) then
                return '1';
            else
                return '0';
            end if;
        elsif (letter = 26) then -- Z
            -- if (y = 0 or y = 6 or (x = 4 and y = 1) or (x = 3 and y = 2) or (x = 2 and y = 3) or (x = 1 and y = 4) or (x = 0 and y = 5)) then
            --     return '1';
            -- else
            --     return '0';
            -- end if;
            return '0';
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
            if ((x = 4 or x = 5) and y = 0) then
                return '1';
            elsif ((x = 3 or x = 6) and y >= 0 and y < 3) then
                return '1';
            elsif ((x = 2 or x = 7) and y > 2 and y < 5) then
                return '1';
            elsif ((x = 1 or x = 8) and y > 4 and y < 9) then
                return '1';
            elsif ((x = 0 or x = 9) and y > 8) then
                return '1';
            elsif (y = 13) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 2) then --2
            if (x = 0 and (y = 18 or y = 2 or y = 3)) then
                return '1';
            elsif (x = 1 and (y = 17 or y = 1)) then
                return '1';
            elsif (x = 2 and (y = 16 or y = 1)) then
                return '1';
            elsif (x = 3 and (y = 15 or y = 0)) then
                return '1';
            elsif (x = 4 and (y = 14 or y = 0)) then
                return '1';
            elsif (x = 5 and (y = 13 or y = 0)) then
                return '1';
            elsif (x = 6 and (y = 12 or y = 0)) then
                return '1';
            elsif (x = 7 and (y = 11 or y = 1)) then
                return '1';
            elsif (x = 8 and (y = 10 or y = 9 or y = 1)) then
                return '1';
            elsif (x = 9 and y > 1 and y < 9) then
                return '1';
            elsif (y = 19) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 3) then --3
            if (x = 9 and ((y < 16 and y > 11) or (y < 8 and y > 3))) then
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
            elsif ((x = 0 or x = 9) and y > 1 and y < 8) then
                return'1';
            elsif ((x = 0 or x = 9) and y > 12 and y < 18) then
                return'1';
            elsif ((x = 1 or x = 8) and (y = 1 or y = 8)) then
                return'1';
            elsif ((x = 2 or x = 7) and y = 9) then
                return'1';
            elsif (x > 2 and x < 7 and y = 10) then
                return'1';
            elsif ((x = 2 or x = 7) and y = 11) then
                return'1';
            elsif ((x = 1 or x = 8) and (y = 12 or y = 18)) then
                return'1';
            else
                return '0';
            end if;
        elsif (number = 9) then --9
            if ((y = 0 or y = 19) and x < 8) then
                return '1';
            elsif ((x = 1 or x = 8) and y > 0 and y < 3) then
                return '1';
            elsif (x = 0 and y > 1 and y < 8) then
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
            elsif ((y = 0 or y = 19) and x > 3 and x < 9) then
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
            elsif (x = 1 and y > 16 and y < 19) then
                return '1';
            elsif (x = 0 and y > 15 and y < 18) then
                return '1';
            else
                return '0';
            end if;
        elsif (number = 12) then --Q
            if ((y = 0 or y = 19)and x > 1 and x < 8) then
                return '1';
            elsif ((x = 0 or x = 9) and y > 1 and y < 18) then
                return '1';
            elsif ((x = 1 or x = 8) and (y = 1 or y = 18)) then
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
            if (x = 0 and (y = 0 or y = 19)) then
                return '1';
            elsif (x = 1) then
                return '1';
            elsif (x = 2 and (y = 0 or y = 19 or (y > 7 and y < 12))) then
                return '1';
            elsif (x = 3 and (y = 7 or y = 8 or y = 11 or y = 12)) then
                return '1';
            elsif (x = 4 and (y = 6 or y = 7 or y = 12 or y = 13)) then
                return'1';
            elsif (x = 5 and (y = 5 or y = 6 or y = 13 or y = 14)) then
                return '1';
            elsif (x = 6 and (y = 5 or y = 4 or y = 14 or y = 15)) then
                return '1';
            elsif (x = 7 and (y = 4 or y = 3 or y = 15 or y = 16)) then
                return '1';
            elsif (x = 8 and ((y < 4 and y > 0) or (y < 19 and y > 15))) then
                return '1';
            elsif (x = 9 and (y = 0 or y = 19)) then
                return '1';
            else
                return '0';
            end if;
        end if;
    end function;

    impure function table (
        x        : integer range 0 to 115;
        y        : integer range 0 to 45;
        player_a : std_logic;
        card1_1  : integer range 0 to 13  := 0;
        card1_2  : integer range 0 to 13  := 0;
        card1_3  : integer range 0 to 13  := 0;
        card1_4  : integer range 0 to 13  := 0;
        card1_5  : integer range 0 to 13  := 0;
        money1   : integer range 0 to 999 := 0;

        player_b : std_logic;
        card2_1  : integer range 0 to 13  := 0;
        card2_2  : integer range 0 to 13  := 0;
        card2_3  : integer range 0 to 13  := 0;
        card2_4  : integer range 0 to 13  := 0;
        card2_5  : integer range 0 to 13  := 0;
        money2   : integer range 0 to 999 := 0;

        player_c : std_logic;
        card3_1  : integer range 0 to 13  := 0;
        card3_2  : integer range 0 to 13  := 0;
        card3_3  : integer range 0 to 13  := 0;
        card3_4  : integer range 0 to 13  := 0;
        card3_5  : integer range 0 to 13  := 0;
        money3   : integer range 0 to 999 := 0;

        player_d : std_logic;
        card4_1  : integer range 0 to 13  := 0;
        card4_2  : integer range 0 to 13  := 0;
        card4_3  : integer range 0 to 13  := 0;
        card4_4  : integer range 0 to 13  := 0;
        card4_5  : integer range 0 to 13  := 0;
        money4   : integer range 0 to 999 := 0
    ) return std_logic is
    begin
        if (y < 7) then
            if (x < 6) then
                return small_letter(x, y, 6); --P
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
            elsif (x < 108) then
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
                return small_number(x - 48, y - 11, money_a/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 11, (money_a/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 11, money_a mod 10);
            elsif (x < 78) then
                return '0'; --Space
            elsif (x < 84 and card1_1 > 0) then
                return small_card_char(x - 78, y - 11, card1_1); --player_a card 1
            elsif (x < 90 and card1_2 > 0) then
                return small_card_char(x - 84, y - 11, card1_2); --player_a card 2
            elsif (x < 96 and card1_3 > 0) then
                return small_card_char(x - 90, y - 11, card1_3); --player_a card 3
            elsif (x < 102 and card1_4 > 0) then
                return small_card_char(x - 96, y - 11, card1_4); --player_a card 4
            elsif (x < 108 and card1_5 > 0) then
                return small_card_char(x - 102, y - 11, card1_5); --player_a card 5
            else
                return '0';
            end if;
        elsif (y >= 20 and y < 27) then
            if (x < 6) then
                return small_letter(x, y - 20, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 20, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 20, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 20, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 20, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 20, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 20, 2); --2
            elsif (x < 48) then
                return small_letter(x - 42, y - 20, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 20, money_b/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 20, (money_b/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 20, money_b mod 10);
            elsif (x < 78) then
                return '0'; --Space
            elsif (x < 84 and card1_1 > 0) then
                return small_card_char(x - 78, y - 20, card2_1); --Player2 card 1
            elsif (x < 90 and card1_2 > 0) then
                return small_card_char(x - 84, y - 20, card2_2); --Player2 card 2
            elsif (x < 96 and card1_3 > 0) then
                return small_card_char(x - 90, y - 20, card2_3); --Player2 card 3
            elsif (x < 102 and card1_4 > 0) then
                return small_card_char(x - 96, y - 20, card2_4); --Player2 card 4
            elsif (x < 108 and card1_5 > 0) then
                return small_card_char(x - 102, y - 20, card2_5); --Player2 card 5
            else
                return '0';
            end if;
        elsif (y >= 29 and y < 36) then
            if (x < 6) then
                return small_letter(x, y - 29, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 29, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 29, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 29, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 29, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 29, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 29, 3); --3
            elsif (x < 48) then
                return small_letter(x - 42, y - 29, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 29, money_c/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 29, (money_c/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 29, money_c mod 10);
            elsif (x < 78) then
                return '0'; --Space
            elsif (x < 84 and card1_1 > 0) then
                return small_card_char(x - 78, y - 29, card3_1); --Player3 card 1
            elsif (x < 90 and card1_2 > 0) then
                return small_card_char(x - 84, y - 29, card3_2); --Player3 card 2
            elsif (x < 96 and card1_3 > 0) then
                return small_card_char(x - 90, y - 29, card3_3); --Player3 card 3
            elsif (x < 102 and card1_4 > 0) then
                return small_card_char(x - 96, y - 29, card3_4); --Player3 card 4
            elsif (x < 108 and card1_5 > 0) then
                return small_card_char(x - 102, y - 29, card3_5); --Player3 card 5
            else
                return '0';
            end if;
        elsif (y >= 38 and y < 45) then
            if (x < 6) then
                return small_letter(x, y - 38, 16); --P
            elsif (x < 12) then
                return small_letter(x - 6, y - 38, 12); --L
            elsif (x < 18) then
                return small_letter(x - 12, y - 38, 1); --A
            elsif (x < 24) then
                return small_letter(x - 18, y - 38, 25); --Y
            elsif (x < 30) then
                return small_letter(x - 24, y - 38, 5); --E
            elsif (x < 36) then
                return small_letter(x - 30, y - 38, 18); --R
            elsif (x < 42) then
                return small_number(x - 36, y - 38, 4); --4
            elsif (x < 48) then
                return small_letter(x - 42, y - 38, 0); --Space
            elsif (x < 54) then
                return small_number(x - 48, y - 38, money_d/100); --Player money
            elsif (x < 60) then
                return small_number(x - 54, y - 38, (money_d/10) mod 10);
            elsif (x < 66) then
                return small_number(x - 60, y - 38, money_d mod 10);
            elsif (x < 78) then
                return '0'; --Space
            elsif (x < 84 and card1_1 > 0) then
                return small_card_char(x - 78, y - 38, card4_1); --Player4 card 1
            elsif (x < 90 and card1_2 > 0) then
                return small_card_char(x - 84, y - 38, card4_2); --Player4 card 2
            elsif (x < 96 and card1_3 > 0) then
                return small_card_char(x - 90, y - 38, card4_3); --Player4 card 3
            elsif (x < 102 and card1_4 > 0) then
                return small_card_char(x - 96, y - 38, card4_4); --Player4 card 4
            elsif (x < 108 and card1_5 > 0) then
                return small_card_char(x - 102, y - 38, card4_5); --Player4 card 5
            else
                return '0';
            end if;
        else
            return '0';
        end if;
    end function;

    function cards (
        x     : integer range 0 to 99;
        y     : integer range 0 to 108;
        card1 : integer range 0 to 13 := 0;
        card2 : integer range 0 to 13 := 0;
        card3 : integer range 0 to 13 := 0;
        card4 : integer range 0 to 13 := 0;
        card5 : integer range 0 to 13 := 0;
        split : std_logic             := '0'
    ) return std_logic is
    begin
        if (x >= 44 and card1 > 0) then
            if (x <= 45 or y <= 1 or x >= 98 or y >= 107) then
                return '1';
            elsif (x >= 67 and x < 77 and y >= 44 and y < 64) then
                return big_number(x - 67, y - 44, card1);
            elsif (x >= 48 and x <= 52 and y >= 4 and y <= 10) then
                return small_card_char(x - 48, y - 4, card1);
            elsif (x >= 91 and x < 96 and y >= 97 and y < 104) then
                return small_card_char(x - 91, y - 97, card1);
            else
                return '0';
            end if;
        elsif (x >= 33 and x <= 43 and card2 > 0) then
            if (x <= 34 or y <= 1 or y >= 107) then
                return '1';
            elsif (x >= 37 and x < 42 and y >= 4 and y <= 10) then
                return small_card_char(x - 37, y - 4, card2);
            else
                return '0';
            end if;
        elsif (x >= 22 and x <= 32 and card3 > 0) then
            if (x <= 23 or y <= 1 or y >= 107) then
                return '1';
            elsif (x >= 26 and x <= 30 and y >= 4 and y <= 10) then
                return small_card_char(x - 26, y - 4, card3);
            else
                return '0';
            end if;
        elsif (x >= 11 and x <= 21 and card4 > 0) then
            if (x <= 12 or y <= 1 or y >= 107) then
                return '1';
            elsif (x >= 15 and x <= 19 and y >= 4 and y <= 10) then
                return small_card_char(x - 15, y - 4, card4);
            else
                return '0';
            end if;
        elsif (x <= 10 and card5 > 0) then
            if (x <= 1 or y <= 1 or y >= 107) then
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
        hit       : std_logic := '0';
        hold      : std_logic := '0';
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

    function begin_menu(
        x          : integer range 0 to 639;
        y          : integer range 0 to 479;
        screentype : std_logic_vector (1 downto 0) := "00"
    ) return std_logic is
    begin
        if (screentype = "00") then
            if (y >= 22 and y <= 28 and x > 278) then
                if (x < 285) then
                    return small_letter(x - 279, y - 22, 16); --P
                elsif (x < 291) then
                    return small_letter(x - 285, y - 22, 12); --L
                elsif (x < 297) then
                    return small_letter(x - 291, y - 22, 1); --A
                elsif (x < 303) then
                    return small_letter(x - 297, y - 22, 25); --Y
                elsif (x < 309) then
                    return small_letter(x - 303, y - 22, 5); --E
                elsif (x < 315) then
                    return small_letter(x - 309, y - 22, 18); --R
                elsif (x < 321) then
                    return small_letter(x - 315, y - 22, 0); --Space
                elsif (x < 327) then
                    return small_number(x - 321, y - 22, 1); --1
                elsif (x < 333) then
                    return small_letter(x - 327, y - 22, 0); --Space
                elsif (x < 339) then
                    return small_number(x - 333, y - 22, 2); --2
                elsif (x < 345) then
                    return small_letter(x - 339, y - 22, 0); --Space
                elsif (x < 351) then
                    return small_number(x - 345, y - 22, 3); --3
                elsif (x < 357) then
                    return small_letter(x - 351, y - 22, 0); --Space
                elsif (x < 363) then
                    return small_number(x - 357, y - 22, 4); --4
                else
                    return '0';
                end if;

            elsif (y >= 72 and y <= 78) then
                if (x > 278) then
                    if (x < 285) then
                        return small_letter(x - 279, y - 72, 19); --S
                    elsif (x < 291) then
                        return small_letter(x - 285, y - 72, 20); --T
                    elsif (x < 297) then
                        return small_letter(x - 291, y - 72, 1); --A
                    elsif (x < 303) then
                        return small_letter(x - 297, y - 72, 18); --R
                    elsif (x < 309) then
                        return small_letter(x - 303, y - 72, 20); --T
                    else
                        return '0';
                    end if;
                else
                    return '0';
                end if;
            else
                return '0';
            end if;
        elsif (screentype = "01") then
            if (y >= 0 and y < 48 and x > 443) then
                if (x < 450 and y < 7) then
                    return small_letter(x - 444, y, 2); --b
                elsif (x < 456 and y < 7) then
                    return small_letter(x - 450, y, 5);--e
                elsif (x < 462 and y < 7) then
                    return small_letter(x - 456, y, 20);--t

                elsif (x < 450 and y >= 9 and y <= 16) then
                    return small_number(x - 444, y - 9, 2);--2

                elsif (x < 450 and y >= 18 and y <= 24) then
                    return small_number(x - 444, y - 18, 6);--6

                elsif (x < 450 and y >= 27 and y <= 33) then
                    return small_number(x - 444, y - 27, 1);--1
                elsif (x < 456 and y >= 27 and y <= 33) then
                    return small_number(x - 450, y - 27, 0);--0

                elsif (x < 450 and y >= 36 and y <= 43) then
                    return small_number(x - 444, y - 36, 2);--2
                elsif (x < 456 and y >= 36 and y <= 43) then
                    return small_number(x - 450, y - 36, 0);--0

                else
                    return '0';
                end if;
            else
                return '0';
            end if;
        elsif (screentype = "11") then
            if (y >= 22 and y <= 28 and x > 278) then
                if (x < 285) then
                    return small_letter(x - 279, y - 22, 5); --E
                elsif (x < 291) then
                    return small_letter(x - 285, y - 22, 14); --N
                elsif (x < 297) then
                    return small_letter(x - 291, y - 22, 4); --D
                elsif (x < 303) then
                    return small_letter(x - 297, y - 22, 0); --SPACE
                elsif (x < 309) then
                    return small_letter(x - 303, y - 22, 18); --R
                elsif (x < 315) then
                    return small_letter(x - 309, y - 22, 15);--O
                elsif (x < 321) then
                    return small_letter(x - 315, y - 22, 21);--U
                elsif (x < 327) then
                    return small_letter(x - 321, y - 22, 14);--N
                elsif (x < 333) then
                    return small_letter(x - 327, y - 22, 4);--D
                else
                    return '0';
                end if;
            elsif (y >= 72 and y <= 78) then
                if (x > 278) then
                    if (x < 285) then
                        return small_letter(x - 279, y - 72, 5); -- E
                    elsif (x < 291) then
                        return small_letter(x - 285, y - 72, 14);--N
                    elsif (x < 297) then
                        return small_letter(x - 291, y - 72, 4);--D
                    elsif (x < 303) then
                        return small_letter(x - 297, y - 72, 0); --SPACE
                    elsif (x < 309) then
                        return small_letter(x - 303, y - 72, 7); --G
                    elsif (x < 315) then
                        return small_letter(x - 309, y - 72, 1); --A
                    elsif (x < 321) then
                        return small_letter(x - 315, y - 72, 13); --M
                    elsif (x < 327) then
                        return small_letter(x - 321, y - 72, 5); --E
                    else
                        return '0';
                    end if;
                else
                    return '0';
                end if;
            else
                return '0';
            end if;
        else
            return '0';
        end if;

    end function;

    function details(
        x           : integer range 0 to 84;
        y           : integer range 0 to 38;
        player      : integer range 1 to 4;
        money       : integer range 0 to 999;
        bet         : std_logic_vector(1 downto 0);
        double_down : std_logic := '0';
        insurance   : std_logic := '0'
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
            elsif (double_down = '1') then
                case bet is
                    when "00" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 4);
                        else
                            return '0';
                        end if;
                    when "01" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 1);
                        else
                            return small_number(x - 39, y - 21, 2);
                        end if;
                    when "10" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 2);
                        else
                            return small_number(x - 39, y - 21, 0);
                        end if;
                    when others =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 4);
                        else
                            return small_number(x - 39, y - 21, 0);
                        end if;
                end case;
            else
                case bet is
                    when "00" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 2);
                        else
                            return '0';
                        end if;
                    when "01" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 6);
                        else
                            return '0';
                        end if;
                    when "10" =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 1);
                        else
                            return small_number(x - 39, y - 21, 0);
                        end if;
                    when others =>
                        if (x < 39) then
                            return small_number(x - 33, y - 21, 2);
                        else
                            return small_number(x - 39, y - 21, 0);
                        end if;
                end case;
            end if;
        elsif (x >= 3 and x < 87 and y >= 30 and y < 37) then -- Insurance: {{insurance}}
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

    money_a <= to_integer(unsigned(money1));
    money_b <= to_integer(unsigned(money2));
    money_c <= to_integer(unsigned(money3));
    money_d <= to_integer(unsigned(money4));

    carda_1 <= to_integer(unsigned(card1_1));
    carda_2 <= to_integer(unsigned(card1_2));
    carda_3 <= to_integer(unsigned(card1_3));
    carda_4 <= to_integer(unsigned(card1_4));
    carda_5 <= to_integer(unsigned(card1_5));

    cardb_1 <= to_integer(unsigned(card2_1));
    cardb_2 <= to_integer(unsigned(card2_2));
    cardb_3 <= to_integer(unsigned(card2_3));
    cardb_4 <= to_integer(unsigned(card2_4));
    cardb_5 <= to_integer(unsigned(card2_5));

    cardc_1 <= to_integer(unsigned(card3_1));
    cardc_2 <= to_integer(unsigned(card3_2));
    cardc_3 <= to_integer(unsigned(card3_3));
    cardc_4 <= to_integer(unsigned(card3_4));
    cardc_5 <= to_integer(unsigned(card3_5));

    cardd_1 <= to_integer(unsigned(card4_1));
    cardd_2 <= to_integer(unsigned(card4_2));
    cardd_3 <= to_integer(unsigned(card4_3));
    cardd_4 <= to_integer(unsigned(card4_4));
    cardd_5 <= to_integer(unsigned(card4_5));

    carde_1 <= to_integer(unsigned(card5_1));
    carde_2 <= to_integer(unsigned(card5_2));
    carde_3 <= to_integer(unsigned(card5_3));
    carde_4 <= to_integer(unsigned(card5_4));
    carde_5 <= to_integer(unsigned(card5_5));

    cardf_1 <= to_integer(unsigned(card6_1));
    cardf_2 <= to_integer(unsigned(card6_2));
    cardf_3 <= to_integer(unsigned(card6_3));
    cardf_4 <= to_integer(unsigned(card6_4));
    cardf_5 <= to_integer(unsigned(card6_5));

    -- The process that splits the screen in sections
    process (x_pos, y_pos, screentype, split1, split2, split3, split4, player, cursor, carda_1, carda_2, carda_3, carda_4, carda_5, cardb_1, cardb_2, cardb_3, cardb_4, cardb_5, cardc_1, cardc_2, cardc_3, cardc_4, cardc_5, cardd_1, cardd_2, cardd_3, cardd_4, cardd_5, carde_1, carde_2, carde_3, carde_4, carde_5, cardf_1, cardf_2, cardf_3, cardf_4, cardf_5,
        money_a, money_b, money_c, money_d, hit, hold, em, double, insurance, split, bet1, bet2, bet3, bet4, doubledown1, doubledown2, doubledown3, doubledown4, insurance1, insurance2, insurance3, insurance4)
    begin
        if (x_pos < 0 or x_pos > 639 or y_pos < 0 or y_pos > 479) then

            r <= 0;
            g <= 0;
            b <= 0;

        elsif (screentype = "00") then
            r <= 0;
            g <= 0;
            b <= 0;

            if (x_pos >= 0 and y_pos >= 190 and y_pos <= 290) then
                if (begin_menu(x_pos, y_pos - 190, "00") = '1') then
                    if (y_pos >= 212 and y_pos <= 218) then
                        if (cursor = "001" and x_pos > 320 and x_pos < 327) then
                            r <= 10;
                            g <= 0;
                            b <= 0;
                        elsif (cursor = "010" and x_pos > 332 and x_pos < 339) then
                            r <= 10;
                            g <= 0;
                            b <= 0;
                        elsif (cursor = "011" and x_pos > 344 and x_pos < 351) then
                            r <= 10;
                            g <= 0;
                            b <= 0;
                        elsif (cursor = "100" and x_pos > 355 and x_pos < 362) then
                            r <= 10;
                            g <= 0;
                            b <= 0;
                        else
                            r <= 15;
                            g <= 15;
                            b <= 15;
                        end if;
                    else
                        r <= 15;
                        g <= 15;
                        b <= 15;
                    end if;
                else
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end if;
					 
            end if;

        elsif (screentype = "01" and x_pos >= 440 and x_pos < 467 and y_pos < 479 and y_pos >= 430) then --bet
            if (begin_menu(x_pos, y_pos - 432, "01") = '1') then
                if (cursor = "001" and y_pos >= 441 and y_pos    <= 447 and x_pos >= 440 and x_pos < 451) then
                    r                                                <= 10;
                    g                                                <= 0;
                    b                                                <= 0;
                elsif (cursor = "010" and y_pos >= 450 and y_pos <= 456 and x_pos >= 440 and x_pos < 451) then
                    r                                                <= 10;
                    g                                                <= 0;
                    b                                                <= 0;
                elsif (cursor = "011" and y_pos >= 459 and y_pos <= 465 and x_pos >= 440 and x_pos < 456) then
                    r                                                <= 10;
                    g                                                <= 0;
                    b                                                <= 0;
                elsif (cursor = "100" and y_pos >= 468 and y_pos <= 474 and x_pos >= 440 and x_pos < 456) then
                    r                                                <= 10;
                    g                                                <= 0;
                    b                                                <= 0;
                else
                    r <= 15;
                    g <= 15;
                    b <= 15;
                end if;
            else
                r <= 4;
                g <= 4;
                b <= 4;
            end if;

        elsif (screentype = "11") then
            r <= 0;
            g <= 0;
            b <= 0;

            if (x_pos >= 0 and y_pos >= 190 and y_pos <= 290) then
                if (begin_menu(x_pos, y_pos - 190, "11") = '1') then --end
                    if (y_pos > 260 and cursor = "010") then
                        r <= 10;
                        g <= 0;
                        b <= 0;
                    elsif (y_pos < 260 and cursor = "001") then
                        r <= 10;
                        g <= 0;
                        b <= 0;
                    else
                        r <= 15;
                        g <= 15;
                        b <= 15;
                    end if;
                else
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end if;
            elsif (x_pos >= 50 and y_pos >= 137 and x_pos <= 161 and y_pos <= 189) then
                if (table(x_pos - 50, y_pos - 190, '1', 0, 0, 0, 0, 0, money_a, '1', 0, 0, 0, 0, 0, money_b, '1', 0, 0, 0, 0, 0, money_c, '1', 0, 0, 0, 0, 0, money_d) = '1') then
                    r <= 15;
                    g <= 15;
                    b <= 15;
                else
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end if;
            end if;
        elsif (y_pos <= 470 and y_pos >= 362 and x_pos >= 10 and x_pos <= 109) then -- Player hand
            if (player = "000" and cards(x_pos - 10, y_pos - 362, carda_1, carda_2, carda_3, carda_4, carda_5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "001" and cards(x_pos - 10, y_pos - 362, cardb_1, cardb_2, cardb_3, cardb_4, cardb_5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "010" and cards(x_pos - 10, y_pos - 362, cardc_1, cardc_2, cardc_3, cardc_4, cardc_5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "011" and cards(x_pos - 10, y_pos - 362, cardd_1, cardd_2, cardd_3, cardd_4, cardd_5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            else
                r <= 15;
                g <= 15;
                b <= 15;
            end if;
        elsif (y_pos <= 470 and y_pos >= 362 and x_pos >= 120 and x_pos <= 219) then
            if (player = "000" and split1 = '1' and cards(x_pos - 120, y_pos - 362, cardf_1, cardf_2, cardf_3, cardf_4, cardf_5, '1') = '1') then -- Player hand with split
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "001" and split2 = '1' and cards(x_pos - 120, y_pos - 362, cardf_1, cardf_2, cardf_3, cardf_4, cardf_5, '1') = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "010" and split3 = '1' and cards(x_pos - 120, y_pos - 362, cardf_1, cardf_2, cardf_3, cardf_4, cardf_5, '1') = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "011" and split4 = '1' and cards(x_pos - 120, y_pos - 362, cardf_1, cardf_2, cardf_3, cardf_4, cardf_5, '1') = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif ((player = "000" and split1 = '1') or (player = "001" and split2 = '1') or (player = "010" and split3 = '1') or (player = "011" and split4 = '1')) then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 2;
                g <= 11;
                b <= 2;
            end if;
        elsif (y_pos >= 10 and y_pos < 118 and x_pos < 630 and x_pos >= 530) then -- Dealer hand
            if (cards(x_pos - 530, y_pos - 10, carde_1, carde_2, carde_3, carde_4, carde_5) = '1') then
                r <= 0;
                g <= 0;
                b <= 0;
            else
                r <= 15;
                g <= 15;
                b <= 15;
            end if;
        elsif (y_pos >= 180 and y_pos < 280) then -- Action menu
            if (action_menu(x_pos, y_pos - 180, hit, hold, em, double, insurance, split) = '1') then
                if (screentype /= "10") then
                    null;
                elsif (y_pos >= 202 and y_pos <= 208) then
                    if (cursor = "001" and x_pos >= 80 and x_pos < 98) then --hit
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    elsif (cursor = "010" and x_pos >= 293 and x_pos < 329) then --double
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    elsif (cursor = "011" and x_pos >= 507 and x_pos < 567) then --even money
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    else
                        r <= 15;
                        g <= 15;
                        b <= 15;
                    end if;
                elsif (y_pos >= 252 and y_pos <= 258) then
                    if (cursor = "100" and x_pos >= 80 and x_pos < 104) then -- HOLD
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    elsif (cursor = "101" and x_pos >= 293 and x_pos < 323) then -- SPLIT
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    elsif (cursor = "110" and x_pos >= 507 and x_pos < 561) then -- INSURANCE
                        r <= 8;
                        g <= 0;
                        b <= 0;
                    else
                        r <= 15;
                        g <= 15;
                        b <= 15;
                    end if;
                else
                    r <= 15;
                    g <= 15;
                    b <= 15;
                end if;
            else
                r <= 4;
                g <= 4;
                b <= 4;
            end if;
        elsif (x_pos < 630 and x_pos >= 544 and y_pos < 470 and y_pos >= 429) then -- Details
            if (x_pos = 544 or x_pos = 629 or y_pos = 429 or y_pos = 469) then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (player = "000" and details(x_pos - 545, y_pos - 430, 1, money_a, bet1, doubledown1, insurance1) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            elsif (player = "001" and details(x_pos - 545, y_pos - 430, 2, money_b, bet2, doubledown2, insurance2) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            elsif (player = "010" and details(x_pos - 545, y_pos - 430, 3, money_c, bet3, doubledown3, insurance3) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            elsif (player = "011" and details(x_pos - 545, y_pos - 430, 4, money_c, bet4, doubledown4, insurance4) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;

            else
                r <= 2;
                g <= 11;
                b <= 2;
            end if;
        elsif (x_pos >= 10 and y_pos >= 10 and x_pos < 122 and y_pos < 62) then -- Table
            if (x_pos = 10 or x_pos = 121 or y_pos = 10 or y_pos = 61) then
                r <= 0;
                g <= 0;
                b <= 0;
            elsif (x_pos <= 12 or x_pos >= 138 or y_pos <= 12 or y_pos >= 59) then
                r <= 2;
                g <= 11;
                b <= 2;
            elsif (table(x_pos - 13, y_pos - 13, '1', carda_1, carda_2, carda_3, carda_4, carda_5, money_a, '1', cardb_1, cardb_2, cardb_3, cardb_4, cardb_5, money_b, '1', cardc_1, cardc_2, cardc_3, cardc_4, cardc_5, money_c, '1', cardd_1, cardd_2, cardd_3, cardd_4, cardd_5, money_d) = '1') then
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
