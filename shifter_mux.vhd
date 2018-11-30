----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: shifter_mux - Behavioral
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

entity shifter_mux is 
port (
		reg_input : in STD_LOGIC_VECTOR (31 DOWNTO 0);
		const : in STD_LOGIC_VECTOR (4 DOWNTO 0);
		sel : in STD_LOGIC;
		result : out STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
end;

architecture shifter_mux_arch of shifter_mux is
begin
process(reg_input,const,sel)
begin
	case sel is
		when '0' => 
			result <= const;
		when '1' =>
			result <= reg_input(4 DOWNTO 0);
	end case;
end process;
end shifter_mux_arch;
