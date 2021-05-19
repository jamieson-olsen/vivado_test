# Simple TCL script for Vivado builds
# Jamieson Olsen <jamieson@fnal.gov>
#
# vivado -mode tcl -source vivado_batch.tcl

# general setup stuff...

set_param general.maxThreads 4
set outputDir ./output
file mkdir $outputDir
set_part xc7k325t-ffg900-2

# load the sources...

read_vhdl ../src/top_level.vhd

# Load IP core container file should be *.XCIX container
# which includes the output products.  XCIX does not
# require synth_ip and generate_target commands
#read_ip ../src/ip/gig_ethernet_pcs_pma_0.xcix

# Load IP module as *.xci
#read_ip ../src/ip/gig_ethernet_pcs_pma_0.xci
#set_property target_language VHDL [current_project]
#generate_target all [get_files ../src/ip/gig_ethernet_pcs_pma_0.xci]

# Load general constraints...

read_xdc -verbose ./constraints.xdc

# synth design...

synth_design -top top_level
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_power -file $outputDir/post_synth_power.rpt
report_utilization -file $outputDir/post_synth_util.rpt

# place design...

opt_design
place_design
phys_opt_design -directive AggressiveFanoutOpt
write_checkpoint -force $outputDir/post_place
report_timing_summary -file $outputDir/post_place_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_place_timing.rpt

# route...

route_design
write_checkpoint -force $outputDir/post_route

# generate reports...

report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
report_io -file $outputDir/io.rpt

# write out VHDL and constraints for timing sim...

#write_vhdl -force $outputDir/vivpram_impl_netlist.v
#write_xdc -no_fixed_only -force $outputDir/bft_impl.xdc

# generate bitstream...

write_bitstream -force $outputDir/vivado_test.bit

# write out ILA debug probes file
# write_debug_probes -force $outputDir/probes.ltx

