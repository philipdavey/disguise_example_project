#-------------------------------------------------------------------------------
#-- Title    : Script to run LED Driver Testbench
#-- Project  : Example Project
#-------------------------------------------------------------------------------
#-- File     : run_led_driuver_tb.do
#-- Author   : Philip Davey
#-- Platform : Questasim
#-------------------------------------------------------------------------------

set sim_dir [pwd]
set output_dir ../sim/output
set work_dir   [pwd]/work
set source_dir ../source

# RTL Files:
vcom -2008 -work $work_dir $source_dir/button_debounce/button_debounce.vhd
vcom -2008 -work $work_dir $source_dir/led_driver/led_driver.vhd

# Testbench:
vcom -2008 -work $work_dir $sim_dir/led_driver_tb.vhd

# Start Sim:
vsim -voptargs=+acc $work_dir.led_driver_tb

# Add Wave file:
do $sim_dir/led_driver_tb_wave.do

# Run:
run -all;