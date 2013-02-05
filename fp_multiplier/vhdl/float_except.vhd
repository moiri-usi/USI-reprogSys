library ieee; 
use ieee.std_logic_1164.all;
 
entity float_except is
    port (
        op_a          : in std_logic_vector(31 downto 0);
        op_b          : in std_logic_vector(31 downto 0);
        sign          : in std_logic;
        enable        : in std_logic;
        exp_overflow  : in std_logic;
        mant_overflow : in std_logic;
        prec_lost     : in std_logic;
        sm_flush      : out std_logic;
        sm_except     : out std_logic_vector(7 downto 0)
    );
end float_except;

architecture handler of float_except is
  
begin
    process (op_a, op_b, sign, exp_overflow, mant_overflow,enable,prec_lost)
    begin
		sm_except <= (others => '0');
		sm_flush <= '0';
		if enable ='1' then
		  if prec_lost ='1' then
        sm_except(5)<='1';
      end if;
			if op_a(30 downto 23) = "00000000" then
				sm_flush <= '1';
				if op_a(22 downto 0) = "00000000000000000000000" then
					if sign = '0' then
						sm_except(0) <= '1';   -- +0
					else
						sm_except(1) <= '1';   -- -0
					end if;
				else
					sm_except(4) <= '1';       -- NaN
				end if;
			elsif op_b(30 downto 23) = "00000000" then
				sm_flush <= '1';
				if op_b(22 downto 0) = "00000000000000000000000" then
					if sign = '0' then
						sm_except(0) <= '1';   -- +0
					else
						sm_except(1) <= '1';   -- -0
					end if;
				else
					sm_except(4) <= '1';       -- NaN
				end if;
			elsif op_a(30 downto 23) = "11111111" and op_b(30 downto 23) = "11111111" then
				sm_flush <= '1';
				if op_a(22 downto 0) = "00000000000000000000000" and op_b(22 downto 0) = "00000000000000000000000" then
					if sign = '0' then
						sm_except(2) <= '1';   -- +infinity
					else
						sm_except(4) <= '1';   -- NaN
					end if;
				else
					sm_except(4) <= '1';       -- NaN
				end if;
			elsif op_a(30 downto 23) = "11111111" then
				sm_flush <= '1';
				if op_a(22 downto 0) = "00000000000000000000000" then
					if sign = '0' then
						sm_except(2) <= '1';   -- +infinity
					else
						sm_except(3) <= '1';   -- -infinity
					end if;
				else
					sm_except(4) <= '1';       -- NaN
				end if;
			elsif op_b(30 downto 23) = "11111111" then
				sm_flush <= '1';
				if op_b(22 downto 0) = "00000000000000000000000" then
					if sign = '0' then
						sm_except(2) <= '1';   -- +infinity
					else
						sm_except(3) <= '1';   -- -infinity
					end if;
				else
					sm_except(4) <= '1';       -- NaN
				end if;
			elsif exp_overflow='1' and mant_overflow='1' then
				sm_flush <= '1';
				sm_except(6) <= '1';
				sm_except(7) <= '1';
			elsif exp_overflow='1' then
				sm_flush <= '1';
				sm_except(6) <= '1';
			elsif mant_overflow='1' then
			  sm_flush <= '1';
				sm_except(7) <= '1';
			else
				sm_flush <= '0';
			end if;
		end if;
    end process;
end handler;
