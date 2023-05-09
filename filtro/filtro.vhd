--  ----------------------------------------------------------------------------
--  name        :   filtro.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   9 de maio de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Uma "filtro" media móvel com o objetivo de mostrar o uso de
--                  vetores.
--  ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filtro is
    port(
        clk      : in  std_logic;
        rst      : in  std_logic;
        data_in  : in  signed(23 downto 0);
        --
        data_out : out signed(47 downto 0)
    );
end entity filtro;

architecture RTL of filtro is
    type registradores is array (0 to 15) of signed(47 downto 0);
    type coeficientes is array (0 to 15) of signed(23 downto 0);

    constant COEFF : coeficientes := (others => x"000001");

begin
    p0 : process(clk, rst) is
        variable i      : unsigned(3 downto 0) := (others => '0');
        variable inputs : registradores;
        variable soma   : signed(47 downto 0);
    begin
        if rst = '1' then               -- Reset
            i    := (others => '0');
            soma := (others => '0');
            for i in inputs'range loop
                inputs(i) := (others => '0');
            end loop;
        elsif rising_edge(clk) then
            soma                  := soma - inputs(to_integer(i)) + data_in * COEFF(to_integer(i));
            inputs(to_integer(i)) := data_in * COEFF(to_integer(i));
            i                     := i + 1;
        end if;

        data_out(43 downto 0) <= soma(47 downto 4);
        if soma(47) = '0' then          -- Se a soma é positiva, estende com zeros
            data_out(47 downto 44) <= "0000";
        else                            -- Se a soma é negativa, estende com ums
            data_out(47 downto 44) <= "1111";
        end if;
    end process;
end architecture RTL;
