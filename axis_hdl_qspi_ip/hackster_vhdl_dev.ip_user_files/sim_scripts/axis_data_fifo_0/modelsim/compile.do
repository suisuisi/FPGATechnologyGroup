vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/axis_infrastructure_v1_1_0
vlib modelsim_lib/msim/axis_data_fifo_v2_0_10
vlib modelsim_lib/msim/xil_defaultlib

vmap axis_infrastructure_v1_1_0 modelsim_lib/msim/axis_infrastructure_v1_1_0
vmap axis_data_fifo_v2_0_10 modelsim_lib/msim/axis_data_fifo_v2_0_10
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work axis_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../ipstatic/hdl" \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_10  -incr -mfcu  "+incdir+../../../ipstatic/hdl" \
"../../../ipstatic/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic/hdl" \
"../../../../hackster_vhdl_dev.gen/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

