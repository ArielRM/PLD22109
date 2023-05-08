library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture RTL of testbench is
    signal clk, rst : std_logic;
    signal data_in  : signed(23 downto 0);
    signal data_out : signed(47 downto 0); -- @suppress "signal data_out is never read"
begin
    filt : entity work.filtro
        port map(
            clk      => clk,
            rst      => rst,
            data_in  => data_in,
            data_out => data_out
        );

    process(clk) is
        variable count: signed(23 downto 0) := (others => '1');
    begin
        data_in <= count;
        if falling_edge(clk) then
            count := count + 1;
        end if;
    end process;
    
    rst <= '1', '0' after 2 ns;

    process is
        constant PERIODO : time := 2 ns;
    begin
        clk <= '0';
        wait for PERIODO / 2;
        clk <= '1';
        wait for PERIODO / 2;
    end process;

end architecture RTL;
