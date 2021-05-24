# Vivado Test 

## Introduction

This is a simple vivado test project to be built from the command line in batch mode. It does not use the Vivado GUI, nor does it include any IP blocks. This design targets the Kintex 7 FPGA on the KC705 development board. Also note that the top_level.vhd file instantates two Xilinx primitives (BUFDS and BUFG) which makes this example code unsuitable for porting to another FPGA vendor.

## Git Integration

The TCL script used in this example passes the git SHA commit ID to the top level VHDL file as a generic string. This is useful for storing this value into read-only register in the design. That way the user can query the FPGA and know exactly what firmware version is running on the device. (Depending on the user to put a "version number" into the source is error prone.)

## Instructions

From a command line (unix shell or windows cmd shell) type the following:

	vivado -mode tcl -source vivado_batch.tcl

It will take a few minutes, but in the end you should have a BIT file and a bunch of reports in the output/ sub directory.

JTO

