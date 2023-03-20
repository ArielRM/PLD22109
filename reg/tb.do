# ============================================================================
# Name        : tb.do
# Author      : Ariel
# Version     : 0.1
# Copyright   : Ariel
# Description : Exemplo de script de compilação ModelSim para divisor de clock
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom reg.vhd reg_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.reg_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clk
add wave -radix binary  /sclr_n
add wave -radix binary  /clk_ena
add wave -radix unsigned /datain
add wave -radix unsigned /reg_out

#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula até um 50ns
run 50ns

wave zoomfull
write wave wave.ps