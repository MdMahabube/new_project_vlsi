restoreDesign DESIGN/place.inn.dat picosoc

setDesignMode -topRoutingLayer 5
ccopt_design -cts
set_interactive_constraint_modes [all_constraint_modes ]
set_propagated_clock [all_clocks ]

set_global report_timing_format {instance arc cell net load delay arrival required}
 
checkPlace > report/cts/density.rpt
checkDesign -all > report/cts/checkdesign.rpt

report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/cts/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/cts/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/cts/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true 
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/cts/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/cts/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/cts/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false 


setDesignMode -topRoutingLayer 5
optDesign -postCTS

checkDesign -all > report/postcts/checkdesign.rpt
checkPlace > report/postcts/density.rpt

report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postcts/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postcts/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postcts/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true 
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postcts/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postcts/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postcts/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false 

saveDesign DESIGN/cts.inn
#HOLD OPTIMIZATION

setOptMode -opt_hold_target_slack 0.05
setOptMode -opt_setup_target_slack 0.1

optDesign -hold -postCTS
checkDesign -all > report/postcts-opt/checkdesign.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postcts-opt/setup.reg2reg.rpt
report_timing -path_type full_clock -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postcts-opt/setup.reg2out.rpt
report_timing -path_type full_clock -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postcts-opt/setup.in2reg.rpt

set timing_enable_simultaneous_setup_hold_mode true
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 9999999 > report/postcts-opt/hold.reg2reg.rpt
report_timing -path_type full_clock -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 9999999 > report/postcts-opt/hold.reg2out.rpt
report_timing -path_type full_clock -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 9999999 > report/postcts-opt/hold.in2reg.rpt
set timing_enable_simultaneous_setup_hold_mode false

saveDesign DESIGN/cts.inn
#exit

