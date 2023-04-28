-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Ariel Montardo
-- Version     : 0.1
-- Copyright   : -
-- Description : testbench para o package `seg7` contido em 
--               "seg7.vhd". O teste utiliza 2 displays de sete 
--               segmentos e um contador síncrono.
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.seg7.all;

entity testebench is
end entity testebench;

architecture RTL of testebench is
    signal clock : std_logic;
    signal value  : unsigned(7 downto 0);
    signal HEX0: std_logic_vector(7 downto 0); -- @suppress "signal HEX0 is never read"
    signal HEX1: std_logic_vector(7 downto 0); -- @suppress "signal HEX1 is never read"
begin

    clk : process is
        constant PERIOD: time := 2 ns;
    begin
       clock <= '0';
       wait for PERIOD/2;
       clock <= '1';
       wait for PERIOD/2; 
    end process;

    contador: process(clock) is
        variable count: unsigned(7 downto 0) := (others => '0');
    begin
        if rising_edge(clock) then
            count := count + 1;
        end if;
        value <= count;
    end process;

    HEX0 <= '1' & bcd2seg7(value(3 downto 0));
    HEX1 <= '1' & bcd2seg7(value(7 downto 4));
    
end architecture RTL;
