--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:40:46 05/28/2019
-- Design Name:   
-- Module Name:   /home/toumzine/Bureau/WORK/toumzinecompilateur/process/BancRegistre_test.vhd
-- Project Name:  process
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BancRegistre
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

use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY BancRegistre_test IS
END BancRegistre_test;
 
ARCHITECTURE behavior OF BancRegistre_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal Clk : std_logic := '0';
   signal RST : std_logic := '0';
   signal Wa : std_logic := '0';
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Qa : std_logic_vector(15 downto 0);
   signal Qb : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancRegistre PORT MAP (
          Clk => Clk,
          RST => RST,
          Wa => Wa,
          A => A,
          B => B,
          W => W,
          Qa => Qa,
          Qb => Qb,
          DATA => DATA
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
			Wa <='1';
         DATA <= "0000000011111111";
         W <= "0011";

		wait for 100 ns;	


		Wa <= '0';
      A <= "0000";
      B <= "0011";

         

		

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
