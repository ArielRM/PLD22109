--  ----------------------------------------------------------------------------
-- Name         :   de0_lite.vhd
-- Author       :    
-- Version      :   0.1
-- Copyright    :   Departamento de Eletr�nica, Florian�polis, IFSC
-- Description  :   Inst�ncia��o de fsm (fsm.vhd) para sintese e grava��o no kit 
--                  DE10-Lite. Adaptado de `Projeto base DE10-Lite`
--  ----------------------------------------------------------------------------

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

entity de10_lite is
    port(
        ---------- CLOCK ----------
        ADC_CLK_10    : in  std_logic;
        MAX10_CLK1_50 : in  std_logic;
        MAX10_CLK2_50 : in  std_logic;
        ----------- KEY ------------
        KEY           : in  std_logic_vector(1 downto 0);
        ----------- LED ------------
        LEDR          : out std_logic_vector(9 downto 0);
        ----------- SW ------------
        SW            : in  std_logic_vector(9 downto 0)
    );
end entity;

architecture rtl of de10_lite is
    component src_and_probes is
        port (
            source : out std_logic_vector(3 downto 0);                    -- source
            probe  : in  std_logic_vector(2 downto 0) := (others => 'X')  -- probe
        );
    end component src_and_probes;


    signal clk : std_logic;
    signal rst : std_logic;
    signal fsr : std_logic;
    signal msr : std_logic;
    signal clr : std_logic;
    signal fm  : std_logic;
    signal mm  : std_logic;

    signal source : std_logic_vector(3 downto 0);
    signal probe  : std_logic_vector(2 downto 0);
begin

    u0 : component src_and_probes
        port map (
            source => source, -- sources.source
            probe  => probe   --  probes.probe
        );

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

    probe(0) <= clk;
    LEDR(0)  <= '0';

    probe(1) <= fm;
    LEDR(1)  <= fm;

    probe(2) <= mm;
    LEDR(2)  <= mm;

    LEDR(9 downto 3) <= (others => '0');

    -- Usando o padr�o (SRC_1 xor SRC_2) � poss�vel controlar o sinal de forma 
    -- independente tanto a partir de SRC_1 quanto de SRC_2. Por�m a l�gica
    -- pode ficar aparentimente invertida, ent�o � importante sempre observar 
    -- o estado de cada fonte.
    rst <= source(0) xor SW(0);
    fsr <= source(1) xor not KEY(0);    -- Os bot�es s�o normalmente em '1' (pull-up)
    msr <= source(2) xor not KEY(1);    -- Os bot�es s�o normalmente em '1' (pull-up)
    clr <= source(3) xor SW(1);

end;

