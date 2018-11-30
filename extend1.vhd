----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: extend1 - Behavioral
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

entity extend1 is
--  Port ( );
port (
			instruction : in STD_LOGIC_VECTOR(11 DOWNTO 0);
			result : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end extend1;

architecture extend1_arch of extend1 is
signal zero : STD_LOGIC_VECTOR(19 DOWNTO 0) := "00000000000000000000";
begin

result<= (zero) & (instruction);
end extend1_arch;
