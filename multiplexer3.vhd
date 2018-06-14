----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:49 06/12/2018 
-- Design Name: 
-- Module Name:    multiplexer3 - Behavioral 
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

entity multiplexer3 is
	Port (Sel : in std_logic_vector(3 downto 0);
		  In1 : in std_logic_vector(15 downto 0);
		  In2 : in std_logic_vector(15 downto 0);
        Output : out std_logic_vector(15 downto 0));
end multiplexer3;

architecture Behavioral of multiplexer3 is

begin
	Output <= In1 when Sel = x"8" else In2;

end Behavioral;

