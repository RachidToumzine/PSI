Library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    -- use IEEE.STD_LOGIC_UNSIGNED.ALL;
    -- use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.NUMERIC_STD.ALL;
    
    
    entity BancRegistre is
        port (Clk : in std_logic;
        RST : in std_logic;
        Wa : in std_logic;
        A, B : in std_logic_vector(3 downto 0);	
                 W: in std_logic_vector(3 downto 0);
                Qa, Qb : out std_logic_vector(15 downto 0);	
                DATA:in std_logic_vector(15 downto 0));
    
     end BancRegistre;
        
     architecture Behavioral of BancRegistre is
          type registre is array (0 to 15) of std_logic_vector(15 downto 0) ;
          signal registre_tab:registre; 
     begin
          Qa <= DATA when (RST='0' and Wa='1' and W=A) else
                  registre_tab(to_integer(unsigned(A)));
          Qb <= DATA when (RST='0' and Wa='1' and W=B) else
                  registre_tab(to_integer(unsigned(B)));  
       
      
        process
    
        begin 
            wait until Clk'event and Clk='1';
    
                if RST='1' then 
                    registre_tab <=(others=>(others =>'0'));
                elsif Wa='1' then 
                    registre_tab(to_integer(unsigned(W)))<= DATA;
                end if ;
    
    
        end process;
    end Behavioral;