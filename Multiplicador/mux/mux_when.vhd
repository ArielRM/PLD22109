-------------------------------------------------------------------
-- name         :   mux_sel.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Declara a arquitetura `when_else` para o multiplexador em contido "mux.vhd"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture when_else of mux is
begin
    -- Eu usei `sel(0) = '0'` pois `sel = "0"` causava um `Warning` durante a simulação no ModelSim 
    -- # ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
    -- #    Time: 0 ns  Iteration: 0  Instance: /mux_tb/MUX_WHEN_ELSE
    output <= a when sel(0) = '0' else b;
end architecture when_else;