----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:56:42 05/10/2019 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
port(a, b : in std_logic_vector(15 downto 0);	
		op : in std_logic_vector(3 downto 0);
		Z,N,O,C : out std_logic;
	    S : out std_logic_vector(15 downto 0));
end UAL;

architecture Behavioral of UAL is

	 signal Smul: std_logic_vector(31 downto 0);
    signal Stemp: std_logic_vector(15 downto 0);
    signal Sadd: std_logic_vector(16 downto 0);
    begin 
            
	  Stemp <= a and b   when op="0000" else
	  a or b   when op="0001" else
	  Sadd(15 downto 0)  when op="0010" else    
	  a - b   when op="0011" else          
	  Smul(15 downto 0)   when op="0100" else
	  (others => '0')  ;
					  
	 Sadd <= ('0'&a) +( '0'&b) ;
	 Smul <= a * b;
	 C <= Sadd(16);
	 Z <= '1' when Stemp=x"0000" else '0';
	 N<= '1' when Stemp(15)='1' else '0';
	 
	 S<=Stemp;

end Behavioral;

