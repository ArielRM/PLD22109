--  -----------------------------------------------------------------------
--  name        :   counter_tb.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Testbench para o contador de n-bits (counter.vhd)
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture Test of counter_tb is
    constant N       : natural := 2;
    signal clk       : std_logic;
    signal aclr_n    : std_logic;
    signal count_out : unsigned(N - 1 downto 0); -- @suppress "signal count_out is never read"
begin
    cnt : entity work.counter
        generic map(
            N => N
        )
        port map(
            clk       => clk,
            aclr_n    => aclr_n,
            count_out => count_out
        );

    -- Rising edge em 1ns, 3ns, 5ns  ...
    clock : process is
        variable tmp : std_logic := '0';
    begin
        clk <= tmp;
        tmp := not tmp;
        wait for 1 ns;
    end process;

    aclr_n <= '1',                      -- deixa contar até 2
    '0' after 4 ns,                     -- `clear` enquanto o valor é 2
    '1' after 6 ns;                     -- deixa contar até o "fim"

end architecture Test;
