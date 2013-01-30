library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity int_adder is
port(	
	enable_add:in std_logic;
	exp_a:in std_logic_vector(7 downto 0);
	exp_b:in std_logic_vector(7 downto 0);
	r_msb: in std_logic;
	exp_res: out std_logic_vector(7 downto 0));
end int_adder;  

architecture int_adder_arch of int_adder is
signal exp_res_s:std_logic_vector(7 downto 0):=(others => '0');
begin
  process(enable_add)
		begin
		  if enable_add ='1' then
		    exp_res_s<=exp_a + exp_b - 127 + r_msb;
		  end if;
 end process;
	exp_res<=exp_res_s;
end int_adder_arch;
