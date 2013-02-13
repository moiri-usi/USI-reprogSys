library ieee; 
use ieee.std_logic_1164.all; 

entity ctrl is
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
end ctrl;

architecture arch of ctrl is
    signal s_mem_sel_op : std_logic_vector(2 downto 0);
    signal s_mem1_we_n, s_mem2_we_n : std_logic_vector(3 downto 0);
begin

    process(clk, reset_n, opcode, s_mem_sel_op, s_mem1_we_n, s_mem2_we_n)
    begin
        if reset_n = '0' then
            sel_in_1 <= (others => '0');
            sel_in_2 <= (others => '0');
            sel_const <= '0';
            s_mem_sel_op <= (others => '0');
            sel_op <= (others => '0');
            s_mem1_we_n <= (others => '1');
            s_mem2_we_n <= (others => '1');
            we_n <= (others => '1'); 
        else
            if rising_edge(clk) then
                sel_in_1 <= addr_in_1;
                sel_in_2 <= addr_in_2;
                sel_const <= '0';
                if (opcode = "001") or ((addr_in_1 xor addr_in_2) = "00") then
                    sel_const <= '1';
                end if;
                s_mem_sel_op <= opcode;
                sel_op <= s_mem_sel_op;
                if opcode = "000" then
                    s_mem2_we_n <= (others => '1');
                elsif addr_out = "00" then
                    s_mem2_we_n <= "1110";
                elsif addr_out = "01" then
                    s_mem2_we_n <= "1101";
                elsif addr_out = "10" then
                    s_mem2_we_n <= "1011";
                else
                    s_mem2_we_n <= "0111";
                end if;
                s_mem1_we_n <= s_mem2_we_n;
                we_n <= s_mem1_we_n;
            end if;
        end if;
    end process;
 
end arch;
