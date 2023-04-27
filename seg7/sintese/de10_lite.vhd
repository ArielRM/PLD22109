-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : Ariel Montardo
-- Version     : 0.1
-- Copyright   : -
-- Description : Entidade Top-level para sintetise com objetivo de
--               testar o package `seg7` contido em "seg7.vhd".
-------------------------------------------------------------------

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

use work.seg7.all;

entity de10_lite is
    port(
        HEX0 : out std_logic_vector(7 downto 0);
        SW   : in  std_logic_vector(9 downto 0);
        LEDR : out std_logic_vector(9 downto 0)
    );
end entity;

architecture rtl of de10_lite is
begin
    HEX0 <= '1' & bcd2seg7(SW(3 downto 0));
    LEDR(3 downto 0) <= SW(3 downto 0);
    LEDR(9 downto 4) <= (others => '0');
end;

