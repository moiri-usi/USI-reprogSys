library ieee; 
use ieee.std_logic_1164.all;
 
entity float_except is
    port (
        op_a        : in std_logic_vector(31 downto 0);
        op_b        : in std_logic_vector(31 downto 0);
        sign        : in std_logic;
        except      : out std_logic;
        add_except  : out std_logic_vector(2 downto 0)
    );
end float_except;

architecture handler of float_except is
  
begin
    process (op_a, op_b, sign)
    begin
        if op_a(30 downto 23) = "00000000" then
            except <= '1';
            if op_a(22 downto 0) = "00000000000000000000000" then
                if sign = '0' then
                    add_except <= "000";   -- +0
                else
                    add_except <= "001";   -- -0
                end if;
            else
                add_except <= "100";       -- NaN
            end if;
        elsif op_b(30 downto 23) = "00000000" then
            except <= '1';
            if op_b(22 downto 0) = "00000000000000000000000" then
                if sign = '0' then
                    add_except <= "000";   -- +0
                else
                    add_except <= "001";   -- -0
                end if;
            else
                add_except <= "100";       -- NaN
            end if;
        elsif op_a(30 downto 23) = "11111111" and op_b(30 downto 23) = "11111111" then
            except <= '1';
            if op_a(22 downto 0) = "00000000000000000000000" and op_b(22 downto 0) = "00000000000000000000000" then
                if sign = '0' then
                    add_except <= "010";   -- +infinity
                else
                    add_except <= "100";   -- NaN
                end if;
            else
                add_except <= "100";       -- NaN
            end if;
        elsif op_a(30 downto 23) = "11111111" then
            except <= '1';
            if op_a(22 downto 0) = "00000000000000000000000" then
                if sign = '0' then
                    add_except <= "010";   -- +infinity
                else
                    add_except <= "011";   -- -infinity
                end if;
            else
                add_except <= "100";       -- NaN
            end if;
        elsif op_b(30 downto 23) = "11111111" then
            except <= '1';
            if op_b(22 downto 0) = "00000000000000000000000" then
                if sign = '0' then
                    add_except <= "010";   -- +infinity
                else
                    add_except <= "011";   -- -infinity
                end if;
            else
                add_except <= "100";       -- NaN
            end if;
        else
            except <= '0';
            add_except <= "000";           -- +0
        end if;
    end process;
end handler;
