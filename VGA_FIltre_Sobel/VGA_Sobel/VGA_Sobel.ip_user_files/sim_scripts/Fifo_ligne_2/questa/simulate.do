onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Fifo_ligne_2_opt

do {wave.do}

view wave
view structure
view signals

do {Fifo_ligne_2.udo}

run -all

quit -force
