library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package Multiplier_Package is

Component control 
	port ( 
		clk : in std_logic;
		reset : in std_logic;
		start : in std_logic;
		Ready_multi : in std_logic;
		ready_mant : in std_logic;	
		
		enable_res : out std_logic;
		flush : out std_logic;
		enable : out std_logic;
		load_mant : out std_logic;
		enable_add : out std_logic;
		load_multi : out std_logic;
		ready : out std_logic_vector (7 downto 0)	
		);
end component;

Component datapath is
	port (
		add_A : in std_logic_vector (2 downto 0);
		add_B : in std_logic_vector (2 downto 0);
		clk : in std_logic;
		reset : in std_logic;
		load_multi: in std_logic;
		enable_add : in std_logic;
		load_mant : in std_logic;
		show_AB : in std_logic;
		enable : in std_logic;
		flush : in std_logic;
		enable_res : in std_logic;
		
		result : out std_logic_vector (31 downto 0);
		ready_multi : out std_logic;
		ready_mant : out std_logic;
		out_AB : out std_logic_vector (31 downto 0)
		
	);
end component;

component extractor is
port(	
	result_mult:in std_logic_vector(47 downto 0);
	clk: in std_logic;
	load_mant: in std_logic;
	reset: in std_logic;
	ready_mant: out std_logic;
	result_mant: out std_logic_vector(22 downto 0)
);
end component;  

component reg_result is
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
end component;

component int_multiplier is
port(	
	a_m,b_m:in std_logic_vector(22 downto 0);
	clk: in std_logic;
	load_mult: in std_logic;
	reset: in std_logic;
	result_mult: out std_logic_vector(47 downto 0);
	r_msb: out std_logic;
	--overflow_mult: out std_logic;
	ready_mult: out std_logic
);
end component; 

component int_adder is
port(	
	enable_add:in std_logic;
	exp_a:in std_logic_vector(7 downto 0);
	exp_b:in std_logic_vector(7 downto 0);
	r_msb: in std_logic;
	exp_res: out std_logic_vector(7 downto 0));
end component;

component reg_operand is
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
end component; 

component mux is
    port (
        add_a       : in std_logic_vector(2 downto 0);
        add_b       : in std_logic_vector(2 downto 0);
        op_a        : out std_logic_vector(31 downto 0);
        op_b        : out std_logic_vector(31 downto 0)
    );
end component;

end Multiplier_Package;