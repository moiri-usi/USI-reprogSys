library ieee; 
use ieee.std_logic_1164.all; 

entity regf is
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
end regf;

architecture arch of regf is
begin
    process(clk, reset_n, data_in, we_n)
    begin
        if (rising_edge(clk)) then
            if (reset_n = '0') then
                data_out_1 <= (others => '0');
                data_out_2 <= (others => '0');
                data_out_3 <= (others => '0');
                data_out_4 <= (others => '0');
            else
                if (we_n(0) = '0') then
                    data_out_1 <= data_in;
                end if;
                if (we_n(1) = '0') then
                    data_out_2 <= data_in;
                end if;
                if (we_n(2) = '0') then
                    data_out_3 <= data_in;
                end if;
                if (we_n(3) = '0') then
                    data_out_4 <= data_in;
                end if;
            end if;
        end if;
    end process;
end arch;
