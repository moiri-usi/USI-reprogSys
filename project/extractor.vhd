library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity extractor is
port(	
	result_mult:in std_logic_vector(47 downto 0);
	clk: in std_logic;
	load_mant: in std_logic;
	reset: in std_logic;
	ready_mant: out std_logic;
	result_mant: out std_logic_vector(22 downto 0)
);
end extractor;  

architecture extractor_arch of extractor is
signal result_mult_s:std_logic_vector(47 downto 0):=(others => '0');
signal result_mant_s:std_logic_vector(22 downto 0):=(others => '0');
signal enable: std_logic:='0';
signal ready_mant_s:std_logic:='0';
begin
    process(clk,reset,load_mant)
		begin
		  if reset ='0' then
		    result_mult_s<=(others => '0');
		    enable<='1';
		    
		    result_mant_s<=(others => '0');
		  else
		    if load_mant ='1' then
		       result_mult_s<= result_mult;
		       result_mant_s<=(others => '0');
		       enable<='1';
		    else
		      if rising_edge(clk) then
		        result_mult_s <= result_mult_s(46 downto 0) & '0';
		        if result_mult_s(47) ='1' and enable='1' then
		         enable<='0';
		         result_mant_s<=result_mult_s(46 downto 24);
		         ready_mant_s<='1';
   	        end if;
		       end if;
		    end if;
		 end if;
		end process;
		process(clk,enable)
		begin
		  if enable='0' and rising_edge(clk) then
		    ready_mant_s<='0';
		  end if;
		end process;
		ready_mant<=ready_mant_s;
		result_mant<=result_mant_s;
end extractor_arch;