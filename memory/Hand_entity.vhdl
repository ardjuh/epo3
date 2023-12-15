library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hand is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        mem_rst : in std_logic;
        enable  : in std_logic;
        card    : in std_logic_vector(3 downto 0);

        card1         : out std_logic_vector(3 downto 0);
        card2         : out std_logic_vector(3 downto 0);
        card3         : out std_logic_vector(3 downto 0);
        card4         : out std_logic_vector(3 downto 0);
        card5         : out std_logic_vector(3 downto 0);
        numberofcards : out std_logic_vector(2 downto 0)
    );
end entity;

architecture hand_arc of hand is

    signal numberofcards_new                                                : unsigned(2 downto 0)         := "000";
    signal card_temp, card1_new, card2_new, card3_new, card4_new, card5_new : std_logic_vector(3 downto 0) := "0000";
begin

    process (clk, rst, mem_rst, enable)
        variable numberofcards_sig : unsigned(2 downto 0) := "000";
    begin
        if (rst = '1' or mem_rst = '1') then
            numberofcards_new <= "000";
            card_temp         <= "0000";
            card1_new         <= "0000";
            card2_new         <= "0000";
            card3_new         <= "0000";
            card4_new         <= "0000";
            card5_new         <= "0000";
        elsif (rising_edge(clk)) then
            numberofcards_sig := numberofcards_new;
            case numberofcards_sig is
                when "001" =>
                    card1_new <= card_temp;
                    card2_new <= card2_new;
                    card3_new <= card3_new;
                    card4_new <= card4_new;
                    card5_new <= card5_new;
                when "010" =>
                    card1_new <= card1_new;
                    card2_new <= card_temp;
                    card3_new <= card3_new;
                    card4_new <= card4_new;
                    card5_new <= card5_new;
                when "011" =>
                    card1_new <= card1_new;
                    card2_new <= card2_new;
                    card3_new <= card_temp;
                    card4_new <= card4_new;
                    card5_new <= card5_new;
                when "100" =>
                    card1_new <= card1_new;
                    card2_new <= card2_new;
                    card3_new <= card3_new;
                    card4_new <= card_temp;
                    card5_new <= card5_new;
                when "101" =>
                    card1_new <= card1_new;
                    card2_new <= card2_new;
                    card3_new <= card3_new;
                    card4_new <= card4_new;
                    card5_new <= card_temp;
                when others =>
                    null; -- Do nothing for other cases
            end case;

            if (enable = '1') then
                numberofcards_new <= numberofcards_sig + 1;
                card_temp         <= card;
            else
                null;
            end if;
        end if;
    end process;

    card1         <= card1_new;
    card2         <= card2_new;
    card3         <= card3_new;
    card4         <= card4_new;
    card5         <= card5_new;
    numberofcards <= std_logic_vector(numberofcards_new);

end architecture;
