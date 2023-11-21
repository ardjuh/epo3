-- rgb output, 4 bits per color, hsync, vsync
entity gpu_driver is
    port (
        h_pos : in std_logic_vector(9 downto 0);
        v_pos : in std_logic_vector(8 downto 0);
        red   : out integer range 0 to 15;
        green : out integer range 0 to 15;
        blue  : out integer range 0 to 15
    );
end entity gpu_driver;