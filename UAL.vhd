----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:04 05/03/2018 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           flags : out  STD_LOGIC_VECTOR (3 downto 0));
end UAL;

architecture Behavioral of UAL is
	Signal SAdd : STD_LOGIC_VECTOR (16 downto 0);
	Signal SSub : STD_LOGIC_VECTOR (16 downto 0);
	Signal SMul : STD_LOGIC_VECTOR (31 downto 0);
	Signal SInf : STD_LOGIC_VECTOR (15 downto 0);
	Signal SSup : STD_LOGIC_VECTOR (15 downto 0);
	Signal SInfEq : STD_LOGIC_VECTOR (15 downto 0);
	Signal SSupEq : STD_LOGIC_VECTOR (15 downto 0);
	Signal SEq : STD_LOGIC_VECTOR (15 downto 0);
begin
	S <= SAdd(15 downto 0) when op = x"1" else
		SSub(15 downto 0) when op = x"3" else
		SMul(15 downto 0) when op = x"2" else
		--"0" & A (15 downto 1) when op = x"4" else
		--A(14 downto 0) & "0" when op = x"5" else
		SEq when op = x"9" else
		SInf when op = x"A" else
		SInfEq when op = x"B" else
		SSup when op = x"C" else
		SSupEq  when op = x"D" else
		(others => 'U'); 
		
	SAdd <= ("0" & A) + ("0" & B);
	SSub <= ("0" & A) - ("0" & B);
	SMul <= A * B;
	SInf <= x"0001" when (A<B) else x"0000";
	SSup <= x"0001" when (A>B) else x"0000";
	SInfEq <= x"0001" when (A<=B) else x"0000";
	SSupEq <= x"0001" when (A>=B) else x"0000";
	SEq <= x"0001" when (A=B) else x"0000";
	
	
	flags(3) <= SAdd(16) when op = x"1" else
					SSub(16) when op = x"3" else ('0'); 							-- C
	flags(2) <= SAdd(15) when op = x"1" else										-- N
					SSub(15) when op = x"3" else
					SMul(15) when op = x"2" else ('0');
	flags(1) <= ('1') when ((SAdd = x"0000" and op = x"1") 					-- Z
					or (SSub = x"0000" and op = x"3")  
					or (SMul = x"0000" and op = x"2")
					or (("0" & A (15 downto 1)) = 0 and op = x"4"))
					else ('0');
	flags(0) <= ('1') when (SMul(31 downto 16) > x"0000" and op = x"2")	-- V
					else ('0');
end Behavioral;

