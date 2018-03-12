##############################################################################
## Filename:          E:\postgrad\SEECS\Thesis\ShortestPath\Virtex6\Tasks\serial_bf16x16\Design/drivers/bf_16x16_v1_00_a/data/bf_16x16_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Jun 23 20:20:19 2013 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "bf_16x16" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
