library ieee; 
use ieee.std_logic_1164.all; 

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
        case ctrl is
            when "000" => data_out <= (others => '0');              -- nop
            when "001" => data_out <= data_in_a;                    -- move const
            when "010" => data_out <= data_in_a + data_in_b;        -- add
            when "011" => data_out <= data_in_a or data_in_b;       -- or
            when "100" => data_out <= data_in_a and data_in_b;      -- and
            when "101" => data_out <= data_in_a(6 downto 0) & '0';  -- shift left
        end case;
    end process;
end arch;
