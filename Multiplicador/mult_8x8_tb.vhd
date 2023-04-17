--  -----------------------------------------------------------------------
--  name        :   mult_x8x_tb.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   brief
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_8x8_tb is
end mult_8x8_tb;

architecture Test of mult_8x8_tb is
    signal dataa          : unsigned(7 downto 0);
    signal datab          : unsigned(7 downto 0);
    signal start          : std_logic;
    signal reset_a        : std_logic;
    signal clk            : std_logic;
    --
    signal done_flag      : std_logic;  -- @suppress "signal done_flag is never read"
    signal product8x8_out : unsigned(15 downto 0); -- @suppress "signal product8x8_out is never read"
    signal seg_a          : std_logic;  -- @suppress "signal seg_a is never read"
    signal seg_b          : std_logic;  -- @suppress "signal seg_b is never read"
    signal seg_c          : std_logic;  -- @suppress "signal seg_c is never read"
    signal seg_d          : std_logic;  -- @suppress "signal seg_d is never read"
    signal seg_e          : std_logic;  -- @suppress "signal seg_e is never read"
    signal seg_f          : std_logic;  -- @suppress "signal seg_f is never read"
    signal seg_g          : std_logic;  -- @suppress "signal seg_g is never read"
begin
    mult_x8x : entity work.mult_8x8
        port map(
            dataa          => dataa,
            datab          => datab,
            start          => start,
            reset_a        => reset_a,
            clk            => clk,
            done_flag      => done_flag,
            product8x8_out => product8x8_out,
            seg_a          => seg_a,
            seg_b          => seg_b,
            seg_c          => seg_c,
            seg_d          => seg_d,
            seg_e          => seg_e,
            seg_f          => seg_f,
            seg_g          => seg_g
        );

    reset_a <= '0';
    clock : process is
        variable tmp : std_logic := '0';
    begin
        clk <= tmp;
        tmp := not tmp;
        wait for 1 ns;
    end process;

    process(done_flag) is
        variable first_roll : boolean                := true;
        variable a          : integer range 0 to 255 := 0;
        variable b          : integer range 0 to 255 := 0;
    begin
        if falling_edge(done_flag) or first_roll then
            if not first_roll then
                if a = 2 ** 8 - 1 then
                    a := 0;
                    if b = 2 ** 8 - 1 then
                        b := 0;
                        report "@ loop around" severity note;
                    else
                        b := b + 1;
                    end if;
                else
                    a := a + 1;
                end if;
            end if;
            dataa      <= to_unsigned(a, 8);
            datab      <= to_unsigned(b, 8);
            start      <= '0', '1' after 1 ns, '0' after 3 ns;
            first_roll := false;
        end if;
        if rising_edge(done_flag) then
            assert a * b = product8x8_out
            report "@ Cálculo deu errado para " & integer'image(a) & "*" & integer'image(b) & ", esperava-se " & integer'image(a * b) & " e foi encontrado " & integer'image(to_integer(product8x8_out))
            severity failure;
        end if;
    end process;

end architecture Test;
