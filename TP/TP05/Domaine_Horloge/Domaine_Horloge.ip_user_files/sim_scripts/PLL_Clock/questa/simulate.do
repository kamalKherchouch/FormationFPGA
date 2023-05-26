onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib PLL_Clock_opt

do {wave.do}

view wave
view structure
view signals

do {PLL_Clock.udo}

run -all

quit -force
