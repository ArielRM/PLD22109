-------------------------------------------------------------------
-- name         :   adder_tb.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Testbench para o somador de N bits
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end adder_tb;

architecture Test of adder_tb is
    constant N : natural := 3;

    signal a   : unsigned(N - 1 downto 0);
    signal b   : unsigned(N - 1 downto 0);
    signal sum : unsigned(N - 1 downto 0); -- @suppress "signal sum is never read"
begin

    add : entity work.adder
        generic map(
            N => N
        )
        port map(
            a   => a,
            b   => b,
            sum => sum
        );
        
    -- Testa todos os valores possíveis de `a`com todos os valores possíveis de `b`
    process
        variable var_a : unsigned(N - 1 downto 0) := to_unsigned(0, N);
        variable var_b : unsigned(N - 1 downto 0) := to_unsigned(0, N);
    begin
        a <= var_a;
        b <= var_b;

        if (var_a = 2 ** N - 1) then
            var_a := to_unsigned(0, N);

            if (var_b = 2 ** N - 1) then
                wait; -- quando so dois valores chegam ao máximo interrompe o processo
            end if;
            var_b := var_b + 1;
        else
            var_a := var_a + 1;
        end if;

        wait for 10 ns;
    end process;

end architecture Test;
