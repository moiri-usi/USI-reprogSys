library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg_operand is
	port(	
		op:in std_logic_vector(31 downto 0);
		clk: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
		op_out: out std_logic_vector(31 downto 0)
	);
end reg_operand;  

architecture reg_operand_arch of reg_operand is
begin
    process(clk,reset,enable)
	begin
		if reset ='0' then
			op_out<=(others => '0');
		else
			if enable='1' and rising_edge(clk) then
				op_out<=op;
			end if;
		end if;
	end process;
end reg_operand_arch;