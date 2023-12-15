library IEEE;
use IEEE.std_logic_1164.all;

--in:

-- 1 kaart
-- insurance
-- enable-kaart
-- reset
-- double down
-- double down - win
-- Blackjack - win
-- normale win
-- insurance - win
-- bid (2 bits)

entity memory is
    port (
        rst              : in std_logic;
        card_enable      : in std_logic;
        card             : in std_logic_vector(3 downto 0);
        insurance        : in std_logic;
        insurance_enable : in std_logic_vector;
    )
end entity memory;