library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_a is
    port (
        add_a       : in std_logic_vector(2 downto 0);
        op_a        : out std_logic_vector(31 downto 0)
		);
end rom_a;

architecture mux_rom_a of rom_a is
type rom_type is array(0 to 7) of std_logic_vector(31 downto 0);
constant val_a : rom_type := ( 
	"11000001100100000000000000000000", -- = 0xC1900000 = -1.001x2^4 = -18.0
	"01000011000001100001000000000000", -- = 0x43061000 = +1.00001100001x2^7 = 134.0625
	"11000001011010000000000000000000", -- = 0xC1680000 = -1.1101x2^3 = -14.5
	"01000000111100000000000000000000", -- = 0x40F00000 = +1.111x2^2 = 7.5
	"00000000000000000000000000000000", -- = 0x00000000 = 0.0
	"01111111100000000000000000000000", -- = 0x7F000000 = +INF
	"11111111100000000000000000000000", -- = 0xFF000000 = -INF
	"01100001001011010111100011101100"  -- = 0x7F180000 = 2.0E20
);
begin
    op_a <= val_a(to_integer( unsigned( add_a ) ));
end mux_rom_a;

