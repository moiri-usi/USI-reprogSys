library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity control is
    port (
        clk            : in std_logic;
        reset          : in std_logic;
        start          : in std_logic;
        ready_multi    : in std_logic;
        overflow       : in std_logic;
        truncate       : in std_logic;
        load_multi     : out std_logic;
        enable         : out std_logic;
        enable_res     : out std_logic;
        flush          : out std_logic;
        ready          : out std_logic_vector(7 downto 0);
        valid          : out std_logic_vector(7 downto 0)  
    );
end control;

architecture sm of control is
type state is (init, load_val, load_mult, mult, load_res, display, wait_start);
signal current_state, next_state : state;
begin 
	process(current_state, start, ready_multi, overflow, truncate) 
	begin 
		load_multi<='0';
		enable<='0';
		enable_res<='0';
		flush<='0';
		ready<=(others =>'0');
		valid<=(others =>'0');
		next_state<= init;
		case current_state is
			when init => 
				next_state <= init;
				if start ='0' then
					next_state <= load_val;
				end if;
			when load_val =>
				next_state <= load_mult;
				enable <= '1';
				flush <= '1';
			when load_mult =>
				load_multi <= '1';
				next_state <= mult;
			when mult =>
				next_state <= mult;
				if ready_multi='1' then
					next_state <= load_res;
				end if;
			when load_res =>
                enable_res <= '1';
				next_state <= display;
			when display =>
                ready <= (others=>'1');
                valid<=(others =>'1');
                if overflow = '1' then
                    ready <= "10101010";
                    valid <= "11110000";
                elsif truncate = '1' then
                    ready <= "10101010";
                    valid <= "00001111";
				end if;
				next_state <= display;
                if start='1' then
                    next_state <= wait_start;
                end if;
			when wait_start =>
                ready <= (others=>'1');
                valid<=(others =>'1');
                if overflow = '1' then
                    ready <= "10101010";
                    valid <= "11110000";
                elsif truncate = '1' then
                    ready <= "10101010";
                    valid <= "00001111";
				end if;
				next_state <= wait_start;
				if start='0' then
					next_state <= load_val;
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
