# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Script de compilação ModelSim subprogramas
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem � importante
vcom seg7.vhd testbench.vhd

#Simula (work � o diretorio, testbench � o nome da entity)
vsim -voptargs="+acc" -t ns work.testebench

#Mosta forma de onda
view wave

#Adiciona ondas espec�ficas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clock
add wave -radix hex /value
add wave -radix binary /HEX0
add wave -radix binary /HEX1

#Simula at� 512ns
run 512ns

wave zoomfull
write wave wave.ps