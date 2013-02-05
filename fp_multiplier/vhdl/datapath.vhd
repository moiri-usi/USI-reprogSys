library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Datapath_Package.all;

entity datapath is
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
end datapath;

architecture behaviour of datapath is
    signal sign_result_s, except_s : std_logic;
    -- signal for register
    signal op_a_s, op_b_s, op_a_out_s, op_b_out_s, op_except_s, result_s, result_final_s : std_logic_vector (31 downto 0);
    -- signal for datapath
    signal result_mult_s : std_logic_vector (47 downto 0);
    -- signal for adder
    signal exp_res_s: std_logic_vector (7 downto 0);
    -- signal for extractor
    signal result_mant_s : std_logic_vector (22 downto 0);
    signal add_except_s : std_logic_vector(2 downto 0);
begin 
	sign_result_s <= op_a_out_s(31) xor op_b_out_s(31);
	out_AB <= op_b_out_s when show_AB = '1' else op_a_out_s;
	result_final_s <= result_s when except_s = '0' else op_except_s;
    result <= result_final_s; 

    a_rom : rom_a port map (
        add_a => add_a,
        op_a => op_a_s
    );

    b_rom : rom_b port map (
        add_b => add_b,
        op_b => op_b_s
    );

    except_rom : rom_except port map (
        add_except => add_except_s,
        op_except => op_except_s
    );

    a_Reg : reg_operand port map(
        clk => clk,
        reset => reset,
        op => op_a_s,
        enable => enable,
        op_out => op_a_out_s
    );

    b_Reg : reg_operand port map(
        clk => clk,
        reset => reset,
        op => op_b_s,
        enable => enable,
        op_out => op_b_out_s
    );

    multi : int_multiplier port map (
        a_m => op_a_out_s(22 downto 0),
        b_m => op_b_out_s(22 downto 0),
        clk => clk,
        load_mult => load_multi,
        reset => reset,
        result_mult => result_mult_s,
        ready_mult => ready_multi
    );

    adder : int_adder port map(
        exp_a => op_a_out_s(30 downto 23),
        exp_b => op_b_out_s(30 downto 23),
        r_msb => result_mult_s(47),
        exp_overflow => sm_overflow,
        exp_res => exp_res_s
    );

    extrac : extractor port map(
        result_mult => result_mult_s,
        result_mant => result_mant_s,
        prec_lost => sm_truncate
    );

    result_reg : reg_result port map(
        clk => clk,
        reset => reset,
        mant => result_mant_s,
        sign => sign_result_s,
        exp => exp_res_s,
        flush => flush,
        enable_res => enable_res,
        result => result_s
    );

    except : float_except port map(
        op_a => op_a_out_s,
        op_b => op_b_out_s,
        sign => sign_result_s,
        except => except_s,
        add_except => add_except_s
    );
end behaviour;
