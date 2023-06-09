-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity de10_lite is
    port(
        ---------- CLOCK ----------
        ADC_CLK_10      : in    std_logic;
        MAX10_CLK1_50   : in    std_logic;
        MAX10_CLK2_50   : in    std_logic;
        ----------- SDRAM ------------
        DRAM_ADDR       : out   std_logic_vector(12 downto 0);
        DRAM_BA         : out   std_logic_vector(1 downto 0);
        DRAM_CAS_N      : out   std_logic;
        DRAM_CKE        : out   std_logic;
        DRAM_CLK        : out   std_logic;
        DRAM_CS_N       : out   std_logic;
        DRAM_DQ         : inout std_logic_vector(15 downto 0);
        DRAM_LDQM       : out   std_logic;
        DRAM_RAS_N      : out   std_logic;
        DRAM_UDQM       : out   std_logic;
        DRAM_WE_N       : out   std_logic;
        ----------- SEG7 ------------
        HEX0            : out   std_logic_vector(7 downto 0);
        HEX1            : out   std_logic_vector(7 downto 0);
        HEX2            : out   std_logic_vector(7 downto 0);
        HEX3            : out   std_logic_vector(7 downto 0);
        HEX4            : out   std_logic_vector(7 downto 0);
        HEX5            : out   std_logic_vector(7 downto 0);
        ----------- KEY ------------
        KEY             : in    std_logic_vector(1 downto 0);
        ----------- LED ------------
        LEDR            : out   std_logic_vector(9 downto 0);
        ----------- SW ------------
        SW              : in    std_logic_vector(9 downto 0);
        ----------- VGA ------------
        VGA_B           : out   std_logic_vector(3 downto 0);
        VGA_G           : out   std_logic_vector(3 downto 0);
        VGA_HS          : out   std_logic;
        VGA_R           : out   std_logic_vector(3 downto 0);
        VGA_VS          : out   std_logic;
        ----------- Accelerometer ------------
        GSENSOR_CS_N    : out   std_logic;
        GSENSOR_INT     : in    std_logic_vector(2 downto 1);
        GSENSOR_SCLK    : out   std_logic;
        GSENSOR_SDI     : inout std_logic;
        GSENSOR_SDO     : inout std_logic;
        ----------- Arduino ------------
        ARDUINO_IO      : inout std_logic_vector(15 downto 0);
        ARDUINO_RESET_N : inout std_logic
    );
end entity;

architecture rtl of de10_lite is
    signal product8x8_out : unsigned(15 downto 0);

    signal produto : std_logic_vector(15 downto 0); -- para facilitar a comunica��o com o controlador de 7-seg
    signal dataa   : unsigned(7 downto 0);
    signal datab   : unsigned(7 downto 0);
    signal probe   : std_logic_vector(15 downto 0);
    signal source  : std_logic_vector(16 downto 0);
	 signal clk : std_logic;
    component unnamed is
        port(
            source : out std_logic_vector(16 downto 0); -- source
            probe  : in  std_logic_vector(15 downto 0) := (others => 'X') -- probe
        );
    end component unnamed;
begin
    produto <= std_logic_vector(product8x8_out);

    mult : entity work.mult_8x8
        port map(
            dataa          => dataa,
            datab          => datab,
            start          => SW(2),
            reset_a        => SW(1),
            clk            => clk,
            done_flag      => LEDR(0),
            product8x8_out => product8x8_out,
            seg_a          => HEX0(0),
            seg_b          => HEX0(1),
            seg_c          => HEX0(2),
            seg_d          => HEX0(3),
            seg_e          => HEX0(4),
            seg_f          => HEX0(5),
            seg_g          => HEX0(6)
        );

    HEX0(7) <= '1';

    disp5 : entity work.seven_segment_cntrl
        port map(
            input => produto(15 downto 12),
            dp    => '0',
            segs  => HEX5
        );

    disp4 : entity work.seven_segment_cntrl
        port map(
            input => produto(11 downto 8),
            dp    => '0',
            segs  => HEX4
        );

    disp3 : entity work.seven_segment_cntrl
        port map(
            input => produto(7 downto 4),
            dp    => '0',
            segs  => HEX3
        );

    disp2 : entity work.seven_segment_cntrl
        port map(
            input => produto(3 downto 0),
            dp    => '0',
            segs  => HEX2
        );
    ip : component unnamed
        port map(
            probe  => probe,
            source => source
        );
	 clk <= source(16) or SW(3);

    dataa <= unsigned(source(15 downto 8));
    datab <= unsigned(source(7 downto 0));

    probe <= produto;

end;

