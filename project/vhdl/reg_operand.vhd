library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg_operand is
port(	
	op:in std_logic_vector(31 downto 0);
	clk: in std_logic;
	enable: in std_logic;
	reset: in std_logic;
	sign: out std_logic;
	exp: out std_logic_vector(7 downto 0);
	mant: out std_logic_vector(22 downto 0);
	op_out: out std_logic_vector(31 downto 0)
);
end reg_operand;  

architecture reg_operand_arch of reg_operand is
signal op_out_s:std_logic_vector(31 downto 0):=(others => '0');
signal exp_s:std_logic_vector(7 downto 0):=(others => '0');
signal mant_s:std_logic_vector(22 downto 0):=(others => '0');
signal sign_s:std_logic:='0';

begin
    process(clk,reset)
		begin
		  if reset ='0' then
		    op_out_s<=(others => '0');
		    exp_s<=(others => '0');
		    mant_s<=(others => '0');
		    sign_s<='0';
		  else
		    if enable='1' and rising_edge(clk) then
		      op_out_s<=op;
		      exp_s<=op(30 downto 23);
		      mant_s<=op(22 downto 0);
		      sign_s<=op(31); 
		    end if;
		 end if;
		end process;
		op_out<=op_out_s;
		exp<=exp_s;
		mant<=mant_s;
		sign<=sign_s;
end reg_operand_arch;
