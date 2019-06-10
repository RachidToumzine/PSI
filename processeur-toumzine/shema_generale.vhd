------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity shema_generale is
	port(
		clk: in std_logic;
		rst: in std_logic;
		dec_signal: in std_logic_vector(31 downto 0)
	);
end shema_generale;

architecture Behavioral of shema_generale is

--decodeur
 COMPONENT DEC
    PORT(
         dec_sig : IN  std_logic_vector(31 downto 0);
         oper : OUT  std_logic_vector(7 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

--BANC REGISTRE
COMPONENT BancRegistre
    PORT(
         Clk : IN  std_logic;
         RST : IN  std_logic;
         Wa : IN  std_logic;
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic_vector(3 downto 0);
         Qa : OUT  std_logic_vector(15 downto 0);
         Qb : OUT  std_logic_vector(15 downto 0);
         DATA : IN  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
-- data memory
  COMPONENT memoire_donnee
    PORT(
         Clk : IN  std_logic;
         RW : IN  std_logic;
         RST : IN  std_logic;
         ADDR : IN  std_logic_vector(7 downto 0);
         I : IN  std_logic_vector(15 downto 0);
         O : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;  


 --pipeline
 
   COMPONENT pipeline
    PORT(
         Clk : IN  std_logic;
         Ai : IN  std_logic_vector(15 downto 0);
         Bi : IN  std_logic_vector(15 downto 0);
         Ci : IN  std_logic_vector(15 downto 0);
         OPi : IN  std_logic_vector(7 downto 0);
         Ao : OUT  std_logic_vector(15 downto 0);
         Bo : OUT  std_logic_vector(15 downto 0);
         Co : OUT  std_logic_vector(15 downto 0);
         OPo : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 
	 
	  COMPONENT instr_memory
    PORT(
         sel : IN  std_logic_vector(15 downto 0);
         q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
--ual	 
	    COMPONENT UAL
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         b : IN  std_logic_vector(15 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         Z : OUT  std_logic;
         N : OUT  std_logic;
         O : OUT  std_logic;
         C : OUT  std_logic;
         S : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

	  


	signal R_Ai,R_Bi,R_Ci,d_Ai,d_Bi,d_Ci,X_Ai,X_Bi,X_Ci, mux_Di, QA, QB, mux_Ex, ALU_S : std_logic_vector(15 downto 0) ;
  
   signal R_OPi : std_logic_vector(7 downto 0) ;
 	signal m_OPi : std_logic_vector(7 downto 0) ;
	

	
	signal MUX_MEM_IN : std_logic_vector(15 downto 0) ;
	signal MUX_MEM_OUT : std_logic_vector(15 downto 0) ;
		signal  S_O : std_logic_vector(15 downto 0) ;
   signal d_OPi : std_logic_vector(7 downto 0) ;
	signal X_OPi : std_logic_vector(7 downto 0) ;
	signal m_Ai : std_logic_vector(15 downto 0) ;

   signal m_Bi : std_logic_vector(15 downto 0) ;
	signal mem_Bi : std_logic_vector(15 downto 0) ;
	signal lc_OPi : std_logic;
	signal f_Ai : std_logic_vector(15 downto 0) ;
	signal temp_OPi : std_logic_vector(7 downto 0) ;
   signal f_Bi : std_logic_vector(15 downto 0) ;
	signal lc_alu : std_logic_vector(3 downto 0);
	signal  lc_mem : std_logic;
	--signal SIG_sel : std_logic_vector(15 downto 0) ;
  -- signal SIG_q :  std_logic_vector(31 downto 0) ;


begin

	decodeur: DEC PORT MAP (
          dec_sig => dec_signal,
          oper =>R_OPi ,
          A => R_Ai,
          B => R_Bi,
          C => R_Ci
        );

  
	pipe_LI_DI: pipeline PORT MAP (
          Clk => Clk,
          Ai =>R_Ai ,
          Bi => R_Bi,
          Ci => R_Ci,
          OPi => R_OPi,
          Ao => d_Ai,
           Bo => d_Bi,
          Co => d_Ci,
          OPo => d_OPi
        );
		 
	Bank_registre: BancRegistre PORT MAP (
          Clk => Clk,
          RST => RST,
          Wa => lc_OPi,
          A => d_Bi(3 downto 0),
          B => d_Ci(3 downto 0),
          W => f_Ai(3 downto 0),
          Qa => QA,
          Qb => QB,
          DATA => f_Bi
        );
		  
	mux_di <= QA when d_OPi = x"01" or d_OPi = x"02" or d_OPi = x"03" or d_OPi = x"04" or d_OPi = x"05" else
				 d_Bi;
		  
	pipe_DI_EX: pipeline PORT MAP (
          Clk => Clk,
          Ai => d_Ai,
          Bi => mux_di,
          Ci => QB ,
          OPi => d_OPi,
          Ao => X_Ai,
          Bo => X_Bi,
          Co => X_Ci,
          OPo => X_OPi
        );
		  
	  lc_alu <= x"2" when X_OPi(3 downto 0) = x"1" else
					x"3" when X_OPi(3 downto 0) = x"2" else
					x"4" when X_OPi(3 downto 0) = x"3" else
					x"5" when X_OPi(3 downto 0) = x"4" else
					x"6";
		  
	  UAL_i: UAL PORT MAP (
          a => X_Bi,
          b => X_Ci,
          op => lc_alu,
          Z => open,
          N => open,
          O => open,
          C => open,
          S => ALU_S
        );	  
		  
	mux_Ex <= ALU_S when X_OPi = x"01" or X_OPi = x"02" or X_OPi = x"03" or X_OPi = x"04" else  
				 X_Bi;
		  
	pipe_EX_MEM: pipeline PORT MAP (
          Clk => Clk,
          Ai => x_Ai,
          Bi => mux_Ex,
          Ci => X"0000",
          OPi => x_OPi,
          Ao => m_Ai,
          Bo => m_Bi,
          Co => open,
          OPo => m_OPi
        );
		  
	 data_Memory: memoire_donnee PORT MAP (
          Clk => Clk,
          RW => lc_mem,
          RST => RST,
          ADDR => MUX_MEM_IN(7 downto 0),
          I => m_Bi,
          O => S_O
        );	  
	MUX_MEM_IN <=	 m_Ai when   m_OPi= x"08" else  m_Bi ;  
	  
	lc_mem <= '0'	 when  m_OPi(3 downto 0)= x"8" else
     '1'; 	
		  
		  
	 pipe_MEM_RE: pipeline PORT MAP (
          Clk => Clk,
          Ai => m_Ai,
          Bi => MUX_MEM_OUT,
          Ci => X"0000",
          OPi => m_OPi,
          Ao => f_Ai,
          Bo => f_Bi,
          Co => open,
          OPo => temp_OPi
        );
		  
	MUX_MEM_OUT <= S_O when  m_OPi= x"07" else m_Bi;	  
		  
		 -- I_MEMORY: instr_memory PORT MAP (
          --sel => OPEN,
          --q => OPEN
        --);

	



		lc_OPi <='1' when  temp_OPi=x"01" --ADD  
						    or temp_OPi=x"02" --SOU
							 or temp_OPi=x"03" --MUL
							 or temp_OPi=x"04" --DIV
							 or temp_OPi=x"05" --COP
							 or temp_OPi=x"06" --AFC
							 
							 else 
					'0' ;




end Behavioral;

