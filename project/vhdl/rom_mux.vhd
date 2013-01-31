library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    port (
        add_a       : in std_logic_vector(2 downto 0);
        add_b       : in std_logic_vector(2 downto 0);
        op_a        : out std_logic_vector(31 downto 0);
        op_b        : out std_logic_vector(31 downto 0)
    );
end mux;

architecture int_rom of mux is
    type rom_type is array(0 to 7) of std_logic_vector(31 downto 0);
    constant rom_a : rom_type := ( 
        "11000001100100000000000000000000", -- = 0xC1900000 = -1.001x2^4 = -18.0
        "01000011000001100001000000000000", -- = 0x43061000 = +1.00001100001x2^7 = 134.0625
        "11000001011010000000000000000000", -- = 0xC1680000 = -1.1101x2^3 = -14.5
        "01000000111100000000000000000000", -- = 0x40F00000 = +1.111x2^2 = 7.5
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000"  -- = 0x00000000 = 0.0
    );
    constant rom_b : rom_type := (
        "01000001000110000000000000000000", -- = 0x41180000 = +1.0011x2^3 = 9.5
        "11000000000100000000000000000000", -- = 0xC0100000 = -1.001x2^1 = -2.25
        "10111110110000000000000000000000", -- = 0xBEC00000 = -1.1x2^-2 = -0.375
        "01000001011110000000000000000000", -- = 0x41780000 = +1.1111x2^3 = +15.5
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000", -- = 0x00000000 = 0.0
        "00000000000000000000000000000000"  -- = 0x00000000 = 0.0
    );
begin
process(add_a)
  begin
  case add_a is
   when "000"  =>
     op_a <= rom_a(0);
   when "001"  =>
     op_a <= rom_a(1);
   when "010"  =>
     op_a <= rom_a(2);
   when "011"  =>
     op_a <= rom_a(3);
   when "100"  =>
     op_a <= rom_a(4);
   when "101"  =>
     op_a <= rom_a(5); 
   when "110"  =>
     op_a <= rom_a(6); 
   when "111"  =>
     op_a <= rom_a(7); 
   when others =>
     null;
   end case;
end process;

process(add_b)
  begin
  case add_b is
   when "000"  =>
     op_b <= rom_b(0);
   when "001"  =>
     op_b <= rom_b(1);
   when "010"  =>
     op_b <= rom_b(2);
   when "011"  =>
     op_b <= rom_b(3);
   when "100"  =>
     op_b <= rom_b(4);
   when "101"  =>
     op_b <= rom_b(5); 
   when "110"  =>
     op_b <= rom_b(6); 
   when "111"  =>
     op_b <= rom_b(7);
    when others =>
     null; 
   end case;
end process;
    --op_a <= rom_a(0 );-- to_integer( unsigned( add_a ) )
    --op_b <= rom_b(to_integer( unsigned( add_b,1 ) ));
end int_rom;

