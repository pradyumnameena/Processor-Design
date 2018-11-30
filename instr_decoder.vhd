----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:51:48
-- Design Name: 
-- Module Name: instr_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inst_dec is 
port (
		instruction : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		code : out STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end inst_dec;

architecture inst_dec_arch of inst_dec is
begin
	code <= "000000";
		process(instruction)
			begin
				case instruction(27 DOWNTO 26) is
					when "10" => --branching
						if (instruction(25)='1') then
						    code(7 DOWNTO 6) <= "10";
 						    code(5 DOWNTO 2) <= "0000";
							--branch instruction
						else
						    code(7 DOWNTO 6) <= "10";
							code(1 DOWNTO 0) <= "10";
						end if;
					when "01" => --DT Instruction
						if (instruction(25)='0') then
							--DT imm offset
							code(7 DOWNTO 6) <= "01";
							code(5 DOWNTO 2) <= "0001";
						else
							if (instruction(4)='0') then
								--DT register offset
								code(7 DOWNTO 6) <= "01";
								code(5 DOWNTO 2) <= "0010";
							else
								--error in instruction/undefined
								code(7 DOWNTO 6) <= "01";
								code(1 DOWNTO 0) <= "01";
							end if;	
						end if;
					when "00" => --DP Instruction
						if (instruction(25)='1') then
						code(7 DOWNTO 6) <= "00";
						code(5 DOWNTO 2) <= "0011";
							--arithmetic instruction with immediate operand2
						else
							if (instruction(4)='0') then
							code(7 DOWNTO 6) <= "00";
							code(5 DOWNTO 2) <= "0100";
							--DP shift_amnt immediate
							else
								if (instruction(7)='0') then
									if (instruction(11 DOWNTO 8)="1111") then
										--not implemented
										code(7 DOWNTO 6) <= "00";
										code(1 DOWNTO 0) <= "10";
									else
									code(7 DOWNTO 6) <= "00";
									code(5 DOWNTO 2) <= "0101";
										--DP shift_amnt register
									end if;
								else
									if (instruction(6 DOWNTO 5)="00") then
										if (instruction(24)='0') then
											if (instruction(23)='0') then
											code(7 DOWNTO 6) <= "00";
											code(5 DOWNTO 2) <= "0110";
											--mul/mla
											else
											--not implemented
											code(7 DOWNTO 6) <= "00";
											code(1 DOWNTO 0) <= "10";
											end if;
										else
										--not implemented
										code(7 DOWNTO 6) <= "00";
										code(1 DOWNTO 0) <= "10";	
										end if;
									else	
										if (instruction(22)='0') then
										code(7 DOWNTO 6) <= "00";
										code(5 DOWNTO 2) <= "0111";
										--halfword DT register offset
										else
										code(7 DOWNTO 6) <= "00";	
										code(5 DOWNTO 2) <= "1000";
										--halfword DT immediate offset
										end if;
									end if;
								end if;	
							end if;
						end if;
					when "11" => --SWI Instruction
						--nothing implemented yet
						code(7 DOWNTO 6) <= "11";
						code(1 DOWNTO 0) <= "10";
					when others => null;
				end case;
		end process;
end inst_dec_arch;
