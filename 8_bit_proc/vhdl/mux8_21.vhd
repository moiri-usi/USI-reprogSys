library ieee; 
use ieee.std_logic_1164.all; 

entity mux8_21 is
	port(
        addr        : in std_logic;
        data_in_1   : in std_logic_vector(7 downto 0);
        data_in_2   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end mux8_21;

architecture arch of mux8_21 is
begin
    process(addr, data_in)
    begin
        case addr is
            when '0' => data_out <= data_in_1;
            when '1' => data_out <= data_in_2;
        end case;
    end process;
end arch;
