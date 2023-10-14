transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+axis_data_fifo_0  -L axis_infrastructure_v1_1_0 -L axis_data_fifo_v2_0_10 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axis_data_fifo_0 xil_defaultlib.glbl

do {axis_data_fifo_0.udo}

run 1000ns

endsim

quit -force
