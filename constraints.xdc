# constraints file for Vivado test 
# this will work on the KC705 development board
# Jamieson Olsen <jamieson@fnal.gov>

# Timing constraints
# Note: Xilinx IP core constraints will be applied automatically when the *.xcix file is added to the project

create_clock -name clock -period 5.000  [get_ports sysclk_p]

# set_clock_groups -name async_groups -asynchronous \
# -group [get_clocks -include_generated_clocks sysclk] \
# -group [get_clocks -include_generated_clocks oeiclk] \

# tell vivado about places where signals cross clock domains so timing can be ignored here
# set_false_path -from {eth_int_inst/*/*/tx_en_reg*/C} -to {eth_act_led_reg_reg[0]/D}
# set_false_path -from {*/*/*/gig_ethernet_pcs_pma_0_core/gpcs_pma_inst/RECEIVER/RX_DV_reg/C} -to {eth_act_led_reg_reg[0]/D}

# Pin LOCation and IOSTANDARD Constraints...

# reset pin is from pushbutton SW7, I/O bank 34 VCCO=1.5V

set_property PACKAGE_PIN AB7 [get_ports reset]
set_property IOSTANDARD LVCMOS15 [get_ports {reset}]

# din 7..4 is from N S E W pushbuttons, VCCO bank 1.5V

set_property PACKAGE_PIN A112 [get_ports {din[7]}]
set_property PACKAGE_PIN AB12 [get_ports {din[6]}]
set_property PACKAGE_PIN AG5 [get_ports {din[5]}]
set_property PACKAGE_PIN AC6 [get_ports {din[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {din[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {din[6]}]
set_property IOSTANDARD LVCMOS15 [get_ports {din[5]}]
set_property IOSTANDARD LVCMOS15 [get_ports {din[4]}]

# din 3..0 is from DIP switch SW11, bank 13, VCCO=VADJ_FPGA=2.5V

set_property PACKAGE_PIN Y28  [get_ports {din[3]}]
set_property PACKAGE_PIN AA28 [get_ports {din[2]}]
set_property PACKAGE_PIN W29  [get_ports {din[1]}]
set_property PACKAGE_PIN Y29  [get_ports {din[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {din[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {din[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {din[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {din[0]}]

# SYSCLK is LVDS 200MHz comes in on bank 33, VCCO=1.5V. Normally LVDS requires VCCO=1.8V
# But LVDS input is OK in this bank if internal termination resistor is NOT used.

set_property PACKAGE_PIN  AD12 [get_ports sysclk_p]
set_property PACKAGE_PIN  AD11 [get_ports sysclk_n]
set_property IOSTANDARD LVDS [get_ports sysclk_p]
set_property IOSTANDARD LVDS [get_ports sysclk_n]
set_property DIFF_TERM FALSE [get_ports sysclk_p]
set_property DIFF_TERM FALSE [get_ports sysclk_n]

# User LEDs are driven by pins in several different banks, some with different I/O voltages
# external level converter chips are used to drive actual LEDs with 3.3V logic.
# Assume default value for VADJ_FPGA is 2.5V.

# User LED7 bank 18 VCCO=VADJ_FPGA=2.5V
set_property PACKAGE_PIN F16 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[7]}]

# User LED6..5 bank 17 VCCO=VADJ_FPGA=2.5V
set_property PACKAGE_PIN E18 [get_ports {led[6]}]
set_property PACKAGE_PIN G19 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[5]}]

# User LED4 bank 13 VCCO=VADJ_FPGA=2.5V
set_property PACKAGE_PIN AE26 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[4]}]

# User LED3..0 bank 13 VCCO=1.5V
set_property PACKAGE_PIN AB9 [get_ports {led[3]}]
set_property PACKAGE_PIN AC9 [get_ports {led[2]}]
set_property PACKAGE_PIN AA8 [get_ports {led[1]}]
set_property PACKAGE_PIN AB8 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[0]}]

# General bitstream constraints...

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

