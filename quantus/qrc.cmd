extract \
	-selection all \
	-type rc_coupled
filter_coupling_cap \
	-total_cap_threshold 5.0 \
	-coupling_cap_threshold_absolute 3.0 \
	-coupling_cap_threshold_relative 0.03 \
	-cap_filtering_mode absolute_and_relative
input_db -type def \
	-lef_file_list_file SQRC_RUN/qrc.leflist
input_db -type def \
	-design_file SQRC_RUN/qrc.def.gz
log_file \
	-file_name qrc_195529_20260812_11:52:34_922.log \
	-dump_options true
extraction_setup \
	-promote_pin_pad logical
process_technology \
	-technology_library_file SQRC_RUN/_qrc_techlib.defs \
	-technology_name _qrc_tech_ \
	-technology_corner rctypical \
	-temperature 25
output_db -type spef \
	-short_incomplete_net_pins true \
	-user_defined_file_name picosoc.rctypical.spef \
	-subtype STANDARD
output_setup \
	-compressed true \
	-directory_name SQRC_RUN \
	-temporary_directory_name SQRC_RUN
include qrc_incr.cmd
