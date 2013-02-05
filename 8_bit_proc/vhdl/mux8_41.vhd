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
    process(addr, data_in_1, data_in_2, data_in_3, data_in_4)
    begin
        if addr = "00" then
            data_out <= data_in_1;
        elsif addr = "01" then
            data_out <= data_in_2;
        elsif addr = "10" then
            data_out <= data_in_3;
        elsif addr = "11" then
            data_out <= data_in_4;
        else
            data_out <= (others => '0');
        end if;
    end process;
end arch;
