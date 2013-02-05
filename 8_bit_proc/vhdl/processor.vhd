library ieee;
use ieee.std_logic_1164.all;

entity processor is
	port(	
        clk           : in std_logic;
        reset_n       : in std_logic;
        input         : in std_logic_vector(16 downto 0);
        output        : out std_logic_vector(7 downto 0)
	);
end processor;  

architecture arch of processor is

signal s_sel_const : std_logic;
signal s_sel_in_1, s_sel_in_2, s_addr_in_1, s_addr_in_2, s_addr_out : std_logic_vector(1 downto 0);
signal s_sel_op, s_opcode, s_ctrl : std_logic_vector(2 downto 0);
signal s_we_n : std_logic_vector(3 downto 0);
signal s_immed_op, s_data_in_a, s_data_in_b, s_m2_m1, s_r2_m1, s_m1_r3, s_m3_r5 : std_logic_vector(7 downto 0);
signal s_data_out, s_data_out_1, s_data_out_2, s_data_out_3, s_data_out_4, s_output : std_logic_vector(7 downto 0);
signal s_instruction : std_logic_vector(16 downto 0);

component ctrl is
	port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        opcode      : in std_logic_vector(2 downto 0);
        addr_in_1   : in std_logic_vector(1 downto 0);
        addr_in_2   : in std_logic_vector(1 downto 0);
        addr_out    : in std_logic_vector(1 downto 0);
        sel_const   : out std_logic;
        we_n        : out std_logic_vector(3 downto 0);
        sel_in_1    : out std_logic_vector(1 downto 0);
        sel_in_2    : out std_logic_vector(1 downto 0);
        sel_op      : out std_logic_vector(2 downto 0)
    );
end component;

component decoder is
	port(
        instruction : in std_logic_vector(16 downto 0);
        opcode      : out std_logic_vector(2 downto 0);
        addr_in_1   : out std_logic_vector(1 downto 0);
        addr_in_2   : out std_logic_vector(1 downto 0);
        addr_out    : out std_logic_vector(1 downto 0);
        immed_op    : out std_logic_vector(7 downto 0)
    );
end component;

component exec is
	port(
        ctrl        : in std_logic_vector(2 downto 0);
        data_in_a   : in std_logic_vector(7 downto 0);
        data_in_b   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end component;

component mux8_21 is
	port(
        addr        : in std_logic;
        data_in_1   : in std_logic_vector(7 downto 0);
        data_in_2   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end component;

component mux8_41 is
	port(
        addr        : in std_logic_vector(1 downto 0);
        data_in_1   : in std_logic_vector(7 downto 0);
        data_in_2   : in std_logic_vector(7 downto 0);
        data_in_3   : in std_logic_vector(7 downto 0);
        data_in_4   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end component;

component reg17 is
	port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        data_in     : in std_logic_vector(16 downto 0);
        data_out    : out std_logic_vector(16 downto 0)
    );
end component;

component reg8 is
	port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        data_in     : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end component;

component regf is
	port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        we_n        : in std_logic_vector(3 downto 0);
        data_in     : in std_logic_vector(7 downto 0);
        data_out_1  : out std_logic_vector(7 downto 0);
        data_out_2  : out std_logic_vector(7 downto 0);
        data_out_3  : out std_logic_vector(7 downto 0);
        data_out_4  : out std_logic_vector(7 downto 0)
    );
end component;

begin 
	u1 : ctrl port map (
        clk         => clk,
        reset_n     => reset_n,
        opcode      => s_opcode,
        addr_in_1   => s_addr_in_1,
        addr_in_2   => s_addr_in_2,
        addr_out    => s_addr_out,
        sel_const   => s_sel_const,
        we_n        => s_we_n,
        sel_in_1    => s_sel_in_1,
        sel_in_2    => s_sel_in_2,
        sel_op      => s_sel_op
	);

	u2 : decoder port map ( 
        instruction => s_instruction,
        opcode      => s_opcode,
        addr_in_1   => s_addr_in_1,
        addr_in_2   => s_addr_in_2,
        addr_out    => s_addr_out,
        immed_op    => s_immed_op
	);

	u3 : exec port map ( 
        ctrl        => s_ctrl,
        data_in_a   => s_data_in_a,
        data_in_b   => s_data_in_b,
        data_out    => s_data_out
	);

    mux1 : mux8_21 port map (
        addr        => s_sel_const,
        data_in_1   => s_m2_m1,
        data_in_2   => s_r2_m1,
        data_out    => s_m1_r3
    );

    mux2 : mux8_41 port map (
        addr        => s_sel_in_1,
        data_in_1   => s_data_out_1,
        data_in_2   => s_data_out_2,
        data_in_3   => s_data_out_3,
        data_in_4   => s_data_out_4,
        data_out    => s_m2_m1
    );

    mux3 : mux8_41 port map (
        addr        => s_sel_in_2,
        data_in_1   => s_data_out_1,
        data_in_2   => s_data_out_2,
        data_in_3   => s_data_out_3,
        data_in_4   => s_data_out_4,
        data_out    => s_m3_r5
    );

    reg1 : reg17 port map (
        clk         => clk,
        reset_n     => reset_n,
        data_in     => input,
        data_out    => s_instruction
    );

    reg2 : reg8 port map (
        clk         => clk,
        reset_n     => reset_n,
        data_in     => s_immed_op,
        data_out    => s_r2_m1
    );

    reg3 : reg8 port map (
        clk         => clk,
        reset_n     => reset_n,
        data_in     => s_m1_r3,
        data_out    => s_data_in_b
    );

    reg4 : reg8 port map (
        clk         => clk,
        reset_n     => reset_n,
        data_in     => s_data_out,
        data_out    => s_output
    );

    reg5 : reg8 port map (
        clk         => clk,
        reset_n     => reset_n,
        data_in     => s_m3_r5,
        data_out    => s_data_in_a
    );

    reg6 : regf port map (
        clk         => clk,
        reset_n     => reset_n,
        we_n        => s_we_n,
        data_in     => s_output,
        data_out_1  => s_data_out_1,
        data_out_2  => s_data_out_2,
        data_out_3  => s_data_out_3,
        data_out_4  => s_data_out_4
    );

end arch;
