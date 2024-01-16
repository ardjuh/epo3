library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

architecture behaviour of vga_driver is

    signal h_pos_signal, v_pos_signal : unsigned(9 downto 0);

begin
         h_pos_signal <= unsigned(h_pos);
         v_pos_signal <= unsigned(v_pos);
    process(reset, h_pos_signal, v_pos_signal)
    begin
        if reset = '1' then
         H_sync <= '0';
         V_sync <= '0';
        else
             if h_pos_signal < 96 then -- Hsync should be low during the horizontal sync pulse and high otherwise
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
end behaviour;

