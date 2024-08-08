#----------------------------------------------------------------------
#-- Title    : TCL Script to generate Vivado project for FPGA Design
#-- Project  : Example Project
#----------------------------------------------------------------------
#-- File     : run_vivado.tcl
#-- Author   : Philip Davey
#-- Platform : Xilinx Vivado
#----------------------------------------------------------------------

set script_dir [pwd]
set output_dir $script_dir/vivado
set source_dir ../source

# Set Project name and part number:
set project_name example_project_vivado
set part_num     xcku5p-ffvd900-2L-e


# Create Vivado project:
create_project -force $project_name $output_dir -part $part_num
set_property target_language VHDL [current_project]

cd $source_dir

# Add IP Cores:
add_files -norecurse ip_cores/clk_wiz_0/clk_wiz_0.xci
add_files -norecurse ip_cores/microblaze/hdl/microblaze_wrapper.vhd
add_files -norecurse ip_cores/microblaze/microblaze.bd

# Add Custom RTL Files:
add_files -norecurse button_debounce/button_debounce.vhd
add_files -norecurse led_driver/led_driver.vhd
add_files -norecurse ./example_project_top.vhd

set_property file_type {VHDL 2008} [get_files $source_dir/led_driver/led_driver.vhd]
set_property file_type {VHDL 2008} [get_files $source_dir/example_project_top.vhd]

# Add XDC File:
add_files -fileset constrs_1 -norecurse $source_dir/example_project_top.xdc