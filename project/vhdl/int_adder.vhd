library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity int_adder is
port(	
	exp_a:in std_logic_vector(7 downto 0);
	exp_b:in std_logic_vector(7 downto 0);
	r_msb: in std_logic;
	exp_res: out std_logic_vector(7 downto 0));
end int_adder;  

architecture int_adder_arch of int_adder is
begin
    exp_res<=exp_a + exp_b - 127 + r_msb;
end int_adder_arch;
