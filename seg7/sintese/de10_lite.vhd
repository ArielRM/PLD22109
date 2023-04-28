-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : Ariel Montardo
-- Version     : 0.1
-- Copyright   : -
-- Description : Entidade Top-level para sintetise com objetivo de
--               testar o package `seg7` contido em "seg7.vhd". O
--               teste utiliza 2 displays de 7 segmentos e um 
--               contador síncrono. O clock é operado via probe (IP)
-------------------------------------------------------------------

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

use work.seg7.all;
use ieee.numeric_std.all;

entity de10_lite is
    port(
        ----------- SEG7 ------------
        HEX0 : out std_logic_vector(7 downto 0);
        HEX1 : out std_logic_vector(7 downto 0);
        HEX2 : out std_logic_vector(7 downto 0);
        HEX3 : out std_logic_vector(7 downto 0);
        HEX4 : out std_logic_vector(7 downto 0);
        HEX5 : out std_logic_vector(7 downto 0);
        -----------------------------
        LEDR : out std_logic_vector(9 downto 0)
    );
end entity;

architecture rtl of de10_lite is
    component unnamed is
        port(
            source : out std_logic_vector(0 downto 0); -- source
            probe  : in  std_logic_vector(7 downto 0) := (others => 'X') -- probe
        );
    end component unnamed;

    signal clock  : std_logic;
    signal value  : unsigned(7 downto 0);
    signal source : std_logic_vector(0 downto 0);
    signal probe  : std_logic_vector(7 downto 0);
begin

    u0 : component unnamed
        port map(
            source => source,           -- sources.source
            probe  => probe             --  probes.probe
        );
    clock <= source(0);
    probe <= std_logic_vector(value);

    contador : process(clock) is
        variable count : unsigned(7 downto 0) := (others => '0');
    begin
        if rising_edge(clock) then
            count := count + 1;
        end if;
        value <= count;
    end process;

    -- Representação BCD nos LEDs
    LEDR(7 downto 0) <= std_logic_vector(value);

    -- Apaga os outros LEDs para não confundir
    LEDR(9 downto 8) <= "00";

    -- Representação 7-Srgmentos nos displays
    HEX0 <= '1' & bcd2seg7(value(3 downto 0));
    HEX1 <= '1' & bcd2seg7(value(7 downto 4));

    -- Apaga os outros displays para não confudir
    HEX2 <= (others => '1');
    HEX3 <= (others => '1');
    HEX4 <= (others => '1');
    HEX5 <= (others => '1');

end;

