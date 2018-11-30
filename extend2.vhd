----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: extend2 - Behavioral
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

entity extend2 is
--  Port ( );
port (
			instruction : in STD_LOGIC_VECTOR(23 DOWNTO 0);
			result : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end extend2;

architecture extend2_arch of extend2 is
signal sign_ex : STD_LOGIC_VECTOR(5 DOWNTO 0) := (others => instruction(23));
begin
result(31 DOWNTO 26) <= sign_ex;
result(25 DOWNTO 0) <= instruction & "00";
end extend2_arch;
