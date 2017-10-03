proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir S:/Vivado/cpu_31/cpu_31.cache/wt [current_project]
  set_property parent.project_path S:/Vivado/cpu_31/cpu_31.xpr [current_project]
  set_property ip_repo_paths s:/Vivado/cpu_31/cpu_31.cache/ip [current_project]
  set_property ip_output_repo s:/Vivado/cpu_31/cpu_31.cache/ip [current_project]
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  add_files -quiet S:/Vivado/cpu_31/cpu_31.runs/synth_1/cpu.dcp
  add_files -quiet s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip.dcp
  set_property netlist_only true [get_files s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip.dcp]
  read_xdc -mode out_of_context -ref iiram_ip -cells U0 s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip_ooc.xdc
  set_property processing_order EARLY [get_files s:/Vivado/cpu_31/cpu_31.srcs/sources_1/ip/iiram_ip/iiram_ip_ooc.xdc]
  link_design -top cpu -part xc7a100tcsg324-1
  write_hwdef -file cpu.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force cpu_opt.dcp
  report_drc -file cpu_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force cpu_placed.dcp
  report_io -file cpu_io_placed.rpt
  report_utilization -file cpu_utilization_placed.rpt -pb cpu_utilization_placed.pb
  report_control_sets -verbose -file cpu_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force cpu_routed.dcp
  report_drc -file cpu_drc_routed.rpt -pb cpu_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file cpu_timing_summary_routed.rpt -rpx cpu_timing_summary_routed.rpx
  report_power -file cpu_power_routed.rpt -pb cpu_power_summary_routed.pb -rpx cpu_power_routed.rpx
  report_route_status -file cpu_route_status.rpt -pb cpu_route_status.pb
  report_clock_utilization -file cpu_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

