library IEEE;
use IEEE.std_logic_1164.ALL;

entity main is
   port(r      : out std_logic_vector(3 downto 0);
        g      : out std_logic_vector(3 downto 0);
        b      : out std_logic_vector(3 downto 0);
        clk    : in  std_logic;
        reset  : in  std_logic;
        vga_hsync : out std_logic;
        vga_vsync : out std_logic);
end main;
