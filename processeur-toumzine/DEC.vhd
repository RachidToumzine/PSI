library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY DEC IS
	port(dec_sig: in std_logic_vector(31 downto 0);	
		oper: out std_logic_vector(7 downto 0);
		A,B,C: out std_logic_vector(15 downto 0));

	
END DEC;

architecture behavioral of DEC is
	signal stemp_dec_seg: std_logic_vector(31 downto 0);
	signal OP:std_logic_vector(7 downto 0);
	Begin
         
	OP <= stemp_dec_seg(31 downto  24);

	A <=  stemp_dec_seg(23 downto  8)  when OP ="00001000" or OP="00001110" OR OP="00001111" else
		   "00000000" & stemp_dec_seg(23 downto  16); 

	B<= stemp_dec_seg(15 downto  0)  when OP="00000110" or OP="00000111" else
		 ("00000000"& stemp_dec_seg(7 downto  0))	when OP="00001000" or OP="00001111" else
		 "00000000"& stemp_dec_seg(15 downto  8);

	C <= "00000000"& stemp_dec_seg(7 downto  0);
	 
	stemp_dec_seg<= dec_sig;
	oper<=OP;	
		   
end Behavioral;