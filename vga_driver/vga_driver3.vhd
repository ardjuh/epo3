library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_driver is
    port(clk   	: in std_logic;
        reset 	: in std_logic;
        h_pos   : in std_logic_vector (9 downto 0);
        v_pos   : in std_logic_vector (9 downto 0);
        H_sync	: out std_logic;
        V_sync	: out std_logic;
        
end vga_driver;

architecture vga_driver_arch of vga_driver is

    signal h_pos_signal, v_pos_signal : unsigned(9 downto 0);

begin
         h_pos_signal <= unsigned(h_pos)
         v_pos_signal <= unsigned(v_pos)
    process(clk, reset)
    begin
        if reset = '1' then
         H_sync <= '0';
         V_sync <= '0';

        elsif rising_edge(clk) then
         
             if h_pos_signal < 128 then -- Hsync should be low during the horizontal sync pulse and high otherwise
                 H_sync <= '0';
             else 
                 H_sync <= '1';
             end if;
         
             if v_pos_signal < 2 then-- Vsync should be low during the vertical sync pulse and high otherwise
                V_sync <= '0';
             else 
                V_sync <= '1';
             end if;
         end if;
    end process;
end vga_driver_arch;

    
