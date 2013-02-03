library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier is
	port ( 
		clk    : in std_logic;
		reset  : in std_logic;
		addrA  : in std_logic_vector (2 downto 0);
		addrB  : in std_logic_vector (2 downto 0);
		start  : in std_logic;
		showAB : in std_logic;
		result : out std_logic_vector (31 downto 0);
		outAB  : out std_logic_vector (31 downto 0);
		ready  : out std_logic_vector (7 downto 0);
		valid  : out std_logic_vector (7 downto 0)
	);
end Multiplier;

Architecture Multiplier_arch of Multiplier is
signal ready_multi_s, flush_s, enable_s, load_multi_s, enable_res_s, truncate_s, overflow_s : std_logic;
signal ready_s, valid_s : std_logic_vector(7 downto 0);

component control is
    port (
        clk            : in std_logic;
        reset          : in std_logic;
        start          : in std_logic;
        ready_multi    : in std_logic;
        overflow       : in std_logic;
        truncate       : in std_logic;
        load_multi     : out std_logic;
        enable         : out std_logic;
        enable_res     : out std_logic;
        flush          : out std_logic;
        ready          : out std_logic_vector(7 downto 0);
        valid          : out std_logic_vector(7 downto 0)  
    );
end component;

component datapath is
    port (
		clk             : in std_logic;
		reset           : in std_logic;
		load_multi      : in std_logic;
		show_AB         : in std_logic;
		enable          : in std_logic;
		enable_res      : in std_logic;
		flush           : in std_logic;
		add_A           : in std_logic_vector (2 downto 0);
		add_B           : in std_logic_vector (2 downto 0);
		sm_overflow     : out std_logic;
		sm_truncate     : out std_logic;
		ready_multi     : out std_logic;
		result          : out std_logic_vector (31 downto 0);
		out_AB          : out std_logic_vector (31 downto 0)		
    );
end component;

begin 
	u1: control port map (
		clk 			=> clk,
		reset			=> reset,
		start			=> start,
		ready_multi     => ready_multi_s,
        overflow        => overflow_s,
        truncate        => truncate_s,
		load_multi      => load_multi_s,
		enable          => enable_s,
		enable_res      => enable_res_s,
		flush           => flush_s,
		ready           => ready_s,
        valid           => valid_s
	);

	ready <= ready_s;
	valid <= valid_s;

	u2: datapath port map ( 
		clk         => clk,
		reset       => reset,
		load_multi  => load_multi_s,
		show_AB     => showAB,
		enable      => enable_s,
		enable_res  => enable_res_s,
		flush       => flush_s,
		add_A       => addrA,
		add_B       => addrB,
		sm_overflow => overflow_s,
		sm_truncate => truncate_s,
		ready_multi => ready_multi_s,
		result      => result,
		out_AB      => outAB
	);		
	
end Multiplier_arch;
