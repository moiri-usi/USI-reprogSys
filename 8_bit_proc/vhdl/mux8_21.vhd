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
    process(addr, data_in_1, data_in_2)
    begin
        if addr = '0' then
            data_out <= data_in_1;
        elsif addr = '1' then
            data_out <= data_in_2;
        else
            data_out <= (others => '0');
        end if;
    end process;
end arch;
