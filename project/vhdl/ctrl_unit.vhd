library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
entity control is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        ready_multi : in std_logic;
        ready_mant  : in std_logic;
        load_multi  : out std_logic;
        load_mant   : out std_logic;
        enable      : out std_logic;
        enable_add  : out std_logic;
        enable_res  : out std_logic;
        flush       : out std_logic;
        ready       : out std_logic_vector(7 downto 0)
    );
end control;
architecture sm of control is
  type state is (init, read, mult, mult_dmy, extract, extract_dmy, assemble, display);
  signal current_state, next_state : state;
  begin 
  process(current_state,start,ready_multi,ready_mant) 
  begin 
    load_multi<='0';
    load_mant<='0';
    enable<='0';
    enable_add<='0';
    enable_res<='0';
    flush<='0';
    ready<=(others =>'0');
    next_state<= init;
    case current_state is
        when init => 
            next_state <= init;
            if rising_edge(start) then
                next_state <= read;
            end if;
        when read =>
            next_state <= mult;
            enable <= '1';
            flush <= '1';
        when mult =>
            load_multi <= '1';
            next_state <= mult_dmy;
        when mult_dmy =>         
            if ready_multi='1' then
                next_state <= extract;
            else
                next_state <= mult_dmy;
            end if; 
        when extract =>
            enable_add <= '1';
            load_mant <= '1';
            next_state <= extract_dmy;
        when extract_dmy =>
            if ready_mant='1' then
                next_state <= assemble;
            else
                next_state <= extract_dmy;
            end if;
        when assemble =>
            next_state <= display;
            enable_res<='1';
        when display =>
            ready <= (others=>'1');
            next_state <= display;
            if rising_edge(start) then
                next_state <= read;
            end if;
        end case;
    end process;

    process(clk, reset) 
    begin 
        if reset='0' then
            current_state<= init; 
        elsif rising_edge(clk) then
            current_state<= next_state; 
        end if; 
    end process; 
end sm;
