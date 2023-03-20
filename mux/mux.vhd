-------------------------------------------------------------------
-- name         :   mux_sel.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Declara a entidade de um multiplexador com duas entradas de N bits. 
--                  As duas arquiteturas para essa entidade estão contidas em 
--                  "mux_sel.vhd" e "mux_when.vhd"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Multiplexador com duas entradas de N bits
entity mux is
    generic(
        N : natural := 4
    );
    port(
        a      : in  unsigned(N - 1 downto 0);
        b      : in  unsigned(N - 1 downto 0);
        sel    : in  unsigned(0 downto 0);
        output : out unsigned(N - 1 downto 0)
    );
end entity mux;
