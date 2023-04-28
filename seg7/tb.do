# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Script de compilaÃ§Ã£o ModelSim subprogramas
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seg7.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.testebench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clock
add wave -radix hex /value
add wave -radix binary /HEX0
add wave -radix binary /HEX1

#Simula até 512ns
run 512ns

wave zoomfull
write wave wave.ps