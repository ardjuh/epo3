library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

architecture behaviour of deck_mem is
	

	type memory is array (0 to 12) of unsigned(4 downto 0);
	signal mem, Q_reg, Q_next, Q : memory;
	signal enable : std_logic_vector(3 downto 0);
begin	

	
	
	process(clk)
	variable summation : unsigned (7 downto 0);
	begin
	if (rising_edge(clk)) then
		if random_num > "00000000" then
			summation := to_unsigned(0,8);
				
			for i in 0 to 12 loop
			--	mem(i) <= Q(i);
				summation := summation + Q(i);
				if summation >= unsigned(random_num) then
					 --word kaart op plek i
					random_card <= std_logic_vector(to_unsigned(i + 1,4));
					--mogen we in dezelfde line berekening doen en converten
				mem(i) <= Q(i) - to_unsigned(1,5);					
				--enable <= '1';
				enable <= std_logic_vector(to_unsigned(i + 1,4));

				
					exit;
				end if;
					
			end loop;
		else
			random_card <= "0000";
			enable <= "0000";
		end if;	
	end if;
	end process;	


--Elke flipflop 13 keer, 0 = aas, 1 = eenen...... 12 = koning.			
   process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(0) <= "10000";			
			else 
				Q_reg(0) <= Q_next(0); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(1) <= "10000";			
			else 
				Q_reg(1) <= Q_next(1); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(2) <= "10000";			
			else 
				Q_reg(2) <= Q_next(2); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(3) <= "10000";			
			else 
				Q_reg(3) <= Q_next(3); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(4) <= "10000";			
			else 
				Q_reg(4) <= Q_next(4); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(5) <= "10000";			
			else 
				Q_reg(5) <= Q_next(5); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(6) <= "10000";			
			else 
				Q_reg(6) <= Q_next(6); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(7) <= "10000";			
			else 
				Q_reg(7) <= Q_next(7); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(8) <= "10000";			
			else 
				Q_reg(8) <= Q_next(8); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(9) <= "10000";			
			else 
				Q_reg(9) <= Q_next(9); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(10) <= "10000";			
			else 
				Q_reg(10) <= Q_next(10); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(11) <= "10000";			
			else 
				Q_reg(11) <= Q_next(11); 
			end if;
		end if;       
	end process; 

 process(Clk)
	begin 
		if(rising_edge(Clk)) then
			if reset= '1' OR shuffle = '1' then 
				Q_reg(12) <= "10000";			
			else 
				Q_reg(12) <= Q_next(12); 
			end if;
		end if;       
	end process; 



--next state logic
Q_next(0) <= mem(0) when enable = "0001" else Q_reg(0);
Q_next(1) <= mem(1) when enable = "0010" else Q_reg(1);
Q_next(2) <= mem(2) when enable = "0011" else Q_reg(2);
Q_next(3) <= mem(3) when enable = "0100" else Q_reg(3);
Q_next(4) <= mem(4) when enable = "0101" else Q_reg(4);
Q_next(5) <= mem(5) when enable = "0110" else Q_reg(5);
Q_next(6) <= mem(6) when enable = "0111" else Q_reg(6);
Q_next(7) <= mem(7) when enable = "1000" else Q_reg(7);
Q_next(8) <= mem(8) when enable = "1001" else Q_reg(8);
Q_next(9) <= mem(9) when enable = "1010" else Q_reg(9);
Q_next(10) <= mem(10) when enable = "1011" else Q_reg(10);
Q_next(11) <= mem(11) when enable = "1100" else Q_reg(11);
Q_next(12) <= mem(12) when enable = "1101" else Q_reg(12);



--output logic
Q(0) <= Q_reg(0);
Q(1) <= Q_reg(1);
Q(2) <= Q_reg(2);
Q(3) <= Q_reg(3);
Q(4) <= Q_reg(4);
Q(5) <= Q_reg(5);
Q(6) <= Q_reg(6);
Q(7) <= Q_reg(7);
Q(8) <= Q_reg(8);
Q(9) <= Q_reg(9);
Q(10) <= Q_reg(10);
Q(11) <= Q_reg(11);
Q(12) <= Q_reg(12);

	

end behaviour;
