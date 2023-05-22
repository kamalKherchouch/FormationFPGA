onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+FIFO_Code_Couleur -L xpm -L fifo_generator_v13_2_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.FIFO_Code_Couleur xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {FIFO_Code_Couleur.udo}

run -all

endsim

quit -force
