library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Multiplier_Package.all;


entity Multiplier is
port ( 
		clk : in std_logic;
		reset : in std_logic;
		add_A : in std_logic_vector (2 downto 0);
		add_B : in std_logic_vector (2 downto 0);
		start : in std_logic;
		show_AB : in std_logic;
		
		result : out std_logic_vector (31 downto 0);
		out_AB : out std_logic_vector (31 downto 0);
		ready : out std_logic_vector (7 downto 0)
		);
	
end Multiplier;

Architecture behavior of Multiplier is

	signal ready_multi_in, ready_mant_in, flush_in, enable_add_in, load_mant_in, enable_in, load_multi_in, enable_res_in : std_logic:='0';
  signal ready_out:std_logic_vector(7 downto 0);
begin 

u1: control port map ( clk 			=> clk,
								reset			=> reset,
								start			=> start,
								Ready_multi => ready_multi_in,
								Ready_mant => ready_mant_in,
								
								flush => flush_in,
								enable => enable_in,
								load_mant => load_mant_in,
								enable_add => enable_add_in,
								load_multi => load_multi_in,
								ready => ready_out,
								enable_res => enable_res_in
							);

u2: datapath port map ( 
								add_A => add_A,
								add_B => add_B,
								clk => clk,
								reset => reset,
								load_multi => load_multi_in,
								enable_add => enable_add_in,
								load_mant => load_mant_in,
								show_AB => show_AB,
								enable => enable_in,
								flush => flush_in,
								enable_res => enable_res_in,
						
								result => result,
								ready_multi => ready_multi_in,
								ready_mant => ready_mant_in,
								out_AB => out_AB
						
							);
						ready<=ready_out;	
end behavior;