# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Script de compilação ModelSim para fsm.vhd + testbench.vhd
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom fsm.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -label clk -radix binary /clk
add wave -label rst -radix binary /rst
add wave -label fsr -radix binary /fsr
add wave -label msr -radix binary /msr
add wave -label clr -radix binary /clr
add wave -label fm -radix binary /fm
add wave -label mm -radix binary /mm

add wave -label state -radix hex /fsm/state

#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula até um 50ns
#run 786431ns
run 80 ns

wave zoomfull
write wave wave.ps