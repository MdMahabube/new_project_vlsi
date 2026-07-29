# comment
#
init:
	innovus -init SCRIPTS/$@.tcl -log logs/$@.log
fp: init
	innovus -init SCRIPTS/$@.tcl -log logs/$@.log

place: fp
	innovus -init SCRIPTS/$@.tcl -log logs/$@.log

cts: place
	innovus -init SCRIPTS/$@.tcl -log logs/$@.log

route: cts
	innovus -init SCRIPTS/$@.tcl -log logs/$@.log
SHELL=/bin/csh
fillgen: DESIGN/route_final.inn
	cd GDS_flow/ ; \
	source step2_fillgen.csh ; \
	source step3_merge.csh ; \
	cd ../
SHELL=/bin/bash
drc: fillgen
	mkdir -p phy_ver ; \
	mkdir -p phy_ver/drc ; \
	cd phy_ver/drc ; \
	export PEGASUS_DRC="/pdk/sky130_release_0.1.0/Sky130_DRC/" ; \
	pegasus -drc -gds ../../GDS_flow/darkio.wFill.gds.gz -top_cell darkio -run_dir runDir_DRC -log_dir LOGS /pdk/sky130_release_0.1.0/Sky130_DRC/sky130_rev_0.0_2.12.drc.pvl 2>&1 | tee pegasus.log.1

lvs: DESIGN/route_final.inn
	mkdir -p phy_ver ; \
	mkdir -p phy_ver/lvs ; \
	cd phy_ver/lvs ; \
	v2cdl \
	-v ../../output/darkio_pnr.v \
	-o darkio.cdl \
	-s0 VSS \
	-s1 VDD \
	-lsr  ../../include.cdl \
	-s ../../include.cdl \
	-exclude_empty_modules ; \
	pegasus -lvs -gds ../../output/darkio.gds -top_cell darkio -source_cdl darkio.cdl -source_top_cell darkio -automatch -run_dir runDir_LVS -log_dir LOGS -ui_data /pdk/sky130_release_0.1.0/Sky130_LVS/sky130.lvs.v0.0_1.1.pvl 2>&1 | tee pegasus.log.1 











#for x5.m* problem
#selectIOPin *
#dbGet selected.net.name
#set IOPINS [dbGet selected.name]
#foreach pin $IOPINS { deselectAll ; selectIOPin $pin; eval "add_shape -net [dbGet selected.name] -layer [dbGet selected.layer.name] -rect [dbGet selected.pinshapes.rect]" }
 
