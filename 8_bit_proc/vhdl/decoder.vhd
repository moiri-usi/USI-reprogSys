library ieee; 
use ieee.std_logic_1164.all; 

entity decoder is
	port(
        instruction : in std_logic_vector(16 downto 0);
        opcode      : out std_logic_vector(2 downto 0);
        addr_in_1   : out std_logic_vector(1 downto 0);
        addr_in_2   : out std_logic_vector(1 downto 0);
        addr_out    : out std_logic_vector(1 downto 0);
        immed_op    : out std_logic_vector(7 downto 0)
    );
end decoder;

architecture arch of decoder is
begin
    opcode <= instruction(16 downto 14);
    immed_op <= instruction(13 downto 6);
    addr_in_1 <= instruction(5 downto 4);
    addr_in_2 <= instruction(3 downto 2);
    addr_out <= instruction(1 downto 0);
end arch;
