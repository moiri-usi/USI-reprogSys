library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_b is
	port(
		add_b       : in std_logic_vector(2 downto 0);
        op_b        : out std_logic_vector(31 downto 0)
		);
end rom_b;

architecture mux_rom_b of rom_b is
type rom_type is array(0 to 7) of std_logic_vector(31 downto 0);
constant val_b : rom_type := (
	"01000001000110000000000000000000", -- = 0x41180000 = +1.0011x2^3 = 9.5
	"11000000000100000000000000000000", -- = 0xC0100000 = -1.001x2^1 = -2.25
	"10111110110000000000000000000000", -- = 0xBEC00000 = -1.1x2^-2 = -0.375
	"01000001011110000000000000000000", -- = 0x41780000 = +1.1111x2^3 = +15.5
	"10000000000000000000000000000000", -- = 0x80000000 = -0.0
	"01100001100000100001101010110001", -- = 0x61821AB1 = +3.0E20
	"01111111100011000000000000000000", -- = 0x7F180000 = Nan
	"11111111100000000000000000000000"  -- = 0xFF000000 = -INF
);

begin
    op_b <= val_b(to_integer( unsigned( add_b ) ));
end mux_rom_b;

