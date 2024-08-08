-------------------------------------------------------------------------------
-- Title    : Button Debounce
-- Project  : Example Project
-------------------------------------------------------------------------------
-- File     : button_debounce.vhd
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
entity button_debounce is
  generic (
    clk_freq    : integer := 100_000_000; -- Input clock frequency in Hz
    stable_time : integer := 10           -- Time that the button must be stable in ms
  );
  port (
    -- Clock and Active Low reset:
    clk           : in  std_logic;
    rst_n         : in  std_logic;
    -- Button Input:
    input_button  : in  std_logic;
    -- LED Output:
    btn_debounced : out std_logic
  );
end entity button_debounce;

architecture arch of button_debounce is

  signal button_reg      : std_logic_vector(1 downto 0); -- Button registers
  signal xor_out         : std_logic; -- XOR Output

  signal btn_debounced_s : std_logic;

begin

  -------------------------------------------------------------------------------
  -- Concurrent Statements:
  -------------------------------------------------------------------------------
  -- XOR both outputs (will output 1 when there is a difference between two flip flops):
  xor_out <= button_reg(0) xor button_reg(1);

  btn_debounced <= btn_debounced_s;

  -------------------------------------------------------------------------------
  -- Process to make sure button has been stable for at least 10ms:
  -------------------------------------------------------------------------------
  process(clk, rst_n)
    variable counter : integer range 0 to clk_freq*stable_time/1000;
  begin
    if rst_n = '0' then
      button_reg    <= (others => '0');
      counter       := 0;
      btn_debounced <= '0';
    elsif rising_edge(clk) then
      
      button_reg(0) <= input_button;  -- Assign to input button
      button_reg(1) <= button_reg(0); -- Assign to registered value of input button

      if xor_out = '1' then -- If there has been a change between both registers
        counter := 0;
      elsif (counter < clk_freq*stable_time/1000) THEN  --stable input time is not yet met
        counter := counter + 1;
      else
        btn_debounced <= button_reg(1);
      end if;
    end if;
  end process;

end arch;