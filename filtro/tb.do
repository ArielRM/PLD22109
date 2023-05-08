# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Script de compilaï¿½ï¿½o ModelSim para fsm.vhd + testbench.vhd
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem ï¿½ importante
vcom filtro.vhd testbench.vhd

#Simula (work ï¿½ o diretorio, testbench ï¿½ o nome da entity)
vsim -voptargs="+acc" -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas especï¿½ficas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -label clk -radix binary /clk
add wave -label rst -radix binary /rst
add wave -label input -radix dec /data_in
add wave -label output -radix dec /data_out

add wave -height 15 -divider "Sinais internos"
add wave -label acc -radix dec /filt/p0/soma
add wave -label regs -radix dec /filt/p0/inputs
add wave -label count -radix unsigned /filt/p0/i

#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula até 50ns
run 100 ns

wave zoomfull
write wave wave.ps