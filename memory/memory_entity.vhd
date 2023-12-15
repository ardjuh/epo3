library IEEE;
use IEEE.std_logic_1164.all;

entity memory is
    port (
        rst                : in std_logic;
        card_enable        : in std_logic;
        card               : in std_logic_vector(3 downto 0);
        insurance          : in std_logic;
        insurance_enable   : in std_logic_vector;
        double_down        : in std_logic;
        double_down_enable : in std_logic;
        win_type           : in std_logic_vector(1 downto 0); -- 0: normal, 1: insurance, 2: double down: 3: blackjack
        win_enable         : in std_logic;
        bid                : in std_logic_vector(1 downto 0); -- 0: 2, 1: 6, 2: 10, 3: 20
    )
end entity memory;