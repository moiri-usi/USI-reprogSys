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

architecture arch of exec is
begin

end arch;
