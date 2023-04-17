-------------------------------------------------------------------
-- name         :   mult.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Declara a interface e o comportamento de um multiplicador de N bits.
--                  O produto é realizada utilizando o `overload` do operador de multiplicação 
--                  provido por `ieee.numeric_std.all`.
-------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;

--! Multiplicador de N bits, multiplica `a`com `b`
entity mult is
    generic(
        N : natural := 4
    );
    port(
        a       : in  unsigned(N - 1 downto 0);
        b       : in  unsigned(N - 1 downto 0);
        product : out unsigned(2 * N - 1 downto 0)
    );
end entity mult;

architecture RTL of mult is

begin
    product <= a * b;
end architecture RTL;
