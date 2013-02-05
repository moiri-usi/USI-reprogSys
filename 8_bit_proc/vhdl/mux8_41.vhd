library ieee; 
use ieee.std_logic_1164.all; 

entity mux8_41 is
	port(
        addr        : in std_logic_vector(1 downto 0);
        data_in_1   : in std_logic_vector(7 downto 0);
        data_in_2   : in std_logic_vector(7 downto 0);
        data_in_3   : in std_logic_vector(7 downto 0);
        data_in_4   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end mux8_41;

architecture arch of mux8_41 is
begin
    process(addr, data_in)
    begin
        case addr is
            when "00" => data_out <= data_in_1;
            when "01" => data_out <= data_in_2;
            when "10" => data_out <= data_in_3;
            when "11" => data_out <= data_in_4;
        end case;
    end process;
end arch;
