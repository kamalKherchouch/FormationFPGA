onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Fifo_Ligne2_opt

do {wave.do}

view wave
view structure
view signals

do {Fifo_Ligne2.udo}

run -all

quit -force
