LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE std.textio.all;
USE work.txt_util.all;

ENTITY test_processor IS
	PORT (output    : OUT STD_LOGIC_VECTOR(7  DOWNTO 0));
END;

ARCHITECTURE only OF test_processor IS
  COMPONENT processor
	PORT (in_instruction : IN  STD_LOGIC_VECTOR(16 DOWNTO 0);
     	  out_output     : OUT STD_LOGIC_VECTOR(7  DOWNTO 0);     	  
	      rst_n          : IN  STD_LOGIC;
	      clk            : IN  STD_LOGIC);	    
  END COMPONENT;
  
  SIGNAL inst   : STD_LOGIC_VECTOR(16 DOWNTO 0)  := (OTHERS => '0');  
  SIGNAL clk    : STD_LOGIC                      := '0';
  SIGNAL rst    : STD_LOGIC                      := '1';

  BEGIN
    processor_unit : processor
     	PORT MAP (in_instruction => inst,
         	   	  out_output     => output,	   	           
                clk            => clk,
                rst_n          => rst);

    clock : PROCESS 
    BEGIN
      WAIT FOR 10 ns; clk  <= NOT clk;
    END PROCESS clock;
    
    stimulus : PROCESS
			VARIABLE inline : LINE;
  			VARIABLE s      : STRING(17 DOWNTO 1);	
			FILE     myfile : text IS "sim.dat";
   	BEGIN
      WAIT FOR 20 ns; rst <= '0';
      WAIT FOR 10 ns;       
      WHILE NOT endfile(myfile) LOOP
        readline(myfile,inline);
        read(inline, s);
        print(s);
        inst <= to_std_logic_vector(s); 
        WAIT FOR 20 ns;      
      END LOOP;
    END PROCESS stimulus;
  
END only;




