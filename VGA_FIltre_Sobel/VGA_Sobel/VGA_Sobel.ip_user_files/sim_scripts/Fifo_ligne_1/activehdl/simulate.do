onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+Fifo_ligne_1 -L fifo_generator_v13_2_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Fifo_ligne_1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Fifo_ligne_1.udo}

run -all

endsim

quit -force
