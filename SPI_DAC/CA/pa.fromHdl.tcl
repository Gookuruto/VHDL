
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name CA -dir "F:/XilinxISEWeMiF/DKopiec/CA/planAhead_run_2" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "DAC_TOP.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {DAC_Control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {DAC_TOP.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top DAC_TOP $srcset
add_files [list {DAC_TOP.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
