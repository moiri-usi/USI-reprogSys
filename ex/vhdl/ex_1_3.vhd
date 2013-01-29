library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is
    port (
        InSig: in std_logic_vector(1 downto 0);
        Sel: in std_logic;
        Q: out std_logic
    );
end mux2_1;

architecture behaviour of mux2_1 is
begin
    process(InSig, Sel)
    begin
        if Sel = '0' then
            Q <= InSig(0);
        else
            Q <= InSig(1);
        end if;
    end process;
end behaviour;
