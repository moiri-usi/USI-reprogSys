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
  type state is (init, read, mult, mult_dmy, extract, extract_dmy, assemble, display, display_dmy);
  signal current_state, next_state : state; 
  signal load_multi_s,load_mant_s,enable_s,enable_add_s,enable_res_s,flush_s:std_logic;
  signal ready_s:std_logic_vector(7 downto 0):="00000000";
  begin 
  process(current_state,start,ready_multi,ready_mant) 
  begin 
    load_multi_s<='0';
    load_mant_s<='0';
    enable_s<='0';
    enable_add_s<='0';
    enable_res_s<='0';
    flush_s<='0';
    --ready_s<=(others =>'0');
    next_state<= init;
    case current_state is
        when init => 
          if rising_edge(start) then
            next_state <= read;
          else
            next_state <= init;
          end if;
        when read =>
          next_state <= mult;
          enable_s <= '1';
          flush_s <= '1';
         when mult =>
          load_multi_s <= '1';
          next_state <= mult_dmy;
         when mult_dmy =>
          --load_multi_s <= '0';
         
          if ready_multi='1' then
              next_state <= extract;
          else
              next_state <= mult_dmy;
          end if; 
         when extract =>
          enable_add_s <= '1';
          load_mant_s <= '1';
          next_state <= extract_dmy;
         when extract_dmy =>
          if ready_mant='1' then
              next_state <= assemble;
          else
              next_state <= extract_dmy;
          end if;
         when assemble =>
                -- TODO: is this state needed?
                -- wait one clock cycle
            next_state <= display;
            enable_res_s<='1';
         when display =>
            ready_s <= (others=>'1');
            --enable_res_s <= '1';
            next_state <= display_dmy;
          when display_dmy =>
            if rising_edge(start) then
                next_state <= read;
            else
                next_state <= display_dmy;
            end if;
        end case;
       end process;
    process(clk, reset) 
    begin 
      if reset='0' then
         current_state<= init; 
      else
      if rising_edge(clk) then
         load_multi<=load_multi_s;
         load_mant<=load_mant_s;
         enable<=enable_s;
         enable_add<=enable_add_s;
         enable_res<=enable_res_s;
         flush<=flush_s;
         ready<=ready_s;
         current_state<= next_state; 
      end if;
    end if; 
    end process; 
end sm;
