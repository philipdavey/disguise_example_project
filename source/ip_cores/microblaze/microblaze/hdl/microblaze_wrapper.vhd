--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Thu Aug  8 13:28:41 2024
--Host        : GBR-L-8PQ9JR3 running 64-bit major release  (build 9200)
--Command     : generate_target microblaze_wrapper.bd
--Design      : microblaze_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity microblaze_wrapper is
  port (
    C0_SYS_CLK_0_clk_n : in STD_LOGIC;
    C0_SYS_CLK_0_clk_p : in STD_LOGIC;
    c0_init_calib_complete_0 : out STD_LOGIC;
    dbg_bus_0 : out STD_LOGIC_VECTOR ( 511 downto 0 );
    dbg_clk_0 : out STD_LOGIC;
    ddr4_rtl_0_act_n : out STD_LOGIC;
    ddr4_rtl_0_adr : out STD_LOGIC_VECTOR ( 16 downto 0 );
    ddr4_rtl_0_ba : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_bg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_ck_c : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_ck_t : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dm_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    ddr4_rtl_0_dqs_c : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dqs_t : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_reset_n : out STD_LOGIC;
    reset_rtl_0 : in STD_LOGIC;
    reset_rtl_0_0 : in STD_LOGIC
  );
end microblaze_wrapper;

architecture STRUCTURE of microblaze_wrapper is
  component microblaze is
  port (
    ddr4_rtl_0_act_n : out STD_LOGIC;
    ddr4_rtl_0_adr : out STD_LOGIC_VECTOR ( 16 downto 0 );
    ddr4_rtl_0_ba : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_bg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr4_rtl_0_ck_c : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_ck_t : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dm_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    ddr4_rtl_0_dqs_c : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_dqs_t : inout STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr4_rtl_0_reset_n : out STD_LOGIC;
    C0_SYS_CLK_0_clk_n : in STD_LOGIC;
    C0_SYS_CLK_0_clk_p : in STD_LOGIC;
    reset_rtl_0 : in STD_LOGIC;
    reset_rtl_0_0 : in STD_LOGIC;
    c0_init_calib_complete_0 : out STD_LOGIC;
    dbg_bus_0 : out STD_LOGIC_VECTOR ( 511 downto 0 );
    dbg_clk_0 : out STD_LOGIC
  );
  end component microblaze;
begin
microblaze_i: component microblaze
     port map (
      C0_SYS_CLK_0_clk_n => C0_SYS_CLK_0_clk_n,
      C0_SYS_CLK_0_clk_p => C0_SYS_CLK_0_clk_p,
      c0_init_calib_complete_0 => c0_init_calib_complete_0,
      dbg_bus_0(511 downto 0) => dbg_bus_0(511 downto 0),
      dbg_clk_0 => dbg_clk_0,
      ddr4_rtl_0_act_n => ddr4_rtl_0_act_n,
      ddr4_rtl_0_adr(16 downto 0) => ddr4_rtl_0_adr(16 downto 0),
      ddr4_rtl_0_ba(1 downto 0) => ddr4_rtl_0_ba(1 downto 0),
      ddr4_rtl_0_bg(1 downto 0) => ddr4_rtl_0_bg(1 downto 0),
      ddr4_rtl_0_ck_c(0) => ddr4_rtl_0_ck_c(0),
      ddr4_rtl_0_ck_t(0) => ddr4_rtl_0_ck_t(0),
      ddr4_rtl_0_cke(0) => ddr4_rtl_0_cke(0),
      ddr4_rtl_0_cs_n(0) => ddr4_rtl_0_cs_n(0),
      ddr4_rtl_0_dm_n(0) => ddr4_rtl_0_dm_n(0),
      ddr4_rtl_0_dq(7 downto 0) => ddr4_rtl_0_dq(7 downto 0),
      ddr4_rtl_0_dqs_c(0) => ddr4_rtl_0_dqs_c(0),
      ddr4_rtl_0_dqs_t(0) => ddr4_rtl_0_dqs_t(0),
      ddr4_rtl_0_odt(0) => ddr4_rtl_0_odt(0),
      ddr4_rtl_0_reset_n => ddr4_rtl_0_reset_n,
      reset_rtl_0 => reset_rtl_0,
      reset_rtl_0_0 => reset_rtl_0_0
    );
end STRUCTURE;
