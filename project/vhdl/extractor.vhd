library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity extractor is
port(	
	result_mult:in std_logic_vector(47 downto 0);
	load_mant: in std_logic;
	result_mant: out std_logic_vector(22 downto 0)
);
end extractor;  

architecture extractor_arch of extractor is
signal result_mant_s:std_logic_vector(22 downto 0):=(others => '0');
signal ready_mant_s: std_logic:='0';
begin
	process(load_mant,result_mult)
	begin
	 if load_mant='1' then
		  if result_mult(47)='1' then
			 result_mant<=result_mult(46 downto 24);
		  else
			 result_mant<=result_mult(45 downto 23);
		  end if;
	end if;
	end process;
end extractor_arch;
