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
vcom mux.vhd mux_when.vhd mux_sel.vhd mux_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.mux_tb_config

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix hex  /a
add wave -radix hex  /b
add wave -radix unsigned  /sel
add wave -radix hex -label with_select /output1
add wave -radix hex -label when_else /output2
#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula até um 500ns
run 40ns

wave zoomfull
write wave wave.ps