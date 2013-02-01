library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control_multi is
    port(	
        clk           : in std_logic;
        reset         : in std_logic;
        load_mult     : in std_logic;
        add_ctrl      : in std_logic;
        ready_ctrl    : in std_logic;
        overflow_ctrl : in std_logic;
        add_ops       : out std_logic;
        shift_ops     : out std_logic;
        load_ops      : out std_logic;
        mant_overflow : out std_logic;
        ready_mult    : out std_logic
    );
end control_multi;

architecture sm of control_multi is
    type state is (init, load, shifter, adder, overflow, done);
    signal current_state, next_state : state;
begin 
    process(current_state, load_mult, add_ctrl, ready_ctrl, overflow_ctrl) 
    begin
        add_ops <= '0';
        shift_ops <= '0';
        load_ops <= '0';
        mant_overflow <= '0';
        ready_mult <= '0';
        next_state <= init;
        case current_state is
        when init => 
            next_state <= init;
            if load_mult = '1' then
                next_state <= load;
            end if;
        when load =>
            next_state <= shifter;
            load_ops <= '1';
        when shifter => 
            next_state <= shifter;
            shift_ops <= '1';
            if add_ctrl = '1' then
                next_state <= adder;
            end if;
        when adder =>
            next_state <= shifter;
            add_ops <= '1';
            if ready_ctrl = '1' then
                next_state <= done;
            elsif overflow_ctrl = '1' then
                next_state <= overflow;
            end if;
        when overflow =>
            next_state <= overflow;
            ready_mult <= '1';
            mant_overflow <= '1';
            if load_mult = '1' then
                next_state <= load;
            end if;
        when done =>
            next_state <= done;
            ready_mult <= '1';
            if load_mult = '1' then
                next_state <= load;
            end if;
        end case;
   end process;

    process(clk, reset) 
    begin 
        if reset='0' then
            current_state <= init; 
        elsif rising_edge(clk) then
            current_state <= next_state; 
        end if; 
    end process; 
end sm;
