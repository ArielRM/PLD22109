--  -----------------------------------------------------------------------
--  name        :   counter.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Contador de n-bits com `clear` assíncrono
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  -----------------------------------------------------------------------
--  Contador com reset assincrono, a saída vai para 0 imediatamente quando 
--  `aclr_n`='0'. Se `aclr_n` não é '0', o contador é incrementado em 1 na 
--  borda de subida de `clk`.
--  -----------------------------------------------------------------------
entity counter is
    generic(N : natural := 2);
    port(
        clk       : in  std_logic;
        aclr_n    : in  std_logic;      -- Assyncronous clear com lógica negada
        count_out : out unsigned(N - 1 downto 0)
    );
end entity counter;

architecture RTL of counter is
begin
    process(clk, aclr_n) is
        variable count : unsigned(N - 1 downto 0) := to_unsigned(0, N);
    begin
        if aclr_n = '0' then
            count := to_unsigned(0, N);
        elsif rising_edge(clk) then
            count := count + 1;
        end if;

        -- `count_out` sempre recebe um valor, evtando Latches
        count_out <= count;
    end process;
end architecture RTL;
