----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:42 06/01/2018 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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

entity Processor is
	Port ( instr : in  STD_LOGIC_VECTOR(31 downto 0);
          RST : in  STD_LOGIC;
			 clk : in STD_LOGIC;
			 data_di : in STD_LOGIC_VECTOR(15 downto 0);
			 data_do : out STD_LOGIC_VECTOR(15 downto 0);
			 data_a : out STD_LOGIC_VECTOR(15 downto 0);
			 data_we : out STD_LOGIC);
end Processor;

architecture Behavioral of Processor is
	 
	 COMPONENT Multiplexer
    PORT(
         Sel : IN  std_logic_vector(3 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         In2 : IN  std_logic_vector(15 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT Multiplexer2
    PORT(
         Sel : IN  std_logic_vector(3 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         In2 : IN  std_logic_vector(15 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT Multiplexer3
    PORT(
         Sel : IN  std_logic_vector(3 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         In2 : IN  std_logic_vector(15 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

	COMPONENT Multiplexer4
    PORT(
         Sel : IN  std_logic_vector(3 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         In2 : IN  std_logic_vector(15 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

	 
	 COMPONENT BankRegister PORT(
         clk : IN  std_logic;
         W_enable : IN  std_logic;
         RST : IN  std_logic;
         regA_addr : IN  std_logic_vector(3 downto 0);
         regB_addr : IN  std_logic_vector(3 downto 0);
         regW_addr : IN  std_logic_vector(3 downto 0);
         DATA : IN  std_logic_vector(15 downto 0);
         regA : OUT  std_logic_vector(15 downto 0);
         regB : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT Decoder PORT(
         instr : IN  std_logic_vector(31 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0);
         OP : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT UAL PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT PIPELINE
    PORT(
         op_in : IN  std_logic_vector(3 downto 0);
         op_out : OUT  std_logic_vector(3 downto 0);
         a_in : IN  std_logic_vector(15 downto 0);
         a_out : OUT  std_logic_vector(15 downto 0);
         b_in : IN  std_logic_vector(15 downto 0);
         b_out : OUT  std_logic_vector(15 downto 0);
         c_in : IN  std_logic_vector(15 downto 0);
         c_out : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT; 
	 
	 -- SIGNAUX BANKREGISTER
	 SIGNAL regA : std_logic_vector(15 downto 0);
	 SIGNAL regB : std_logic_vector(15 downto 0);
	 SIGNAL W : std_logic;
	 -- SIGNAUX DECODER
	 SIGNAL A_decoder : std_logic_vector(15 downto 0);
	 SIGNAL B_decoder : std_logic_vector(15 downto 0);
	 SIGNAL C_decoder : std_logic_vector(15 downto 0);
	 SIGNAL OP_decoder : std_logic_vector(3 downto 0);
	 -- SIGNAUX UAL
	 SIGNAL S_UAL : std_logic_vector(15 downto 0);
	 SIGNAL Flags_UAL : std_logic_vector(3 downto 0);
	 -- SIGNAUX LI/DI
	 SIGNAL LIop_out : std_logic_vector(3 downto 0);
	 SIGNAL LIa_out : std_logic_vector(15 downto 0);
	 SIGNAL LIb_out : std_logic_vector(15 downto 0);
	 SIGNAL LIc_out : std_logic_vector(15 downto 0);
	 -- SIGNAUX DI/EX
	 SIGNAL DIop_out : std_logic_vector(3 downto 0);
	 SIGNAL DIa_out : std_logic_vector(15 downto 0);
	 SIGNAL DIb_out : std_logic_vector(15 downto 0);
	 SIGNAL DIc_out : std_logic_vector(15 downto 0);
	 -- SIGNAUX EX/MEM
	 SIGNAL EXop_out : std_logic_vector(3 downto 0);
	 SIGNAL EXa_out : std_logic_vector(15 downto 0);
	 SIGNAL EXb_out : std_logic_vector(15 downto 0);
	 SIGNAL EXc_out : std_logic_vector(15 downto 0);
	 -- SIGNAUX MEM/RE
	 SIGNAL MEMop_out : std_logic_vector(3 downto 0);
	 SIGNAL MEMa_out : std_logic_vector(15 downto 0);
	 SIGNAL MEMb_out : std_logic_vector(15 downto 0);
	 SIGNAL MEMc_out : std_logic_vector(15 downto 0);
	 -- SIGNAUX MULTIPLEXER
	 SIGNAL multi1_out : std_logic_vector(15 downto 0);
	 SIGNAL multi2_out : std_logic_vector(15 downto 0);
	 SIGNAL multi3_out : std_logic_vector(15 downto 0);
	 SIGNAL multi4_out : std_logic_vector(15 downto 0);
	 
begin
	-- Instantiate the Unit Under Test (UUT)
		  
	dec: Decoder PORT MAP (instr, A_decoder, B_decoder , C_decoder, OP_decoder);
		  
	lidi: PIPELINE PORT MAP (OP_decoder, LIop_out, A_decoder, LIa_out, B_decoder, LIb_out, C_decoder, LIc_out, clk);
	
	mul1: Multiplexer PORT MAP (LIop_out, LIb_out, regA, multi1_out);
	
	breg: BankRegister PORT MAP (clk, W, RST, LIb_out(3 downto 0), LIc_out(3 downto 0), MEMa_out(3 downto 0), multi4_out, regA, regB);
		  
	diex: PIPELINE PORT MAP (LIop_out, DIop_out, LIa_out, DIa_out, multi1_out, DIb_out, regB, DIc_out, clk);
	
	alu: UAL PORT MAP (DIb_out, DIc_out, DIop_out, S_UAL, Flags_UAL);
		  
	exm: PIPELINE PORT MAP (DIop_out, EXop_out, DIa_out, EXa_out, multi2_out , EXb_out, DIc_out, EXc_out, clk);

	mem: PIPELINE PORT MAP (EXop_out, MEMop_out, EXa_out, MEMa_out, EXb_out, MEMb_out, EXc_out, MEMc_out, clk);
	
	mul2: Multiplexer2 PORT MAP (DIop_out, DIb_out, S_UAL, multi2_out);
	
	mul3: Multiplexer3 PORT MAP (EXop_out, EXa_out, EXb_out, multi3_out);
	
	mul4: Multiplexer4 PORT MAP (MEMop_out, MEMb_out, data_di, multi4_out);
	
	W <= '1' when MEMop_out = x"1" or 
					  MEMop_out = x"2" or 
					  MEMop_out = x"3" or 
					  MEMop_out = x"4" or 
					  MEMop_out = x"5" or 
					  MEMop_out = x"6" or
					  MEMop_out = x"7" else '0'; 						  
											
	
	data_a <= multi3_out;
	data_we <= '1' when Exop_out = x"8";
	data_do <= EXb_out when Exop_out = x"8";
	
					  
	
					  
		 
end Behavioral;

