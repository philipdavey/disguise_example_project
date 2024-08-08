onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /led_driver_tb/clk_s
add wave -noupdate /led_driver_tb/rst_n_s
add wave -noupdate /led_driver_tb/input_button_s
add wave -noupdate -radix binary /led_driver_tb/led_out_s
add wave -noupdate /led_driver_tb/dut/state_s
add wave -noupdate /led_driver_tb/dut/cycle_cnt_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2414 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {414 ns}
