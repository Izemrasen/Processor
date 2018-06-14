----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:58:50 05/28/2018 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
           a: out  STD_LOGIC_VECTOR (15 downto 0);
           b : out  STD_LOGIC_VECTOR (15 downto 0);
           c : out  STD_LOGIC_VECTOR (15 downto 0);
			  op : out  STD_LOGIC_VECTOR (3 downto 0));
end Decoder;

architecture Behavioral of Decoder is
begin
	op <= instr(27 downto 24);
	a <= instr(23 downto 8) when instr(31 downto 24) = x"08" or instr(31 downto 24) >= x"0E" else
		x"00" & instr (23 downto 16);
	b <= x"00" & instr(7 downto 0) when instr(31 downto 24) = x"08" or instr(31 downto 24) >= x"0E" else
		instr(15 downto 0) when instr(31 downto 24) = x"06" or instr(31 downto 24) = x"07" else
		x"00" & instr(15 downto 8);
	c <= (others => 'U') when (instr(31 downto 24) = x"05" or instr(31 downto 24) >= x"E" 
		or instr(31 downto 24) >= x"06") else x"00" & instr(7 downto 0);
		
end Behavioral;

