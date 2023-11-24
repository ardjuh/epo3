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



function big_number(
	y	:	integer range 0 to 19;
	x	:	integer range 0 to 9;
	number	: 	integer range 0 to 13
		)	 
return std_logic is 
begin
	if number = 0 then --no card
	return  '0';
	elsif number = 1 then --A 
		if (x > 4 and x <7 and y = 0) then
		return '1';
		elsif (x =3 or x= 6 and y >=0 and y<3)then
		return '1';
		elsif (x= 2 or x=7 and y >2 and y <5)then
		return '1';
		elsif (x =1 or x = 8 and y >4 and y <9)then
		return '1';
		elsif (x =0 or x =11 and y >8)then
		return '1';
		elsif (y = 13)then
		return '1';
		else return '0';
		end if;
	elsif number = 2 then --2
		if (x >2 ans x< 7 and y = 0) then
		return '1';
		elsif ((x > 0 and x< 3) or (x>6 and x<9) and y = 1)then
		return '1';
		elsif (x=0 or x = 8 and y = 1)then
		return '1';
		elsif (x=0 or x =9 and y = 2)then
		return '1';
		elsif (x = 9 and y>3 and y<10)then
		return '1';
		elsif (x=8 and y = 10)then
		return '1';
		elsif (x =7 and y >10 and <13)then
		return '1';
		elsif (x >4 and x < 7 and y =13)then
		return '1';
		elsif (x =4 and y >13 and y<16)then
		return '1';
		elsif (x>1 and x<4 and y = 16)then
		return '1';
		elsif (x =1 and y >16)then
		return '1';
		elsif (y=19)then
		return 1;
		else return '0';
	end if;
	
	elsif number = 3 then --3
		if (x = 0 or x = 9 and (y<16 and y >11) or (y<8 and y>3)) then
		return'1';
		elsif( x=1 or x = 8 and (y<18 and y>15)or( y<4 and y>1))then
		return '1';
		elsif(x>1 and x<3 or x>5 and x<8 and (y = 1 or y= 18))then
		return '1';
		elsif (y= 0 or  =19 and x >2 and x<7)then
		return'1';
		elsif(x = 8 and y= 11 or y=8)then
		return  '1';
		elsif(x = 7 and y >8 and y<11)then
		return'1';
		else return '0';
	end if;
	
	elsif number = 4	then --4
		if(x=0 and y >=0 and y<10) then
		return  '1';
		elsif(x=9 and y >=0)then
		return '1';
		elsif(x<10 and y = 9)then
		return '1';
else return '0';
	end if;
	
	elsif number = 5 then --5
		if(y=0) then
		return '1';
		elsif(x=0 and y < 7 or y = 18)then
		return'1';
		elsif(x>0 and x<7 and y = 19)then
		return '1';
		elsif(x>0 and x<3 and y =7)then
		return '1';
		elsif(x>2 and x<8 and y = 8)then
		return '1';
		elsif(x > 7 and y = 9)then
		return '1';
		elsif (x = 9 and y > 9 and y<17)then
		return'1';
		elsif(x=8 and y = 17)then
		return '1';
		elsif(x>6 and x<9 and y = 18)then
		return '1';
else return '0';
	end if;
	
	elsif number = 6 then --6
		if (x>3 and y=0) then
		return '1';
		elsif(x>1 and x<4 and y =1 )then
		return  '1';
		elsif(x=1 and y = 2) then
		return '1';
		elsif(x=0 and y >2 and y<17 )then
		return '1';
		elsif (x=1 and y = 11)then
		return '1';
		elsif (x=1 and y <19 and y>16)then
		return '1';
		elsif(x >1 and x<7 and y =10 or y =19)then
		return'1';
		elsif(x=2 and y= 18)then
		return '1';
		elsif(x=7 and y = 18 or (y<13 and y>10))then
		return'1';
		elsif(x=8 and y <18 and y >12)then
		return'1';
else return '0';
	end if;
	
	elsif number = 7 then --7
		if(y =0) then
		return '1';
		elsif(y>0 and y<3 and x = 8)then
		return '1';
		elsif(y>2 and x = 7)then
		return '1';
		elsif(y=10 and x>3)then
		return '1';
else return '0';
	end if;
	
	elsif number = 8 then --8
		if (y=0 or y=19 and x >1 and x<8)then
		return'1';
		elsif(x =1 or x=8 and y >0 and y<3 or y>5 and y<8 or y>10 and y<13 or y>15 and y<19)then
		return '1';
		elsif(x=0 or x=9 and y >2 and y< 6)then
		return '1';
		elsif(x>1 and x<4 or x>5 and x>8 and y=8 or y = 10)then
		return '1';
		elsif(y = 9 and x>3 and x<6)then
		return '1';
else return '0';
	end if;
	elsif number = 9 then --9
		if(y= 0 or y = 19 and x >1 and x<8)then
		return '1';
		elsif(x=1 or x =8 and y>0 and y<3)then
		return '1';
		elsif(x=0 and y>2 and y<8)then
		return '1';
		elsif(x=1 and y>6 and y<10)then
		return '1';
		elsif(x=8 and y = 9)then
		return '1';
		elsif(x=9 and y>2 and y<19)then
		return '1';
		elsif(x>1 and x<8 and y =10)then
		return '1';
		elsif(x>6 and y = 18)then
		return '1';
else return '0';
	end if;
	elsif number = 10 then --10
		if(x=0) then
		return'1';
		elsif (y=0 or y =19 and x>3 and x<8)then
		return'1';
		elsif (x=9 or x =3 and y>0 and y<19)then
		return '1';
else return '0';
	end if;
	elsif number = 11 then --J
		if (y=0)then
		return'1';
		elsif(x=8 and y<16)then
		return '1';
		elsif(y=19 and x >0 and x<8)then
		return '1';
		elsif(x=0 or x=7 and y<19 and y>15)then
		return'1';
else return '0';
	end if;
	elsif number = 12 then --Q
		if (y=0 or y=19 and x>1 and x<8) then
		return '1';
		elsif(x=0 or x=9 and y>2 and y<18)then
		return '1';
		elsif(x=1 or x=8 and y=2 or y= 18)then
		return '1';
		elsif(x=6 and y = 16)then
		return  '1';
		elsif(x= 7 and y = 17)then
		return  '1';
		elsif(x=9 and y = 19 )then
		return '1';
else return '0';
	end if;

	else   --K
		if (x=0)then
		return '1';
		elsif(x=1 and y >7 and y<12)then
		return'1';
		elsif(x=2 and y=7 or y=12)then
		return '1';
		elsif (x=3 and y=6 or y=13)then
		return'1';
		elsif(x= 4 and y=5 or y=14)then
		return'1';
		elsif(x=5 and y= 4 or y= 15)then
		return '1';
		elsif(x=6 and y=3 or y=16)then
		return '1';
		elsif(x=7 and y=2 or y= 17)then
		return '1';
		elsif(x=8 and y=1 or y=18)then
		return '1';
		elsif(x=9 and y=0 or y= 19)then
		return'1';
else return '0';
	end if;
	end if;




end function;


pure function cards (
        x     : integer range 0 to 91;
        y     : integer range 0 to 86;
        card1 : integer range 0 to 13 := 0;
        card2 : integer range 0 to 13 := 0;
        card3 : integer range 0 to 13 := 0;
        card4 : integer range 0 to 13 := 0;
        card5 : integer range 0 to 13 := 0
    ) return std_logic is

    begin
        if (x >= 36 and x <= 91 and card1 > 0) then
            if (x <= 37 or y <= 1 or x >= 90 or y >= 85) then
                return '0';
            elsif (x >= 62 and x <= 72 and y >= 33 and y <= 56) then
                big_number(x, y, number)
                return '0';
            else 
                return '1';
            end if;
            return '1';
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
        if (x_pos < 0 or x_pos > 640 or y_pos < 0 or y_pos > 480) then
            r <= 0;
            g <= 0;
            b <= 0;
        elsif (y_pos <= 470 and y_pos >= 383 and x_pos >= 10 and x_pos <= 101) then
            if (cards(y_pos - 383, x_pos - 10) = '1') then
                r <= 15;
                g <= 15;
                b <= 15;
            else
                r <= 0;
                g <= 0;
                b <= 0;
            end if;
        else
            r <= 2;
            g <= 15;
            b <= 3;
        end if;
    end process;
end architecture;
