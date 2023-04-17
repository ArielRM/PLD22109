--  -----------------------------------------------------------------------
--  name        :   shifter.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   9 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Um deslocador de 8-bit para 16-bit utilizando as 
--                  instruções IF-THEN.
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  -----------------------------------------------------------------------
--  Deslocador de 8-bits para 16-bits, quando a entrada `shift_cntrl` é 
--  "00" ou "11" a saída `shift_out` é igual à entrada (input << 0), quando
--  `shift_cntrl` é "01" a saída é a entrada `input` deslocada em 4 bits à
--  esquerda (input << 4) e quando `shift_cntrl` é "10" `shift_out` recebe
--  `input` deslocada em 8 bits à esquerda (input << 8).
--  -----------------------------------------------------------------------
entity shifter is
    port(
        input       : in  unsigned(7 downto 0);
        shift_cntrl : in  std_logic_vector(1 downto 0);
        shift_out   : out unsigned(15 downto 0)
    );
end entity shifter;

architecture RTL of shifter is

begin
    process(input, shift_cntrl) is
    begin
        -- Valor padrão, além de evitar latches caso alguns caminhos escrevam em `shift_out` e outros não
        -- isso também garante que todos os bits de `shift_out` sejam definidos.
        shift_out <= x"0000";

        if shift_cntrl = "01" then
            shift_out(11 downto 4) <= input;
        elsif shift_cntrl = "10" then
            shift_out(15 downto 8) <= input;
        else
            -- Caso "00" ou "01", um pouco redundante com o valor padrão, mas pode evitar erros futuros.
            shift_out(7 downto 0) <= input;
        end if;

    end process;
end architecture RTL;
