onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+clock_VGA -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clock_VGA xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {clock_VGA.udo}

run -all

endsim

quit -force
