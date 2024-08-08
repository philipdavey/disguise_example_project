-------------------------------------------------------------------------------
-- Title    : LED Driver testbench
-- Project  : Example Project
-------------------------------------------------------------------------------
-- File     : led_driver.vhd
-- Author   : Philip Davey
-- Platform : Xilinx Vivado
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Library Files
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

-------------------------------------------------------------------------------
-- Entity declaration:
-------------------------------------------------------------------------------
entity led_driver_tb is
end entity led_driver_tb;

-------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------
architecture test of led_driver_tb is
  signal clk_s          : std_logic := '0';
  signal rst_n_s        : std_logic := '1';
  signal input_button_s : std_logic := '0';
  signal led_out_s      : std_logic_vector(7 downto 0) := (others => '0');

begin

  -------------------------------------------------------------------------------
  -- Clock and Active Low reset:
  -------------------------------------------------------------------------------
  clk_s   <= not clk_s after 10ns;
  rst_n_s <= '0', '1' after 30ns;

  -------------------------------------------------------------------------------
  -- DUT Instantiation:
  -------------------------------------------------------------------------------
  dut : entity work.led_driver
  port map (
    -- Clock and Active Low reset:
    clk          => clk_s,
    rst_n        => rst_n_s,
    -- Input button:
    input_button => input_button_s,
    -- LED Output:
    led_out      => led_out_s
  );

  -------------------------------------------------------------------------------
  -- Test Stimulus:
  -------------------------------------------------------------------------------
  stim : process
  begin

    input_button_s <= '0';

    -- Wait for active low reset:
    wait until (rst_n_s = '1');

    for i in 0 to 25 loop
      wait until rising_edge(clk_s);
    end loop;

    for i in 0 to 7 loop
      wait until rising_edge(clk_s);
      input_button_s <= '1';
      wait until rising_edge(clk_s);
      input_button_s <= '0';

      for i in 0 to 25 loop
        wait until rising_edge(clk_s);
      end loop;
    end loop;

    stop;

  end process;
  
end test;