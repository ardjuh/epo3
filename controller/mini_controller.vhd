library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mini_con is
    port (
        clk           : in std_logic;
        reset         : in std_logic;
        button_left   : in std_logic;
        button_right  : in std_logic;
        button_select : in std_logic;

        switch_left   : out std_logic;
        switch_right  : out std_logic;
        switch_select : out std_logic);
end mini_con;

architecture behaviour of mini_con is

    type mini_con_state is (
        sela,
        selb,
        --	upa,
        --	upb,
        --	downa,
        --	downb,
        lefta,
        leftb,
        righta,
        rightb,
        reset_state,
        player_action
    );

    signal state, new_state : mini_con_state;
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                state <= reset_state;
            else
                state <= new_state;
            end if;
        end if;
    end process;

    process (state, button_left, button_right, button_select)
        variable button : std_logic_vector(2 downto 0);
    begin
        button(0) := button_left;
        button(1) := button_right;
        button(2) := button_select;

        switch_select <= '0';
        switch_left   <= '0';
        switch_right  <= '0';

        case state is

            when player_action =>
                switch_select <= '0';
                switch_left   <= '0';
                switch_right  <= '0';
                if (button = "100") then
                    new_state <= sela;
                elsif (button = "001") then
                    new_state <= lefta;
                elsif (button = "010") then
                    new_state <= righta;
                else
                    new_state <= player_action;
                end if;

			when sela => 
				switch_select <= '1' ; 	
				if  (button = "100") then 
					new_state <= selb;
				else 
					new_state <= player_action; 
				end if;
					
			when selb => 
				switch_select <= '0' ; 	
				if  (button = "100") then 
					new_state <= selb; 
				else 
					new_state <= player_action;
				end if;
					
			when lefta => 
				switch_left <= '1' ;	
				if  (button = "001") then 
					new_state <= leftb;
				else 
					new_state <= player_action;
				end if;
					
			when leftb =>
				 switch_left <= '0';
				if (button = "001") then 
					new_state <= leftb;
				else 
					new_state <= player_action;
				end if;
					
			when righta => 
				switch_right <= '1' ;	
				if (button = "010") then
				 	new_state <= rightb;
				else 
					new_state <= player_action;
				end if;
					
			when rightb => 
				switch_right <= '0' ;
				if (button = "010") then 
					new_state <= rightb;
				else 
					new_state <= player_action;
	        		end if;

            when reset_state =>
                switch_right  <= '0';
                switch_left   <= '0';
                switch_select <= '0';
                if (reset = '0') then
                    new_state <= player_action;
                else
                    new_state <= reset_state;
                end if;
        end case;
    end process;
end architecture behaviour;
