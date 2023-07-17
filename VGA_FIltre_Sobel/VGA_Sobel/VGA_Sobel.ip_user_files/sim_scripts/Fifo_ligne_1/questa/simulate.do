onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Fifo_ligne_1_opt

do {wave.do}

view wave
view structure
view signals

do {Fifo_ligne_1.udo}

run -all

quit -force
