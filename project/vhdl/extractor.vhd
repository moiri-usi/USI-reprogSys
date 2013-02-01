library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity extractor is
	port(	
		result_mult:in std_logic_vector(47 downto 0);
		result_mant: out std_logic_vector(22 downto 0);
		prec_lost: out std_logic
	);
end extractor;  

architecture extractor_arch of extractor is
begin
	process(result_mult)
	begin
		if result_mult(47)='1' then
			result_mant<=result_mult(46 downto 24);
			if (result_mult(23 downto 0) nand "000000000000000000000000" )= "1111111111111111111111111" then
			  prec_lost<='1';
			else 
			  prec_lost<='0';
			end if;
		else
			result_mant<=result_mult(45 downto 23);
			if (result_mult(22 downto 0) nand "00000000000000000000000") = "111111111111111111111111" then
			  prec_lost<='1';
			else 
			  prec_lost<='0';
			end if;
		end if;
	end process;
end extractor_arch;
