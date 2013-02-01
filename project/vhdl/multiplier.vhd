library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Multiplier_Package.all;

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

Architecture behavior of Multiplier is
	signal ready_multi_in, flush_in, enable_in, load_multi_in,enable_except_s, enable_res_in, sm_flush_in:std_logic;
	signal ready_s, except_s, sm_except_in:std_logic_vector(7 downto 0);
begin 

u1: control port map (
    clk 			=> clk,
    reset			=> reset,
    start			=> start,
    ready_multi     => ready_multi_in,
    flush           => flush_in,
    enable          => enable_in,
    load_multi      => load_multi_in,
    ready           => ready_s,
    except          => except_s,
    enable_res      => enable_res_in,
    enable_except   => enable_except_s,
    sm_flush        => sm_flush_in,
    sm_except       => sm_except_in
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
							
end behavior;
