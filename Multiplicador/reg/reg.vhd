--  -----------------------------------------------------------------------
--  name        :   reg.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   código para um registrador de n-bits.
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  -----------------------------------------------------------------------
--  Todas as operações ocorrem na subida de `clk`, com exceção de `sclr_n`.
--  se `sclr_n` é baixo a saída é limpa (prioridade mais alta). Na subida 
--  do clock, se `clk_ena` é alto a saída é atribuída à entrada e se 
--  `clk_ena` é baixo, nada é feito;
--  -----------------------------------------------------------------------
entity registrador is
    generic(N : natural := 16);
    port(
        clk     : in  std_logic;
        sclr_n  : in  std_logic;
        clk_ena : in  std_logic;
        datain  : in  unsigned(N - 1 downto 0);
        reg_out : out unsigned(N - 1 downto 0)
    );
end entity registrador;

architecture RTL of registrador is
begin
    process(clk, sclr_n) is
    begin
        if sclr_n = '0' then
            reg_out <= to_unsigned(0, N);
        elsif rising_edge(clk) and clk_ena = '1' then
            reg_out <= datain;
        end if;
    end process;
end architecture RTL;
