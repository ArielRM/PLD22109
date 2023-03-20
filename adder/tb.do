# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Exemplo de script de compila��o ModelSim para divisor de clock
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem � importante
vcom adder.vhd adder_tb.vhd

#Simula (work � o diretorio, testbench � o nome da entity)
vsim -voptargs="+acc" -t ns work.adder_tb

#Mosta forma de onda
view wave

#Adiciona ondas espec�ficas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix unsigned  /b
add wave -radix unsigned  /a
add wave -radix unsigned  /sum
#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula at� um 500ns
run 700ns

wave zoomfull
write wave wave.ps