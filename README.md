# Vivado Test 

## Introduction

This is a simple vivado test project to be built from the command line in batch mode. It does not use the Vivado GUI, nor does it include any IP blocks. This design targets the Kintex 7 FPGA on the KC705 development board. Also note that the top_level.vhd file instantates two Xilinx primitives (BUFDS and BUFG) which makes this example code unsuitable for porting to another FPGA vendor.

## Git Integration and Version Numbering

The TCL script used in this example passes the short form of the git SHA-1 hash (aka commit ID) to the top level VHDL file as a generic 28-bit std_logic_vector. This is useful for storing this value into read-only register in the design. That way the user can query the FPGA and know exactly what firmware version is running on the device. 

The alternative is to require the user to put a "version number" into a script or source each time the device is built. This is error prone and should be avoided at all costs.

## Instructions

From a command line (unix shell or windows cmd shell) type the following:

	vivado -mode tcl -source vivado_batch.tcl

It will take a few minutes, but in the end you should have a BIT file and a bunch of reports in the output/ sub directory.

JTO

