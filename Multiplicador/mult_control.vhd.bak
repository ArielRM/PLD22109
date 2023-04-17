--  -----------------------------------------------------------------------
--  name        :   mult_control.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   brief
--  -----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_control is
    port(
        clk       : in  std_logic;
        reset_a     : in  std_logic;
        start     : in  std_logic;
        count     : in  unsigned(1 downto 0);
        --
        input_sel : out unsigned(1 downto 0);
        shift_sel : out std_logic_vector(1 downto 0);
        done      : out std_logic;
        clk_ena   : out std_logic;
        sclr_n    : out std_logic;
        --
        state_out : out std_logic_vector(2 downto 0)
    );
end entity mult_control;

architecture RTL of mult_control is
    type state_type is (IDLE, LSB, MID, MSB, CALC_DONE, ERR);
    signal state : state_type := IDLE;
begin
    process(reset_a, clk)
    begin
        if reset_a = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= LSB;
                    end if;
                when LSB =>
                    if start = '0' and count = "00" then
                        state <= MID;
                    else
                        state <= ERR;
                    end if;
                when MID =>
                    if start = '0' and count = "01" then
                        state <= MID;
                    elsif start = '0' and count = "10" then
                        state <= MSB;
                    else
                        state <= ERR;
                    end if;
                when MSB =>
                    if start = '0' and count = "11" then
                        state <= CALC_DONE;
                    else
                        state <= ERR;
                    end if;
                when CALC_DONE =>
                    if start = '0' then
                        state <= IDLE;
                    else
                        state <= ERR;
                    end if;
                when ERR =>
                    if start = '0' then
                        state <= LSB;
                    end if;
            end case;
        end if;
    end process;

    process(state) is
    begin
        case state is
            when IDLE =>
                state_out <= "000";
            when LSB =>
                state_out <= "001";
            when MID =>
                state_out <= "010";
            when MSB =>
                state_out <= "011";
            when CALC_DONE =>
                state_out <= "100";
            when ERR =>
                state_out <= "101";
        end case;
    end process;

    process(start, count, state) is
    begin
        case state is
            when IDLE =>
                if start = '0' then
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '0';
                end if;
            when LSB =>
                if start = '0' and count = "00" then
                    input_sel <= "00";
                    shift_sel <= "00";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;
            when MID =>
                if start = '0' and count = "01" then
                    input_sel <= "01";
                    shift_sel <= "01";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                elsif start = '0' and count = "10" then
                    input_sel <= "10";
                    shift_sel <= "01";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;
            when MSB =>
                if start = '0' and count = "11" then
                    input_sel <= "11";
                    shift_sel <= "10";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;
            when CALC_DONE =>
                if start = '0' then
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '1';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                end if;
            when ERR =>
                if start = '0' then
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '0';
                    sclr_n    <= '1';
                else
                    input_sel <= "XX";
                    shift_sel <= "XX";
                    done      <= '0';
                    clk_ena   <= '1';
                    sclr_n    <= '0';
                end if;
        end case;
    end process;

end architecture RTL;
