library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture RTL of testbench is
    signal clk, rst : std_logic;
    signal data_in  : signed(23 downto 0);
    signal data_out : signed(47 downto 0);
begin
    filt : entity work.filtro
        port map(
            clk      => clk,
            rst      => rst,
            data_in  => data_in,
            data_out => data_out
        );

    data_in <= (0 => '1', others => '0');
    process is
        constant PERIODO : time := 2 ns;
    begin
        clk <= '0';
        wait for PERIODO / 2;
        clk <= '1';
        wait for PERIODO / 2;
    end process;


end architecture RTL;
