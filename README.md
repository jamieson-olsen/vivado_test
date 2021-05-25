# Vivado Test 

## Introduction

This is a simple Vivado example to be built from the command line in "Non-Project" mode. It does not use the Vivado GUI, nor does it include any IP blocks. This design targets the Kintex 7 FPGA on the KC705 development board. There are a few Xilinx-specific primitives (BUFDS and BUFG) instantiated in the top_level.vhd but other than that the code is mostly vanilla VHDL. 

At some point I'll work on adding a simple IP block to show how that is pulled in. In the meantime, you can check out my OEI_SFP repo, as that is another example of a Vivado Non-Project scripted flow and it does use an IP core in the XCIX format.

## Git Integration and Version Numbering

The TCL script used in this example passes the short form of the git SHA hash (aka commit ID) to the top level VHDL file as a generic 28-bit std_logic_vector. This is useful for storing this value into a read-only register in the design. That way the user can query the FPGA and know exactly what firmware version is running on the device. (It's best to make this process automatic, otherwise someone WILL forget to update the version number if it is contained in one of the source files.)

## Instructions

From a command line (unix shell or windows cmd shell) type the following:

	vivado -mode tcl -source vivado_batch.tcl

It will take a few minutes, but in the end you should have a BIT file and a bunch of reports in the output/ sub directory.

JTO

