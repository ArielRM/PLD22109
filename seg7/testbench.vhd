library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.seg7.all;

entity testebench is
end entity testebench;

architecture RTL of testebench is
    signal data: std_logic_vector(7 downto 0); -- @suppress "signal data is never read"
begin
    data(7) <= '1';
    
    p0: process is
        variable a: unsigned(3 downto 0) := "0000";
    begin
        data(6 downto 0) <= bcd2seg7(a);
        wait for 2 ns;
        a := a + 1; 
    end process;

end architecture RTL;
