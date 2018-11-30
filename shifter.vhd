----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: shifter - Behavioral
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
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shifter is 
port (
		op1 : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		result : out STD_LOGIC_VECTOR (31 DOWNTO 0);
		shifter_carry : out STD_LOGIC;
		opcode : in STD_LOGIC_VECTOR (1 DOWNTO 0);
		shift_amnt : in STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end;

architecture shift_arch of shifter is
signal one : STD_LOGIC_VECTOR(31 DOWNTO 0) := "11111111111111111111111111111111";
signal zero : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin

shift_process : process(op1,opcode,shift_amnt)
variable amnt : natural;
begin
 amnt := to_integer(unsigned(shift_amnt(11 downto 7)));
	case opcode is
		when "00" => --lsl
			if amnt>0 then
				shifter_carry <= op1(32-amnt);
				result <= op1(31-amnt DOWNTO 0)&zero(amnt-1 DOWNTO 0);
			else
				shifter_carry <= '0';
				result <= op1;
			end if;		
		
		when "01" => --lsr
			if amnt>0 then
				shifter_carry <= op1(amnt - 1);
				result <= zero(amnt-1 DOWNTO 0)&op1(31 DOWNTO amnt);
			else
				shifter_carry <= '0';
				result <= op1;
			end if;
				
		when "10" => --asr
			if amnt>0 then
				shifter_carry <= op1(amnt - 1);
				if op1(31)='0' then
					result <= zero(amnt-1 DOWNTO 0)&op1(31 DOWNTO amnt);
				else
					result <= one(amnt-1 DOWNTO 0)&op1(31 DOWNTO amnt);
				end if;
			else
				shifter_carry <= '0';
				result <= op1;
			end if;
		
		when "11" => --ror
			if amnt>0 then
				shifter_carry <= op1(amnt - 1);
				result <= op1(amnt-1 DOWNTO 0)&op1(31 DOWNTO amnt);
			else
				shifter_carry <= '0';
				result <= op1;
			end if;
			
		when others => null;
	end case;
end process;
end shift_arch;
