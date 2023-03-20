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

entity seven_segment_cntrl is
    port(
        input : in  std_logic_vector(3 downto 0);
        dp    : in  std_logic;
        segs  : out std_logic_vector(7 downto 0)
    );
end entity seven_segment_cntrl;

architecture RTL of seven_segment_cntrl is
    constant AC_0 : std_logic_vector(6 downto 0) := "0000001";
    constant AC_1 : std_logic_vector(6 downto 0) := "1001111";
    constant AC_2 : std_logic_vector(6 downto 0) := "0010010";
    constant AC_3 : std_logic_vector(6 downto 0) := "0000110";
    constant AC_4 : std_logic_vector(6 downto 0) := "1001100";
    constant AC_5 : std_logic_vector(6 downto 0) := "0100100";
    constant AC_6 : std_logic_vector(6 downto 0) := "0100000";
    constant AC_7 : std_logic_vector(6 downto 0) := "0001111";
    constant AC_8 : std_logic_vector(6 downto 0) := "0000000";
    constant AC_9 : std_logic_vector(6 downto 0) := "0001100";
    constant AC_A : std_logic_vector(6 downto 0) := "0001000";
    constant AC_B : std_logic_vector(6 downto 0) := "1100000";
    constant AC_C : std_logic_vector(6 downto 0) := "0110001";
    constant AC_D : std_logic_vector(6 downto 0) := "1000010";
    constant AC_E : std_logic_vector(6 downto 0) := "0110000";
    constant AC_F : std_logic_vector(6 downto 0) := "0111000";

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
                segs <= AC_0 & not dp;
            when x"1" =>
                segs <= AC_1 & not dp;
            when x"2" =>
                segs <= AC_2 & not dp;
            when x"3" =>
                segs <= AC_3 & not dp;
            when x"4" =>
                segs <= AC_4 & not dp;
            when x"5" =>
                segs <= AC_5 & not dp;
            when x"6" =>
                segs <= AC_6 & not dp;
            when x"7" =>
                segs <= AC_7 & not dp;
            when x"8" =>
                segs <= AC_8 & not dp;
            when x"9" =>
                segs <= AC_9 & not dp;
            when x"A" =>
                segs <= AC_A & not dp;
            when x"B" =>
                segs <= AC_B & not dp;
            when x"C" =>
                segs <= AC_C & not dp;
            when x"D" =>
                segs <= AC_D & not dp;
            when x"E" =>
                segs <= AC_E & not dp;
            when x"F" =>
                segs <= AC_F & not dp;
            when others =>
                -- Um pouco redundante com o valor padrão, mas pode evitar erros futuros.
                segs <= x"FF";
        end case;
    end process;
end architecture RTL;
