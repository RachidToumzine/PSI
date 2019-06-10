--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:44:24 05/28/2019
-- Design Name:   
-- Module Name:   /home/toumzine/Bureau/WORK/toumzinecompilateur/process/memoire_donnee_test.vhd
-- Project Name:  process
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memoire_donnee
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY memoire_donnee_test IS
END memoire_donnee_test;
 
ARCHITECTURE behavior OF memoire_donnee_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal Clk : std_logic := '0';
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal ADDR : std_logic_vector(7 downto 0) := (others => '0');
   signal I : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memoire_donnee PORT MAP (
          Clk => Clk,
          RW => RW,
          RST => RST,
          ADDR => ADDR,
          I => I,
          O => O
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	RST <= '0';
	RW <= '0';
	I <= "0000000000000101";
	ADDR <="00000001";
	
			wait for 150 ns;	

	RW <= '1';
	ADDR <="00000001";


      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
