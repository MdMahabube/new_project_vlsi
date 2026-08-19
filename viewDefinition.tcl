#PVT Corner for Slow_1.62_125
#create_rc_corner -name rctypical \
#-T 25 \
-qx_tech_file /pdk/sky130_release_0.1.0/quantus/extraction/typical/qrcTechFile \

#create_library_set -name slow_libs \
#-timing \
#{/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ss_1.62_125_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ss_1.62_125_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ss_1.62_125_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib
#}

#create_delay_corner -name rctypical_slow -library_set slow_libs -rc_corner rctypical

#create_constraint_mode -name func_slow -sdc_files $sdc

#create_analysis_view -name func_slow_125_1v62 -constraint_mode func_slow -delay_corner rctypical_slow


#PVT Corner for Typical_1.8_25
#source setup.tcl
create_rc_corner -name rctypical \
-T 25 \
-qx_tech_file /pdk/sky130_release_0.1.0/quantus/extraction/typical/qrcTechFile \

create_library_set -name typical_libs \
-timing \
{/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_tt_1.8_25_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_tt_1.8_25_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_tt_1.8_25_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib \

/pnr_training/WORK_BATCH1/REFERENCE/FINAL_PROJECT/ram/sky130_sram_2kbyte/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib \

/pnr_training/WORK_BATCH1/REFERENCE/FINAL_PROJECT/ram/sky130_sram_4kbyte/lib/sky130_sram_4kbyte_1rw1r_32x1024_8_TT_1p8V_25C.lib


}

create_delay_corner -name rctypical_typical -library_set typical_libs -rc_corner rctypical

create_constraint_mode -name func_typical -sdc_files /pnr_training/WORK_BATCH1/saif_39/final_project/FINAL_PROJECT/syn/outputs/picosoc.sdc

create_analysis_view -name func_typical_25_1v8 -constraint_mode func_typical -delay_corner rctypical_typical 


#PVT Corner for Fast_1.98_0
#create_rc_corner -name rctypical \
-T 25 \
-qx_tech_file /pdk/sky130_release_0.1.0/quantus/extraction/typical/qrcTechFile \

#create_library_set -name fast_libs \
#-timing \
{/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ff_1.98_0_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ff_1.98_0_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ff_1.98_0_nldm.lib.gz \
/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib 
#}

#create_delay_corner -name rctypical_fast -library_set fast_libs -rc_corner rctypical

#create_constraint_mode -name func_fast -sdc_files $sdc

#create_analysis_view -name func_fast_0_1v98 -constraint_mode func_fast -delay_corner rctypical_fast 


#HOLD and SETUP analysis view
set_analysis_view -setup {func_typical_25_1v8} -hold {func_typical_25_1v8}
