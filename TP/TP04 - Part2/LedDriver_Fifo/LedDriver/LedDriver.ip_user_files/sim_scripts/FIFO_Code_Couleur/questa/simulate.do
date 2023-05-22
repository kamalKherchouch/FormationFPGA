onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib FIFO_Code_Couleur_opt

do {wave.do}

view wave
view structure
view signals

do {FIFO_Code_Couleur.udo}

run -all

quit -force
