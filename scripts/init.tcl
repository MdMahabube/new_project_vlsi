source setup.tcl
set init_gnd_net VSS
set init_pwr_net VDD
set init_lef_file {/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lef/sky130_scl_9T.tlef /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lef/sky130_scl_9T_phyCells.lef /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lef/sky130_scl_9T_HS.lef /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lef/sky130_scl_9T_LP.lef /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/lef/sky130_scl_9T.lef /pnr_training/WORK_BATCH1/saif_39/final_project/FINAL_PROJECT/ram/sky130_sram_2kbyte/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef /pnr_training/WORK_BATCH1/saif_39/final_project/FINAL_PROJECT/ram/sky130_sram_4kbyte/lef/sky130_sram_4kbyte_1rw1r_32x1024_8.lef }
set init_verilog $netlist 
set init_top_cell picosoc
set init_mmmc_file viewDefinition.tcl
init_design
saveDesign DESIGN/init.inn
#source SCRIPT/fp.tcl
#saveDesign DESIGN/fp.inn
#exit
