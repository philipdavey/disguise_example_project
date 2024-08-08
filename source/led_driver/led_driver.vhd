-------------------------------------------------------------------------------
-- Title    : LED Driver
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

-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------
entity led_driver is
  generic (
    SIMULATION_MODE : boolean := True -- Simulation mode to add / remove button debounce logic  
  );
  port (
    -- Clock and Active Low reset:
    clk          : in  std_logic;
    rst_n        : in  std_logic;
    -- Button Input:
    input_button : in  std_logic;
    -- LED Output:
    led_out      : out std_logic_vector(7 downto 0)
  );
end entity led_driver;

-------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------
architecture arch of led_driver is

  -- Type and signals defined:
  type state_t is (s_idle,
                   s_increment);
 
  signal state_s         : state_t;      -- Signal for state
  signal cycle_cnt_s     : integer := 0; -- Signal for counter
  signal debounced_btn_s : std_logic;

  -- Mark signals for debug:
  attribute MARK_DEBUG : string;
  attribute MARK_DEBUG of state_s     : signal is "TRUE";
  attribute MARK_DEBUG of cycle_cnt_s : signal is "TRUE";

begin

  -------------------------------------------------------------------------------
  -- Instantiate button debounce block:
  -------------------------------------------------------------------------------
  btn_debounce_gen : if SIMULATION_MODE = False generate
    button_debounce_inst : entity work.button_debounce
    generic map (
      clk_freq      => 100_000_000, -- 100MHz clock input
      stable_time   => 10           -- 10ms Settling Time
    )
    port map (
      -- Clock and Reset:
      clk           => clk,
      rst_n         => rst_n,
      -- Input Button:
      input_button  => input_button,
      -- Debounced Output
      btn_debounced => debounced_btn_s
    );
  else generate
    debounced_btn_s <= input_button;
  end generate;

  -------------------------------------------------------------------------------
  -- Process to move to next LED when the input button is pressed:
  -------------------------------------------------------------------------------
  process(clk, rst_n)
  begin
    if rst_n = '0' then
      cycle_cnt_s <= 0;
      led_out     <= (others => '0');
      state_s     <= s_idle;
    elsif rising_edge(clk) then

      case state_s is

        when s_idle =>
          led_out(cycle_cnt_s) <= '1';
          if debounced_btn_s = '1' then
            led_out(cycle_cnt_s) <= '0';
            state_s <= s_increment;
          end if;

        when s_increment =>
          if cycle_cnt_s = 7 then
            cycle_cnt_s <= 0;
            state_s     <= s_idle;
          else
            cycle_cnt_s <= cycle_cnt_s + 1;
            state_s     <= s_idle;
          end if;

        when others =>
          state_s <= s_idle;

      end case;
    end if;
  end process;
end arch;