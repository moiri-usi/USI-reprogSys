library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package Datapath_Package is

	Component control is
	port(
		clk         : in std_logic;
		reset       : in std_logic;
		start       : in std_logic;
		ready_multi : in std_logic;
		load_multi  : out std_logic;
		enable      : out std_logic;
		enable_res  : out std_logic;
		flush       : out std_logic;
		enable_except : out std_logic;
		ready       : out std_logic_vector(7 downto 0);
		except      : out std_logic_vector(7 downto 0);
		sm_flush    : in std_logic;
		sm_except   : in std_logic_vector(7 downto 0)
	);
	end component;

	Component datapath is
	port (
		add_A : in std_logic_vector (2 downto 0);
		add_B : in std_logic_vector (2 downto 0);
		clk : in std_logic;
		reset : in std_logic;
		load_multi: in std_logic;
		show_AB : in std_logic;
		enable : in std_logic;
		flush : in std_logic;
		enable_res : in std_logic;	
		enable_except: in std_logic;
		sm_flush: out std_logic;
		sm_except: out std_logic_vector(7 downto 0);
		result : out std_logic_vector (31 downto 0);
		ready_multi : out std_logic;
		out_AB : out std_logic_vector (31 downto 0)	
		);
	end component;

	component extractor is
	port(	
				result_mult:in std_logic_vector(47 downto 0);
		    result_mant: out std_logic_vector(22 downto 0);
		    prec_lost: out std_logic	
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
		mant_overflow: out std_logic;
		result_mult: out std_logic_vector(47 downto 0);
		ready_mult: out std_logic
		);
	end component; 

	component int_adder is
	port(	
		exp_a:in std_logic_vector(7 downto 0);
		exp_b:in std_logic_vector(7 downto 0);
		r_msb: in std_logic;
		exp_overflow: out std_logic;
		exp_res: out std_logic_vector(7 downto 0)
		);
	end component;

	component reg_operand is
	port(	
		op:in std_logic_vector(31 downto 0);
		clk: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
		op_out: out std_logic_vector(31 downto 0)
		);
	end component; 

	component rom_a is
	port (
		add_a       : in std_logic_vector(2 downto 0);
		op_a        : out std_logic_vector(31 downto 0)
		);
	end component;

	component rom_b is
	port (
		add_b       : in std_logic_vector(2 downto 0);
		op_b        : out std_logic_vector(31 downto 0)
		);
	end component;

	component float_except is
	port (
        op_a          : in std_logic_vector(31 downto 0);
        op_b          : in std_logic_vector(31 downto 0);
        sign          : in std_logic;
        enable        : in std_logic;
        exp_overflow  : in std_logic;
        mant_overflow : in std_logic;
        prec_lost     : in std_logic;
        sm_flush      : out std_logic;
        sm_except     : out std_logic_vector(7 downto 0)
      	);
	end component;
	
end Datapath_Package;