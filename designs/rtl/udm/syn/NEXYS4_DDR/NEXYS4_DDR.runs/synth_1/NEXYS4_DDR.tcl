# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.cache/wt [current_project]
set_property parent.project_path D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.sv
read_verilog -library xil_defaultlib {
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/hw/udm.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/hw/uart_rx.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/hw/udm_controller.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/hw/uart_tx.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/reset_sync/reset_sync.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/ram/ram_dual_memsplit.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/ram/ram.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/ram/ram_dual.v
  D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.srcs/sources_1/new/test.v
}
read_ip -quiet D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.srcs/sources_1/ip/sys_clk/sys_clk.xci
set_property used_in_implementation false [get_files -all d:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.srcs/sources_1/ip/sys_clk/sys_clk_board.xdc]
set_property used_in_implementation false [get_files -all d:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.srcs/sources_1/ip/sys_clk/sys_clk.xdc]
set_property used_in_implementation false [get_files -all d:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.srcs/sources_1/ip/sys_clk/sys_clk_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.xdc
set_property used_in_implementation false [get_files D:/Lang_for_arch_HW/lab_1/activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top NEXYS4_DDR -part xc7a100tcsg324-3


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef NEXYS4_DDR.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file NEXYS4_DDR_utilization_synth.rpt -pb NEXYS4_DDR_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
