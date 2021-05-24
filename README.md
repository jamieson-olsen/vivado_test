# Vivado Test Project
This is a simple vivado test project to be built from the command line in batch mode. It does not use the Vivado GUI, nor does it include any IP blocks. This design targets the Kintex 7 FPGA on the KC705 development board.

# How to build it!

From a command line (unix shell or windows cmd shell) type the following:

$ vivado -mode tcl -source vivado_batch.tcl

It will take a few minutes, but in the end you should have a BIT file and a bunch of reports in the output/ sub directory.

JTO



