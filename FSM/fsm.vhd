library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port(
        clk : in std_logic;
        rst : in std_logic;
        fsr : in std_logic;
        msr : in std_logic;
        clr : in std_logic;
        
        fm : out std_logic;
        mm : out std_logic
    );
end entity fsm;

architecture RTL of fsm is
    type state_type is (S_INIT, S_WAIT, S_MOTION, S_FRONT);
    signal state : state_type := S_INIT;
begin

    process(clk, rst) is
        variable counter : integer := 2;
    begin
        if rst = '1' then
            state <= S_INIT;
        elsif rising_edge(clk) then
            case state is
                when S_INIT =>
                    state <= S_WAIT;
                when S_WAIT =>
                    if fsr = '1' then
                        state <= S_FRONT;
                    elsif msr = '1' then
                        state <= S_MOTION;
                    end if;
                when S_MOTION =>
                    counter := counter - 1;
                    if counter = 0 then
                        counter := 2;
                        state <= S_WAIT;
                    end if;
                when S_FRONT =>
                    if clr = '1' then
                        state <= S_WAIT;
                    end if;
            end case;
        end if;
    end process;
    
    process(state) is
    begin
        fm <= '0';
        mm <= '0';
        case state is
            when S_INIT =>
                -- default
            when S_WAIT =>
                -- default
            when S_MOTION=>
                mm <= '1';
            when S_FRONT =>
                fm <= '1';
        end case;
    end process;

end architecture RTL;
