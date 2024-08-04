#----------------------------------------------------------------------
#-- Title    : TCL Script to generate Vivado project for FPGA Design
#-- Project  : Disguise Code challenge
#----------------------------------------------------------------------
#-- File     : run_vivado.tcl
#-- Author   : Philip Davey
#-- Platform : Xilinx Vivado
#----------------------------------------------------------------------

set script_dir [pwd]
set output_dir $script_dir/vivado
set source_dir ../source

# Set Project name and part number:
set project_name disguise_code_challenge_vivado
set part_num     xcku5p-ffvd900-2L-e

# Create Vivado project:
create_project -force $project_name $output_dir -part $part_num

cd $source_dir

# Add IP Cores:
add_files -norecurse ip_cores/clk_wiz_0/clk_wiz_0.xci
add_files -norecurse ip_cores/design_1/hdl/design_1_wrapper.vhd
add_files -norecurse ip_cores/design_1/design_1.bd

# Add Custom RTL Files:
add_files -norecurse led_driver/led_driver.vhd
add_files -norecurse ./code_challenge_top.vhd

# Add XDC File:
add_files -fileset constr_1 -norecurse $source_dir/code_challenge_top.xdc