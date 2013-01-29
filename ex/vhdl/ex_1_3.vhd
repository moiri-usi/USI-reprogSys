library ieee;
use ieee.std_logic_1164.all;

Entity mux2_1 is
    Port (
        InSig: IN std_logic_vector(1 downto 0);
        Sel: IN std_logic;
        Q: OUT std_logic
    );
End mux2_1;

Architecture behaviour of mux2_1 is
Begin
    Process(InSig, Sel)
    Begin
        IF Sel = '0' THEN
            Q <= InSig(0)
        ELSE
            Q <= InSig(1)
    End process;
End behaviour;
