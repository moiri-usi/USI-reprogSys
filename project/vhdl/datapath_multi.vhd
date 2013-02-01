library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity datapath_multi is
    port(	
        clk           : in std_logic;
        reset         : in std_logic;
        a_m           : in std_logic_vector(22 downto 0);
        b_m           : in std_logic_vector(22 downto 0);
        add_ops       : in std_logic;
        shift_ops     : in std_logic;
        load_ops      : in std_logic;
        add_ctrl      : out std_logic;
        ready_ctrl    : out std_logic;
        result_mult   : out std_logic_vector(47 downto 0)
    );
end datapath_multi;

architecture arch of datapath_multi is
    signal a_m_s:std_logic_vector(47 downto 0);
    signal b_m_s:std_logic_vector(23 downto 0);
    signal result_mult_s:std_logic_vector(48 downto 0);
    signal count:std_logic_vector(4 downto 0);
begin
    process(clk, reset, load_ops, shift_ops, add_ops, a_m, b_m, result_mult_s,a_m_s,b_m_s)
    begin
        if reset = '0' then
            a_m_s <= (others => '0');
            b_m_s <= (others => '0');
            result_mult_s<=(others => '0');
		  else
			  if load_ops = '1' and rising_edge(clk) then
					a_m_s<="0000000000000000000000001" & a_m;
					b_m_s<= '1' & b_m;
					result_mult_s<=(others => '0');
			  elsif shift_ops = '1' and rising_edge(clk) then
				 a_m_s <= a_m_s(46 downto 0) & '0';
				 b_m_s <= '0' & b_m_s(23 downto 1);
			  elsif add_ops = '1' and rising_edge(clk) then
					result_mult_s <= result_mult_s + a_m_s;
			  else
					a_m_s <= a_m_s;
					b_m_s <= b_m_s;
					result_mult_s <= result_mult_s;
			  end if;
			end if;
    end process;

    process(clk, reset, load_ops, shift_ops, add_ops, a_m_s, b_m_s, result_mult_s)
    begin
        if b_m_s = "000000000000000000000000" then
            ready_ctrl <= '1';
        else
            ready_ctrl <= '0';
        end if;
    end process;

    add_ctrl <= b_m_s(0);

    result_mult<=result_mult_s(47 downto 0);

end arch;
