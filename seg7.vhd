library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package seg7 is
    function bcd2seg7(bcd : unsigned (3 downto 0)) return std_logic_vector;
    function bcd2seg7(bcd : std_logic_vector (3 downto 0)) return std_logic_vector;
end package seg7;

package body seg7 is
    type seg7tab_type is array (15 downto 0) of std_logic_vector(6 downto 0);
    constant seg7tab : seg7tab_type := (
        "1000000",
        "1111001",
        "0100100",
        "0110000",
        "0011001",
        "0010010",
        "0000010",
        "1111000",
        "0000000",
        "0011000",
        "0001000",
        "0000011",
        "1000110",
        "0100001",
        "0000110",
        "0001110"
    );

    function bcd2seg7(bcd : unsigned (3 downto 0)) return std_logic_vector is
    begin
        return seg7tab(to_integer(bcd));
    end bcd2seg7;

    function bcd2seg7(bcd : std_logic_vector (3 downto 0)) return std_logic_vector is
    begin
        return seg7tab(to_integer(unsigned(bcd)));
    end bcd2seg7;

end package body seg7;
