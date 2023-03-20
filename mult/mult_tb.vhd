-------------------------------------------------------------------
-- name         :   mult_tb.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Testbench para o multiplicador de N bits
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_tb is
end mult_tb;

architecture Test of mult_tb is
    constant N     : natural := 3;
    signal a       : unsigned(N - 1 downto 0);
    signal b       : unsigned(N - 1 downto 0);
    signal product : unsigned(2 * N - 1 downto 0); -- @suppress "signal product is never read"
begin
    mult : entity work.mult
        generic map(
            N => N
        )
        port map(
            a       => a,
            b       => b,
            product => product
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
                wait;
            end if;
            var_b := var_b + 1;
        else
            var_a := var_a + 1;
        end if;

        wait for 10 ns;
    end process;

end architecture Test;
