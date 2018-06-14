--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:09:12 06/12/2018
-- Design Name:   
-- Module Name:   /home/taleb/Bureau/4A/PROJECT VALKYRIE/VHDL/UAL/test_chemin_de_donnees.vhd
-- Project Name:  UAL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: chemin_de_donnees
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
 
ENTITY test_chemin_de_donnees IS
END test_chemin_de_donnees;
 
ARCHITECTURE behavior OF test_chemin_de_donnees IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT chemin_de_donnees
    PORT(
         RST : IN  std_logic;
         clk : IN  std_logic;
         instr : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal clk : std_logic := '0';
   signal instr : std_logic_vector(31 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: chemin_de_donnees PORT MAP (
          RST => RST,
          clk => clk,
          instr => instr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 5 ns;
		rst <= '0';
		wait for 1 ns;
		rst <= '1';
		

		wait for 200 ns;	
		instr <= x"06010002";
		wait for 200 ns;	
		instr <= x"08000101";
		


      wait;
   end process;

END;
