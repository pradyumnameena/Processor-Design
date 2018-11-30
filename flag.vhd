----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: flag - Behavioral
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

entity flag_comp is
	port (
			oldF : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			aluF : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			s_bit : in STD_LOGIC;
			newF : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
end flag_comp;

architecture flag_arch of flag_comp is
begin
process(s_bit,oldF,aluF)
begin
	case (s_bit) is
		when '1' => 
			newF <= aluF;
		when others =>
			newF <= oldF;
	end case;
end process;
end flag_arch;
