library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

ENTITY memoire_donnee IS

	port(
			Clk,RW,RST: in std_logic;	
			ADDR: in std_logic_vector(7 downto 0);
			I: in std_logic_vector(15 downto 0);
			O: out std_logic_vector(15 downto 0));
END memoire_donnee;

architecture behavioral of memoire_donnee is
    type memory is array (0 to 10) of std_logic_vector(15 downto 0) ;
     signal memoire_tab: memory;
begin
    
   
    process
    begin
        
		  wait until CLK'event and CLK='1';

            if RST='1' then 
            memoire_tab <=(others=>(others =>'0'));
            elsif RW='0' then 
            memoire_tab(to_integer(unsigned(ADDR)))<= I;
				else -- when  RW='1'
				O <=  memoire_tab(to_integer(unsigned(ADDR))) ;
            end if ;
            


    end process;
END behavioral;