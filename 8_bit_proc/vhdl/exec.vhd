library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity exec is
	port(
        ctrl        : in std_logic_vector(2 downto 0);
        data_in_a   : in std_logic_vector(7 downto 0);
        data_in_b   : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0)
    );
end exec;

architecture arch of exec is
begin
    process(ctrl, data_in_a, data_in_b)
    begin
        if ctrl = "000" then
            data_out <= (others => '0');              -- nop
        elsif ctrl = "001" then
            data_out <= data_in_b;                    -- move const
        elsif ctrl = "010" then
            data_out <= data_in_a + data_in_b;        -- add
        elsif ctrl = "011" then
            data_out <= data_in_a or data_in_b;       -- or
        elsif ctrl = "100" then
            data_out <= data_in_a and data_in_b;      -- and
        elsif ctrl = "101" then
            data_out <= data_in_a(6 downto 0) & '0';  -- shift left
        end if;
    end process;
end arch;
