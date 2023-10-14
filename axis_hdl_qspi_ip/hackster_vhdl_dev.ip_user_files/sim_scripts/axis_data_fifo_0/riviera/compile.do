transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/hdl_projects/hackster_vhdl_dev/hackster_vhdl_dev.cache/compile_simlib/riviera}
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/axis_data_fifo_v2_0_10
vlib riviera/xil_defaultlib

vlog -work axis_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../ipstatic/hdl" -l axis_infrastructure_v1_1_0 -l axis_data_fifo_v2_0_10 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_10  -incr -v2k5 "+incdir+../../../ipstatic/hdl" -l axis_infrastructure_v1_1_0 -l axis_data_fifo_v2_0_10 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../ipstatic/hdl" -l axis_infrastructure_v1_1_0 -l axis_data_fifo_v2_0_10 -l xil_defaultlib \
"../../../../hackster_vhdl_dev.gen/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \


vlog -work xil_defaultlib \
"glbl.v"
