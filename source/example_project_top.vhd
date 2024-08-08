-------------------------------------------------------------------------------
-- Title    : Top Level
-- Project  : Example Project
-------------------------------------------------------------------------------
-- File     : example_project_top.vhd
-- Author   : Philip Davey
-- Platform : Xilinx Vivado
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Library Files
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------
entity example_project_top is
  port (
    -- Clock and Active Low reset:
    fpga_clk_n         : in    std_logic;
    fpga_clk_p         : in    std_logic;
    mig_clk_n          : in    std_logic;
    mig_clk_p          : in    std_logic;
    fpga_rst_n         : in    std_logic;
    -- Button Input:
    input_button       : in    std_logic;
    -- LED Output:
    led_out            : out   std_logic_vector( 7 downto 0);
    -- DDR4 Interface:
    ddr4_rtl_0_ck_c    : out   std_logic_vector( 0 to 0);
    ddr4_rtl_0_ck_t    : out   std_logic_vector( 0 to 0);
    ddr4_rtl_0_reset_n : out   std_logic;
    ddr4_rtl_0_cke     : out   std_logic_vector( 0 to 0);
    ddr4_rtl_0_cs_n    : out   std_logic_vector( 0 to 0);
    ddr4_rtl_0_act_n   : out   std_logic;
    ddr4_rtl_0_adr     : out   std_logic_vector(16 downto 0);
    ddr4_rtl_0_ba      : out   std_logic_vector( 1 downto 0);
    ddr4_rtl_0_bg      : out   std_logic_vector( 1 downto 0);
    ddr4_rtl_0_dm_n    : inout std_logic_vector( 0 to 0);
    ddr4_rtl_0_dq      : inout std_logic_vector( 7 downto 0);
    ddr4_rtl_0_dqs_c   : inout std_logic_vector( 0 to 0);
    ddr4_rtl_0_dqs_t   : inout std_logic_vector( 0 to 0);
    ddr4_rtl_0_odt     : out   std_logic_vector( 0 to 0)
  );
end entity example_project_top;

-------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------
architecture arch of example_project_top is

  -- 100 MHz clock signal:
  signal clk_100mhz_s         : std_logic;
  signal fpga_rst_s           : std_logic; -- Active High FPGA Reset

  -- Input button and LED:
  signal input_button_s       : std_logic;
  signal led_out_s            : std_logic_vector(7 downto 0);

  -- DDR4 Related signals:
  signal ddr4_rtl_0_ck_c_s    : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_ck_t_s    : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_reset_n_s : std_logic;  
  signal ddr4_rtl_0_cke_s     : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_cs_n_s    : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_act_n_s   : std_logic;
  signal ddr4_rtl_0_adr_s     : std_logic_vector(16 downto 0); 
  signal ddr4_rtl_0_ba_s      : std_logic_vector( 1 downto 0);  
  signal ddr4_rtl_0_bg_s      : std_logic_vector( 1 downto 0);  
  signal ddr4_rtl_0_dm_n_s    : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_dq_s      : std_logic_vector( 7 downto 0);  
  signal ddr4_rtl_0_dqs_c_s   : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_dqs_t_s   : std_logic_vector( 0 downto 0);  
  signal ddr4_rtl_0_odt_s     : std_logic_vector( 0 downto 0);  

begin

  -------------------------------------------------------------------------------
  -- Concurrent Statements:
  -------------------------------------------------------------------------------
  fpga_rst_s         <= not(fpga_rst_n); -- Convert Active Low reset to Active High.

  led_out            <= led_out_s;
  input_button_s     <= input_button;

  -- DDR4 Interface:
  ddr4_rtl_0_ck_c    <= ddr4_rtl_0_ck_c_s;   
  ddr4_rtl_0_ck_t    <= ddr4_rtl_0_ck_t_s;   
  ddr4_rtl_0_reset_n <= ddr4_rtl_0_reset_n_s;
  ddr4_rtl_0_cke     <= ddr4_rtl_0_cke_s;    
  ddr4_rtl_0_cs_n    <= ddr4_rtl_0_cs_n_s;   
  ddr4_rtl_0_act_n   <= ddr4_rtl_0_act_n_s;  
  ddr4_rtl_0_adr     <= ddr4_rtl_0_adr_s;    
  ddr4_rtl_0_ba      <= ddr4_rtl_0_ba_s;     
  ddr4_rtl_0_bg      <= ddr4_rtl_0_bg_s;     
  ddr4_rtl_0_dm_n    <= ddr4_rtl_0_dm_n_s;   
  ddr4_rtl_0_dq      <= ddr4_rtl_0_dq_s;     
  ddr4_rtl_0_dqs_c   <= ddr4_rtl_0_dqs_c_s;  
  ddr4_rtl_0_dqs_t   <= ddr4_rtl_0_dqs_t_s;  
  ddr4_rtl_0_odt     <= ddr4_rtl_0_odt_s;    

  -------------------------------------------------------------------------------
  -- Clocking Wizard:
  -------------------------------------------------------------------------------
  clk_wiz_inst : entity work.clk_wiz_0
  port map (
    -- Input Clock and Reset:
    clk_in1_n => fpga_clk_n,  -- 33.33 MHz in
    clk_in1_p => fpga_clk_p,
    resetn    => fpga_rst_n,  -- Active Low reset in
    -- Output Clock
    clk_out1  => clk_100mhz_s -- 100 MHz clock out
  );

  -------------------------------------------------------------------------------
  -- LED Driver:
  -------------------------------------------------------------------------------
  led_driver_inst : entity work.led_driver
  generic map (
    SIMULATION_MODE => True
  )
  port map (
    -- Input Clock and Active Low reset:
    clk          => clk_100mhz_s,
    rst_n        => fpga_rst_n,
    -- Input button:
    input_button => input_button_s,
    -- LED Output:
    led_out      => led_out_s
  );

  -------------------------------------------------------------------------------
  -- Microblaze and DDR4 RAM Block Diagram:
  -------------------------------------------------------------------------------
  microblaze_ddr4_inst : entity work.microblaze_wrapper
  port map (
    -- Clocks and Resets:
    C0_SYS_CLK_0_clk_n       => mig_clk_n,
    C0_SYS_CLK_0_clk_p       => mig_clk_p,
    reset_rtl_0              => fpga_rst_n,           -- Active Low reset for Clk Wiz
    reset_rtl_0_0            => fpga_rst_s,           -- Active High reset for DDR4

    c0_init_calib_complete_0 => open,
    dbg_bus_0                => open,
    dbg_clk_0                => open,

    -- DDR4 Related ports:
    ddr4_rtl_0_ck_c          => ddr4_rtl_0_ck_c_s,    -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_ck_t          => ddr4_rtl_0_ck_t_s,    -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_reset_n       => ddr4_rtl_0_reset_n_s, -- STD_LOGIC;
    ddr4_rtl_0_cke           => ddr4_rtl_0_cke_s,     -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_cs_n          => ddr4_rtl_0_cs_n_s,    -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_act_n         => ddr4_rtl_0_act_n_s,   -- STD_LOGIC;
    ddr4_rtl_0_adr           => ddr4_rtl_0_adr_s,     -- STD_LOGIC_VECTOR( 16 downto 0 );
    ddr4_rtl_0_ba            => ddr4_rtl_0_ba_s,      -- STD_LOGIC_VECTOR( 1 downto 0 );
    ddr4_rtl_0_bg            => ddr4_rtl_0_bg_s,      -- STD_LOGIC_VECTOR( 1 downto 0 );
    ddr4_rtl_0_dm_n          => ddr4_rtl_0_dm_n_s,    -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_dq            => ddr4_rtl_0_dq_s,      -- STD_LOGIC_VECTOR( 7 downto 0 );
    ddr4_rtl_0_dqs_c         => ddr4_rtl_0_dqs_c_s,   -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_dqs_t         => ddr4_rtl_0_dqs_t_s,   -- STD_LOGIC_VECTOR( 0 to 0 );
    ddr4_rtl_0_odt           => ddr4_rtl_0_odt_s      -- STD_LOGIC_VECTOR( 0 to 0 );
  );

end arch;