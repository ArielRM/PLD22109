--  -----------------------------------------------------------------------
--  name        :   seven_segment_cntrl.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   9 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Um decodificador de 7-segmentos utilizando a instrução 
--                  case.
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Decodificador 7-segmentos, a ordem dos bit é `"pgfedcba"`
entity seven_segment_cntrl is
    port(
        input : in  std_logic_vector(3 downto 0);
        dp    : in  std_logic;
        segs  : out std_logic_vector(7 downto 0) -- `"pgfedcba"`
    );
end entity seven_segment_cntrl;

architecture RTL of seven_segment_cntrl is
    constant AC_0 : std_logic_vector(6 downto 0) := "1000000";
    constant AC_1 : std_logic_vector(6 downto 0) := "1111001";
    constant AC_2 : std_logic_vector(6 downto 0) := "0100100";
    constant AC_3 : std_logic_vector(6 downto 0) := "0110000";
    constant AC_4 : std_logic_vector(6 downto 0) := "0011001";
    constant AC_5 : std_logic_vector(6 downto 0) := "0010010";
    constant AC_6 : std_logic_vector(6 downto 0) := "0000010";
    constant AC_7 : std_logic_vector(6 downto 0) := "1111000";
    constant AC_8 : std_logic_vector(6 downto 0) := "0000000";
    constant AC_9 : std_logic_vector(6 downto 0) := "0011000";
    constant AC_A : std_logic_vector(6 downto 0) := "0001000";
    constant AC_B : std_logic_vector(6 downto 0) := "0000011";
    constant AC_C : std_logic_vector(6 downto 0) := "1000110";
    constant AC_D : std_logic_vector(6 downto 0) := "0100001";
    constant AC_E : std_logic_vector(6 downto 0) := "0000110";
    constant AC_F : std_logic_vector(6 downto 0) := "0001110";

begin
    process(input, dp) is
    begin
        -- Valor padrão, além de evitar latches caso alguns caminhos escrevam em `segs` e outros não
        -- isso também garante que todos os bits de `segs` sejam definidos.
        segs <= x"FF";

        -- É utilizado `not dp` porquê o display é anodo comum, e no programa fica mais lógico
        -- acionar o `decimal point` em `1` 
        case input is
            when x"0" =>
                segs <= not dp & AC_0;
            when x"1" =>
                segs <= not dp & AC_1;
            when x"2" =>
                segs <= not dp & AC_2;
            when x"3" =>
                segs <= not dp & AC_3;
            when x"4" =>
                segs <= not dp & AC_4;
            when x"5" =>
                segs <= not dp & AC_5;
            when x"6" =>
                segs <= not dp & AC_6;
            when x"7" =>
                segs <= not dp & AC_7;
            when x"8" =>
                segs <= not dp & AC_8;
            when x"9" =>
                segs <= not dp & AC_9;
            when x"A" =>
                segs <= not dp & AC_A;
            when x"B" =>
                segs <= not dp & AC_B;
            when x"C" =>
                segs <= not dp & AC_C;
            when x"D" =>
                segs <= not dp & AC_D;
            when x"E" =>
                segs <= not dp & AC_E;
            when x"F" =>
                segs <= not dp & AC_F;
            when others =>
                -- Um pouco redundante com o valor padrão, mas pode evitar erros futuros.
                segs <= x"FF";
        end case;
    end process;
end architecture RTL;
