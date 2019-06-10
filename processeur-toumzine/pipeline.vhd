library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity pipeline is
port (Clk : in std_logic;
Ai, Bi,Ci : in std_logic_vector(15 downto 0);	
		OPi : in std_logic_vector(7 downto 0);
        Ao, Bo ,Co : out std_logic_vector(15 downto 0);	
		OPo:out std_logic_vector(7 downto 0));
      
end pipeline;

architecture Behavioral of pipeline is
begin

process(Clk)

BEGIN
	 --wait until CLK'event and CLK='1';
    if(rising_edge(Clk)) then
        Ao <= Ai;
        Bo <= Bi;
        OPo <= OPi;
        Co <= Ci;
    end if ;    
       
END PROCESS;

end Behavioral;