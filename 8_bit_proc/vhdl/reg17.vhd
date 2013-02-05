library ieee; 
use ieee.std_logic_1164.all; 

entity reg17 is
	port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        data_in     : in std_logic_vector(16 downto 0);
        data_out    : out std_logic_vector(16 downto 0)
    );
end reg17;

architecture arch of reg17 is
begin
    process(clk, reset_n, data_in)
    begin
        if reset_n = '0' then
            data_out <= (others => '0');
        else
            if rising_edge(clk) then
                data_out <= data_in;
            end if;
        end if;
    end process;
end arch;
