library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity int_adder is
	port(	
		exp_a:in std_logic_vector(7 downto 0);
		exp_b:in std_logic_vector(7 downto 0);
		r_msb: in std_logic;
		exp_overflow: out std_logic;
		exp_res: out std_logic_vector(7 downto 0)
		);
end int_adder;  

architecture int_adder_arch of int_adder is
signal exp_res_s: std_logic_vector(8 downto 0);
begin
    exp_res_s<=('0' & exp_a) + ('0' & exp_b) - 127 + r_msb;
    exp_res<= exp_res_s(7 downto 0);
    exp_overflow<=exp_res_s(8);
end int_adder_arch;
