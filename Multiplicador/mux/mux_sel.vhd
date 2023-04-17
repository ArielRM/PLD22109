-------------------------------------------------------------------
-- name         :   mux_sel.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Declara a arquitetura `with_select` para o multiplexador contido em "mux.vhd"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture with_select of mux is
begin
    with sel select output <=
        a when "0",
        b when "1",
        b when others;                  -- Tecnicamente não exitem `others`
end architecture with_select;