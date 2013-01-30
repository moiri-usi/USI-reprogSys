library ieee;
use ieee.std_logic_1164.all;

entity ctrl_unit is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        ready_mult  : in std_logic;
        ready_mant  : in std_logic;
        load_mult   : out std_logic;
        load_mant   : out std_logic;
        enable      : out std_logic;
        enable_add  : out std_logic;
        flush       : out std_logic;
        ready       : out std_logic
    );
end ctrl_unit;

architecture sm of ctrl_unit is
    type state is (init, read, mult, extract, assemble, display);
    signal current_state, next_state : state;
    signal enable_int, enable_add_int, flush_int, load_mult_int, load_mant_int, ready_int : std_logic;
begin
    process (current_state, reset, start, clk, ready_mult, ready_mant)
    begin
        load_mult <= '0';
        load_mult_int <= '0';
        load_mant <= '0';
        load_mant_int <= '0';
        enable <= '0';
        enable_int <= '0';
        enable_add <= '0';
        enable_add_int <= '0';
        ready <= '0';
        ready_int <= '0';
        flush <= '0';
        flush_int <= '0';
        next_state <= init;
        case current_state is
            when init =>
                if rising_edge(start) then
                    next_state <= read;
                else
                    next_state <= init;
                end if;
            when read =>
                next_state <= mult;
                if enable_int='0' then
                    enable_int <= '1';
                    enable <= '1';
                end if;
                if flush_int='0' then
                    flush_int <= '1';
                    flush <= '1';
                end if;
            when mult =>
                if load_mult_int='0' then
                    load_mult_int <= '1';
                    load_mult <= '1';
                end if;
                if ready_mult='1' then
                    next_state <= extract;
                else
                    next_state <= mult;
                end if;
            when extract =>
                if enable_add_int='0' then
                    enable_add_int <= '1';
                    enable_add <= '1';
                end if;
                if load_mant_int='0' then
                    load_mant_int <= '1';
                    load_mant <= '1';
                end if;
                if ready_mant='1' then
                    next_state <= assemble;
                else
                    next_state <= extract;
                end if;
            when assemble =>
                -- TODO: is this state needed?
                -- wait one clock cycle
                next_state <= display;
            when display =>
                if ready_int='0' then
                    ready_int <= '1';
                    ready <= '1';
                end if;
                if rising_edge(start) then
                    next_state <= read;
                else
                    next_state <= display;
                end if;
        end case;
    end process;

    process (clk, reset)
    begin
        if reset='1' then
            current_state <= init;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
end sm;
