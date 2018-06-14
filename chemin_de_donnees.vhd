----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:34:16 06/12/2018 
-- Design Name: 
-- Module Name:    chemin_de_donnees - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chemin_de_donnees is
	Port ( RST : in  STD_LOGIC;
			 clk : in STD_LOGIC;
			 instr : IN  std_logic_vector(31 downto 0));
end chemin_de_donnees;

architecture Behavioral of chemin_de_donnees is
    COMPONENT Processor
    PORT(
         instr : IN  std_logic_vector(31 downto 0);
         RST : IN  std_logic;
         clk : IN  std_logic;
			data_di : in STD_LOGIC_VECTOR(15 downto 0);
			data_do : out STD_LOGIC_VECTOR(15 downto 0);
			data_a : out STD_LOGIC_VECTOR(15 downto 0);
			data_we : out STD_LOGIC);
    END COMPONENT;
	 
	component bram16
		generic (
			init_file : String := "none";
			adr_width : Integer := 11);
			port (
				-- System
				sys_clk : in std_logic;
				sys_rst : in std_logic;
				-- Master
				di : out std_logic_vector(15 downto 0);
				we : in std_logic;
				a : in std_logic_vector(15 downto 0);
				do : in std_logic_vector(15 downto 0)
		);
	end component;
	
	--SIGNAUX PROCESSEUR
	SIGNAL data_di : std_logic_vector(15 downto 0);
	SIGNAL data_we : std_logic;
	SIGNAL data_a : std_logic_vector(15 downto 0);
	SIGNAL data_do : std_logic_vector(15 downto 0);
	
begin

	processeur : processor PORT MAP (instr, RST, clk, data_di, data_do, data_a, data_we);
   memoire : bram16 PORT MAP (clk, rst, data_di, data_we, data_a, data_do);

end Behavioral;

