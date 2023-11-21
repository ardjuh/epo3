-- rgb output, 4 bits per color, hsync, vsync
entity gpu_driver is
    port (
        h_pos : in std_logic_vector(9 downto 0);
        v_pos : in std_logic_vector(8 downto 0);
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0);
    );
end entity gpu_driver;