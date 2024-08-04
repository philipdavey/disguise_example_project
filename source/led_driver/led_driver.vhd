----------------------------------------------------------------------
-- Title    : LED Driver
-- Project  : Disguise Code challenge
----------------------------------------------------------------------
-- File     : led_driver.vhd
-- Author   : Philip Davey
-- Platform : Xilinx Vivado
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Library Files:
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------------------------
-- Entity declaration:
----------------------------------------------------------------------
entity led_driver is
  port (
    -- Clock and Reset:
    clk          : in  std_logic;
    rst_n        : in  std_logic;
    -- Input Push button:
    input_button : in  std_logic;
    -- LED outputs:
    led_out      : out std_logic_vector(7 downto 0)
  );
end entity led_driver;

architecture rtl_led_driver of led_driver is

  -- Types and signals declared:

  type state_t is (s_idle, s_increment); -- State type defined
  signal state_s     : state_t;          -- State signal

  signal cycle_cnt_s : integer := 0;     -- Cycle counter to count through all 8 LEDs.

  -- Signals assigned to be kept / marked for debug:
  attribute KEEP       : boolean;
  attribute MARK_DEBUG : boolean;
  attribute KEEP       of state_s     : signal is True;
  attribute MARK_DEBUG of state_s     : signal is True;
  attribute KEEP       of cycle_cnt_s : signal is True;
  attribute MARK_DEBUG of cycle_cnt_s : signal is True;

begin

  ----------------------------------------------------------------------
  -- Process to cycle through different flashing modes.
  ----------------------------------------------------------------------
  process (clk, rst_n)
  begin
    if rst_n = '0' then
      led_out <= (others => '0'); -- Reset LEDs
      state_s <= s_idle;
    elsif rising_edge(clk) then

      case state_s is

        when s_idle =>
          led_out(cycle_cnt_s) <= '1'; -- Assign first LED and wait for button to be pressed.

          if input_button = '1' then -- When button pressed, move to increment counter state.
            led_out(cycle_cnt_s) <= '0';
            state_s <= s_increment;
          end if;

        when s_increment =>
          cycle_cnt_s <= cycle_cnt_s + 1; -- Increment counter

          if cycle_cnt_s = 8 then -- If cycle counter goes beyond number of LEDs, reset to zero.
            cycle_cnt_s <= 0;
            state_s     <= s_idle;
          end if;

        when others =>
          null;
      end case;
    end if;
  end process;

end rtl_led_driver;