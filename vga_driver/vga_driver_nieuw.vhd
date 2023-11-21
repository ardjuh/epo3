library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_driver is
  port(clk      : in std_logic;
      reset     : in std_logic;
      H_sync    : out std_logic;
      V_sync    : out std_logic;
      VIDON     : out std_logic;
      vc, hc    : out integer range 0 to 799);

end entity;


architecture arch of vga_driver is 

component FSM_sync is
  port(clk      : in std_logic;
       reset    : in std_logic;
       H_sync   : out std_logic;
       V_sync   : out std_logic;
       VIDON    : out std _logic;
       vc, hc   : out integer range 0 to 799);

end component;

end arch;

entity FSM_sync is
  port(clk      : in std_logic;
       reset    : in std_logic;
       H_sync   : out std_logic;
       V_sync   : out std_logic;
       VIDON    : out std _logic;
       vc, hc   : out integer range 0 to 799);

end entity;

architecture arch of FSM_sync is

  constant counter_max_h : integer := 640;
  constant counter_sp_h  : integer := 96;
  constant counter_bp_h  : integer := 48;
  constant counter_hv_h  : integer := 640;
  constant counter_fp_h : integer := 16;

  constant counter_max_v : integer := 384000; -- voor een heel frame 480*800
  constant counter_sp_v  : integer := 1600; -- 2 lines (2*800)
  constant counter_bp_v  : integer := 26400; -- 33 lines (33*800)
  constant counter_hv_v : integer := 384000; -- active (480*800)
  constant counter_fp_v  : integer := 8000; --  10 lines (10*800)

  constant pixel_max_h : integer := 800;
  constant pixel_max_v : integer := 525;

  type state is (SP, BP, HV, FP, reset);

  signal present_state_h, next_state_h, present_state_v, next_state_v : state;

  signal timer : integer range 0 to counter_max_h; 
  signal timer2 : integer range 0 to counter_max_v;
  signal video_1, video_2 : std_logic;
  signal h_count_reg, v_count_reg : integer range 0 to 799;

  begin 
  counter : process (clk, reset)
             variable counter1 : integer range 0 to counter_max_h - 1;
             variable counter2 : integer range 0 to pixel_max_h - 1;
             variable counter3 : integer range 0 to pixel_max_v -1;
            begin
              if (reset = '1') then

                counter1 := 0;
                counter2 := 0;
                counter3 := 0;
                present_state_h <= reset;

              elsif (clk'event and clk = '1') then
                counter1 := counter1 + 1;
                if (counter2 < pixel_max_h -1)
                  counter2 := counter2 +1;
                else
                  counter2 :=0;
                  if (counter3 < pixel_max_v -1)
                    counter3 := counter3 +1;
                  else
                    counter3 := 0;
                  end if;

                end if;

    horizontal sync: process(next_state_h)
            begin

              H_sync <= '1';
              next_state_H <= HV;

              case present_state_h is
                when SP => 
                    H_sync <= '0';
                    next_state_h <= BP;
                    timer <= counter_sp_h;
                    video_1 <= '0';

                when BP =>
                    H_sync <= '1';
                    next_state_h <= HV;
                    timer <= counter_bp_h

  
    
  
      
       
