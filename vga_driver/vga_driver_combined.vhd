library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_driver_combined is
  port(clk : in std_logic;
       reset: in std_logic;
       x_pos: out std_logic_vector (9 downto 0);
       y_pos: out std_logic_vector (9 downto 0);
       H_sync: out std_logic;
       V_sync: out std_logic);

end vga_driver_combined;

architecture behavioral of vga_driver_combined is

  component counter 
    port (clk : in std_logic;
          reset : in std_logic;
          x_pos : out std_logic_vector(9 downto 0);
          y_pos : out std_logic_vector(9 downto 0));
  end component;

  component vga_driver
    port(
         reset : in std_logic;
         h_pos : in std_logic_vector(9 downto 0);
         v_pos : in std_logic_vector(9 downto 0);
         H_sync: out std_logic;
         V_sync: out std_logic);
  end component;

  signal m1, m2 : std_logic_vector(9 downto 0);
  signal m3, m4 : std_logic;
begin

  c1: counter port map(clk => clk, reset => reset, x_pos => m1, y_pos => m2);
  c2: vga_driver port map(reset => reset, h_pos => m1, v_pos =>m2, H_sync => m3, V_sync => m4);

  x_pos <= m1;
  y_pos <= m2;
  H_sync <= m3;
  V_sync <= m4;

end behavioral;

        
