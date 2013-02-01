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
        add_ops       : out std_logic;
        shift_ops     : out std_logic;
        load_ops      : out std_logic;
        mant_overflow : out std_logic;
        ready_mult    : out std_logic
    );
end control_multi;

architecture sm of control_multi is
    type state is (init, load, check, shifter, adder, done);
    signal current_state, next_state : state;
begin 
    process(current_state, load_mult, add_ctrl, ready_ctrl) 
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
            next_state <= check;
            load_ops <= '1';
        when check =>
            if add_ctrl = '1' then
                next_state <= adder;
            elsif ready_ctrl = '1' then
                next_state <= done;
            else
                next_state <= shifter;
            end if;
        when shifter => 
            next_state <= check;
            shift_ops <= '1';
        when adder =>
            next_state <= shifter;
            add_ops <= '1';
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
