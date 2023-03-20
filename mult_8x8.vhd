--  -----------------------------------------------------------------------
--  name        :   mult_x8x.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   brief
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_8x8 is
    port(
        dataa          : in  unsigned(7 downto 0);
        datab          : in  unsigned(7 downto 0);
        start          : in  std_logic;
        reset_a        : in  std_logic;
        clk            : in  std_logic;
        --
        done_flag      : out std_logic;
        product8x8_out : out unsigned(15 downto 0);
        --
        seg_a          : out std_logic;
        seg_b          : out std_logic;
        seg_c          : out std_logic;
        seg_d          : out std_logic;
        seg_e          : out std_logic;
        seg_f          : out std_logic;
        seg_g          : out std_logic
    );
end entity mult_8x8;

architecture RTL of mult_8x8 is
    signal count            : unsigned(1 downto 0);
    signal sel              : unsigned(1 downto 0);
    signal shift            : std_logic_vector(1 downto 0);
    signal clk_ena          : std_logic;
    signal sclr_n           : std_logic;
    signal state_out        : std_logic_vector(2 downto 0);
    signal segs             : std_logic_vector(7 downto 0);
    signal aout             : unsigned(3 downto 0);
    signal bout             : unsigned(3 downto 0);
    signal product          : unsigned(7 downto 0);
    signal shift_out        : unsigned(15 downto 0);
    signal product8x8       : unsigned(15 downto 0);
    signal sum              : unsigned(15 downto 0);
    --
    signal not_start        : std_logic;
    signal longer_state_out : std_logic_vector(3 downto 0);
begin
    not_start        <= not start;
    longer_state_out <= '0' & state_out;

    mult_control : entity work.mult_control
        port map(
            clk       => clk,
            reset_a   => reset_a,
            start     => start,
            count     => count,
            input_sel => sel,
            shift_sel => shift,
            done      => done_flag,
            clk_ena   => clk_ena,
            sclr_n    => sclr_n,
            state_out => state_out
        );

    mux4_1 : entity work.mux
        generic map(
            N => 4
        )
        port map(
            a      => dataa(3 downto 0),
            b      => dataa(7 downto 4),
            sel    => sel(1 downto 1),
            output => aout
        );

    mux4_2 : entity work.mux
        generic map(
            N => 4
        )
        port map(
            a      => datab(3 downto 0),
            b      => datab(7 downto 4),
            sel    => sel(0 downto 0),
            output => bout
        );

    mult4x4 : entity work.mult
        generic map(
            N => 4
        )
        port map(
            a       => aout,
            b       => bout,
            product => product
        );

    shifter : entity work.shifter
        port map(
            input       => product,
            shift_cntrl => shift,
            shift_out   => shift_out
        );

    adder : entity work.adder
        generic map(
            N => 16
        )
        port map(
            a   => shift_out,
            b   => product8x8,
            sum => sum
        );

    reg16 : entity work.registrador
        generic map(
            N => 16
        )
        port map(
            clk     => clk,
            sclr_n  => sclr_n,
            clk_ena => clk_ena,
            datain  => sum,
            reg_out => product8x8
        );

    counter : entity work.counter
        generic map(
            N => 2
        )
        port map(
            clk       => clk,
            aclr_n    => not_start,
            count_out => count
        );

    product8x8_out <= product8x8;

    seg_a <= segs(7);
    seg_b <= segs(6);
    seg_c <= segs(5);
    seg_d <= segs(4);
    seg_e <= segs(3);
    seg_f <= segs(2);
    seg_g <= segs(1);
    seven_segment_cntrl : entity work.seven_segment_cntrl
        port map(
            input => longer_state_out,
            dp    => '0',
            segs  => segs
        );

end architecture RTL;
