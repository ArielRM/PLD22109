--  -----------------------------------------------------------------------
--  name        :   reg_tb.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Testbench para o registrador de n-bits (reg.vhd)
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_tb is
end reg_tb;

--  -----------------------------------------------------------------
--  ---------------- COMPORTAMENTO ESPERADADO DE CADA SINAL ---------
--  -----------------------------------------------------------------
--  t           0    5    10   15   20   25   30   35   40   45   50     
--  clk         |____|ииии|____|ииии|____|ииии|____|ииии|____|ииии|
--  sclr_n      _|ииииииииииииииии|___________________|иииииииии|__
--  clk_ena     ииииииии|___________________|ииииииииииииииииииииии
--  datain      333333333332222222222000000000011111111113333333333
--  reg_out     00000^333333333333000000000000000000000000000^33000
--  -----------------------------------------------------------------
architecture Test of reg_tb is
    constant N     : natural := 2;
    signal clk     : std_logic;
    signal sclr_n  : std_logic;
    signal clk_ena : std_logic;
    signal datain  : unsigned(N - 1 downto 0);
    signal reg_out : unsigned(N - 1 downto 0); -- @suppress "signal reg_out is never read"
begin

    regis : entity work.registrador
        generic map(
            N => N
        )
        port map(
            clk     => clk,
            sclr_n  => sclr_n,
            clk_ena => clk_ena,
            datain  => datain,
            reg_out => reg_out
        );

    clock : process is
        variable tmp : std_logic := '0';
    begin
        clk <= tmp;
        tmp := not tmp;
        wait for 5 ns;
    end process;

    sclr_n  <= '0', '1' after 01 ns, '0' after 18 ns, '1' after 38 ns, '0' after 48 ns;
    clk_ena <= '1', '0' after 08 ns, '1' after 28 ns;

    data : process is
        type ty_data is array (1 to 5) of natural;
        constant v_data : ty_data := (3, 2, 0, 1, 3);
    begin
        for d in v_data'range loop
            datain <= to_unsigned(v_data(d), N);
            wait for 10 ns;
        end loop;
    end process;

end architecture Test;
