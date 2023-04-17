
--  -----------------------------------------------------------------------
--  name        :   testbench.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   17 de abr. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Testbench para fsm (fsm.vhd)
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture RTL of testbench is
    signal clk : std_logic;
    signal rst : std_logic;
    signal fsr : std_logic;
    signal msr : std_logic;
    signal clr : std_logic;
    signal fm  : std_logic;             -- @suppress "signal fm is never read"
    signal mm  : std_logic;             -- @suppress "signal mm is never read"

begin

    fsm : entity work.fsm
        port map(
            clk => clk,
            rst => rst,
            fsr => fsr,
            msr => msr,
            clr => clr,
            fm  => fm,
            mm  => mm
        );

    process is
        constant period : time := 2 ns;
    begin
        clk <= '0';
        wait for period;
        clk <= '1';
        wait for period;
    end process;

    process is
    begin
        rst <= '1';
        fsr <= '0';
        msr <= '0';
        clr <= '0';
        wait until falling_edge(clk);

        rst <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);   -- deve se manter em S_WAIT

        fsr <= '1';
        wait until falling_edge(clk);
        fsr <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);   -- deve se manter em S_FRONT

        clr <= '1';
        wait until falling_edge(clk);
        clr <= '0';
        wait until falling_edge(clk);
        
        msr <= '1';
        wait until falling_edge(clk);
        msr <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);
        wait until falling_edge(clk);
        
        msr <= '1';
        wait until falling_edge(clk);
        msr <= '0';
        clr <= '1';
        wait until falling_edge(clk);
        clr <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);

    end process;

end architecture RTL;
