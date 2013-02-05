library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_except is
    port (
        add_except : in std_logic_vector(2 downto 0);
        op_except  : out std_logic_vector(31 downto 0)
		);
end rom_except;

architecture mux_rom_except of rom_except is
type rom_type is array(0 to 7) of std_logic_vector(31 downto 0);
constant val_except : rom_type := ( 
	"00000000000000000000000000000000", -- = 0x00000000 = +0.0
	"10000000000000000000000000000000", -- = 0x00000000 = -0.0
	"01111111100000000000000000000000", -- = 0x7F000000 = +INF
	"11111111100000000000000000000000", -- = 0xFF000000 = -INF
	"01111111100000000000000000000001", -- = 0x7F000001 = NaN
	"00000000000000000000000000000000", -- = 0x00000000 = +0.0
	"00000000000000000000000000000000", -- = 0x00000000 = +0.0
	"00000000000000000000000000000000"  -- = 0x00000000 = +0.0
);
begin
    op_except <= val_except(to_integer( unsigned( add_except ) ));
end mux_rom_except;

