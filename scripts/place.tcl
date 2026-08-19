#restoreDesign DESIGN/init.inn.dat picosoc
setDesignMode -topRoutingLayer 4
place_design
mkdir -p report
mkdir -p report/place
checkDesign -all > report/place/checkdesign.rpt
checkPlace

report_timing -from [all_inputs ] -to [all_registers ] -max_slack 0 -max_paths 9999 > report/place/setup_in2reg.rpt
report_timing -from [all_registers ] -to [all_registers ] -max_slack 0 -max_paths 9999 > report/place/setup_reg2reg.rpt
report_timing -from [all_registers ] -to [all_outputs ] -max_slack 0 -max_paths 9999 > report/place/setup_reg2out.rpt

saveDesign DESIGN/place.inn
optDesign -preCTS
mkdir -p report/prects
checkDesign -all > report/prects/checkdesignopt.rpt
report_timing -from [all_registers ] -to [all_outputs ] -max_slack 0 -max_paths 9999 > report/prects/setup_reg2outopt.rpt
report_timing -from [all_registers ] -to [all_registers ] -max_slack 0 -max_paths 9999 > report/prects/setup_reg2regopt.rpt
report_timing -from [all_inputs ] -to [all_registers ] -max_slack 0 -max_paths 9999 > report/prects/setup_in2regopt.rpt

saveDesign DESIGN/place.inn

#exit


setDesignMode -topRoutingLayer 4

add_ndr -name 2W2S -width {met1 0.28 met2 0.28 met3 0.6 met4 0.6} -spacing {met1 0.28 met2 0.28 met3 0.6 met4 0.6}
create_route_type -name CLK_2W2S -non_default_rule 2W2S
set_ccopt_property route_type CLK_2W2S -net_type trunk
set_ccopt_property route_type CLK_2W2S -net_type leaf

add_ndr -name 2W2S_shield -width {met1 0.28 met2 0.28 met3 0.6 met4 0.6} -spacing {met1 0.28 met2 0.28 met3 0.6 met4 0.6}
create_route_type -name CLK_shield -non_default_rule 2W2S_shield -shield_net VSS
set_ccopt_property route_type CLK_shield -net_type trunk
set_ccopt_property route_type CLK_shield -net_type leaf

create_ccopt_clock_tree_spec
ccopt_design -cts
set_interactive_constraint_modes [all_constraint_modes ]
set_propagated_clock [all_clocks ]
set_global report_timing_format {instance arc cell net load delay arrival required }
set timing_enable_simultaneous_setup_hold_mode true
checkDesign -all > report/postCTS/checkDesign.rpt

report_timing -from [all_inputs ] -to [all_registers ] -max_paths 999999 > report/postCTS/setup_in2reg.rpt
report_timing -from [all_registers ] -to [all_registers ] -max_paths 999999 > report/postCTS/setup_reg2reg.rpt
report_timing -from [all_registers ] -to [all_outputs ] -max_paths 999999 > report/postCTS/setup_reg2out.rpt

report_timing -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 999999 > report/postCTS/hold_in2reg.rpt
report_timing -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 999999 > report/postCTS/hold_reg2reg.rpt
report_timing -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 999999 > report/postCTS/hold_reg2out.rpt
set timing_enable_simultaneous_setup_hold_mode false
setOptMode -opt_setup_target_slack 0.1
setOptMode -opt_hold_target_slack 0.05

optDesign -postCTS -prefix postCTS
checkDesign -all > report/postCTS/optcheckDesign.rpt

report_timing -from [all_inputs ] -to [all_registers ] -max_paths 999999 > report/postCTS/setup_in2regopt.rpt
report_timing -from [all_registers ] -to [all_registers ] -max_paths 999999 > report/postCTS/setup_reg2regopt.rpt
report_timing -from [all_registers ] -to [all_outputs ] -max_paths 999999 > report/postCTS/setup_reg2outopt.rpt

set timing_enable_simultaneous_setup_hold_mode true
report_timing -check_type hold -from [all_inputs ] -to [all_registers ] -max_paths 999999 > report/postCTS/hold_in2regopt.rpt
report_timing -check_type hold -from [all_registers ] -to [all_registers ] -max_paths 999999 > report/postCTS/hold_reg2regopt.rpt
report_timing -check_type hold -from [all_registers ] -to [all_outputs ] -max_paths 999999 > report/postCTS/hold_reg2outopt.rpt
saveDesign DESIGN/cts.inn

