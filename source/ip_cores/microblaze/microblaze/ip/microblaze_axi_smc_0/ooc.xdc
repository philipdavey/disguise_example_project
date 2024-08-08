# aclk {FREQ_HZ 156250000 CLK_DOMAIN microblaze_ddr4_0_0_c0_ddr4_ui_clk PHASE 0.00} aclk1 {FREQ_HZ 156250000 CLK_DOMAIN microblaze_ddr4_0_0_c0_ddr4_ui_clk PHASE 0.00}
# Clock Domain: microblaze_ddr4_0_0_c0_ddr4_ui_clk
create_clock -name aclk -period 6.400 [get_ports aclk]
# Generated clocks
create_generated_clock -name aclk1 -source [get_ports aclk] -divide_by 1 [get_ports aclk1]
