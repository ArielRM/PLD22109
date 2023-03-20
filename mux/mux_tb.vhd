-------------------------------------------------------------------
-- name         :   mux_tb.vhd
-- author       :   Ariel Rigueiras Montardo
-- created      :   2 de mar. de 2023
-- version      :   0.1
-- copyright    :   -
-- description  :   Testbench para o multiplexador com duas entradas de N bits.
--                  Como `mux`tem dois comportamentos foi utilizado `configuration` para realizar as
--                  seleções. Lembre que no ModelSim para que a configuração seja interpretada o entidade
--                  target da simulação deve ser a configuração, ex.: 
--                  ``` vsim -voptargs="+acc" -t ns work.mux_tb_config ```
--------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_tb is
end mux_tb;

-- O comportomanto esperado desse testbench é o seguinte
-- t    0   5   10  15  20  25  30  45
-- a    A   F   A   F   A   F   A   F
-- b    B   B   F   F   B   B   F   F
-- s    0   0   0   0   1   1   1   1
-- o    A   F   A   F   B   B   F   F
architecture Test of mux_tb is
    constant N     : natural := 8;
    signal a       : unsigned(N - 1 downto 0);
    signal b       : unsigned(N - 1 downto 0);
    signal sel     : unsigned(0 downto 0);
    signal output1 : unsigned(N - 1 downto 0); -- @suppress "signal output1 is never read"
    signal output2 : unsigned(N - 1 downto 0); -- @suppress "signal output2 is never read"

    component mux is
        generic(N : natural);
        port(
            a      : in  unsigned(N - 1 downto 0);
            b      : in  unsigned(N - 1 downto 0);
            sel    : in  unsigned(0 downto 0);
            output : out unsigned(N - 1 downto 0)
        );
    end component;

begin
    MUX_WITH_SELECT : mux
        generic map(
            N => N
        )
        port map(
            a      => a,
            b      => b,
            sel    => sel,
            output => output1
        );

    MUX_WHEN_ELSE : mux
        generic map(
            N => N
        )
        port map(
            a      => a,
            b      => b,
            sel    => sel,
            output => output2
        );

    se: process is
        variable temp : unsigned(0 downto 0) := "0";
    begin
        sel  <= temp;
        temp := not temp;
        wait for 20 ns;
    end process;

    pa : process is
        variable temp : unsigned(N - 1 downto 0) := x"AA";
    begin
        a <= temp;
        if temp = x"AA" then
            temp := x"FA";
        else
            temp := x"AA";
        end if;
        wait for 5 ns;
    end process pa;

    pb : process is
        variable temp : unsigned(N - 1 downto 0) := x"BB";
    begin
        b <= temp;
        if temp = x"BB" then
            temp := x"FB";
        else
            temp := x"BB";
        end if;
        wait for 10 ns;
    end process pb;

end architecture Test;

configuration mux_tb_config of mux_tb is
    for Test
        for MUX_WITH_SELECT : mux
            use entity work.mux(with_select);
        end for;
        for MUX_WHEN_ELSE : mux
            use entity work.mux(when_else);
        end for;
    end for;
end configuration mux_tb_config;

