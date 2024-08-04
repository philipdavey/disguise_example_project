----------------------------------------------------------------------
-- Title    : Top Level
-- Project  : Disguise Code challenge
----------------------------------------------------------------------
-- File     : code_challenge_top.vhd
-- Author   : Philip Davey
-- Platform : Xilinx Vivado
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Library Files:
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity code_challenge_top is
  port (
    -- Input Differential Clock (33.33MHz):
    fpga_clk_33_p    : in    std_logic;
    fpga_clk_33_n    : in    std_logic;
    -- Input Differential Clock (100MHz for DDR4 and Microblaze):
    fpga_clk_100_p   : in    std_logic;
    fpga_clk_100_n   : in    std_logic;
    -- FPGA Reset:
    fpga_rst_n       : in    std_logic;
    -- Input button:
    input_button     : in    std_logic;
    -- MIG Interface:
    ddr4_rtl_0_act_n : out   std_logic;
    ddr4_rtl_0_adr   : out   std_logic_vector(16 downto 0 );
    ddr4_rtl_0_ba    : out   std_logic_vector(1 downto 0 );
    ddr4_rtl_0_bg    : out   std_logic_vector(1 downto 0 );
    ddr4_rtl_0_ck_c  : out   std_logic_vector(0 to 0 );
    ddr4_rtl_0_ck_t  : out   std_logic_vector(0 to 0 );
    ddr4_rtl_0_cke   : out   std_logic_vector(0 to 0 );
    ddr4_rtl_0_cs_n  : out   std_logic_vector(0 to 0 );
    ddr4_rtl_0_dm_n  : inout std_logic_vector(0 to 0 );
    ddr4_rtl_0_dq    : inout std_logic_vector(7 downto 0 );
    ddr4_rtl_0_dqs_c : inout std_logic_vector(0 to 0 );
    ddr4_rtl_0_odt   : out   std_logic_vector(0 to 0 );
    -- LED Outputs:
    led_out          : out   std_logic_vector(7 downto 0)
  );
end entity code_challenge_top;

architecture rtl_code_challenge_top of code_challenge_top is

  -- Signal declaration:
  signal clk_100_mhz_s : std_logic; -- 100 MHz Clock

  signal reset_rtl_0_s        : std_logic;
  signal ddr4_rtl_0_reset_n_s : std_logic;

begin

  ----------------------------------------------------------------------
  -- Clock Wizard - Converts 33.33MHz differential to 100MHz output
  ----------------------------------------------------------------------
  clk_wiz_inst : entity work.clk_wiz_0
  port map (
    clk_in1_p => fpga_clk_33_p,
    clk_in1_n => fpga_clk_33_n,
    locked    => open,
    clk_out1  => clk_100_mhz_s -- 100MHz clock output
  );

  ----------------------------------------------------------------------
  -- Design 1 block diagram (Includes Microblaze and DDR4 IP):
  ----------------------------------------------------------------------
  design_1_inst : entity work.design_1_wrapper
  port map (
    -- Clock and Reset:
    diff_clock_rtl_0_clk_n => fpga_clk_100_n,
    diff_clock_rtl_0_clk_p => fpga_clk_100_p,
    reset_rtl_0            => reset_rtl_0_s,
    -- MIG Interface:
    ddr4_rtl_0_reset_n     => ddr4_rtl_0_reset_n_s,
    ddr4_rtl_0_act_n       => ddr4_rtl_0_act_n, -- ddr4_rtl_0_act_n : out STD_LOGIC;
    ddr4_rtl_0_adr         => ddr4_rtl_0_adr,   -- ddr4_rtl_0_adr : out STD_LOGIC_VECTOR ( 16 downto 0 );
    ddr4_rtl_0_ba          => ddr4_rtl_0_ba,    -- ddr4_rtl_0_ba : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_bg          => ddr4_rtl_0_bg,    -- ddr4_rtl_0_bg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_ck_c        => ddr4_rtl_0_ck_c,  -- ddr4_rtl_0_ck_c : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_ck_t        => ddr4_rtl_0_ck_t,  -- ddr4_rtl_0_ck_t : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cke         => ddr4_rtl_0_cke,   -- ddr4_rtl_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cs_n        => ddr4_rtl_0_cs_n,  -- ddr4_rtl_0_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dm_n        => ddr4_rtl_0_dm_n,  -- ddr4_rtl_0_dm_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dq          => ddr4_rtl_0_dq,    -- ddr4_rtl_0_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    ddr4_rtl_0_dqs_c       => ddr4_rtl_0_dqs_c, -- ddr4_rtl_0_dqs_c : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_odt         => ddr4_rtl_0_odt    -- ddr4_rtl_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
  );

  ----------------------------------------------------------------------
  -- LED Driver - Custom RTL
  ----------------------------------------------------------------------
  led_driver_inst : entity work.led_driver
  port map (
    clk          => clk_100_mhz_s,
    rst_n        => fpga_rst_n,
    input_button => input_button,
    led_out      => led_out
  );

end rtl_code_challenge_top;