set module "picosoc2n"
mkdir -p reports outputs

source /pnr_training/WORK_BATCH1/saif_39/final_project/FINAL_PROJECT/syn/read_hdl
source /pnr_training/WORK_BATCH1/saif_39/final_project/FINAL_PROJECT/syn/read_liberty

set_db / .library $libs

read_hdl -sv $hdl

set_db / .auto_ungroup none
set_db boundary_optimize_constant_hpins false

elaborate
set_top_module picosoc
write_hdl > outputs/elaborate.v
#write_db -all_root_attributes -to_file genus_db/elaborate.db

source sdc
read_sdc sdc

report_clocks

syn_generic
write_hdl > outputs/generic.v

syn_map
write_hdl > outputs/picosoc_map.v
#write_db -all_root_attributes -to_file genus_db/map.db
write_do_lec -revised_design fv_map -logfile logs/rtl2intermediate.lec.log > outputs/rtl2intermediate.lec.do

syn_opt
write_hdl > outputs/picosoc_opt.v
#write_db -all_root_attributes -to_file genus_db/opt.db
write_do_lec -golden_design fv_map -revised_design outputs/opt.v -logfile logs/intermediate2final.lec.log > outputs/intermediate2final.lec.do
write_do_lec -revised_design outputs/opt.v -logfile logs/rtl2final.lec.log > outputs/rtl2final.lec.do

#write_hdl -mapped > outputs/gate_netlist.v
#write_do_lec -golden_design $hdl -revised_design outputs/gate_netlist.v >outputs/rtlvsgate.lec.do


report_qor > reports/qor.rpt
report_timing > reports/timing.rpt
report_area > reports/area.rpt
report_power > reports/power.rpt

write_sdc > outputs/picosoc.sdc
write_sdf > picosoc.sdf

echo "Synthesis Completed Successfully!"


