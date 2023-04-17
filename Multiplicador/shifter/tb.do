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
vcom shifter.vhd shifter_tb.vhd

#Simula (work � o diretorio, testbench � o nome da entity)
vsim -voptargs="+acc" -t ns work.shifter_tb

#Mosta forma de onda
view wave

#Adiciona ondas espec�ficas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix unsigned  /input
add wave -radix unsigned  /shift_cntrl
add wave -radix unsigned  /shift_out
#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula at� um 500ns
run 40ns

wave zoomfull
write wave wave.ps