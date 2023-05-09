-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : Ariel Montardo
-- Version     : 0.1
-- Copyright   : -
-- Description : Entidade Top-level para sintetise com objetivo de
--               testar o filtro (media movel) contido em "filtro.vhd". 
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
    signal source : std_logic_vector(25 downto 0);
    signal probe  : std_logic_vector(47 downto 0);
    
    signal data_in: signed(23 downto 0);
    signal data_out: signed(47 downto 0);

    component unnamed is
        port(
            source : out std_logic_vector(25 downto 0); -- source
            probe  : in  std_logic_vector(47 downto 0) := (others => 'X') -- probe
        );
    end component unnamed;
begin
    
    data_in <= signed(source(25 downto 2));
    probe <= std_logic_vector(data_out);
    
    filt : entity work.filtro
        port map(
            clk      => source(1),
            rst      => source(0),
            data_in  => data_in,
            data_out => data_out
        );

    u0 : component unnamed
        port map(
            source => source,           -- sources.source
            probe  => probe             --  probes.probe
        );

end;

