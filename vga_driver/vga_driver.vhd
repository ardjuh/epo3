library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_driver is
    port(clk   	: in std_logic;
        reset 	: in std_logic;
        H_sync	: out std_logic;
        V_sync	: out std_logic;
        x	: out std_logic;
        y	: out std_logic;
        R	: out std_logic;
	G	: out std_logic;
	B	: out std_logic);
end vga_driver;

architecture vga_driver of vga_driver is
--constants used in the vga driver
	constant hpixels: std_logic_vector(9 downto 0) := "1100100000"; --amount of pixels in a line (800)
	constant vlines: std_logic_vector(9 downto 0) := "1100001001"; -- amount of lines (521)
	constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --horizontal backporch (144) (hsync pulse plus initial hbackporch)
	constant hfp: std_logic_vector(9 downto 0) := "1100010000"; -- horizontal frontporch (784) (hbackporch plus hscreen)
	constant hsp: std_logic_vector(9 downto 0) := "0010000000"; -- horizontal sync pulse (128)
	constant vbp: std_logic_vector(9 downto 0) := "1111100000"; --vertical backporch (31) (vsync pulse plus initial vbackporch)
	constant vfp: std_logic_vector(9 downto 0) := "0111111111"; --vertical frontporch (511) (vbackporch plus vscreen)
	constant vsp: std_logic_vector(9 downto 0) := "0000000010"; --vertical sync pulse (2)

	signal hc, vc: std_logic_vector (9 downto 0);
	--horizontal and vertical counters
	signal video: std_logic;
	--whether the video should be on or not
	signal vc_enable: std_logic;
	--whether the vertical counter should increment


begin
	--horizontal counter
	process (clk, reset)
	begin
		if reset = '1' then
			hc <= "0000000000";
			x <= "0000000000";
		elsif (rising_edge(clk)) then
			if hc = hpixels - 1 then --the counter reaches the end of the line
				hc <= "0000000000"; --reset the counter
				vc_enable <= '1'; --enable the vertical counter
			else
			hc <= hc + 1; --incement the horizontal counter
			vc_enable <= '0'; --disable the vertical counter
			end if;
				
			if (hc > hbp) then --x position counter, it starts when we leave the backporch
				if (hc >= hfp) then
					x <= "0000000000"; -- it resets when we enter teh frontporch
				else 
					x <= x + 1;
			end if;
		end if;
	end process;

	hsync <= '0' when (hc < hsp) else hsync <= '1'; --Hsync should be low during the sync pulse, high otherwise

	--vertical counter
	process (clk, reset)
	begin
		if reset = '1' then
			vc <= "0000000000";
			y <= "0000000000";
		elsif (rising_edge(clk) and vc_enable = '1') then --increment when vc_enable is on
			if vc = vc_lines - 1 then --the vertical counter is at the end of the lines
				vc <= "0000000000";--so the counter is reset
			else
				vc <= vc + 1;
			end if;

			if (vc > vbp) then --y position counter, it goes up when we're past the backporch
				if (vc >= vfp) then
					y <= "0000000000"; -- it resets when we enter the front porch
				else 
					y <= y + 1;
			end if;
		end if;
	end process;

	vsync <= '0' when (vc < vsp) else vsync <= '1'; --vsync should be low during the sync pulse, high otherwise
