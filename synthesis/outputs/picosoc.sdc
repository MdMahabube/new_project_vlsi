# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Tue Aug 11 17:56:25 +06 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design picosoc

create_clock -name "CLK" -period 8.0 -waveform {0.0 4.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
