----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 19:29:42
-- Design Name: 
-- Module Name: register - Behavioral
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

entity regi is
	port (
			input_data : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			output_data : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel : in STD_LOGIC;
			clock : in STD_LOGIC
		);
end regi;

architecture regi_arch of regi is
begin
process(clock,sel)
begin
	if (rising_edge(clock)) then
		if sel='1' then
			output_data <= input_data;
		end if;
	end if;
end process;
end regi_arch;
