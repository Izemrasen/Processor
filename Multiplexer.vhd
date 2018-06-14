----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:26:00 06/04/2018 
-- Design Name: 
-- Module Name:    Multiplexer - Behavioral 
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

entity Multiplexer is
	port(Sel : in std_logic_vector(3 downto 0);
		  In1 : in std_logic_vector(15 downto 0);
		  In2 : in std_logic_vector(15 downto 0);
        Output : out std_logic_vector(15 downto 0));
end Multiplexer;

architecture Behavioral of Multiplexer is
begin
	Output <= In1 when Sel = x"6" else In2;

end Behavioral;

