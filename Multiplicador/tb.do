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
vcom adder/adder.vhd counter/counter.vhd mult/mult.vhd mux/mux.vhd mux/mux_when.vhd reg/reg.vhd seven_segment_cntrl/seven_segment_cntrl.vhd shifter/shifter.vhd mult_control.vhd mult_8x8.vhd mult_8x8_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.mult_8x8_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -label clk -radix binary  /clk
add wave -label start -radix binary /start
add wave -label reset -radix binary /reset_a
add wave -label done -radix binary /done_flag
add wave -label state -radix unsigned /mult_x8x/state_out

add wave -label a -radix unsigned  /dataa
add wave -label b -radix unsigned  /datab
add wave -label out -radix unsigned /product8x8_out

#Como mostrar sinais internos do processo
#add wave -radix dec /dut_5/p0/count
#add wave -radix dec /dut_10/p0/count


#Simula até um 50ns
#run 786431ns
run 50 ns

wave zoomfull
write wave wave.ps