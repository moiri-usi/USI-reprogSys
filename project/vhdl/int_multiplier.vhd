library ieee;
use ieee.std_logic_1164.all;

entity int_multiplier is
	port(	
        clk           : in std_logic;
        reset         : in std_logic;
        a_m           : in std_logic_vector(22 downto 0);
        b_m           : in std_logic_vector(22 downto 0);
        load_mult     : in std_logic;
        mant_overflow : out std_logic;
        result_mult   : out std_logic_vector(47 downto 0);
		ready_mult    : out std_logic
	);
end int_multiplier;  

architecture arch of int_multiplier is
    signal add_ctrl_in, ready_ctrl_in, add_ops_in, shift_ops_in, load_ops_in : std_logic;

component control_multi is
    port (
        clk           : in std_logic;
        reset         : in std_logic;
        load_mult     : in std_logic;
        add_ctrl      : in std_logic;
        ready_ctrl    : in std_logic;
        add_ops       : out std_logic;
        shift_ops     : out std_logic;
        load_ops      : out std_logic;
        mant_overflow : out std_logic;
        ready_mult    : out std_logic
    );
end component;

component datapath_multi is
    port(	
        clk           : in std_logic;
        reset         : in std_logic;
        a_m           : in std_logic_vector(22 downto 0);
        b_m           : in std_logic_vector(22 downto 0);
        add_ops       : in std_logic;
        shift_ops     : in std_logic;
        load_ops      : in std_logic;
        add_ctrl      : out std_logic;
        ready_ctrl    : out std_logic;
        result_mult   : out std_logic_vector(47 downto 0)
    );
end component;

begin 
	u1: control_multi port map (
		clk 			=> clk,
		reset			=> reset,
		load_mult       => load_mult,
        add_ctrl        => add_ctrl_in, 
        ready_ctrl      => ready_ctrl_in,
        add_ops         => add_ops_in,
        shift_ops       => shift_ops_in,
        load_ops        => load_ops_in,
        mant_overflow   => mant_overflow,
        ready_mult      => ready_mult
	);

	u2: datapath_multi port map ( 
		clk           => clk,
		reset         => reset,
        a_m           => a_m,
        b_m           => b_m,
        add_ops       => add_ops_in,
        shift_ops     => shift_ops_in,
        load_ops      => load_ops_in,
        add_ctrl      => add_ctrl_in,
        ready_ctrl    => ready_ctrl_in,
        result_mult   => result_mult
	);		
	
end arch;
