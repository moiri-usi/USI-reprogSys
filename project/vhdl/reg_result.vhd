library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg_result is
	port(	
		mant:in std_logic_vector(22 downto 0);
		exp:in std_logic_vector(7 downto 0);
		sign:in std_logic;
		clk: in std_logic;
		enable_res: in std_logic;
		flush: in std_logic;
		reset: in std_logic;
		result: out std_logic_vector(31 downto 0)
		);
end reg_result;  

architecture reg_result_arch of reg_result is
signal result_s:std_logic_vector(31 downto 0);
begin
	process(clk,reset)
	begin
		if reset ='0' then
			result_s<=(others => '0');
		else
			if rising_edge(clk) then
				if flush ='1' then
					result_s<=(others => '0');
				else
					if enable_res='1' then  
						result_s<=sign & exp & mant; 
					end if;
				end if;
			end if;
		end if;
	end process;
	result<=result_s;
end reg_result_arch;