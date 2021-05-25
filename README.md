# Vivado Test 

## Introduction

This is a simple Vivado example to be built from the command line in "Non-Project" mode. It does not use the Vivado GUI, nor does it include any IP blocks. This design targets the Kintex 7 FPGA on the KC705 development board. There are a few Xilinx-specific primitives (BUFDS and BUFG) instantiated in the top_level.vhd but other than that the code is mostly vanilla VHDL. At some point I'll work on adding a simple IP block to show how that is pulled in.

## Git Integration and Version Numbering

The TCL script used in this example passes the short form of the git SHA-1 hash (aka commit ID) to the top level VHDL file as a generic 28-bit std_logic_vector. This is useful for storing this value into read-only register in the design. That way the user can query the FPGA and know exactly what firmware version is running on the device. 

The alternative is to require the user to put a "version number" into a script or source each time the device is built. This is error prone and should be avoided at all costs.

## Instructions

From a command line (unix shell or windows cmd shell) type the following:

	vivado -mode tcl -source vivado_batch.tcl

It will take a few minutes, but in the end you should have a BIT file and a bunch of reports in the output/ sub directory.

JTO

