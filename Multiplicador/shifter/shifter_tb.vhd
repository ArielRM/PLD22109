--  -----------------------------------------------------------------------
--  name        :   shifter_tb.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   9 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   brief
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_tb is
end shifter_tb;

architecture Test of shifter_tb is
    signal input       : unsigned(7 downto 0);
    signal shift_cntrl : std_logic_vector(1 downto 0);
    signal shift_out   : unsigned(15 downto 0); -- @suppress "signal shift_out is never read"

begin

    shifter : entity work.shifter
        port map(
            input       => input,
            shift_cntrl => shift_cntrl,
            shift_out   => shift_out
        );

    input <= "00000001";

    shift_cntrl <= "00", "01" after 1 ns, "10" after 2 ns, "11" after 3 ns;

end architecture Test;
