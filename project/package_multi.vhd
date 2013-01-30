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
		ready : out std_logic_vector (8 downto 0))	
		);
end component;

Component datapath is
	port (
		add_A : in std_logic_vector (2 downto 0));
		add_B : in std_logic_vector (2 downto 0));
		clk : in std_logic;
		reset : in std_logic;
		load_multi: in std_logic;
		enable_add : in std_logic;
		load_mant : in std_logic;
		show_AB : in std_logic;
		enable : in std_logic;
		flush : in std_logic;
		enable_res : in std_logic;
		
		result : out std_logic_vector (32 downto 0));
		ready_multi : out std_logic;
		ready_mant : out std_logic;
		out_AB : out std_logic_vector (32 downto 0))
		
	);
end component;