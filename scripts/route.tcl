restoreDesign DESIGN/cts.inn.dat picosoc

setDesignMode -topRoutingLayer 5
set_interactive_constraint_modes [all_constraint_modes ]
set_propagated_clock [all_clocks ]

setNanoRouteMode -route_antenna_cell_name ANTENNA
setNanoRouteMode -route_antenna_diode_insertion true
setNanoRouteMode -route_diode_insertion_for_clock_nets true

#ROUTE DESIGN

routeDesign

checkPlace > report/route/density.rpt
checkDesign -all > report/route/checkdesign.rpt

report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/route/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/route/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/route/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true 
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/route/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/route/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/route/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false

setAnalysisMode -analysisType onChipVariation 

saveDesign DESIGN/route1.inn
#SETUP OPTIMIZATION

setOptMode -opt_hold_target_slack 0.05
setOptMode -opt_setup_target_slack 0.1

optDesign -postRoute

checkDesign -all > report/postroute/checkdesign.rpt
checkPlace > report/postroute/density.rpt

report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postroute/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postroute/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postroute/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true 
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postroute/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postroute/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postroute/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false

saveDesign DESIGN/route2.inn
#HOLD OPTIMIZATION

setOptMode -opt_hold_target_slack 0.05
setOptMode -opt_setup_target_slack 0.1

optDesign -hold -postRoute
checkDesign -all > report/postrouteopt/checkdesign.rpt
checkPlace > report/postrouteopt/density.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postrouteopt/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postrouteopt/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postrouteopt/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postrouteopt/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postrouteopt/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postrouteopt/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false

#GOLBAL NET CONNECT

globalNetConnect VDD -instanceBasename * -pin VDD -verbose
globalNetConnect VSS -instanceBasename * -pin VSS -verbose

#DRC CHECK
verify_drc -limit 99999 > report/postroute/drc.rpt

#SAVING SIGN OFF FILES
saveNetlist output/picosoc_pnr.v -includePhysicalinst -includePOwerGround -excludeCellInst "FILL1 FILL16 FILL2 FILL32 FILL4 FILL64 FILL8"

streamOut -merge "/pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/gds/sky130_scl_9T.gds /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/gds/sky130_scl_9T_HS.gds /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/gds/sky130_scl_9T_LP.gds /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/gds/sky130_scl_9T_phyCells.gds  /pnr_training/WORK_BATCH1/REFERENCE/FINAL_PROJECT/ram/sky130_sram_2kbyte/gds/sky130_sram_2kbyte_1rw1r_32x512_8.gds.gz /pnr_training/WORK_BATCH1/REFERENCE/FINAL_PROJECT/ram/sky130_sram_4kbyte/gds/sky130_sram_4kbyte_1rw1r_32x1024_8.gds.gz   " -mapFile /pdk/sky130_scl_9T_0.1.2/sky130_scl_9T/gds/sky130_stream.mapFile  output/picosoc.gds
defOut -netlist -floorplan output/picosoc.def
write_lef_abstract -stripePin -PGPinLayers { 3 4 } output/picosoc.lef

set_analysis_view -setup {func_typical_25_1v8 } -hold {func_typical_25_1v8 }
do_extract_model -view func_slow_125_1v62 output/picosoc_slow.lib
do_extract_model -view func_fast_0_1v98 output/picosoc_fast.lib
do_extract_model -view func_typical_25_1v8 output/picosoc_typical.lib


#saveNetlist output/darksocv_pnr.v -includePhysicalinst -includePOwerGround
#streamOut -merge "/pdk/gpdk045/gsclib045_all_v4.8/gsclib045/gds/gsclib045.gds /pdk/gpdk045/gsclib045_all_v4.8/gsclib045_hvt/gds/gsclib045_hvt.gds /pdk/gpdk045/gsclib045_all_v4.8/gsclib045_lvt/gds/gsclib045_lvt.gds " -mapFile /pdk/gpdk045/gpdk045_v_6_0/soce/streamOut.map output/darksocv.gds
#defOut -netlist -floorplan output/darksocv.def
#write_lef_abstract -stripePin -PGPinLayers { 4 5 } output/darksocv.lef
#set_analysis_view -setup {func_slow_125_1v0 func_fast_0_1v2} -hold {func_slow_125_1v0 func_fast_0_1v2}
#do_extract_model -view func_slow_125_1v0 output/darksocv_slow.lib
#do_extract_model -view func_fast_0_1v2 output/darksocv_fast.lib


saveDesign DESIGN/route_final.inn
exit
