--  -----------------------------------------------------------------------
--  name        :   seven_segment_cntrl_tb.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   9 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   brief
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_cntrl_tb is
end seven_segment_cntrl_tb;

architecture Test of seven_segment_cntrl_tb is
    signal input : std_logic_vector(3 downto 0);
    signal dp    : std_logic;
    signal segs  : std_logic_vector(7 downto 0); -- @suppress "signal segs is never read"
begin

    ssd : entity work.seven_segment_cntrl
        port map(
            input => input,
            dp    => dp,
            segs  => segs
        );

    process is
        variable temp_dp : std_logic := '0';
    begin
        dp      <= temp_dp;
        for i in 0 to 15 loop
            input <= Std_logic_vector(to_unsigned(i, 4));
            wait for 5 ns;
        end loop;
        temp_dp := not temp_dp;
        wait for 5 ns;
    end process;
end architecture Test;
