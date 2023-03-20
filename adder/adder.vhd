-------------------------------------------------------------------
-- name         :   adder.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Declara a interface e o comportamento de um somador de N bits.
--                  A soma é realizada utilizando o `overload` do operador de soma 
--                  provido por `ieee.numeric_std.all`.
-------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;

--! Somador de N bits, soma `a`com `b` ignorando overflow
entity adder is
    generic(
        N : natural := 4
    );
    port(
        a   : in  unsigned(N - 1 downto 0);
        b   : in  unsigned(N - 1 downto 0);
        sum : out unsigned(N - 1 downto 0)
    );
end entity adder;

architecture rtl of adder is
begin
    sum <= a + b;
end architecture rtl;
