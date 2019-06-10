--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:44:53 05/28/2019
-- Design Name:   
-- Module Name:   /home/toumzine/Bureau/WORK/toumzinecompilateur/process/pipeline_test.vhd
-- Project Name:  process
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
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
 
ENTITY pipeline_test IS
END pipeline_test;
 
ARCHITECTURE behavior OF pipeline_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
         Clk : IN  std_logic;
         Ai : IN  std_logic_vector(15 downto 0);
         Bi : IN  std_logic_vector(15 downto 0);
         Ci : IN  std_logic_vector(15 downto 0);
         OPi : IN  std_logic_vector(3 downto 0);
         Ao : OUT  std_logic_vector(15 downto 0);
         Bo : OUT  std_logic_vector(15 downto 0);
         Co : OUT  std_logic_vector(15 downto 0);
         OPo : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Ai : std_logic_vector(15 downto 0) := (others => '0');
   signal Bi : std_logic_vector(15 downto 0) := (others => '0');
   signal Ci : std_logic_vector(15 downto 0) := (others => '0');
   signal OPi : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Ao : std_logic_vector(15 downto 0);
   signal Bo : std_logic_vector(15 downto 0);
   signal Co : std_logic_vector(15 downto 0);
   signal OPo : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          Clk => Clk,
          Ai => Ai,
          Bi => Bi,
          Ci => Ci,
          OPi => OPi,
          Ao => Ao,
          Bo => Bo,
          Co => Co,
          OPo => OPo
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
Ai<= X"0001";
Bi <= X"0021";
Ci <= X"0031";
OPi <= "1000";
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
