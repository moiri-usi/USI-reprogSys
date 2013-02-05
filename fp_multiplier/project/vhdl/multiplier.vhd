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
		except : out std_logic_vector (7 downto 0)
	);
end Multiplier;

Architecture Multiplier_arch of Multiplier is
signal ready_multi_in, flush_in, enable_in, load_multi_in,enable_except_s, enable_res_in, sm_flush_in:std_logic;
signal ready_s, except_s, sm_except_in:std_logic_vector(7 downto 0);

component control is
port (
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

component datapath is
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

begin 
	u1: control port map (
		clk 			=> clk,
		reset			=> reset,
		start			=> start,
		ready_multi     => ready_multi_in,
		sm_flush        => sm_flush_in,
		sm_except       => sm_except_in,
		load_multi      => load_multi_in,
		enable          => enable_in,
		enable_res      => enable_res_in,
		flush           => flush_in,
		enable_except   => enable_except_s,
		ready           => ready_s,
		except          => except_s
	);

	ready <= ready_s;
	except <= except_s;

	u2: datapath port map ( 
		add_A       => addrA,
		add_B       => addrB,
		clk         => clk,
		reset       => reset,
		load_multi  => load_multi_in,
		show_AB     => showAB,
		enable      => enable_in,
		flush       => flush_in,
		enable_res  => enable_res_in,
		result      => result,
		ready_multi => ready_multi_in,
		enable_except => enable_except_s,
		sm_flush    => sm_flush_in,
		sm_except   => sm_except_in,
		out_AB      => outAB
	);		
	
end Multiplier_arch;
