--  ----------------------------------------------------------------------------
--  name        :   fsm.vhd
--  author      :   Ariel Rigueiras Montardo
--  created     :   14 de mar. de 2023
--  version     :   0.1
--  copyright   :   -
--  description :   Uma máquina de estados finitos (FSM) para controlar um 
--                  sistema de segurança simples.
--
--      Entradas (Todas as chaves são ativadas em nível alto):
--          Chave do portão de entrada `fsr`.
--          Chave de detecção de movimento `msr`.
--          Chave de reset assíncrono `rst`.
--          Chave clear `clr`.
--
--      Saídas:
--          Campainha do portão de entrada `fm`.
--          Campainha do detector de movimento `mm`.
--
--      Comportamento:
--          -Quando o `rst` está acionada, a FSM vai para o estado de 
--           inicialização S_INIT, imediatamente desligando todas as saídas.
--          -Do estado S_INIT, a FSM vai incondicionalmente para o estado de 
--           espera S_WAIT.
--          -Do estado S_WAIT, a FSM espera a ativação de uma das quatro chaves.
--              * Quando `fsr` é pressionado, a FSM vai para o estado S_FRONT, 
--                onde a campainha `fm` é ligada setando `fm = 1`. A FSM 
--                permanece no estado S_FRONT até a chave `clr` ser pressionada
--                e então retorna para S_WAIT.
--              * Quando `msr` é ativada, a FSM vai para o estado S_MOTION onde 
--                a campainha `mm` é ativada. Após dois ciclos de clock a FSM 
--                volta para o estado S_WAIT.
--          - Em qualquer estado, um reset envia a FSM para o estado S_INIT.
--          - A chave `clr` apenas afeta a FSM no estado S_FRONT.
--  ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  ----------------------------------------------------------------------------
--  Uma máquina de estados finitos (FSM) para controlar um sistema de segurança 
--  simples.
--  ----------------------------------------------------------------------------
entity fsm is
    port(
        clk : in  std_logic;            -- Sinal de clock
        rst : in  std_logic;            -- Chave de reset assíncrono `rst`
        fsr : in  std_logic;            -- Chave do portão de entrada `fsr`
        msr : in  std_logic;            -- Chave de detecção de movimento `msr`
        clr : in  std_logic;            -- Chave clear `clr`
        fm  : out std_logic;            -- Campainha do portão de entrada `fm`
        mm  : out std_logic             -- Campainha do detector de movimento `mm`
    );
end entity fsm;

architecture RTL of fsm is
    type state_type is (S_INIT, S_WAIT, S_MOTION, S_FRONT);
    signal state : state_type := S_INIT;
begin

    process(clk, rst) is                -- Lógica de próximo estado
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
                        state   <= S_WAIT;
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
            when S_MOTION =>
                mm <= '1';
            when S_FRONT =>
                fm <= '1';
        end case;
    end process;

end architecture RTL;
