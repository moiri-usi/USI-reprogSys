library ieee;
use ieee.std_logic_1164.all;

Entity Sum_of_Product is
    Port (
        w0, w1, s: IN std_logic;
        f: OUT std_logic
    );
End Sum_of_Product;

Architecure dataflow of Sum_of_Product is
Signal S1, S2: std_logic;
Begin
    S1 <= w0 AND NOT s;
    S2 <= w1 AND s;
    f <= S1 OR S2;
End dataflow;
