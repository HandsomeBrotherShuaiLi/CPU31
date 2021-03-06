# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir S:/Vivado/cpu_31/cpu_31.cache/wt [current_project]
set_property parent.project_path S:/Vivado/cpu_31/cpu_31.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files S:/Vivado/cpu_31/jal.coe
add_files -quiet s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip.dcp
set_property used_in_implementation false [get_files s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip.dcp]
read_verilog -library xil_defaultlib {
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/shifter.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/addsub32.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/selector.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/regfiles.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/pcreg.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/ext.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/dram.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/control_unit.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/alu.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/adddd.v
  S:/Vivado/cpu_31/cpu_31.srcs/sources_1/new/cpu.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top cpu -part xc7a100tcsg324-1


write_checkpoint -force -noxdef cpu.dcp

catch { report_utilization -file cpu_utilization_synth.rpt -pb cpu_utilization_synth.pb }
