----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:58 05/18/2018 
-- Design Name: 
-- Module Name:    BankRegister - Behavioral 
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
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BankRegister is
    Port ( clk : in STD_LOGIC;
			W_enable : in  STD_LOGIC;
			RST : in STD_LOGIC;
			regA_addr : in  STD_LOGIC_VECTOR (3 downto 0);
         regB_addr : in  STD_LOGIC_VECTOR (3 downto 0);
			regW_addr : in  STD_LOGIC_VECTOR (3 downto 0);
			DATA : in STD_LOGIC_VECTOR (15 downto 0);
         regA : out  STD_LOGIC_VECTOR (15 downto 0);
         regB : out  STD_LOGIC_VECTOR (15 downto 0));
end BankRegister;

architecture Behavioral of BankRegister is

type arrayRegister is array(integer range<>) of STD_LOGIC_VECTOR (15 downto 0);
signal registers : arrayRegister (0 to 15); 

begin
		regA <= registers(to_integer(unsigned(regA_addr))) when ((W_enable='0') or (regA_addr /= regW_addr)) else DATA;
		regB <= registers(to_integer(unsigned(regB_addr))) ;
		
	process
	begin
		wait until
			clk'event and clk='1';
		if (RST='0') then
			registers <= (others =>(others =>'U'));
		elsif (W_enable='1') then
			registers(to_integer(unsigned(regW_addr))) <= DATA;
		end if;
	end process;
end Behavioral;

