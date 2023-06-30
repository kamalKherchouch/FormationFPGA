onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib clock_VGA_opt

do {wave.do}

view wave
view structure
view signals

do {clock_VGA.udo}

run -all

quit -force
